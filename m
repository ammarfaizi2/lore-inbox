Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271617AbRIGIf4>; Fri, 7 Sep 2001 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRIGIfr>; Fri, 7 Sep 2001 04:35:47 -0400
Received: from [195.66.192.167] ([195.66.192.167]:23812 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271617AbRIGIff>; Fri, 7 Sep 2001 04:35:35 -0400
Date: Fri, 7 Sep 2001 11:30:06 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1048143499.20010907113006@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: K7/Athlon optimizations and Sacrifices to the Great Ones.
In-Reply-To: <01090612513601.00171@c779218-a>
In-Reply-To: <01090612513601.00171@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thursday, September 06, 2001, 10:51:36 PM, Nicholas Knight <tegeran@home.com> wrote:
NK> 133Mhz FSB + KT133A chipset theory has been officially shot to hell.
NK> Not only that, but 6-4-4 (family/model/stepping) processors don't seem to 
NK> be the culprit. I've now had reports of 6-4-2 experiencing problems, and 
NK> 6-4-4 NOT experiencing problems, even on KT133A @ 133Mhz.
NK> At this point, I can't even isolate a MOTHERBOARD that could be the 
NK> culprit, and I don't think it's the power supply.
...
NK> At this point, I'm giving up on collecting data, as I just don't see a
NK> definitive pattern, all I can say for sure is that the "majority" 
NK> KT133A-based motherboards seem to have problems, but not ALL. I don't 
NK> know of a single report outside of the KT133A chipset of these problems.

Well, why can't guys with Athlons and KT133As who did enable K7
optimizations just open their boxes and report to Nicholas:
* processor and chipset markings
* bus speed
* CPUcore/bus multiplier
* Motherboard model
* BIOS manufacturer, version, date
  This is important. BIOS might fix/mask chipset bugs
  by programming it to stable but slow cfg
* do they see K7 related oops
  ("I don't see oops" is a valuable report too!)
* did oops go away with 100MHz FSB
* did oops go away with different CPU voltage
* did oops go away with smaller multiplier
* did oops go away with BIOS update
* did oops go away with any trick with mmx.c - see below.
  More advanced reporters might try to fiddle with
  arch/i386/lib/mmx.c and try to make oops disappear
* did oops go away with K7 optimization off
* results of memtest86
* results of running burnK7/burnMMX

(Last 3 *'s to make sure it is the K7 bug, not bad memory or
something)

Need to check for oops? "Simen Thoresen" <simen-tt@online.no>:
>I've determined that with the Athlon-optimized fast_copy_page,
>the machine is easy to push into oopsing. Just starting
>a dd with blocksize 128M (half available ram) provokes an oops.
>This is repeatable, consistent and almost fun.
  
Since fast_copy_page() from arch/i386/lib/mmx.c has been isolated as
a code which triggers oops, it can be instrumented to check whether page
is indeed copied right by questionable K7 code and barf loudly if it is not.

Since oops are not instant, looks like interrupts might interfere
with movntq instruction... On the other hand, fast_clear_page()
isn't triggering oops (right?) so maybe mixing normal and
cache-bypassing instructions is triggering oops...

Comparing K7 and MMX fast_copy_page...

Does replacing movntq->movq fix makes oops go avay?

If no, does this (or similar) change makes oops go away?
movq (%0), %%mm0        -> movq (%0), %%mm0
movntq %%mm0, (%1)      -> movq 8(%0), %%mm1
movq 8(%0), %%mm1       -> movq 16(%0), %%mm2
movntq %%mm1, 8(%1)     -> movq 24(%0), %%mm3
movq 16(%0), %%mm2      -> movntq %%mm0, (%1)
movntq %%mm2, 16(%1)    -> movntq %%mm1, 8(%1)
movq 24(%0), %%mm3      -> movntq %%mm2, 16(%1)
movntq %%mm3, 24(%1)    -> movntq %%mm3, 24(%1)
movq 32(%0), %%mm4      -> movq 32(%0), %%mm4
movntq %%mm4, 32(%1)    -> movq 40(%0), %%mm5
movq 40(%0), %%mm5      -> movq 48(%0), %%mm6
movntq %%mm5, 40(%1)    -> movq 56(%0), %%mm7
movq 48(%0), %%mm6      -> movntq %%mm4, 32(%1)
movntq %%mm6, 48(%1)    -> movntq %%mm5, 40(%1)
movq 56(%0), %%mm7      -> movntq %%mm6, 48(%1)
movntq %%mm7, 56(%1)    -> movntq %%mm7, 56(%1)

No? Changing first for() loop from
for(i=0; i<(4096-320)/64; i++) into
for(i=0; i<4096/64; i++) and eliminating second for() -
does this help?

One of above changes HAS to fix K7 oops, because you convert K7
fast_copy_page to MMX fast_copy_page that way :-)
So if you have an Athlon - try these and report. I don't have the
hardware.

David Hollister <david@digitalaudioresources.org> wrote:
>MMX2 does not cause any problems for me.  Robert (the guy who wrote these) has
>provided me with two more versions that mimic the Athlon optimized
>fast_page_copy and fast_page_clear functions in mmx.c.  They aren't exact
>copies, but are close.  One fails for me consistently, the other does not.  The
>one that fails consistently is the one that mimics the fast_page_copy code.

Robert Redelmeier: redelm@ev1.net http://users.ev1.net/~redelm/
Although this tester is not on his page (yet?).
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


