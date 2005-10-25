Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVJYWGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVJYWGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVJYWFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:40 -0400
Received: from [151.97.230.9] ([151.97.230.9]:56293 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932430AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/11] uml console channels: remove console_write wrappers
Date: Wed, 26 Oct 2005 00:02:18 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220217.20010.88625.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
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
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -101,13 +101,6 @@ static void port_close(int fd, void *d)
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
@@ -115,7 +108,7 @@ struct chan_ops port_ops = {
 	.close		= port_close,
 	.read	        = generic_read,
 	.write		= generic_write,
-	.console_write	= port_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= port_free,
 	.winch		= 1,
diff --git a/arch/um/drivers/pty.c b/arch/um/drivers/pty.c
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
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -195,13 +195,6 @@ static void xterm_free(void *d)
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
@@ -209,7 +202,7 @@ struct chan_ops xterm_ops = {
 	.close		= xterm_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= xterm_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= xterm_free,
 	.winch		= 1,

