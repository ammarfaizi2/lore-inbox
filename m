Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUGBPKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUGBPKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUGBPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:10:32 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:8434 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S264635AbUGBPK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:10:29 -0400
Date: Fri, 2 Jul 2004 15:51:03 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       linux-ia64@linuxia64.org, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       parisc-linux@parisc-linux.org, Paul Mundt <lethal@linux-sh.org>,
       linuxsh-shmedia-dev@lists.sourceforge.net,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Comparing PROT_EXEC-only pages on different CPUs
Message-ID: <20040702145103.GB24713@malvern.uk.w2k.superh.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
	Matthew Wilcox <matthew@wil.cx>,
	Grant Grundler <grundler@parisc-linux.org>,
	parisc-linux@parisc-linux.org, Paul Mundt <lethal@linux-sh.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <20040701224016.GB7928@mail.shareable.org> <20040702013636.GA29154@twiddle.net> <20040702040218.GA10366@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702040218.GA10366@mail.shareable.org>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 02 Jul 2004 14:53:10.0772 (UTC) FILETIME=[4B211B40:01C46044]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie

* Jamie Lokier <jamie@shareable.org> [2004-07-02]:
> 
> Richard Henderson wrote:
> > > Richard raises an interesting point: exec-only pages are useless if
> > > the code needs to read jump tables and constant pools.  It seems very
> > > likely Alpha and IA64 have these.
> > 
> > Only if the processor is crippled enough that mixing jump tables and
> > constant pools in the same pages as code is considered reasonable.
> 
> That's a good point, if the i-cache and/or DTLB are separate from
> d-cache and/or DTLB.  Then it makes more sense to put tables in a
> separate address block.
> 
> However if the caches are unified then it makes sense to put them
> together.  Somehow I doubt if any of these 64-bit chips have unified
> i- and d-caches though :)

For the SH-4, and the SH-5 in SHcompact mode, the insertion of constant
pools in amongst the code is essential.  The SH-4 instruction set has
specific "load word/longword from 2N/4N bytes forward of current PC"
instructions (mov.[wl] @(disp,PC),Rm)  for this.  It seems a reasonable
enough way of handling large immediates in a 16-bit encoding.

For SH-5 in SHmedia mode, it probably isn't really necessary to put
switch tables inside the .text section, but it's what the current
toolchains do.

> > Anyway, that's a strawman -- it's the toolchain's job to get the bits
> > on the pt_load segments correct.
> > 
> > If the pt_load segment or the mmap prot argument says execute-only,
> > then you should honor it.
> 
> In other words, PA-RISC and SH64 kernels _should_ create exec-only
> pages if requested, as the hardware can do it, right?
> 
> And the toolchain _should_ ask read permssion for code segments, if
> (and only if) the compiler has generated code which needs that, right?

As it turns out, it looks like the SH-5 toolchains already do that.  The
kernel was forcing readability onto mappings unnecessarily.  I've done
some local fixes to sh64/2.6 today, and the results of the program are
now coming out:

Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r--    -w-    rw-    --x    r-x    -wx    rwx
MAP_PRIVATE    | ---    r--    -w-    rw-    --x    r-x    -wx    rwx

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
