Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276978AbRJCVGG>; Wed, 3 Oct 2001 17:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276979AbRJCVFr>; Wed, 3 Oct 2001 17:05:47 -0400
Received: from robur.slu.se ([130.238.98.12]:36103 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S276978AbRJCVFa>;
	Wed, 3 Oct 2001 17:05:30 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15291.32311.499838.886628@robur.slu.se>
Date: Wed, 3 Oct 2001 23:08:07 +0200
To: <mingo@elte.hu>
Cc: jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>
In-Reply-To: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca>
	<Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar writes:

 > (i did not criticize the list_add/list_del in any way, it's obviously
 > correct to cycle the polled devices. I highlited that code only to show
 > that the current patch as-is polls too agressively for generic server
 > load.)

 Yes I think we need some data here... 

 > can you really make it 100% successful for rx? Ie. do you only ever call
 > the ->poll() function if there is a new packet waiting? How do you know
 > with a 100% probability that someone on the network just sent a new packet
 > waiting? (without receiving an interrupt to begin with that is.)

 Well we need RX-interrupts not to spin away the CPU or exhaust the the PCI-
 bus. The NAPI scheme is simple, turn off RX-interrupts when the first packet
 comes and have the kernel to pull packets from the RX-ring. 

 I tried have pure polling... it easy do just have your driver return
 "not_done" all the time. Not a good idea. :-) Maybe as sofirq test.
 
 If the device has more packets to deliver than is "allowed" we put this
 back on list and the polling process can give the next device its share
 and so on. So we handle screaming network devices and packet flooding 
 nicely a deliver a decent performance even under those circumstances.

 As you seen from some code fragments we have played with some mechanisms 
 to delay the transition from polling to irq-enable. I think I accepted
 a not_done polls for jiffies in some of the tests. Agree other variants 
 are possible and hopefully better.

 SMP is another area, robustness and performance of course but in case
 of SMP we also have to deal with packet reordering which is something
 we really like to minimize. Even here I think the NAPI polling scheme 
 is interesting. During consecutive polls the device is bound to the same 
 CPU and no packet reordering should occur. 

 And from data we have now we can see packet load is even distributed
 among different CPU's and should follow the smp_affinity.

 Cheers.

						--ro


 
