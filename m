Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVERWCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVERWCC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVERWCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:02:02 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:25108 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S262341AbVERWB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:01:29 -0400
Date: Wed, 18 May 2005 17:01:20 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, tripperda@nvidia.com
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050518220120.GJ2596@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <20050513132945.GB16088@wotan.suse.de> <20050513155241.GA3522@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513155241.GA3522@redhat.com>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 18 May 2005 22:01:27.0155 (UTC) FILETIME=[238DFC30:01C55BF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sorry I fell behind on this and never got back to it. I just got back
from vacation and am swamped with stacked-up work, but I'll try to get
back involved with this by this weekend. 

I have no doubts that this isn't in ready condition yet. at the last
time I was working on this, I remember I was comparing how it behaved
on various systems at my disposal and there were some glaring problems
I was trying to take notes on. I think they were cachemap api
problems, but I don't recall the details. I'll try to review the
current code and old email to remember.

right now I think there were a lot of excessive printouts for
debugging purposes. I also have no doubts that there are coding style
differences that need to be cleaned up (feel free to tell me when my code
sucks or isn't up to style).

on a side note, last I was working on this I still had to keep an
extra tree around and manually diff things, which is a burden and easy
to goof things up. is there an easier way to do this? it looks like
you guys are experimenting with git, is there an faq on how to get
started with that?

Thanks,
Terence
 

On Fri, May 13, 2005 at 11:52:41AM -0400, davej@redhat.com wrote:
> Hi Andi,
> 
> On Fri, May 13, 2005 at 03:29:45PM +0200, Andi Kleen wrote:
> 
>  > For memory (pfn_valid == 1) it would be more memory efficient to use a few bits
>  > in struct page->flags
> 
> Maybe.
> 
>  > In general because there are lots of uses of "range lists" it would be better
>  > to put it as a library into lib.
> 
> Ditto.
> 
>  > Coding style needs some work.
> 
> Yep.
> 
>  > Too many printks.
> 
> At least whilst this is getting polished, its worth keeping these
> around. Once its stable, I agree, they can go (or at least be
> demoted to dprintk's).   It seems that theres some problems with
> the current code, so they're definitly useful..
> 
> for eg..
> 
> CMAP: cmap_request_range: 0xf8000000 - 0xf8100fff (1)
> CMAP:     cachings mismatch (4 != 1)
> CMAP: cmap_request_range: 0xf8101000 - 0xf8101fff (1)
> CMAP:     cachings mismatch (4 != 1)
> CMAP: cmap_request_range: 0xf8102000 - 0xf8301fff (1)
> CMAP:     cachings mismatch (4 != 1)
> [drm:radeon_do_init_cp] *ERROR* could not find ioremap agp regions!
> CMAP: cmap_release_range: 0xff8f0000 - 0xff96efff
> CMAP:    last user, freeing
> CMAP:    last user, freeing
> CMAP:    release_range successful!!
> 
> I'm not sure where that's coming from yet.  There's also a few
> failures to release regions which need to be double checked.
> 
>  > I am not sure yet the cmaps don't need reference counting. For some
>  > cases (user space support) they probably will.
> 
> Asides from cmap_entry->count ?
> Hmm, there doesn't seem to be anything guarding concurrent accesses
> to that.
> 
>  > Need user space support, e.g. using the existing ioctls for /proc/bus/pci/*
>  > (they are currently not implemented on i386/x86-64 but should with this)
>  > Then someone would need to change the X server to use this.
> 
> By hooking into ioremap(), we're getting this done automatically.
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
>         Subsystem: PC Partner Limited RV200 QW [Radeon 7500 LE]
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size 08
>         Interrupt: pin A routed to IRQ 225
>         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
>         Region 1: I/O ports at c800 [size=256]
>         Region 2: Memory at ff8f0000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at ff8c0000 [disabled] [size=128K]
>         Capabilities: <available only to root>
> 
> (10:39:17:davej@dhcp83-2:~)$ grep e8000000 /proc/cachemap
>  0xe8000000 - 0xebffffff: 0x0004 1
> 
> Though I agree a userspace interface could be useful.
> 
>  > Need to figure out if CMAP_ALLOW_OVERLAPPING should be set or not.
> 
> *nod*, and if it should, lose the ifdef completely.
>  
>  > Probably need to go over the combining rule etc. with a fine comb
> 
> agreed.  There's a bunch of errata on older CPUs that should probably
> be checked too.
> 
> Thanks for the comments.  I'm not working on this full-time, but
> I'll continue to poke at it occasionally, especially if theres
> interest from anyone else.
> 
> 		Dave
