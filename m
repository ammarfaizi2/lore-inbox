Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSJOGWs>; Tue, 15 Oct 2002 02:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSJOGWs>; Tue, 15 Oct 2002 02:22:48 -0400
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:61568 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262662AbSJOGWr>;
	Tue, 15 Oct 2002 02:22:47 -0400
Date: Tue, 15 Oct 2002 01:28:36 -0500
From: Matt Reppert <arashi@arashi.yi.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, davem@redhat.com, akpm@digeo.com
Subject: [PATCH] smbfs compile fixes for latest BK
Message-Id: <20021015012836.681723e3.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled, no warnings, but not tested (no means to do so ATM); however, these
seem to be in line with changes in the latest BK elsewhere in this file.
Against 2.5.42-mm3.

--- linux-2.5-orig/fs/smbfs/sock.c	2002-10-15 01:03:03 -0500
+++ linux-2.5/fs/smbfs/sock.c		2002-10-15 01:08:50 -0500
@@ -58,7 +58,7 @@
 	iov.iov_len = size;
 
 	init_sync_kiocb(&iocb, NULL);
-	si = kiocb_to_siocb(iocb);
+	si = kiocb_to_siocb(&iocb);
 	si->sock = socket;
 	si->scm = &si->async_scm;
 	si->msg = &msg;
@@ -327,7 +327,7 @@
 		rlen = PAGE_SIZE;
 
 	init_sync_kiocb(&iocb, NULL);
-	si = kiocb_to_siocb(iocb);
+	si = kiocb_to_siocb(&iocb);
 	si->sock = sock;
 	si->scm = &si->async_scm;
 	si->msg = &msg;
@@ -338,7 +338,7 @@
 
 	result = sock->ops->recvmsg(&iocb, sock, &msg, rlen, flags, si->scm);
 	if (result >= 0)
-		scm_recv(sock, &msg, &scm, flags);
+		scm_recv(sock, &msg, si->scm, flags);
 	if (-EIOCBQUEUED == result)
 		result = wait_on_sync_kiocb(&iocb);
 
@@ -366,6 +366,8 @@
 smb_receive(struct smb_sb_info *server, struct smb_request *req)
 {
 	struct socket *sock;
+	struct kiocb iocb;
+	struct sock_iocb *si;
 	unsigned int flags;
 	struct iovec iov[4];
 	struct msghdr msg;
@@ -397,7 +399,7 @@
 		rlen = req->rq_rlen;
 
 	init_sync_kiocb(&iocb, NULL);
-	si = kiocb_to_siocb(iocb);
+	si = kiocb_to_siocb(&iocb);
 	si->sock = sock;
 	si->scm = &si->async_scm;
 	si->msg = &msg;
@@ -464,7 +466,7 @@
 		smb_move_iov(&msg, iov, req->rq_bytes_sent);
 
 	init_sync_kiocb(&iocb, NULL);
-	si = kiocb_to_siocb(iocb);
+	si = kiocb_to_siocb(&iocb);
 	si->scm = &si->async_scm;
 	si->sock = sock;
 	si->msg = &msg;
@@ -476,7 +478,7 @@
 	if (result >= 0) {
 		result = sock->ops->sendmsg(&iocb, sock, &msg, slen, si->scm);
 		if (-EIOCBQUEUED != result)
-			scm_destroy(&scm);
+			scm_destroy(si->scm);
 	}
 	if (-EIOCBQUEUED == result)
 		result = wait_on_sync_kiocb(&iocb);


Matt
