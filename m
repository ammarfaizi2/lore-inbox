Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269915AbUJTLKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269915AbUJTLKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbUJTLIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:08:24 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:38929 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S269926AbUJTLCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:02:08 -0400
Message-ID: <417645A4.7000802@stud.feec.vutbr.cz>
Date: Wed, 20 Oct 2004 13:01:56 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176403B.5@stud.feec.vutbr.cz> <20041020105630.GB2614@elte.hu>
In-Reply-To: <20041020105630.GB2614@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000607040104020006080207"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607040104020006080207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>>I'm getting these BUGs when I use netconsole with Real-Time Preemption
>>(but netconsole works):
> 
> 
> you are getting them because interrupts get disabled somewhere in the
> path. Do your changes perhaps introduce a local_irq_save() or
> local_irq_disable()?
> 

I'm attaching my sk98lin patch. It uses disable_irq(). It's inspired by 
8139too.

> (in PREEMPT_REALTIME spin_lock_irq*() does not disable interrupts for
> mutex-based spinlocks, so the only way to get irqs disabled is
> explicitly.)
> 
> 	Ingo

Michal

--------------000607040104020006080207
Content-Type: text/plain;
 name="sk98lin-netpoll2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sk98lin-netpoll2.diff"

diff -Nurp linux-2.6.9/drivers/net/sk98lin/skge.c linux-2.6.9-mich/drivers/net/sk98lin/skge.c
--- linux-2.6.9/drivers/net/sk98lin/skge.c	2004-10-18 23:53:22.000000000 +0200
+++ linux-2.6.9-mich/drivers/net/sk98lin/skge.c	2004-10-20 01:09:07.566181320 +0200
@@ -1126,6 +1126,21 @@ SK_U32		IntSrc;		/* interrupts source re
 		return SkIsrRetHandled;
 } /* SkGeIsrOnePort */
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/**
+ * SkGePollController - polling receive, for netconsole
+ * @dev: network device
+ *
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void SkGePollController(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	SkGeIsr(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
 
 /****************************************************************************
  *
@@ -4960,6 +4975,9 @@ static int __devinit skge_probe_one(stru
 	dev->set_mac_address =	&SkGeSetMacAddr;
 	dev->do_ioctl =		&SkGeIoctl;
 	dev->change_mtu =	&SkGeChangeMtu;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller =	&SkGePollController;
+#endif
 	dev->flags &= 		~IFF_RUNNING;
 	SET_NETDEV_DEV(dev, &pdev->dev);
 

--------------000607040104020006080207--
