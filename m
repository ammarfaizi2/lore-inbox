Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTENJ3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTENJ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:29:53 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:51973 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261570AbTENJ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:29:52 -0400
Date: Wed, 14 May 2003 13:41:41 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: davidm@hpl.hp.com
Cc: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-ID: <20030514134141.A5170@jurassic.park.msu.ru>
References: <1052690133.10752.176.camel@thor> <16063.60859.712283.537570@napali.hpl.hp.com> <1052768911.10752.268.camel@thor> <16064.453.497373.127754@napali.hpl.hp.com> <1052774487.10750.294.camel@thor> <16064.5964.342357.501507@napali.hpl.hp.com> <1052786080.10763.310.camel@thor> <16064.17852.647605.663544@napali.hpl.hp.com> <20030513173347.A25865@jurassic.park.msu.ru> <16065.6969.137647.391163@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16065.6969.137647.391163@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, May 13, 2003 at 09:20:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 09:20:09AM -0700, David Mosberger wrote:
>   Ivan> Note that some Alphas may have "cant_use_aperture" cleared.
> 
> "Interesting".

Yep. ;-)

> If cant_use_aperture isn't set, my patch won't help, but it shouldn't
> hurt anything either.  I.e., you should be no worse off than before.

Sure. Basically, I'll only need to re-diff.

> What's the nature of those "ugly and fragile" hacks?  Are you saying
> that CPU accesses to AGP space aren't remapped in the "normal" (PC)
> way?  Or is it something entirely different?

Ok, you asked for it... :-)
As you know, Alpha architecture is entirely cache coherent
by design, i.e. there are no such things as non-cacheable mappings
or cache flushing in hardware. Native Alpha Titan/Marvel AGP controllers
are also cache coherent (kind of AGP extension of traditional
Alpha PCI IOMMU).
However, the "normal" PC AGP implementation isn't - this applies
to AMD-751/761 AGP controllers on Nautilus as well.
The AGP window on these chipsets is accessible by CPU *only* in the
system memory address space, i.e. it's always cacheable and thus
totally useless on Alpha.
Fortunately, AMD northbridges (at least 761) have some features
that allow *limited* access to system memory, including AGP space,
through EV6 non-cacheable IO address space (using "magic" 16 Gb offset).
Limitations:
- quadword writes corrupt ECC.
  EV6 doesn't generate ECC for IO space, but the chipset expects ECC
  from CPU on full quad writes (narrower writes are ok since the chipset
  does read-modify-write and updates ECC by itself).
  This wouldn't be a big deal since nobody should access pages mapped
  into AGP, but there are occasional speculative loads which hit data
  with bad ECC that causing the machine checks. So I must handle these
  machine checks properly - check that the page is AGP and then either
  scrub the affected location to fix ECC or dismiss the machine check.
- according to AMD specs, reads to this "non-cacheable" region are
  not supported. Not quite true, as quadword loads (ldq/ldq_u) do work
  (verified on 761, 751 needs testing). Narrower loads indeed don't work.
  Fortunately, AGP space reads seem to be sort of exotic (in both
  kernel and userspace drivers), so they can be easily found and converted
  to ldq/ldq_u.

In addition I cannot trust PALcode error handler on UP1500 - sometimes it
does bogus things...
By now I have all this crap running more or less stable with
radeon 7200 card. Machine check handling needs some improvements though.

Ivan.
