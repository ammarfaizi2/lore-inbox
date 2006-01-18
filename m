Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWARA24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWARA24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWARA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:28:10 -0500
Received: from [151.97.230.9] ([151.97.230.9]:17891 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964910AbWARA1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:27:41 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/9] uml: make daemon transport behave properly
Date: Wed, 18 Jan 2006 01:19:25 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118001923.14622.78817.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid uninitialized data in the daemon_data structure. I used this transport
before doing proper setup before-hand, and I got some very nice SLAB corruption
due to freeing crap pointers. So just make sure to clear everything when
appropriate.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/daemon_kern.c |    4 ++++
 arch/um/drivers/daemon_user.c |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
index 30d285b..507e3cb 100644
--- a/arch/um/drivers/daemon_kern.c
+++ b/arch/um/drivers/daemon_kern.c
@@ -31,6 +31,10 @@ void daemon_init(struct net_device *dev,
 	dpri->fd = -1;
 	dpri->control = -1;
 	dpri->dev = dev;
+	/* We will free this pointer. If it contains crap we're burned. */
+	dpri->ctl_addr = NULL;
+	dpri->data_addr = NULL;
+	dpri->local_addr = NULL;
 
 	printk("daemon backend (uml_switch version %d) - %s:%s", 
 	       SWITCH_VERSION, dpri->sock_type, dpri->ctl_sock);
diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 1bb085b..c944265 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -158,10 +158,16 @@ static void daemon_remove(void *data)
 	struct daemon_data *pri = data;
 
 	os_close_file(pri->fd);
+	pri->fd = -1;
 	os_close_file(pri->control);
+	pri->control = -1;
+
 	kfree(pri->data_addr);
+	pri->data_addr = NULL;
 	kfree(pri->ctl_addr);
+	pri->ctl_addr = NULL;
 	kfree(pri->local_addr);
+	pri->local_addr = NULL;
 }
 
 int daemon_user_write(int fd, void *buf, int len, struct daemon_data *pri)

