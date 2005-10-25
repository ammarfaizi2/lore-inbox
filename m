Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVJYWFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVJYWFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVJYWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:34 -0400
Received: from [151.97.230.9] ([151.97.230.9]:53989 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932424AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/11] uml console channels: fix the API of console_write
Date: Wed, 26 Oct 2005 00:02:41 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220240.20010.67825.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since the 4th param is unused, remove it altogether.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/chan_kern.c |    5 ++---
 arch/um/drivers/chan_user.c |    2 +-
 arch/um/include/chan_user.h |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -89,8 +89,7 @@ static int not_configged_write(int fd, c
 	return(-EIO);
 }
 
-static int not_configged_console_write(int fd, const char *buf, int len,
-				       void *data)
+static int not_configged_console_write(int fd, const char *buf, int len)
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
@@ -299,7 +298,7 @@ int console_write_chan(struct list_head 
 		chan = list_entry(ele, struct chan, list);
 		if(!chan->output || (chan->ops->console_write == NULL))
 			continue;
-		n = chan->ops->console_write(chan->fd, buf, len, chan->data);
+		n = chan->ops->console_write(chan->fd, buf, len);
 		if(chan->primary) ret = n;
 	}
 	return(ret);
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -21,7 +21,7 @@
 #include "choose-mode.h"
 #include "mode.h"
 
-int generic_console_write(int fd, const char *buf, int n, void *unused)
+int generic_console_write(int fd, const char *buf, int n)
 {
 	struct termios save, new;
 	int err;
diff --git a/arch/um/include/chan_user.h b/arch/um/include/chan_user.h
--- a/arch/um/include/chan_user.h
+++ b/arch/um/include/chan_user.h
@@ -25,7 +25,7 @@ struct chan_ops {
 	void (*close)(int, void *);
 	int (*read)(int, char *, void *);
 	int (*write)(int, const char *, int, void *);
-	int (*console_write)(int, const char *, int, void *);
+	int (*console_write)(int, const char *, int);
 	int (*window_size)(int, void *, unsigned short *, unsigned short *);
 	void (*free)(void *);
 	int winch;
@@ -37,7 +37,7 @@ extern struct chan_ops fd_ops, null_ops,
 extern void generic_close(int fd, void *unused);
 extern int generic_read(int fd, char *c_out, void *unused);
 extern int generic_write(int fd, const char *buf, int n, void *unused);
-extern int generic_console_write(int fd, const char *buf, int n, void *state);
+extern int generic_console_write(int fd, const char *buf, int n);
 extern int generic_window_size(int fd, void *unused, unsigned short *rows_out,
 			       unsigned short *cols_out);
 extern void generic_free(void *data);

