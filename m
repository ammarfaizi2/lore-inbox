Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269719AbUJWBdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269719AbUJWBdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269673AbUJWBYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:24:39 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52644
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269621AbUJWBXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:23:17 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <20041022175633.GA1864@elte.hu>
References: <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
	 <20041022155048.GA16240@elte.hu>  <20041022175633.GA1864@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 23 Oct 2004 03:15:12 +0200
Message-Id: <1098494112.3306.113.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 19:56 +0200, Ingo Molnar wrote:
> i have released the -U10.2 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/

The current version is -U10.3

Find below a patch against -U10.3. It contains a couple of smaller fixes
including the network driver bootup BUG.

<Dislaimer>
I'm trying to start a serious discussion on that. It's not my intention
to start a flamewar. 
</Disclaimer>

The network driver load/unload problem, which was reported from a couple
of testers, is related to Ingo's check inside of atomic_dec_and_test().

        if (!atomic_read(v)) {
                printk("BUG: atomic counter underflow at:\n");
                dump_stack();
        }

The unmodified atomic_dec_and_test() returns 0 in all cases except for
the case when the counter is 0 after the decrement. This implementation
covers automatically the case, where atomic_dec_and_test() is called
with counter == 0.

The network code uses atomic_dec_and_test() in qdisk_destroy to check,
if the caller owns the last reference to the qdisc. This covers also the
case when no reference is there when this is called. I fixed this for
now with a check for 0 before calling qdisk_destroy().

Thats a fix, but not an answer to the following question.

The question is whether the atomic implementation is intended to allow
counter values less than 0 or not. Reviewing the usage it seems not to
be the case. The qdisc_destroy code is the only place I recognized so
far, which makes use of that implementation detail.

>From my point of view is allowing such usage covering a hidden problem. 

Assume count = 0, call atomic_dec_test() and you have count = -1. 
At a differemt places the check is if (!atomic_read(v)){...}
If count = -1 it signals, that data or whatever is available.  

I don't think there is code which is actually failing on that, but as a
design rule it might turn out that Ingo's check and the implied rule
"count must be >= 0" is appropriate.

tglx
---

diff --exclude='*~' -urN 2.6.9-mm1-U10.3/drivers/net/8139too.c
2.6.9-mm1-U10.work/drivers/net/8139too.c
--- 2.6.9-mm1-U10.3/drivers/net/8139too.c	2004-10-23 01:59:14.000000000
+0200
+++ 2.6.9-mm1-U10.work/drivers/net/8139too.c	2004-10-22
23:18:32.000000000 +0200
@@ -749,7 +749,7 @@
 	pci_release_regions (pdev);
 
 	free_netdev(dev);
-
+	pci_disable_device (pdev);
 	pci_set_drvdata (pdev, NULL);
 }
 
diff --exclude='*~' -urN
2.6.9-mm1-U10.3/drivers/pci/hotplug/cpci_hotplug_core.c
2.6.9-mm1-U10.work/drivers/pci/hotplug/cpci_hotplug_core.c
--- 2.6.9-mm1-U10.3/drivers/pci/hotplug/cpci_hotplug_core.c	2004-10-23
01:59:15.000000000 +0200
+++ 2.6.9-mm1-U10.work/drivers/pci/hotplug/cpci_hotplug_core.c
2004-10-22 19:06:47.000000000 +0200
@@ -598,7 +598,7 @@
 		msleep(100);
 	}
 	dbg("poll thread signals exit");
-	up(&thread_exit);
+	complete(&thread_exit);
 	return 0;
 }
 
diff --exclude='*~' -urN 2.6.9-mm1-U10.3/net/sched/sch_generic.c
2.6.9-mm1-U10.work/net/sched/sch_generic.c
--- 2.6.9-mm1-U10.3/net/sched/sch_generic.c	2004-10-23
01:59:12.000000000 +0200
+++ 2.6.9-mm1-U10.work/net/sched/sch_generic.c	2004-10-23
02:45:58.000000000 +0200
@@ -584,7 +584,9 @@
 	qdisc = dev->qdisc_sleeping;
 	dev->qdisc = &noop_qdisc;
 	dev->qdisc_sleeping = &noop_qdisc;
-	qdisc_destroy(qdisc);
+
+	if (atomic_read(&qdisc->refcnt))
+		qdisc_destroy(qdisc);
 #if defined(CONFIG_NET_SCH_INGRESS) ||
defined(CONFIG_NET_SCH_INGRESS_MODULE)
         if ((qdisc = dev->qdisc_ingress) != NULL) {
 		dev->qdisc_ingress = NULL;
diff --exclude='*~' -urN 2.6.9-mm1-U10.3/drivers/pcmcia/yenta_socket.c
2.6.9-mm1-U10.work/drivers/pcmcia/yenta_socket.c
--- 2.6.9-mm1-U10.3/drivers/pcmcia/yenta_socket.c	2004-10-22
16:52:26.000000000 +0200
+++ 2.6.9-mm1-U10.work/drivers/pcmcia/yenta_socket.c	2004-10-22
21:26:15.000000000 +0200
@@ -653,6 +653,7 @@
 	yenta_free_resources(sock);
 
 	pci_release_regions(dev);
+	pci_disable_device(dev);
 	pci_set_drvdata(dev, NULL);
 }
 

