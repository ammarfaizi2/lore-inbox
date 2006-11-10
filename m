Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946380AbWKJKgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946380AbWKJKgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946378AbWKJKgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:36:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63625 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946380AbWKJKgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:36:10 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061110011336.008840cf.akpm@osdl.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.569684000@cruncher.tec.linutronix.de>
	 <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de>
	 <1163146206.8335.183.camel@localhost.localdomain>
	 <20061110005020.4538e095.akpm@osdl.org> <20061110085728.GA14620@elte.hu>
	 <20061110011336.008840cf.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:35:58 +0100
Message-Id: <1163154958.3138.671.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We're limping along in a semi-OK fashion with the TSC. 

that's because we fake it a heck of a lot; like after C3 we just make
the kernel guestimate how much to progress it so that it has just enough
ductape on it to not totally fall apart ;(

There's no easy answer. We can keep trying to ductape the TSC everywhere
it sort of breaks (cpu frequency changes on older chips, C3 idle (which
old kernels hit less often just because of the constant timer ticks),
cross cpu drifts and offsets etc etc). 
What that would need at minimum is
1) a per cpu "offset" that gets added to whatever we read from rdtsc
instruction
2) a per cpu "multiplier" or something that gets applied to tsc deltas
3) all code that gets to mop up where TSC breaks (cpuspeed and C3 power
states) use "other timers" to adjust the offset/multiplier values on a
per cpu basis, rather than "hardware TSC".

I suspect that is enough to mostly keep it limping along. It's not
cheap, but it moves the costs mostly to the places where the hardware
can't do it, so if you want to call gettimeofday() in a tight loop at
least you don't pay the hpet tax. (only an add and maybe a mul but those
are cheap and effectively unavoidable if we want to keep the illusion
alive)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

