Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTFJEoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 00:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTFJEoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 00:44:21 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:37381 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262352AbTFJEoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 00:44:20 -0400
Subject: New struct sock_common breaks parisc 64 bit compiles with a
	misalignment
From: James Bottomley <James.Bottomley@steeleye.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, davem@redhat.com
Content-Type: multipart/mixed; boundary="=-zMvLQyb8ABm5TLkd4vja"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 09 Jun 2003 23:57:46 -0500
Message-Id: <1055221067.11728.14.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zMvLQyb8ABm5TLkd4vja
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The problem seems to be that the new struct sock_common ends with a
pointer and an atomic_t (which is an int on parisc), so the compiler
adds an extra four bytes of padding where none previously existed in
struct tcp_tw_bucket, so the __u64 ptr tricks with tw_daddr fail.

A fix that seems to work for me on parisc64 is to move the atomic_t out
of the end of struct sock_common and back into the two other structures
(so struct sock_common now ends on 0 mod 8).

James



--=-zMvLQyb8ABm5TLkd4vja
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D include/net/sock.h 1.43 vs edited =3D=3D=3D=3D=3D
--- 1.43/include/net/sock.h	Wed Jun  4 19:57:07 2003
+++ edited/include/net/sock.h	Mon Jun  9 23:41:15 2003
@@ -111,7 +111,6 @@
 	struct sock		**skc_pprev;
 	struct sock		*skc_bind_next;
 	struct sock		**skc_bind_pprev;
-	atomic_t		skc_refcnt;
 };
=20
 /**
@@ -191,7 +190,7 @@
 #define sk_pprev		__sk_common.skc_pprev
 #define sk_bind_next		__sk_common.skc_bind_next
 #define sk_bind_pprev		__sk_common.skc_bind_pprev
-#define sk_refcnt		__sk_common.skc_refcnt
+	atomic_t		sk_refcnt;
 	volatile unsigned char	sk_zapped;
 	unsigned char		sk_shutdown;
 	unsigned char		sk_use_write_queue;
=3D=3D=3D=3D=3D include/net/tcp.h 1.44 vs edited =3D=3D=3D=3D=3D
--- 1.44/include/net/tcp.h	Fri Jun  6 05:24:44 2003
+++ edited/include/net/tcp.h	Mon Jun  9 23:39:44 2003
@@ -178,7 +178,7 @@
 #define tw_pprev		__tw_common.skc_pprev
 #define tw_bind_next		__tw_common.skc_bind_next
 #define tw_bind_pprev		__tw_common.skc_bind_pprev
-#define tw_refcnt		__tw_common.skc_refcnt
+	atomic_t		tw_refcnt;
 	volatile unsigned char	tw_substate;
 	unsigned char		tw_rcv_wscale;
 	__u16			tw_sport;

--=-zMvLQyb8ABm5TLkd4vja--

