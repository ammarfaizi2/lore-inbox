Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWEHEyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWEHEyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWEHEyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:54:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:49562 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932298AbWEHEyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:54:20 -0400
Date: Sun, 7 May 2006 23:58:23 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, mulix@mulix.org
Subject: Re: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Message-ID: <20060508045822.GB7729@us.ibm.com>
References: <20060504205929.GD14361@us.ibm.com> <20060507085036.GF6015@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507085036.GF6015@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 11:50:36AM +0300, Muli Ben-Yehuda wrote:
> On Thu, May 04, 2006 at 03:59:29PM -0500, Jon Mason wrote:
> 
> > Per Andi Kleen's suggestion in the review of our Calgary IOMMU code, I
> > tried to use the alloc_bootmem_nopanic that Andi recently added.
> > Unfortunately, it needs low mem for our translation tables, so we needed
> > a new function to do this.
> > 
> > I have updated swiotlb to take advantage of this new function (and
> > added an error path to lib/swiotlb.c and resulting fallout from
> > calling functions).
> > 
> > This patch has been tested individually and cumulatively on x86_64 and
> > cross-compile tested on IA64.  Since I have no IA64 hardware, any
> > testing on that platform would be appreciated.
> 
> A couple of minor nits below, otherwise looks good.
> 
> > Signed-off-by: Jon Mason <jdmason@us.ibm.com>
> 
> Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>
> 
> > diff -r b5bb5fea7490 -r 62dc1eb0c5e2 include/linux/bootmem.h
> > --- a/include/linux/bootmem.h	Tue Apr 25 18:18:55 2006
> > +++ b/include/linux/bootmem.h	Wed Apr 26 16:12:39 2006
> > @@ -46,6 +46,7 @@
> >  extern void __init free_bootmem (unsigned long addr, unsigned long size);
> >  extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
> >  extern void * __init __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
> > +extern void * __init __alloc_bootmem_low_nopanic(unsigned long size, unsigned long align, unsigned long goal);
> 
> Would be nice to convert this and the preceding declarations to 80
> chars per line, please.
> 
> > diff -r b5bb5fea7490 -r 62dc1eb0c5e2 mm/bootmem.c
> > --- a/mm/bootmem.c	Tue Apr 25 18:18:55 2006
> > +++ b/mm/bootmem.c	Wed Apr 26 16:12:39 2006
> > @@ -463,3 +463,16 @@
> >  {
> >  	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
> >  }
> > +
> > +void * __init __alloc_bootmem_low_nopanic(unsigned long size, 
> > +					unsigned long align, unsigned long goal)
> > +{
> > +	bootmem_data_t *bdata;
> > +	void *ptr;
> > +
> > +	list_for_each_entry(bdata, &bdata_list, list)
> > +		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 
> > +						LOW32LIMIT)))
> > +			return(ptr);
> 
> This should be 'return ptr';

I completely agree with both nits, but the changes follow the style
currently in the files.  I'll do a clean-up patch to both of the
files in question.  :)

Thanks,
Jon

> 
> Cheers,
> Muli
