Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276377AbRJCPaX>; Wed, 3 Oct 2001 11:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276379AbRJCPaN>; Wed, 3 Oct 2001 11:30:13 -0400
Received: from chiara.elte.hu ([157.181.150.200]:48136 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276377AbRJCPaE>;
	Wed, 3 Oct 2001 11:30:04 -0400
Date: Wed, 3 Oct 2001 17:28:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110030850480.4495-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110031702280.7221-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> No. NAPI is for any type of network activities not just for routers or
> sniffers. It works just fine with servers. What do you see in there
> that will make it not work with servers?

eg. such solutions in tulip-NAPI-010910:

         /* For now we do this to avoid getting into
            IRQ mode too quickly */

         if( jiffies - dev->last_rx  == 0 ) goto not_done;
         [...]
 not_done:
         [...]
         return 1;

combined with this code in the net_rx_action softirq handler:

+         while (!list_empty(&queue->poll_list)) {
+                 struct net_device *dev;
[...]
+                 if (dev->quota <= 0 || dev->poll(dev, &budget)) {
+                         local_irq_disable();
+                         list_del(&dev->poll_list);
+                         list_add_tail(&dev->poll_list, &queue->poll_list);

while the stated goal of NAPI is to do 'intelligent, feedback based
polling', apparently the code is not trusting its own metrics, and is
forcing the interface into polling mode if we are still within the same 10
msec period of time, or if we have looped 300 times (default
netdev_max_backlog value). Not very intelligent IMO.

In a generic computing environment i want to spend cycles doing useful
work, not polling. Even the quick kpolld hack [which i dropped, so please
dont regard it as a 'competitor' patch] i consider superior to this, as i
can renice kpolld to reduce polling. (plus kpolld sucks up available idle
cycles as well.) Unless i royally misunderstand it, i cannot stop the
above code from wasting my cycles, and if that is true i do not want to
see it in the kernel proper in this form.

if the only thing done by a system is processing network packets, then
polling is a very nice solution for high loads. So do not take my comments
as an attack against polling.

*if* you can make polling a success in ~90% of the time we enter
tulip_poll() under non-specific server load (ie. not routing), then i
think you have really good metrics.

	Ingo

