Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVLIT4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVLIT4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVLIT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:56:30 -0500
Received: from natblindhugh.rzone.de ([81.169.145.175]:8367 "EHLO
	natblindhugh.rzone.de") by vger.kernel.org with ESMTP
	id S932423AbVLIT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:56:30 -0500
Subject: Re: [PATCH] x86_64: Display HPET timer option
From: Erwin Rol <mailinglists@erwinrol.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201211848.GE997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
	 <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
	 <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
	 <20051201204339.GC997@wotan.suse.de>
	 <1133471197.3604.3.camel@xpc.home.erwinrol.com>
	 <20051201211848.GE997@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 20:56:17 +0100
Message-Id: <1134158178.3686.2.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 (2.5.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi,

I looked a bit better at what happens (by adding a bunch of printk's in
drivers/char/hpet.c) and it seems that read_counter(&hpet->hpet_mc);
always returns -1 and that causes the following loop in 
static unsigned long hpet_calibrate(struct hpets *hpetp)
to endlessly loop while having local_irq_save(flags).

do {
	m = read_counter(&hpet->hpet_mc);
        write_counter(t + m + hpetp->hp_delta, &timer->hpet_compare);
} while (i++, (m - start) < count);

count is 0xe9 and start and (m - start) is 0. 

What could be the reason that read_counter(&hpet->hpet_mc) is and stays
-1 ?


- Erwin 

On Thu, 2005-12-01 at 22:18 +0100, Andi Kleen wrote: 
> On Thu, Dec 01, 2005 at 10:06:37PM +0100, Erwin Rol wrote:
> > On Thu, 2005-12-01 at 21:43 +0100, Andi Kleen wrote:
> > > On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> > > > On Thu, 1 Dec 2005, Linus Torvalds wrote:
> > > > 
> > > > > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > > > > >
> > > > > > Currently the HPET timer option isn't visible in menuconfig.
> > > > > 
> > > > > Do you want it to?
> > > > > 
> > > > > Why would you ever compile it out?
> > > > 
> > > > For timer testing purposes i sometimes would like not to use the HPET. 
> > > > Would a runtime switch be preferred?
> > > 
> > > nohpet already exists.
> > > 
> > 
> > And luckily it does cause without "nohpet" i can't boot my shuttle
> > ST20G5, the NMI watchdog kills it because ti hangs when initializing the
> > hpet. If the nmi watchdog is off it just hangs for ever. 
> 
> Can you give details on the machine? lspci, dmidecode, acpidmp output,
> boot log from the hang case?
> 
> Then perhaps it can be blacklisted or the failure otherwise avoided.
> 
> [Looks like I finally need to add DMI decode support to x86-64 too :-/]
> 
> -Andi
> 
> 

