Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbULVOiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbULVOiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbULVOiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:38:22 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:25985 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S261987AbULVOiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:38:05 -0500
Message-ID: <60880.192.102.214.6.1103726252.squirrel@webmail.wetlettuce.com>
Date: Wed, 22 Dec 2004 14:37:32 -0000 (GMT)
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: "Mark Broadbent" <markb@wetlettuce.com>
To: <kaber@trash.net>
In-Reply-To: <41C9525F.4070805@trash.net>
References: <20041217233524.GA11202@electric-eye.fr.zoreil.com>
        <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com>
        <20041220211419.GC5974@waste.org>
        <20041221002218.GA1487@electric-eye.fr.zoreil.com>
        <20041221005521.GD5974@waste.org>
        <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com>
        <20041221123727.GA13606@electric-eye.fr.zoreil.com>
        <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com>
        <20041221204853.GA20869@electric-eye.fr.zoreil.com>
        <20041221212737.GK5974@waste.org>
        <20041221225831.GA20910@electric-eye.fr.zoreil.com>
        <41C93FAB.9090708@trash.net>
        <41C9525F.4070805@trash.net>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <romieu@fr.zoreil.com>, <mpm@selenic.com>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Reply-To: markb@wetlettuce.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patrick McHardy said:
> Patrick McHardy wrote:
>> Francois Romieu wrote:
>>
>>> Marc, if the patch below happens to work, it should not drop messages
>>> like the previous one (it is an ugly short-term suggestion).
>>>
>>
>>> -    spin_lock(&np->dev->xmit_lock);
>>> +    while (!spin_trylock(&np->dev->xmit_lock)) {
>>> +        if (np->dev->xmit_lock_owner == smp_processor_id()) {
>>> +            struct Qdisc *q = dev->qdisc;
>>> +
>>> +            q->ops->enqueue(skb, q);
>>
>>
>> Shouldn't this be requeue ?
>
> Since the code doesn't dequeue itself, enqueue seems fine to keep
> at least the queued messages ordered. But you need to grab
> dev->queue_lock, otherwise you risk corrupting qdisc internal data. You
> should probably also deal with the noqueue-qdisc, which doesn't have an
> enqueue function. So it should look something like this:
>
> while (!spin_trylock(&np->dev->xmit_lock)) {
> 	if (np->dev->xmit_lock_owner == smp_processor_id()) {
> 		struct Qdisc *q;
>
> 		rcu_read_lock();
> 		q = rcu_dereference(dev->qdisc);
> 		if (q->enqueue) {
> 			spin_lock(&dev->queue_lock);
> 			q->ops->enqueue(skb, q);
> 			spin_unlock(&dev->queue_lock);
> 			netif_schedule(np->dev);
> 		} else
> 			kfree_skb(skb);
> 		rcu_read_unlock();
> 		return;
> 	}
> }

I've tried both patches (modified slightly to get them to compile) but
they both produce hard NMI detected lockups (as before).
Thanks
Mark

Patches after modification to allow compilation:

Francois' patch (against 2.6.10-rc3-bk10):

diff -X dontdiff -urN linux-2.6.9-rc3-bk10.orig/net/core/netpoll.c
linux-2.6.9-rc3-bk10/net/core/netpoll.c--- linux-2.6.9-rc3-bk10.orig/net/core/netpoll.c	2004-12-22
12:09:32.000000000 +0000+++ linux-2.6.9-rc3-bk10/net/core/netpoll.c	2004-12-22 14:13:54.000000000
+0000@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <asm/unaligned.h>
+#include <net/pkt_sched.h>

 /*
  * We maintain a small pool of fully-sized skbs, to make sure the
@@ -188,7 +189,15 @@
 		return;
 	}

-	spin_lock(&np->dev->xmit_lock);
+	while (!spin_trylock(&np->dev->xmit_lock)) {
+		if (np->dev->xmit_lock_owner == smp_processor_id()) {
+			struct Qdisc *q = np->dev->qdisc;
+
+			q->ops->enqueue(skb, q);
+			return;
+		}
+	}
+
 	np->dev->xmit_lock_owner = smp_processor_id();

 	/*

Patrick's patch (against 2.6.10-rc3-bk10):

diff -X dontdiff -urN linux-2.6.9-rc3-bk10.orig/net/core/netpoll.c
linux-2.6.9-rc3-bk10/net/core/netpoll.c--- linux-2.6.9-rc3-bk10.orig/net/core/netpoll.c	2004-12-22
12:09:32.000000000 +0000+++ linux-2.6.9-rc3-bk10/net/core/netpoll.c	2004-12-22 11:08:06.000000000
+0000@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <asm/unaligned.h>
+#include <net/pkt_sched.h>

 /*
  * We maintain a small pool of fully-sized skbs, to make sure the
@@ -188,7 +189,24 @@
 		return;
 	}

-	spin_lock(&np->dev->xmit_lock);
+	while (!spin_trylock(&np->dev->xmit_lock)) {
+		if (np->dev->xmit_lock_owner == smp_processor_id()) {
+			struct Qdisc *q;
+
+			rcu_read_lock();
+			q = rcu_dereference(np->dev->qdisc);
+			if (q->enqueue) {
+				spin_lock(&np->dev->queue_lock);
+				q->ops->enqueue(skb, q);
+				spin_unlock(&np->dev->queue_lock);
+				netif_schedule(np->dev);
+			} else
+				__kfree_skb(skb);
+			rcu_read_unlock();
+			return;
+		}
+	}
+
 	np->dev->xmit_lock_owner = smp_processor_id();

 	/*


-- 
Mark Broadbent <markb@wetlettuce.com>
Web: http://www.wetlettuce.com



