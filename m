Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBCAAT>; Fri, 2 Feb 2001 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRBCAAK>; Fri, 2 Feb 2001 19:00:10 -0500
Received: from [62.172.234.2] ([62.172.234.2]:9140 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S130112AbRBBX77>;
	Fri, 2 Feb 2001 18:59:59 -0500
Date: Fri, 2 Feb 2001 23:58:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Richard Gooch <rgooch@atnf.csiro.au>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU capabilities -- an update proposal
In-Reply-To: <Pine.GSO.3.96.1010202161941.28509L-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.21.0102022217350.7240-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Maciej W. Rozycki wrote:
> 
>  Following is the current state of my CPU capabilities rework.  It
> introduces a new global variable, common_x86_capability, which holds the
> common set of flags for CPUs.  The boot_cpu_data is used appropriately
> again, i.e. it's treated as current_cpu_data before smp_store_cpu_info()
> is called (it doesn't matter for UP).  I defined a set of macros named
> boot_has_* for the purpose of accessing boot_cpu_data.  I did not create
> current_has_* macros to access current_cpu_data as I think this might
> encourage people to use them instead of cpu_has_* incorrectly.

I like common_x86_capability[], and I like that it's _not_ a struct
cpuinfo_x86 - saves us from wasting time on inventing "common" values
for the other cpuinfo_x86 fields (and'ing, or'ing, min'ing, etc.).
I agree with not defining current_has_ macros (at least until good
reason for them appears).  And I'm glad you're doing a patch to fix
these common capabilities, without getting bogged down in the issue
of how to publish them via /proc (I think that's something for later).

But I don't much like those two sets of macros (one of you is welcome
but enough!).  Congratulations if you have indeed got them all right
(I found no errors), but I'm afraid someone else will later choose
the wrong one, however well you comment.  Which was why my version
kept copying the "and" back into boot_cpu_data (admittedly a hack).

I wonder (you or hpa may very quickly point out why this is stupid
and impossible), could we move the identify_cpu() calls into
cpu_init()?  I used to think it was called too early for that, but
now I see it's already using current, smp_processor_id(), printk().
If identify_cpu() went in there, then we'd only need one set of
macros (cpu_has_ testing common_x86_capability), and a
considerable source of potential errors would be gone.  Not just
errors from using the wrong macro: it's worried me that so much
of startup is relying on the feature flags before identify_cpu() 
comes in to adjust them (e.g. adding PGE for an AMD, removing TSC
from a Cyrix and a Centaur).  We could eliminate dodgy_tsc() then,
its work already done.

I've not applied and installed your patch, but the only problem
I noticed was in i386_ksyms.c: you've put #if 0 #endif around the
EXPORT_SYMBOL(boot_cpu_data), but you need to export it for UP;
and you've no EXPORT_SYMBOL(common_x86_capability), which you'll
need for SMP.  Actually, I'd prefer EXPORT_SYMBOL(boot_cpu_data)
to be replaced by EXPORT_SYMBOL(common_x86_capability) (of course,
without #ifdef 0 #endif), and the SMP/UP divergence removed from
processor.h - give UP its own separate common_x86_capability[]
(hmm, it's already there in setup.c, does that compile?) and
its own cpu_data[1].  A little space wasted, but more confusion
gone - and if you dare, boot_cpu_data can then be __initdata?

Very minor point: remember mem=nopentium switches off PSE,
should be reflected in cpu_data and common_x86_capability.

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
