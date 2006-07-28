Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWG1Ifv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWG1Ifv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbWG1Ifv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:35:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5261 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751985AbWG1Ifu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:35:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=cM1ABnBZhONbHiymtOTlPyvxqhouP8NbtDzSDOeXgKmQl9yx/cqC4Bg9n+B7FrgDjzne22//ZbvIGA7cMC5xVEqlvWDGWat7+xBT+sQUyssupiQW1WmcEq8B7gvzfRPTGKQktc5O+XFnZuLbNnVbOE77ZmQDKzXz+63ptxLhON4=
Date: Fri, 28 Jul 2006 10:35:32 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jet@gyve.org
Subject: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc
Message-ID: <20060728083532.GA311@slug>
References: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> 
Hi,

I think that the bluetooth-guard-bt_proto-with-rwlock.patch introduced the following
BUG:
[   43.232000] BUG: sleeping function called from invalid context at mm/slab.c:2903
[   43.232000] in_atomic():1, irqs_disabled():0
[   43.232000]  [<c0104114>] show_trace_log_lvl+0x197/0x1ba
[   43.232000]  [<c010415e>] show_trace+0x27/0x29
[   43.232000]  [<c010426e>] dump_stack+0x26/0x28
[   43.232000]  [<c011ad1c>] __might_sleep+0xa2/0xaa
[   43.232000]  [<c0173085>] __kmalloc+0x9c/0xb3
[   43.232000]  [<c02f9295>] sk_alloc+0x1bc/0x1de
[   43.232000]  [<c036d689>] hci_sock_create+0x42/0x8a
[   43.236000]  [<c0366f40>] bt_sock_create+0xb5/0x154
[   43.236000]  [<c02f69dc>] __sock_create+0x131/0x356
[   43.236000]  [<c02f6c2f>] sock_create+0x2e/0x30
[   43.236000]  [<c02f6c88>] sys_socket+0x27/0x53
[   43.240000]  [<c02f7db5>] sys_socketcall+0xa9/0x277
[   43.240000]  [<c0103131>] sysenter_past_esp+0x56/0x8d
[   43.240000]  [<b7f38410>] 0xb7f38410


This patch makes sk_alloc GFP_ATOMIC, because we are holding the bt_proto_rwlock, for
the following functions:
- bnep_sock_create
- cmtp_sock_create
- hci_sock_create
- hidp_sock_create
- l2cap_sock_create
- rfcomm_sock_create
- sco_sock_create

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>


diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/bnep/sock.c v2.6.18-rc2-mm1/net/bluetooth/bnep/sock.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/bnep/sock.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/bnep/sock.c	2006-07-28 10:18:34.000000000 +0200
@@ -181,7 +181,7 @@ static int bnep_sock_create(struct socke
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(PF_BLUETOOTH, GFP_KERNEL, &bnep_proto, 1);
+	sk = sk_alloc(PF_BLUETOOTH, GFP_ATOMIC, &bnep_proto, 1);
 	if (!sk)
 		return -ENOMEM;
 
diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/cmtp/sock.c v2.6.18-rc2-mm1/net/bluetooth/cmtp/sock.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/cmtp/sock.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/cmtp/sock.c	2006-07-28 10:18:49.000000000 +0200
@@ -172,7 +172,7 @@ static int cmtp_sock_create(struct socke
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(PF_BLUETOOTH, GFP_KERNEL, &cmtp_proto, 1);
+	sk = sk_alloc(PF_BLUETOOTH, GFP_ATOMIC, &cmtp_proto, 1);
 	if (!sk)
 		return -ENOMEM;
 
diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/hci_sock.c v2.6.18-rc2-mm1/net/bluetooth/hci_sock.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/hci_sock.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/hci_sock.c	2006-07-28 09:28:48.000000000 +0200
@@ -618,7 +618,7 @@ static int hci_sock_create(struct socket
 
 	sock->ops = &hci_sock_ops;
 
-	sk = sk_alloc(PF_BLUETOOTH, GFP_KERNEL, &hci_sk_proto, 1);
+	sk = sk_alloc(PF_BLUETOOTH, GFP_ATOMIC, &hci_sk_proto, 1);
 	if (!sk)
 		return -ENOMEM;
 
diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/hidp/sock.c v2.6.18-rc2-mm1/net/bluetooth/hidp/sock.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/hidp/sock.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/hidp/sock.c	2006-07-28 10:19:03.000000000 +0200
@@ -178,7 +178,7 @@ static int hidp_sock_create(struct socke
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(PF_BLUETOOTH, GFP_KERNEL, &hidp_proto, 1);
+	sk = sk_alloc(PF_BLUETOOTH, GFP_ATOMIC, &hidp_proto, 1);
 	if (!sk)
 		return -ENOMEM;
 
diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/l2cap.c v2.6.18-rc2-mm1/net/bluetooth/l2cap.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/l2cap.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/l2cap.c	2006-07-28 10:09:12.000000000 +0200
@@ -559,7 +559,7 @@ static int l2cap_sock_create(struct sock
 
 	sock->ops = &l2cap_sock_ops;
 
-	sk = l2cap_sock_alloc(sock, protocol, GFP_KERNEL);
+	sk = l2cap_sock_alloc(sock, protocol, GFP_ATOMIC);
 	if (!sk)
 		return -ENOMEM;
 
diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/rfcomm/sock.c v2.6.18-rc2-mm1/net/bluetooth/rfcomm/sock.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/rfcomm/sock.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/rfcomm/sock.c	2006-07-28 10:16:59.000000000 +0200
@@ -336,7 +336,7 @@ static int rfcomm_sock_create(struct soc
 
 	sock->ops = &rfcomm_sock_ops;
 
-	if (!(sk = rfcomm_sock_alloc(sock, protocol, GFP_KERNEL)))
+	if (!(sk = rfcomm_sock_alloc(sock, protocol, GFP_ATOMIC)))
 		return -ENOMEM;
 
 	rfcomm_sock_init(sk, NULL);
diff -x'*.o' -pruN v2.6.18-rc2-mm1~ori/net/bluetooth/sco.c v2.6.18-rc2-mm1/net/bluetooth/sco.c
--- v2.6.18-rc2-mm1~ori/net/bluetooth/sco.c	2006-07-27 11:45:45.000000000 +0200
+++ v2.6.18-rc2-mm1/net/bluetooth/sco.c	2006-07-28 10:11:28.000000000 +0200
@@ -452,7 +452,7 @@ static int sco_sock_create(struct socket
 
 	sock->ops = &sco_sock_ops;
 
-	if (!(sk = sco_sock_alloc(sock, protocol, GFP_KERNEL)))
+	if (!(sk = sco_sock_alloc(sock, protocol, GFP_ATOMIC)))
 		return -ENOMEM;
 
 	sco_sock_init(sk, NULL);
