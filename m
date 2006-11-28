Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757938AbWK1MNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbWK1MNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757934AbWK1MND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:13:03 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5920 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1757932AbWK1MNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:13:00 -0500
Subject: [PATCH] lockdep: fix sk->sk_callback_lock locking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>
In-Reply-To: <1164660685.30244.36.camel@localhost.localdomain>
References: <1164547971.30244.22.camel@localhost.localdomain>
	 <1164635760.6588.27.camel@twins>
	 <1164660685.30244.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 13:07:22 +0100
Message-Id: <1164715642.6588.58.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


=========================================================
[ INFO: possible irq lock inversion dependency detected ]
2.6.19-rc6 #4
---------------------------------------------------------
nc/1854 just changed the state of lock:
 (af_callback_keys + sk->sk_family#2){-.-?}, at: [<c0268a7f>] sock_def_error_report+0x1f/0x90
but this lock was taken by another, soft-irq-safe lock in the past:
 (slock-AF_INET){-+..}

and interrupts could create inverse lock ordering between them.

stack backtrace:
 [<c0103f36>] show_trace_log_lvl+0x26/0x40
 [<c010406b>] show_trace+0x1b/0x20
 [<c01049e4>] dump_stack+0x24/0x30
 [<c013738c>] print_irq_inversion_bug+0x10c/0x130
 [<c01374f2>] check_usage_backwards+0x42/0x50
 [<c0137912>] mark_lock+0x312/0x620
 [<c0138925>] __lock_acquire+0x4c5/0xcb0
 [<c0139499>] lock_acquire+0x69/0x90
 [<c02ddc49>] _read_lock+0x39/0x50
 [<c026778c>] sock_def_wakeup+0x1c/0x60
 [<c02b7d73>] inet_shutdown+0x93/0xf0
 [<c02648d2>] sys_shutdown+0x32/0x60
 [<c0266284>] sys_socketcall+0x1d4/0x260
 [<c01031f3>] syscall_call+0x7/0xb
 =======================

stack backtrace:
 [<c0103f36>] show_trace_log_lvl+0x26/0x40
 [<c010406b>] show_trace+0x1b/0x20
 [<c01049e4>] dump_stack+0x24/0x30
 [<c013738c>] print_irq_inversion_bug+0x10c/0x130
 [<c01374f2>] check_usage_backwards+0x42/0x50
 [<c0137912>] mark_lock+0x312/0x620
 [<c0138925>] __lock_acquire+0x4c5/0xcb0
 [<c0139499>] lock_acquire+0x69/0x90
 [<c02ddc59>] _read_lock+0x39/0x50
 [<c0268a7f>] sock_def_error_report+0x1f/0x90
 [<c029b968>] tcp_disconnect+0x318/0x490
 [<c02b9110>] inet_stream_connect+0x220/0x260
 [<c0264adb>] sys_connect+0x6b/0x90
 [<c026614f>] sys_socketcall+0x9f/0x260
 [<c01031f3>] syscall_call+0x7/0xb
 =======================

sk->sk_callback_lock is usually only read locked from softirq context
however it seems lockdep found two spots that are reachable from process
context, thus creating the possibility of a deadlock.

For now fix these two call sites with manual disabling of softirqs; if
more of these sites are found we might consider changing the read_lock() to
read_lock_bh().

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Martin Josefsson <gandalf@wlug.westbo.se>
---
 net/ipv4/af_inet.c |    2 ++
 net/ipv4/tcp.c     |    2 ++
 2 files changed, 4 insertions(+)

Index: linux-2.6-netdev/net/ipv4/af_inet.c
===================================================================
--- linux-2.6-netdev.orig/net/ipv4/af_inet.c	2006-11-27 14:41:51.000000000 +0100
+++ linux-2.6-netdev/net/ipv4/af_inet.c	2006-11-28 07:06:23.000000000 +0100
@@ -731,7 +731,9 @@ int inet_shutdown(struct socket *sock, i
 	}
 
 	/* Wake up anyone sleeping in poll. */
+	local_bh_disable();
 	sk->sk_state_change(sk);
+	local_bh_enable();
 	release_sock(sk);
 	return err;
 }
Index: linux-2.6-netdev/net/ipv4/tcp.c
===================================================================
--- linux-2.6-netdev.orig/net/ipv4/tcp.c	2006-11-28 07:06:16.000000000 +0100
+++ linux-2.6-netdev/net/ipv4/tcp.c	2006-11-28 07:06:20.000000000 +0100
@@ -1765,7 +1765,9 @@ int tcp_disconnect(struct sock *sk, int 
 
 	BUG_TRAP(!inet->num || icsk->icsk_bind_hash);
 
+	local_bh_disable();
 	sk->sk_error_report(sk);
+	local_bh_enable();
 	return err;
 }
 


