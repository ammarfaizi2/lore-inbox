Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbWBURRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWBURRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWBURRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:17:24 -0500
Received: from [151.97.230.9] ([151.97.230.9]:3038 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932750AbWBURRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:17:22 -0500
X-Antivirus-MYDOMAIN-Mail-From: blaisorblade@yahoo.it via ssc.unict.it
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:1(151.97.230.9):. Processed in 0.104363 secs Process 16093)
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/6] uml: os_connect_socket error path fixup
Date: Tue, 21 Feb 2006 18:16:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060221171627.509.95340.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix an fd leak and a return of -1 instead of -errno in the error path - this
showed up in intensive testing of HPPFS, the os_connect_socket user.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/file.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index f55773c..3bd10de 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -272,14 +272,23 @@ int os_connect_socket(char *name)
 	snprintf(sock.sun_path, sizeof(sock.sun_path), "%s", name);
 
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	if(fd < 0)
-		return(fd);
+	if(fd < 0) {
+		err = -errno;
+		goto out;
+	}
 
 	err = connect(fd, (struct sockaddr *) &sock, sizeof(sock));
-	if(err)
-		return(-errno);
+	if(err) {
+		err = -errno;
+		goto out_close;
+	}
 
-	return(fd);
+	return fd;
+
+out_close:
+	close(fd);
+out:
+	return err;
 }
 
 void os_close_file(int fd)

