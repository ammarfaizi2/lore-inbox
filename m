Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbRBHMKG>; Thu, 8 Feb 2001 07:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbRBHMJ6>; Thu, 8 Feb 2001 07:09:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:54996 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129032AbRBHMJp>;
	Thu, 8 Feb 2001 07:09:45 -0500
Date: Thu, 8 Feb 2001 12:52:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        vandrove@vc.cvut.cz
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <200102080504.GAA23507@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1010208123938.29177H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Mikael Pettersson wrote:

> No, poking into MSRs not explicitly defined on the current CPU is
> inherently unsafe. I have several x86 CPU data sheets here in front
> of me which say the same thing: "Don't write to undocumented MSRs."

 Your point is right -- the problem are not undefined MSRs (that raise
#GP(0) on an access) but undocumented ones, sigh...

> You cannot assume that every single x86 out there stays clear of
> all Intel-defined MSRs. Intel has also expanded this set over time:
> older designs may not even have known about the APIC_BASE MSR.

 Intel is actually sane -- you get #GP(0) for this MSR on P5.  Others
might not and there are less cluefull vendors out there.

> 1. identify_cpu() (and more importantly get_cpu_vendor()) is called
[...]
> 2. include/asm-i386/processor.h #defines X86_VENDOR_INTEL as 0.
[...]
> 3. init/main.c calls time_init() before check_bugs() and thus
[...]
> 4. The cpu detection code rewrite in 2.4.0-test<something>
[...]

 Yes, there are more problems as well.  I'm working on it -- you may want
to look at the preliminary patch I sent here on Monday (strangely enough,
nobody out of linux-kernel seemed to be interested so far).  Next version
should be available later this week -- the main problem with moving
identify_cpu() earlier are other cpu_data fields that get initialized
later, so more code needs to be actually rewritten.

> Ideally, identify_cpu() should be run before init_apic_mappings(),
> but my attempts to do so has so far had some weird side-effects
> (lost interrupts, incorrect bogomips, apparently stuck watchdog,
> and keyboard timeouts), so I won't touch that stuff.

 You see.  I'm going to move identify_cpu() very early anyway, but this
need a careful code review.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
