Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWCPU2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWCPU2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWCPU2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:28:32 -0500
Received: from gold.veritas.com ([143.127.12.110]:27009 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751586AbWCPU2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:28:31 -0500
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="57291960:sNHT31212464"
Date: Thu, 16 Mar 2006 20:29:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: signal_cache slab corruption.
In-Reply-To: <20060314170153.GB32080@redhat.com>
Message-ID: <Pine.LNX.4.61.0603162013350.25141@goblin.wat.veritas.com>
References: <20060313181524.GA26234@redhat.com>
 <Pine.LNX.4.61.0603140921270.5164@goblin.wat.veritas.com>
 <20060314170153.GB32080@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 20:28:29.0485 (UTC) FILETIME=[2FC195D0:01C64938]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Dave Jones wrote:
> On Tue, Mar 14, 2006 at 09:22:35AM +0000, Hugh Dickins wrote:
>  > On Mon, 13 Mar 2006, Dave Jones wrote:
>  > 
>  > > I got into the office today to find my workstation that was running
>  > > a kernel based on .16rc5-git9 was totally unresponsive.
>  > > After rebooting, I found this in the logs.
>  > > 
>  > > slab signal_cache: invalid slab found in partial list at ffff8100e3a48080 (11/11).
>  > > slab signal_cache: invalid slab found in partial list at ffff81007ecc6100 (11/11).
>  > > slab: Internal list corruption detected in cache 'signal_cache'(11), slabp ffff810037ec0998(12). Hexdump:
>  > > 
>  > > 000: c0 60 d9 7e 00 81 ff ff 00 61 cc 7e 00 81 ff ff
>  > > 010: a8 09 ec 37 00 81 ff ff a8 09 ec 37 00 81 ff ff
>  > > 020: 0c 00 00 00 00 00 00 00 57 d0 1d 07 01 00 00 00
>  > > 030: 00 00 00 00
>  > > ----------- [cut here ] --------- [please bite here ] ---------
>  > > Kernel BUG at mm/slab.c:2598

Thanks for the diff, that fitted together better.

I spent several hours poring over your report,
but came to no useful conclusions - sorry.

As you probably noticed yourself, struct slab's colouroff and s_mem
have been overwritten by a list_head; but I can't deduce anything
illuminating from that.

Less obvious and more interesting, is that the struct kmem_cache is
being corrupted during the course of the output: it starts off saying
in several places that cachep->num is 11, but ends up printing only
one kmem_bufctl_t (aside from "free"): implying cachep->num 1 by then.
Which may relate to how 11/11 was wrongly in the partial list.

I'd be interested in the signal_cache line from your /proc/slabinfo,
to see what cachep->num is usually in your configuration.  But it's
an idle interest: I won't have anything interesting to say, whatever
it is...

Anyone else?

Hugh
