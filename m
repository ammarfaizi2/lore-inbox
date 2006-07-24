Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWGXRvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWGXRvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWGXRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:51:54 -0400
Received: from colin.muc.de ([193.149.48.1]:40207 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932266AbWGXRvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:51:51 -0400
Date: 24 Jul 2006 19:51:50 +0200
Date: Mon, 24 Jul 2006 19:51:50 +0200
From: Andi Kleen <ak@muc.de>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060724175150.GD50320@muc.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724171711.GA3662@kiste.smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 07:17:11PM +0200, Matthias Urlichs wrote:
> > Andi: If this is a generic issue, and not specific to Matthias' box, we
> > may need to re-think the assumption that Intel SMP is synced. You're
> > thoughts?
> > 
> "Your". ;-)
> 
> You can probably assume that they're synced on systems with no more
> than one dual-core / hyperthreaded CPU.
> 
> My system obviously has two of those.

According to Intel on all of their chipsets/motherboard reference
designs all the sockets run from a single clock crystal.

I've confirmed this for a long time on 64bit and even to some
extent on 32bit on distro kernels.

Maybe you got a broken BIOS or similar though.

> > Matthias: "clock=pmtmr" is probably the best workaround in the short
> > term. Could you send me your dmesg and dmidecode output? We'll try to
> > find something to key off of so it will mark the tsc as unstable by
> > default on your system.
> > 
> I'd assume that finding (and, possibly, being unable to correct) TSC skew 

The BIOS normally guarantee it at boot. However maybe you got a broken one.

We used to do TSC sync correction at boot on Intel, but stopped doing 
that when we found out that the TSC sync code adds an error
To an already perfectly synchronized system.

Actually I think i386 still does it, just x86-64 stopped 

My first assumption would be that you hit a bug somewhere in the new
clock code. What happens when you boot an older kernel (like 2.6.17)
with clock=tsc ? 


>  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
>  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
> Warning only 4GB will be used.

You should at least set CONFIG_HIGHMEM_64G or use a 64bit 
kernel if the system does long mode.

> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> checking TSC synchronization across 4 CPUs:
> CPU#0 had 748437 usecs TSC skew, fixed it up.
> CPU#1 had 748437 usecs TSC skew, fixed it up.
> CPU#2 had -748437 usecs TSC skew, fixed it up.
> CPU#3 had -748437 usecs TSC skew, fixed it up.

Hmm, that looks unusual. Maybe the BIOS is really broken.
On most Intel systems I saw 

Normally Linux should fix it up here and then the TSC should
tick synchronous though (but with an small offset that the sync
code cannot entirely avoid)

> 
> Handle 0x0000, DMI type 0, 20 bytes.
> BIOS Information
>         Vendor: Phoenix Technologies LTD
>         Version: 6.00
>         Release Date: 09/29/2005
> 
> Handle 0x0001, DMI type 1, 25 bytes.
> System Information
>         Manufacturer: Intel Corporation
>         Product Name: Nocona/Tumwater Customer Reference Board
>         Version: Revision A0


Hmm, those should definitely have a synced TSC. 

However A0 suspiciously sounds like a engineering sample, normally
production systems have higher revision numbers. If it's just
a beta hardware bug we probably won't care.

Asit, do you know of any TSC sync between CPUs issues in that 
board/BIOS version?

-Andi


>         Serial Number: 0123456789
>         UUID: 0A0A0A0A-0A0A-0A0A-0A0A-0A0A0A0A0A0A
>         Wake-up Type: Power Switch
> 
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
>         Manufacturer: Intel Corporation
>         Product Name: TYAN Tiger-i7320-S5350
>         Version: Revision A0
>         Serial Number: 9876543210
> 
