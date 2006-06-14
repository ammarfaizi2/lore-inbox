Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWFNTnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWFNTnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWFNTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:43:33 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:21884 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932132AbWFNTnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:43:32 -0400
Date: Wed, 14 Jun 2006 21:43:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Frank Pavlic <fpavlic@de.ibm.com>
Subject: [patch] ipv4: fix lock usage in udp_ioctl
Message-ID: <20060614194305.GB10391@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix lock usage in udp_ioctl().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

udp_poll() seems to have the same problem, right?

As reported by the lock validator:

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {in-hardirq-W} -> {hardirq-on-W} usage.
syslogd/739 [HC0[0]:SC0[1]:HE1:SE0] takes:
 (&list->lock){++..}, at: [<002e36d6>] udp_ioctl+0x96/0x100
{in-hardirq-W} state was registered at:
  [<00062128>] lock_acquire+0x9c/0xc0
  [<0036209e>] _spin_lock_irqsave+0x66/0x84
  [<002912ce>] skb_dequeue+0x32/0xb0
  [<00263160>] qeth_qdio_output_handler+0x3e8/0xf8c
  [<00219fdc>] tiqdio_thinint_handler+0xde0/0x2234
  [<0020448c>] do_adapter_IO+0x5c/0xa8
  [<0020842c>] do_IRQ+0x13c/0x18c
  [<000208a2>] io_no_vtime+0x16/0x1c
  [<0001978c>] cpu_idle+0x1d0/0x20c
irq event stamp: 1694
hardirqs last  enabled at (1693): [<003629c2>] _spin_unlock_irqrestore+0x92/0xa8
hardirqs last disabled at (1692): [<00362074>] _spin_lock_irqsave+0x3c/0x84
softirqs last  enabled at (1682): [<0028c7c4>] release_sock+0xe4/0xf4
softirqs last disabled at (1694): [<00361f7e>] _spin_lock_bh+0x2e/0x70

other info that might help us debug this:
no locks held by syslogd/739.

stack backtrace:
000000000fd6c148 000000000de2f960 0000000000000002 0000000000000000 
       000000000de2fa00 000000000de2f978 000000000de2f978 000000000001737c 
       0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       000000000de2f960 000000000000000c 000000000de2f960 000000000de2f9d0 
       000000000036fe70 000000000001737c 000000000de2f960 000000000de2f9b0 
Call Trace:
([<000000000001730a>] show_trace+0x166/0x16c)
 [<00000000000173d6>] show_stack+0xc6/0xf8
 [<0000000000017436>] dump_stack+0x2e/0x3c
 [<000000000005f978>] print_usage_bug+0x23c/0x250
 [<00000000000607cc>] mark_lock+0x594/0x714
 [<00000000000613be>] __lock_acquire+0x252/0xf20
 [<0000000000062128>] lock_acquire+0x9c/0xc0
 [<0000000000361fa8>] _spin_lock_bh+0x58/0x70
 [<00000000002e36d6>] udp_ioctl+0x96/0x100
 [<00000000002eadd6>] inet_ioctl+0x72/0x11c
 [<00000000002893f2>] sock_ioctl+0x1ca/0x2c0
 [<00000000000c13ee>] do_ioctl+0x56/0xe0
 [<00000000000c14f2>] vfs_ioctl+0x7a/0x384
 [<00000000000c184e>] sys_ioctl+0x52/0x84
 [<00000000000e80a2>] do_ioctl32_pointer+0x2a/0x3c
 [<00000000000e55c8>] compat_sys_ioctl+0x168/0x378
 [<0000000000020338>] sysc_noemu+0x10/0x16

diffstat:
 net/ipv4/udp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3f93292..b15a17b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -740,7 +740,7 @@ int udp_ioctl(struct sock *sk, int cmd, 
 			unsigned long amount;
 
 			amount = 0;
-			spin_lock_bh(&sk->sk_receive_queue.lock);
+			spin_lock_irq(&sk->sk_receive_queue.lock);
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb != NULL) {
 				/*
@@ -750,7 +750,7 @@ int udp_ioctl(struct sock *sk, int cmd, 
 				 */
 				amount = skb->len - sizeof(struct udphdr);
 			}
-			spin_unlock_bh(&sk->sk_receive_queue.lock);
+			spin_unlock_irq(&sk->sk_receive_queue.lock);
 			return put_user(amount, (int __user *)arg);
 		}
 
