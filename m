Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVDPBwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVDPBwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVDPBwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:52:35 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:20491 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262561AbVDPBwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:52:30 -0400
Date: Sat, 16 Apr 2005 11:49:06 +1000
To: Thomas Graf <tgraf@suug.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>, hadi@cyberus.ca,
       netdev <netdev@oss.sgi.com>, Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>,
       kuznet@ms2.inr.ac.ru, devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
Message-ID: <20050416014906.GA3291@gondor.apana.org.au>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain> <20050415225422.GF4114@postel.suug.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20050415225422.GF4114@postel.suug.ch>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 15, 2005 at 10:54:22PM +0000, Thomas Graf wrote:
>
> Another case were it's not locked is upon a deletion of a class where
> the class deletes its inner qdisc, although there is only one case
> how this can happen and that's under rtnl semaphore so there is no
> way we can have a dumper at the same time.

Sorry, that's where tc went astray :)

The assumption that the rtnl is held during dumping is false.  It is
only true for the initial dump call.  All subsequent dumps are not
protected by the rtnl.

The solution is certainly not to place the dumpers under rtnl :)
The dump operation is read-only and should not need any exclusive
locks.

In fact the whole qdisc locking is a mess.  It's a cross-breed
between locking with ad-hoc reference counting and RCU.  What's
more, the RCU is completely useless too because for the case
where we actually have a queue we still end up taking the spin
lock on each transmit! I think someone's been benchmarking the
loopback device again :)

It needs to be reengineered.

Here is a quick'n'dirty fix to the problem at hand.  What happened
between 2.6.10-rc1 and 2.6.10-rc2 is that qdisc_destroy started
changing the next pointer of qdisc entries which totally confuses
the readers because qdisc_destroy doesn't always take the tree lock.

This patch tries to ensure that all top-level calls to qdisc_destroy
come under the tree lock.  As Thomas correctedly pointed out, most
of the other qdisc_destroy calls occur after the top qdisc has been
unlinked from the device qdisc_list.  However, someone should go
through each one of the remaining ones (they're all in the individual
sch_* implementations) and make sure that this assumption is really
true.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

If anyone has cycles to spare and a stomach strong enough for
this stuff, here is your chance :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== net/sched/sch_api.c 1.47 vs edited =====
--- 1.47/net/sched/sch_api.c	2005-04-01 14:35:56 +10:00
+++ edited/net/sched/sch_api.c	2005-04-16 08:47:16 +10:00
@@ -608,9 +608,9 @@
 			return err;
 		if (q) {
 			qdisc_notify(skb, n, clid, q, NULL);
-			spin_lock_bh(&dev->queue_lock);
+			qdisc_lock_tree(dev);
 			qdisc_destroy(q);
-			spin_unlock_bh(&dev->queue_lock);
+			qdisc_unlock_tree(dev);
 		}
 	} else {
 		qdisc_notify(skb, n, clid, NULL, q);
@@ -743,17 +743,17 @@
 		err = qdisc_graft(dev, p, clid, q, &old_q);
 		if (err) {
 			if (q) {
-				spin_lock_bh(&dev->queue_lock);
+				qdisc_lock_tree(dev);
 				qdisc_destroy(q);
-				spin_unlock_bh(&dev->queue_lock);
+				qdisc_unlock_tree(dev);
 			}
 			return err;
 		}
 		qdisc_notify(skb, n, clid, old_q, q);
 		if (old_q) {
-			spin_lock_bh(&dev->queue_lock);
+			qdisc_lock_tree(dev);
 			qdisc_destroy(old_q);
-			spin_unlock_bh(&dev->queue_lock);
+			qdisc_unlock_tree(dev);
 		}
 	}
 	return 0;

--9amGYk9869ThD9tj--
