Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbULILZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbULILZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 06:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULILZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 06:25:47 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:17909 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261506AbULILZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 06:25:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=POkHUu59qsBOIYlVAVpc52h4BzB/V8/fnSA20pCeWzxNNaRxZzvgcL84K0uW5DHijJikcp/KVKHxHNXdNTvMvWRggxXKwcXreRp33DbvVjGqQfMYxQ5j9Lni45Rupug7FAjNMfvtchas996rXp8PXzyQEW4gTKG1QOs5ZM6bxyA=
Message-ID: <fcb9aa29041209032521899698@mail.gmail.com>
Date: Thu, 9 Dec 2004 13:25:26 +0200
From: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
Reply-To: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
To: netdev@oss.sgi.com,
       =?UTF-8?Q?YOSHIFUJI_Hideaki_/_=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
	<yoshfuji@linux-ipv6.org>,
       davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] port_reuse listen fix (allow simultaneous single listen + outgoing connects from same port)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest patch with removed bool > 1 check and ipv6 support.
http://puding.mine.nu/patches/
http://puding.mine.nu/patches/patch-reuse-bool-ipv6

to check, you can use netcat (sets SO_REUSEADDR by default).
on one host (host A): nc -v -l -p 9999
on another/same host (host B): nc -v -l -p 9000
on host A: nc -v -p 9999 host.B.ip.addr 9000
on host B: nc -v host.A.ip.addr 9999

nothing should fail.

--- linux/net/ipv4/tcp_ipv4.c.orig2004-12-07 14:54:12.597084704 +0200
+++ linux/net/ipv4/tcp_ipv4.c2004-12-08 16:20:32.018896416 +0200
@@ -50,6 +50,8 @@
  *YOSHIFUJI Hideaki @USAGI and:Support IPV6_V6ONLY socket option, which
  *Alexey Kuznetsovallow both IPv4 and IPv6 sockets to bind
  *a single port at the same time.
+ *Ilya Pashkovsky:fix TCP_LISTEN check on reuse
+ *sk_reuse boolean fix
  */
 
 #include <linux/config.h>
@@ -184,7 +186,8 @@ static inline int tcp_bind_conflict(stru
 const u32 sk_rcv_saddr = tcp_v4_rcv_saddr(sk);
 struct sock *sk2;
 struct hlist_node *node;
-int reuse = sk->sk_reuse;
+unsigned char reuse = sk->sk_reuse;
+unsigned char state = sk->sk_state;
 
 sk_for_each_bound(sk2, node, &tb->owners) {
 if (sk != sk2 &&
@@ -193,7 +196,7 @@ static inline int tcp_bind_conflict(stru
      !sk2->sk_bound_dev_if ||
      sk->sk_bound_dev_if == sk2->sk_bound_dev_if)) {
 if (!reuse || !sk2->sk_reuse ||
-    sk2->sk_state == TCP_LISTEN) {
+    (state == TCP_LISTEN && sk2->sk_state == TCP_LISTEN)) {
 const u32 sk2_rcv_saddr = tcp_v4_rcv_saddr(sk2);
 if (!sk2_rcv_saddr || !sk_rcv_saddr ||
     sk2_rcv_saddr == sk_rcv_saddr)
@@ -259,8 +262,11 @@ static int tcp_v4_get_port(struct sock *
 goto tb_not_found;
 tb_found:
 if (!hlist_empty(&tb->owners)) {
-if (sk->sk_reuse > 1)
-goto success;
+/*
+ * sk_reuse is boolean
+ * if (sk->sk_reuse > 1)
+ *goto success;
+ */
 if (tb->fastreuse > 0 &&
     sk->sk_reuse && sk->sk_state != TCP_LISTEN) {
 goto success;
--- linux/net/ipv6/tcp_ipv6.c.orig2004-12-09 01:35:33.162353104 +0200
+++ linux/net/ipv6/tcp_ipv6.c2004-12-09 01:34:38.162714320 +0200
@@ -111,7 +111,7 @@ static inline int tcp_v6_bind_conflict(s
      !sk2->sk_bound_dev_if ||
      sk->sk_bound_dev_if == sk2->sk_bound_dev_if) &&
     (!sk->sk_reuse || !sk2->sk_reuse ||
-     sk2->sk_state == TCP_LISTEN) &&
+     (sk->sk_state == TCP_LISTEN && sk2->sk_state == TCP_LISTEN)) &&
      ipv6_rcv_saddr_equal(sk, sk2))
 break;
 }
