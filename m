Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWGGSNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWGGSNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWGGSNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:13:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932244AbWGGSNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:13:16 -0400
Subject: auro deadlock  (was Re: e100 lockdep irq lock inversion.)
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, mingo@elte.hu, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <20060707171916.GA16343@redhat.com>
References: <20060707171916.GA16343@redhat.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 20:13:09 +0200
Message-Id: <1152295989.3111.116.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 13:19 -0400, Dave Jones wrote:
> Another one triggered by a Fedora-development user..
> 
> e100: eth1: e100_watchdog: link up, 100Mbps, half-duplex
> 
> =========================================================
> [ INFO: possible irq lock inversion dependency detected ]
> ---------------------------------------------------------
> ipcalc/1671 just changed the state of lock:
>  (&skb_queue_lock_key){-+..}, at: [<c05ebe2f>] udp_ioctl+0x3b/0x6e
> but this lock was taken by another, hard-irq-safe lock in the past:
>  (&ai->aux_lock){+...}
> 
> and interrupts could create inverse lock ordering between them.


ok the situation is this:

the airo driver has a per card aux_lock.

This lock is used in the hardirq handler, and thus all uses need to be
irqsave (and they are)

Act 1

Enter the mpi_start_xmit() function, which is airo's xmit function.
This function takes the aux_lock first, with irq's off, then calls
skb_queue_tail(). skb_queue_tail takes the sk_receive_queue.lock (with
irqsave as well).

Act 2

Enter the ipcalc program. This program calls an ioctl, which ends up
calling udp_ioctl. udp_ioctl does
   spin_lock_bh(&sk->sk_receive_queue.lock);


This is a deadlock

For brevity, lock A is the aux_lock, lock B is the sk_receive_queue.lock

CPU 0				CPU 1
user context			user context
				udp_ioctl takes lock B with _bh
				(leaving irqs enabled)

mpi_start_function takes
lock A with _irqsave
mpi_start_function takes
lock B with _irqsave and spins

				interrupt happens
				the hard irq handler takes lock A
				.... and spins for cpu 0

eg a classic AB-BA deadlock.


Now a question for netdev: what is the interrupt-or-softirq rules for
the sk_receive_queue.lock?

Anyway, the patch below fixes this deadlock; it may or may not be the
correct solution depending on the netdev answer, but the deadlock is
gone ;)

Signed-off-by: Arjan van de Ven

Index: linux-2.6.18-rc1/net/ipv4/udp.c
===================================================================
--- linux-2.6.18-rc1.orig/net/ipv4/udp.c
+++ linux-2.6.18-rc1/net/ipv4/udp.c
@@ -725,6 +725,7 @@ out:
  
 int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
+	unsigned long flags;
 	switch(cmd) 
 	{
 		case SIOCOUTQ:
@@ -739,7 +740,7 @@ int udp_ioctl(struct sock *sk, int cmd, 
 			unsigned long amount;
 
 			amount = 0;
-			spin_lock_bh(&sk->sk_receive_queue.lock);
+			spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb != NULL) {
 				/*
@@ -749,7 +750,7 @@ int udp_ioctl(struct sock *sk, int cmd, 
 				 */
 				amount = skb->len - sizeof(struct udphdr);
 			}
-			spin_unlock_bh(&sk->sk_receive_queue.lock);
+			spin_unlock_irqrestore(&sk->sk_receive_queue.lock, flags);
 			return put_user(amount, (int __user *)arg);
 		}
 


