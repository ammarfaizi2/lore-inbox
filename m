Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWEKIDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWEKIDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEKIDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:03:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965197AbWEKIDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:03:11 -0400
Date: Thu, 11 May 2006 00:59:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: nickpiggin@yahoo.com.au, apw@shadowen.org, haveblue@us.ibm.com,
       bob.picco@hp.com, mingo@elte.hu, mbligh@mbligh.org, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Zone boundry alignment fixes
Message-Id: <20060511005952.3d23897c.akpm@osdl.org>
In-Reply-To: <exportbomb.1147172704@pinky>
References: <445DF3AB.9000009@yahoo.com.au>
	<exportbomb.1147172704@pinky>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> Ok.  Finally got my test bed working and got this lot tested.
> 
> To summarise the problem , the buddy allocator currently requires
> that the boundries between zones occur at MAX_ORDER boundries.
> The specific case where we were tripping up on this was in x86 with
> NUMA enabled.  There we try to ensure that each node's stuct pages
> are in node local memory, in order to allow them to be virtually
> mapped we have to reduce the size of ZONE_NORMAL.  Here we are
> rounding the remap space up to a large page size to allow large
> page TLB entries to be used.  However, these are smaller than
> MAX_ORDER.  This can lead to bad buddy merges.  With VM_DEBUG enabled
> we detect the attempts to merge across this boundry and panic.
> 
> We have two basic options we can either apply the appropriate
> alignment when we make make the NUMA remap space, or we can 'fix'
> the assumption in the buddy allocator.  The fix for the buddy
> allocator involves adding conditionals to the free fast path and
> so it seems reasonable to at least favor realigning the remap space.
> 
> Following this email are 3 patches:
> 
> zone-init-check-and-report-unaligned-zone-boundries -- introduces
>   a zone alignement helper, and uses it to add a check to zone
>   initialisation for unaligned zone boundries,
> 
> x86-align-highmem-zone-boundries-with-NUMA -- uses the zone alignment
>   helper to align the end of ZONE_NORMAL after the remap space has
>   been reserved, and
> 
> zone-allow-unaligned-zone-boundries -- modifies the buddy allocator
>   so that we can allow unaligned zone boundries.  A new configuration
>   option is added to enable this functionality.
> 
> The first two are the fixes for alignement in x86, these fix the
> panics thrown when VM_DEBUG is enabled.
> 
> The last is a patch to support unaligned zone boundries.  As this
> (re)introduces a zone check into the free hot path it seems
> reasonable to only enable this should it be needed; for example
> we never need this if we have a single zone.  I have tested the
> failing system with this patch enabled and it also fixes the panic.
> I am inclined to suggest that it be included as it very clearly
> documents the alignment requirements for the buddy allocator.

There's some possibility here of interaction with Mel's "patchset to size
zones and memory holes in an architecture-independent manner." I jammed
them together - let's see how it goes.

I also fixed the spelling of "boundary" in about 1.5 zillion places ;)
