Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSLNCeN>; Fri, 13 Dec 2002 21:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSLNCeN>; Fri, 13 Dec 2002 21:34:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46318 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265589AbSLNCeL>;
	Fri, 13 Dec 2002 21:34:11 -0500
From: Janet Morgan <janetmor@us.ibm.com>
Message-Id: <200212140240.gBE2edd16510@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] sys_epoll for 2.4
To: m.c.p@wolk-project.de (Marc-Christian Petersen)
Date: Fri, 13 Dec 2002 18:40:38 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com (Janet Morgan)
In-Reply-To: <200212132038.23469.m.c.p@wolk-project.de> from "Marc-Christian Petersen" at Dec 13, 2002 07:40:45 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The attached patch is a port of Davide's sys_epoll from 2.5.51 to 2.4.20.
> I get this while make modules:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include  -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
> -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DSMBFS_PARANOIA -nostdinc 
> -iwithprefix include -DKBUILD_BASENAME=sock  -c -o sock.o sock.c
> sock.c: In function `smb_receive_poll':
> sock.c:323: warning: passing arg 1 of `poll_initwait' from incompatible 
> pointer type
> sock.c:328: warning: passing arg 1 of `poll_freewait' from incompatible 
> pointer type
> sock.c:334: warning: passing arg 1 of `poll_freewait' from incompatible 
> pointer type
> sock.c:337: structure has no member named `error'
> sock.c:338: structure has no member named `error'
> make[2]: *** [sock.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.20/fs/smbfs'
> make[1]: *** [_modsubdir_smbfs] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.20/fs'
> make: *** [_mod_fs] Error 2

Marc, 

Thanks for finding this.  fs/ncpfs/sock.c is likewise broken.

The following patch compiles, but I haven't tested it.


--- linux-2.4.20/fs/smbfs/sock.c	Thu Nov 28 15:53:15 2002
+++ sys_epoll/fs/smbfs/sock.c	Fri Dec 13 14:50:15 2002
@@ -314,16 +314,18 @@
 smb_receive_poll(struct smb_sb_info *server)
 {
 	struct file *file = server->sock_file;
-	poll_table wait_table;
+	struct poll_wqueues wait_table;
+	poll_table *wait;
 	int result = 0;
 	int timeout = server->mnt->timeo * HZ;
 	int mask;
 
 	for (;;) {
 		poll_initwait(&wait_table);
+		wait = &wait_table.pt;
                 set_current_state(TASK_INTERRUPTIBLE);
 
-		mask = file->f_op->poll(file, &wait_table);
+		mask = file->f_op->poll(file, wait);
 		if (mask & POLLIN) {
 			poll_freewait(&wait_table);
 			current->state = TASK_RUNNING;
--- linux-2.4.20/fs/ncpfs/sock.c	Sat Jan 20 08:51:51 2001
+++ sys_epoll/fs/ncpfs/sock.c	Fri Dec 13 16:59:07 2002
@@ -86,7 +86,8 @@
 	struct socket *sock;
 	int result;
 	char *start = server->packet;
-	poll_table wait_table;
+	struct poll_wqueues wait_table;
+	poll_table *wait;
 	int init_timeout, max_timeout;
 	int timeout;
 	int retrans;
@@ -136,11 +137,12 @@
 		}
 	      re_select:
 		poll_initwait(&wait_table);
+		wait = &wait_table.pt;
 		/* mb() is not necessary because ->poll() will serialize
 		   instructions adding the wait_table waitqueues in the
 		   waitqueue-head before going to calculate the mask-retval. */
 		__set_current_state(TASK_INTERRUPTIBLE);
-		if (!(sock->ops->poll(file, sock, &wait_table) & POLLIN)) {
+		if (!(sock->ops->poll(file, sock, wait) & POLLIN)) {
 			int timed_out;
 			if (timeout > max_timeout) {
 				/* JEJB/JSP 2/7/94
@@ -261,7 +263,8 @@
 }
 
 static int do_tcp_rcv(struct ncp_server *server, void *buffer, size_t len) {
-	poll_table wait_table;
+	struct poll_wqueues wait_table;
+	poll_table *wait;
 	struct file *file;
 	struct socket *sock;
 	int init_timeout;
@@ -281,11 +284,12 @@
 
 	while (len) {
 		poll_initwait(&wait_table);
+		wait = &wait_table.pt;
 		/* mb() is not necessary because ->poll() will serialize
 		   instructions adding the wait_table waitqueues in the
 		   waitqueue-head before going to calculate the mask-retval. */
 		__set_current_state(TASK_INTERRUPTIBLE);
-		if (!(sock->ops->poll(file, sock, &wait_table) & POLLIN)) {
+		if (!(sock->ops->poll(file, sock, wait) & POLLIN)) {
 			init_timeout = schedule_timeout(init_timeout);
 			poll_freewait(&wait_table);
 			current->state = TASK_RUNNING;
