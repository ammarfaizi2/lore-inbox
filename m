Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVKLSCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVKLSCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVKLSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:21 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:6088 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932440AbVKLSCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:19 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/9] uml console channels: remove console_write wrappers
Date: Sat, 12 Nov 2005 19:07:46 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180738.20133.98491.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We were using a long series of (stupid) wrappers which all call
generic_console_write(). Since the wrappers only change the 4th param, which is
unused by the called proc, remove them and call generic_console_write()
directly.

If needed at any time in the future to reintroduce this stuff, the member could
be moved to a generic struct, to avoid this duplicated handling.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/fd.c        |    9 +--------
 arch/um/drivers/port_user.c |    9 +--------
 arch/um/drivers/pty.c       |   11 ++---------
 arch/um/drivers/tty.c       |    9 +--------
 arch/um/drivers/xterm.c     |    9 +--------
 5 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/arch/um/drivers/fd.c b/arch/um/drivers/fd.c
index f0b888f..3296e86 100644
--- a/arch/um/drivers/fd.c
+++ b/arch/um/drivers/fd.c
@@ -76,13 +76,6 @@ static void fd_close(int fd, void *d)
 	}
 }
 
-static int fd_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct fd_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops fd_ops = {
 	.type		= "fd",
 	.init		= fd_init,
@@ -90,7 +83,7 @@ struct chan_ops fd_ops = {
 	.close		= fd_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= fd_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 1,
diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index ed4a1a6..c43e8bb 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -100,13 +100,6 @@ static void port_close(int fd, void *d)
 	os_close_file(fd);
 }
 
-static int port_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct port_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops port_ops = {
 	.type		= "port",
 	.init		= port_init,
@@ -114,7 +107,7 @@ struct chan_ops port_ops = {
 	.close		= port_close,
 	.read	        = generic_read,
 	.write		= generic_write,
-	.console_write	= port_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= port_free,
 	.winch		= 1,
diff --git a/arch/um/drivers/pty.c b/arch/um/drivers/pty.c
index 0306a1b..1c555c3 100644
--- a/arch/um/drivers/pty.c
+++ b/arch/um/drivers/pty.c
@@ -118,13 +118,6 @@ static int pty_open(int input, int outpu
 	return(fd);
 }
 
-static int pty_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct pty_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops pty_ops = {
 	.type		= "pty",
 	.init		= pty_chan_init,
@@ -132,7 +125,7 @@ struct chan_ops pty_ops = {
 	.close		= generic_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= pty_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 0,
@@ -145,7 +138,7 @@ struct chan_ops pts_ops = {
 	.close		= generic_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= pty_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 0,
diff --git a/arch/um/drivers/tty.c b/arch/um/drivers/tty.c
index 6fbb670..94c9265 100644
--- a/arch/um/drivers/tty.c
+++ b/arch/um/drivers/tty.c
@@ -60,13 +60,6 @@ static int tty_open(int input, int outpu
 	return(fd);
 }
 
-static int tty_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct tty_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops tty_ops = {
 	.type		= "tty",
 	.init		= tty_chan_init,
@@ -74,7 +67,7 @@ struct chan_ops tty_ops = {
 	.close		= generic_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= tty_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 0,
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index b530f1a..aaa6366 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -194,13 +194,6 @@ static void xterm_free(void *d)
 	free(d);
 }
 
-static int xterm_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct xterm_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops xterm_ops = {
 	.type		= "xterm",
 	.init		= xterm_init,
@@ -208,7 +201,7 @@ struct chan_ops xterm_ops = {
 	.close		= xterm_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= xterm_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= xterm_free,
 	.winch		= 1,

