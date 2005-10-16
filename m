Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVJPTYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVJPTYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 15:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVJPTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 15:24:38 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:39818
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751358AbVJPTYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 15:24:37 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
In-Reply-To: <Pine.LNX.4.61.0510150143500.1386@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509301825290.3728@scrub.home>
	 <1128168344.15115.496.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510100213480.3728@scrub.home>
	 <1129016558.1728.285.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
	 <Pine.LNX.4.61.0510150143500.1386@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 16 Oct 2005 21:26:48 +0200
Message-Id: <1129490809.1728.874.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-16 at 18:34 +0200, Roman Zippel wrote:

> The spec is not really clear and Thomas refusal to explain his design 
> decision is as also not really helpful. :-(

I did explain, why I did the rounding in the way it is implemented. If
you define the fact that I have a different interpretation of SUS than
you as refusal, then we can stop this thread right here.

> He sets the timer resolution to (NSEC_PER_SEC/HZ) which matches no value 
> above and this way he basically creates another virtual timer, which has 
> only little to do with the real kernel timer tick.

As George explained already we return the resolution of the timer as the
value which can be assumed to be the resolution of the event source,
which drives the timer, because that seems to be the only interesting
value for an application programmer. The theoretical resolution of a
jiffie based timer system is NSEC_PER_SEC/HZ. 

So why is NSEC_PER_SEC/HZ creating a virtual timer ? Because the ntp
adjusted resolution per tick is 1% off ?

I really don't see any sense in returning changing resolution values
every 5 minutes due to NTP adjustments. I imagine the happiness of
application programmers which actually do calculations based on such a
resolution value.

And in the logical consequence you would have to save the original
userspace timespec value including the time when the timer is set up and
redo the rounding and calculation every time NTP changes the
NSEC_PER_TICK value for _all_ timers which are related to
CLOCK_MONOTONIC and CLOCK_REALTIME. 

The code does not introduce a virtual timer at all. It uses the ntp
adjusted time reference and guarantees that the timer goes not off
early. Usually it expires with the next tick - of course system load can
delay it further. 

	tglx


