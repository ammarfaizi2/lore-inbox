Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbRENMc6>; Mon, 14 May 2001 08:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262051AbRENMcr>; Mon, 14 May 2001 08:32:47 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:58860 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S261960AbRENMch>; Mon, 14 May 2001 08:32:37 -0400
From: Michal Ostrowski <mostrows@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15103.53345.869090.593925@slug.watson.ibm.com>
Date: Mon, 14 May 2001 08:32:33 -0400
To: Marcell GAL <cell@sch.bme.hu>, linux-kernel@vger.kernel.org,
        paulus@samba.org, "David S. Miller" <davem@redhat.com>
Subject: Scheduling in interrupt BUG. [Patch]
In-Reply-To: <3AFFBF14.7D7BAB01@sch.bme.hu>
In-Reply-To: <3AFFBF14.7D7BAB01@sch.bme.hu>
X-Mailer: VM 6.92 under 21.4 (patch 1) "Copyleft" XEmacs Lucid
Reply-To: mostrows@speakeasy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcell GAL writes:
 > Hi Guys,
 > 
 > Once upon a time on my
 > x86 UP box, UP kernel 2.4.4, (64M ram, 260M swap)
 > http://home.sch.bme.hu/~cell/.config
 > I hit a reproducable "Scheduling in interrupt" BUG.
 > Also reproduced with 128M ram and low memory pressure
 > (first I suspected it is related to swapping)
 > Running lots of pppd version 2.4.0 (pppoe) sessions almost at the same
 > time. 
 > (before the crash the pppoe sessions work fine)
 > It crashed after 89 sessions, 473 another time.. (depending
 > on the phase of Jupiter moons I guess .. I still have to verify this),
 > usually much before memory is exhausted (30k mem/pppd process).
 > To do this you have to patch ppp_generic.c
 > http://x-dsl.hu/~cell/ppp_generic_hash/, because
 > otherwise we hit 'NULL ptr in all_ppp_units list'
 > BUG much _more likely_ than this 'sched.c line 709 thingy'..
 > 
 > EIP: c010faa4 <schedule+388/394>   <===== sched.c schedule(), line 709:
 > which is ~ printk("Scheduling in interrupt");BUG();

>From what I've seen, you have a call chain consisting of:

__release_sock -> pppoe_backlog_rcv -> __lock_sock

This is going to be bad, because when __release_sock calls
sk->backlog_rcv, lock.users is still non-zero and thus the lock_sock
operation will block (leading to deadlock).  This problem is fixed
with the patch that I've added below.

You're seeing the "Scheduling in interrupt" message because the
combined effect of the various spin_lock/unlock calls in release_sock
and __release_sock at the time of the call to sk->backlog_rcv is to
increase the local bh count.

Having looked at the code for locking sockets I am concerned that the
locking procedures for tcp may be wrong.   __release_sock releases the
socket spinlock before calling sk->backlog_rcv() (== tcp_v4_do_rcv),
however the comments at the top of tcp_v4_do_rcv() assert that the
socket's spinlock is held (which is definitely not the case).

Anybody care to comment on this?

Michal Ostrowski
mostrows@speakeasy.net

--- drivers/net/pppoe.c~	Tue Mar  6 22:44:35 2001
+++ drivers/net/pppoe.c	Mon May 14 08:24:06 2001
@@ -5,7 +5,7 @@
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.5
+ * Version:    0.6.6
  *
  * 030700 :     Fixed connect logic to allow for disconnect.
  * 270700 :	Fixed potential SMP problems; we must protect against
@@ -19,6 +19,7 @@
  * 051000 :	Initialization cleanup.
  * 111100 :	Fix recvmsg.
  * 050101 :	Fix PADT procesing.
+ * 140501 :	pppoe_backlog_rcv must call bh_lock_sock, not lock_sock.
  *
  * Author:	Michal Ostrowski <mostrows@styx.uwaterloo.ca>
  * Contributors:
@@ -384,9 +385,9 @@
  ***********************************************************************/
 int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
-	lock_sock(sk);
+	bh_lock_sock(sk);
 	pppoe_rcv_core(sk, skb);
-	release_sock(sk);
+	bh_unlock_sock(sk);
 	return 0;
 }
 

