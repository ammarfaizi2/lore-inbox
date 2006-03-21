Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWCUIyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWCUIyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCUIyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:54:00 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:6793 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750890AbWCUIx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:53:59 -0500
Date: Tue, 21 Mar 2006 09:53:52 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Message-ID: <20060321085352.GA17642@rhlx01.fht-esslingen.de>
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142901656.441f4b98472e5@vds.kolivas.org> <87acbk33la.fsf@duaron.myhome.or.jp> <200603211409.50331.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603211409.50331.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 21, 2006 at 02:09:50PM +1100, Con Kolivas wrote:
> On Tue, 21 Mar 2006 01:59 pm, OGAWA Hirofumi wrote:
> > Yes. However, if machines uses buggy chip, I guessed TSC/PIT would be
> > more proper as time source. 
> 
> Oh yes but there has been an epidemic of timer problems (fast/slow, lost ticks 
> etc) lately meaning the pm timer is being relied upon more and more.

I think it's reasonable to question whether to use unlikely or not,
but IMHO omitting unlikely here will not reward well-behaving systems and
not punish buggy systems, and this doesn't seem quite right from an
evolutionary point of view (especially since I'd guess the number of buggy
chipsets is much lower than the number of working chipsets possibly
also from vendors other than Intel - famous last words...).
OTOH by not using the likely/unlikely branch prediction skew we may gain
higher combined (buggy systems *plus* good systems) performance.
But since I/O access time (especially in tripled form!) is **MUCH** higher
than any branching delay judging from my profiling experiments, I'd vote
for keeping the unlikely anyway.


BTW, my original patch (not published) evaluated timer performance over e.g.
10000 cycles and then (if positive) switched a *function pointer* over to the
"good" function.
So the buggy/non-buggy check inside the function could also be done via
function pointers, but this seems much more costly since it wastes kernel
image space for two functions with two stack frame setups etc. pp.

Thanks go to OGAWA for actually writing the patch with a surprisingly easy
buggy chipset check! (PCI revision etc.)

> > I'll remove unlikely(), and also will remove "Use other timer source"
> > from warning.
> 
> Suggesting another timer source is ok in the warning I believe given massive 
> amounts of wasted cpu.

Yes, please keep the warning (and make sure there's a part mentioning
"very costly for certain buggy Intel chipsets" or so).

> > BTW, this patch is still quick hack.
> 
> Understood. Perhaps having an indirect function call set to either 
> good_pmtmr() or bad_pmtmr() after checking would be preferable to a variable 
> that is checked on each function call despite never changing.

Oh, there you even mention it ;) However due to my reasons given above
(and the fact that invoking a function pointer should be similarly expensive
to a conditional) I don't think it's useful.

> > At least, we would need to check the ICH4 which says in comment.
> > However, I couldn't find the PM-Timer Errata in ICH4 spec update.
> >
> > Do you/anyone know about a ICH4 error?
> 
> Not personally but my ICH4 pm timer seems to work very well whereas Andi's 
> apparently similar chipset exhibits terrible problems.

Are you referring to dynticks trouble with my P4HT ("ICH5/ICH5R"!!) here?
I don't think there were any problems due to non-latchedness, jus the usual
batch of slowness issues.

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics Device (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
