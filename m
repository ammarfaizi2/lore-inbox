Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSL3BCR>; Sun, 29 Dec 2002 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSL3BCR>; Sun, 29 Dec 2002 20:02:17 -0500
Received: from stargate-42-82.salzburg-online.at ([213.153.42.82]:24331 "EHLO
	window.dhis.org") by vger.kernel.org with ESMTP id <S264976AbSL3BCO>;
	Sun, 29 Dec 2002 20:02:14 -0500
Date: Mon, 30 Dec 2002 02:09:53 +0100
From: Thomas Ogrisegg <tom@rhadamanthys.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20021230010953.GA17731@window.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch (for 2.4.20 -- should work with all kernels
above 2.4.17) implements TCP Zero Copy for normal (writing)
socket operations on memory mapped files.

This is a major speedup for the TCP/IP stack (depending on the size
of the file more than 100% more throughput) and makes sendfile(2)
nearly useless.

BTW: When I did a (loopback) benchmark against my very own HTTP-
Server it outperformed TUX by roughly 6%. With logging disabled
by roughly 20%.

Please CC any replies to me, as I'm not subscribed to this list.

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tcp.diff"

--- linux.old/net/ipv4/tcp.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20/net/ipv4/tcp.c	Sun Dec 29 20:30:10 2002
@@ -204,6 +204,7 @@
  *		Andi Kleen 	:	Make poll agree with SIGIO
  *	Salvatore Sanfilippo	:	Support SO_LINGER with linger == 1 and
  *					lingertime == 0 (RFC 793 ABORT Call)
+ *	Thomas Ogrisegg		:	Added TCP Zero Copy for mmapped files
  *					
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -1006,6 +1007,41 @@
 	return tmp;
 }
 
+static ssize_t file_send_actor (read_descriptor_t *desc, struct page *page,
+	unsigned long offset, unsigned long size)
+{
+	ssize_t res;
+	unsigned long count = desc->count;
+	struct sock *sk = (struct sock *) desc->buf;
+	int flags;
+
+	if (size > count)
+		size = count;
+
+	flags = (sk->socket->file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
+	if (size < count) flags |= MSG_MORE;
+
+#define TCP_ZC_CSUM_FLAGS (NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM)
+
+	if (!(sk->route_caps & NETIF_F_SG) ||
+		!(sk->route_caps & TCP_ZC_CSUM_FLAGS))
+		return sock_no_sendpage(sk->socket, page, offset, size, flags);
+
+#undef TCP_ZC_CSUM_FLAGS
+
+	TCP_CHECK_TIMER(sk);
+	res = do_tcp_sendpages(sk, &page, offset, size, flags);
+	TCP_CHECK_TIMER(sk);
+
+	if (res < 0) desc->error = res;
+	else {
+		desc->count -= res;
+		desc->written += res;
+	}
+
+	return res;
+}
+
 int tcp_sendmsg(struct sock *sk, struct msghdr *msg, int size)
 {
 	struct iovec *iov;
@@ -1015,6 +1051,7 @@
 	int mss_now;
 	int err, copied;
 	long timeo;
+	int has_sendpage = sk->socket->file->f_op->sendpage != NULL;
 
 	tp = &(sk->tp_pinfo.af_tcp);
 
@@ -1049,6 +1086,44 @@
 
 		iov++;
 
+		if (seglen >= PAGE_SIZE && has_sendpage) {
+			struct vm_area_struct *vma =
+				find_vma (current->mm, (long) from);
+			struct file *filp;
+
+			if (vma && (filp = vma->vm_file)) {
+				read_descriptor_t desc;
+				struct inode *in, *out;
+				loff_t pos = (long) from - vma->vm_start;
+
+				in  = filp->f_dentry->d_inode;
+				out = sk->socket->file->f_dentry->d_inode;
+
+				if (locks_verify_area (FLOCK_VERIFY_READ, in,
+					filp, filp->f_pos, seglen))
+					goto out_no_zero_copy;
+
+				if (locks_verify_area (FLOCK_VERIFY_WRITE, out,
+					sk->socket->file, 0, seglen))
+					goto out_no_zero_copy;
+
+				desc.written = 0;
+				desc.count   = seglen;
+				desc.buf     = (char *) sk;
+				desc.error   = 0;
+
+				do_generic_file_read (filp, &pos, &desc,
+					file_send_actor);
+
+				if (!desc.written) {
+					err = desc.error;
+					goto do_error;
+				}
+				copied += desc.written;
+				continue;
+			}
+		}
+out_no_zero_copy:
 		while (seglen > 0) {
 			int copy;
 			

--6c2NcOVqGQ03X4Wi--
