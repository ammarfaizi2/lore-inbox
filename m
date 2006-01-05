Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWAEFnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWAEFnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWAEFnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:43:05 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:50093 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751952AbWAEFnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:43:04 -0500
Date: Thu, 05 Jan 2006 14:42:32 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: jschopp@austin.ibm.com
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (change build_zonelists)[3/8]
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <43BAEB98.8060906@austin.ibm.com>
References: <20051220172910.1B0C.Y-GOTO@jp.fujitsu.com> <43BAEB98.8060906@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060105142549.4919.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	BUG_ON(zone_type > ZONE_HIGHMEM);
> > +	BUG_ON(zone_type > ZONE_EASY_RECLAIM);
> 
> It might be nice to check ifndef CONFIG_HIGHMEM that the zone isn't 
> particularly ZONE_HIGHMEM.

Hmm. I was a bit lazy :-(.

> >  	int res = ZONE_NORMAL;
> > -	if (zone_bits & (__force int)__GFP_HIGHMEM)
> > -		res = ZONE_HIGHMEM;
> > -	if (zone_bits & (__force int)__GFP_DMA32)
> > -		res = ZONE_DMA32;
> > -	if (zone_bits & (__force int)__GFP_DMA)
> > +
> > +	if (zone_bits == fls((__force int)__GFP_DMA))
> >  		res = ZONE_DMA;
> > +	if (zone_bits == fls((__force int)__GFP_DMA32) &&
> > +	    (__force int)__GFP_DMA32 == 0x02)
> > +		res = ZONE_DMA32;
> > +	if (zone_bits == fls((__force int)__GFP_HIGHMEM))
> > +		res = ZONE_HIGHMEM;
> > +	if (zone_bits == fls((__force int)__GFP_EASY_RECLAIM))
> > +		res = ZONE_EASY_RECLAIM;
> > +
> >  	return res;
> >  }
> 
> It is incredibly silly to check a constant for a value.  When it is zero 
> instead of 2 the first part of the statement will be false anyway.
> Which reminds me.  Why are we using fls again?  I don't see why we 
> aren't just (zone_bits & value) the types.  It seems much easier to 
> understand that way.

Ahhh. I might be still confused around it. :-(
Its cause came from the value of __GFP_DMA32 which might be 0, 1, or 2.
This was that I tried to solve making zonelists for all of them.
But, something looks redundant.....

Thanks.


> 
> >  
> > Index: zone_reclaim/include/linux/gfp.h
> > ===================================================================
> > --- zone_reclaim.orig/include/linux/gfp.h	2005-12-19 20:19:37.000000000 +0900
> > +++ zone_reclaim/include/linux/gfp.h	2005-12-19 20:19:56.000000000 +0900
> > @@ -81,7 +81,7 @@ struct vm_area_struct;
> >  
> >  static inline int gfp_zone(gfp_t gfp)
> >  {
> > -	int zone = GFP_ZONEMASK & (__force int) gfp;
> > +	int zone = fls(GFP_ZONEMASK & (__force int) gfp);
> >  	BUG_ON(zone >= GFP_ZONETYPES);
> >  	return zone;
> >  }
> > 
> 
> 

-- 
Yasunori Goto 


