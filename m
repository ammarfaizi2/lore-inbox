Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUDSW4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUDSW4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUDSW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:56:18 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:60689 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261187AbUDSW4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:56:08 -0400
Date: Mon, 19 Apr 2004 17:54:57 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org,
       eich@suse.de
Subject: Re: PAT support
Message-ID: <20040419225456.GM632@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040417004217.GC72227@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417004217.GC72227@colin2.muc.de>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.4
X-OriginalArrivalTime: 19 Apr 2004 22:54:59.0878 (UTC) FILETIME=[57BB1C60:01C42661]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 05:42:17PM -0700, ak@muc.de wrote:
> change_page_attr can change more than just caching attributes,
> also read/write (e.g. slab debug uses it for that) 

ah, ok. sorry, missed that.

> At least for the later adding another book keeping data structure
> may be too expensive.

makes sense.

> I think I prefer the do/undo model instead of push/pop.
> That can work with cmaps too. PAGE_KERNEL means no cmap,
> PAGE_KERNEL_WC and PAGE_KERNEL_NOCACHE get a cmap.

but then what is the point of cmap? I would expect a mix of WC and UC mappings to be much less dangerous than a mix of WC/UC and WB. perhaps my mindset is wrong, but it seems allowing ioremap to request a cached mapping is important, and that if that mapping was followed by ioremap_nocached or ioremap_wrcomb, that these subsequent calls should fail.

I did finish implementing your suggestion, that change_page_attr should consider PAGE_KERNEL as a call to cmap_release_range and anything else as a call to cmap_request_range. seemed to work ok, but I'm seeing the acpi table code doing a lot of ioremaps (cached) that are ignored, then iounmaps are causing cmap_release_range calls to complain about not finding the regions. of course in a final version, we'd cut out the debug output, but expecting lots of empty calls to cmap_release_range seems messy.

what if there was a restore_page_attr(unsigned long address, unsigned long numpages) that assumed the pgprot was PAGE_KERNEL. change_page_attr knows to call cmap_request_range and restore_page_attr knows to call cmap_release_range. otherwise they do the same thing, restore_ just inherently uses PAGE_KERNEL for the caching type.

> remove_vm_area() needs to just be split into some worker functions 
> (__remove_vm_area et.al.)

ok, easily done.

Thanks,
Terence
