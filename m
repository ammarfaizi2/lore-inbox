Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbULHM6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbULHM6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbULHM6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:58:07 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:56088 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261201AbULHM6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:58:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qvmHO4K1+gkObt+ZE3T5s4tHD9g09bsMP0LmPpbudoPCSpCZc3m1Rr8sdL85/wyec7asNRvG6djZu+rTONNEXkWCUuAHErtv7fmzlDcBcxqfvzXX6bCGey36VFxGbrQFgrVON1QjpkgFDf50dwxZAvW2B42lVXuZvxnpae0bZ4M=
Message-ID: <fcb9aa2904120804584bd3c718@mail.gmail.com>
Date: Wed, 8 Dec 2004 14:58:01 +0200
From: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
Reply-To: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sk_reuse fixes
In-Reply-To: <fcb9aa29041208045671633835@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fcb9aa29041208045671633835@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes sk_reuse checks:
1) allow outgoing connections AND one listening socket bound to same
source port.
2) remove > 1 check of a boolean variable

http://puding.mine.nu/patches/patch-reuse-bool

--- linux/net/ipv4/tcp_ipv4.c.orig      2004-12-07 14:54:12.597084704 +0200
+++ linux/net/ipv4/tcp_ipv4.c   2004-12-08 14:47:27.792827816 +0200
@@ -50,6 +50,8 @@
 *     YOSHIFUJI Hideaki @USAGI and:   Support IPV6_V6ONLY socket option, which
 *     Alexey Kuznetsov                allow both IPv4 and IPv6 sockets to bind
 *                                     a single port at the same time.
+ *     Ilya Pashkovsky         :       fix TCP_LISTEN check on reuse
+ *                                     remove (sk_reuse > 1) check in get_port
 */

#include <linux/config.h>
@@ -184,7 +186,8 @@ static inline int tcp_bind_conflict(stru
       const u32 sk_rcv_saddr = tcp_v4_rcv_saddr(sk);
       struct sock *sk2;
       struct hlist_node *node;
-       int reuse = sk->sk_reuse;
+       unsigned char reuse = sk->sk_reuse;
+       unsigned char state = sk->sk_state;

       sk_for_each_bound(sk2, node, &tb->owners) {
               if (sk != sk2 &&
@@ -193,7 +196,7 @@ static inline int tcp_bind_conflict(stru
                    !sk2->sk_bound_dev_if ||
                    sk->sk_bound_dev_if == sk2->sk_bound_dev_if)) {
                       if (!reuse || !sk2->sk_reuse ||
-                           sk2->sk_state == TCP_LISTEN) {
+                           (state == TCP_LISTEN && sk2->sk_state ==
TCP_LISTEN)) {
                               const u32 sk2_rcv_saddr = tcp_v4_rcv_saddr(sk2);
                               if (!sk2_rcv_saddr || !sk_rcv_saddr ||
                                   sk2_rcv_saddr == sk_rcv_saddr)
@@ -259,8 +262,14 @@ static int tcp_v4_get_port(struct sock *
       goto tb_not_found;
tb_found:
       if (!hlist_empty(&tb->owners)) {
-               if (sk->sk_reuse > 1)
-                       goto success;
+
+               /*
+                * sk_reuse is boolean
+                *
+                *if (sk->sk_reuse > 1)
+                *      goto success;
+                */
+
               if (tb->fastreuse > 0 &&
                   sk->sk_reuse && sk->sk_state != TCP_LISTEN) {
                       goto success;
