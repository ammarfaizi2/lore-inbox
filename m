Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWBIQIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWBIQIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWBIQIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:08:21 -0500
Received: from proof.pobox.com ([207.106.133.28]:17865 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932579AbWBIQIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:08:20 -0500
Date: Thu, 9 Feb 2006 10:08:09 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209160808.GL18730@localhost.localdomain>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com> <20060208190512.5ebcdfbe.akpm@osdl.org> <20060208190839.63c57a96.akpm@osdl.org> <43EAC6BE.2060807@cosmosbay.com> <20060208204502.12513ae5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060208204502.12513ae5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> >
> > Andrew Morton a écrit :
> > > Andrew Morton <akpm@osdl.org> wrote:
> > >> Users of __GENERIC_PER_CPU definitely need cpu_possible_map to be initialised
> > >>  by the time setup_per_cpu_areas() is called,
> > > 
> > > err, they'll need it once Eric's
> > > dont-waste-percpu-memory-on-not-possible-CPUs patch is merged..
> > > 
> > >> so I think it makes sense to
> > >>  say "thou shalt initialise cpu_possible_map in setup_arch()".
> > >>
> > >>  I guess Xen isn't doing that.  Can it be made to?
> > > 
> > > Lame fix:  cpu_possible_map = (1<<NR_CPUS)-1 in setup_arch().
> > 
> > I dont understand why this HOTPLUG stuff is problematic for Xen (or other 
> > arch) : If CONFIG_HOTPLUG_CPU is configured, then the map should be preset to 
> > CPU_MASK_ALL.
> 
> Presumably not all architectures are doing that.

powerpc/ppc64, for instance, determines the number of possible cpus
from information exported by firmware (and I'm mystified as to why
other platforms don't do this).  So it's typical to have a kernel an a
pSeries partition with NR_CPUS=128, but cpu_possible_map = 0xff.


> > Its even documented in line 332 of include/linux/cpumask.h
> > 
> >   *  #ifdef CONFIG_HOTPLUG_CPU
> >   *     cpu_possible_map - all NR_CPUS bits set
> 
> That seems a quite bad idea.  If we know which CPUs are possible we should
> populate cpu_possible_map correctly, whether or not CONFIG_HOTPLUG_CPU is
> set.  Setting all the bits like that wastes memory and wastes CPU cycles.

Yes, that comment is wrong or outdated.

