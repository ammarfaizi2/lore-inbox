Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVKLSB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVKLSB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVKLSB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:01:58 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:46560 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932452AbVKLSB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:01:58 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 7/9] uml console channels: fix the API of console_write
Date: Sat, 12 Nov 2005 19:07:52 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180748.20133.97774.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
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
index 16e7dc8..5b58fad 100644
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
index 1c55d58..5d50d4a 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -20,7 +20,7 @@
 #include "choose-mode.h"
 #include "mode.h"
 
-int generic_console_write(int fd, const char *buf, int n, void *unused)
+int generic_console_write(int fd, const char *buf, int n)
 {
 	struct termios save, new;
 	int err;
diff --git a/arch/um/include/chan_user.h b/arch/um/include/chan_user.h
index f77d9aa..659bb3c 100644
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

