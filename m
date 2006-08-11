Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWHKGwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWHKGwK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHKGwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:52:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:3026 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932347AbWHKGwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:52:04 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH for review] [69/145] x86_64: Disable DAC on VIA PCI bridges
Date: Fri, 11 Aug 2006 08:51:53 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810935.775038000@suse.de> <20060810193625.3605D13C0B@wotan.suse.de> <20060810205554.GE4745@rhun.haifa.ibm.com>
In-Reply-To: <20060810205554.GE4745@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110851.53038.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 22:55, Muli Ben-Yehuda wrote:

> 
> > Because of several reports that it doesn't work
> > 
> > TBD needs a real confirmation this fixes the problem
> > TBD needs more testing
> 
> Should this go to mainline then?

I've haven't decided yet. I put it out for review for now at least.

I got various reports of the VIA bridges having trouble with DAC over the
years, but usually when I asked for confirmation the reporters disappeared.
I finally did the patch now because with cheap 2GB DIMMs VIA systems
with 4GB (which gives some memory over 4GB) are becomming more common.

But again the last reporters disappeared this time.

I will probably not sent it off before final confirmation again.

> > +static int allow_dac;
> 
> __read_mostly, like the rest?

Ok. Changed

> 
> > +static int bridge_from_vendor(struct device *dev, u16 vendor)
> > +{
> > +#ifdef CONFIG_PCI
> 
> My preference would be to provide two versions of this function, one
> empty (!CONFIG_PCI) and one with the code you have here.


I prefer it this way.

 
> >  int dma_supported(struct device *dev, u64 mask)
> >  {
> >  	if (dma_ops->dma_supported)
> >  		return dma_ops->dma_supported(dev, mask);
> 
> I just checked, no ops has a dma_supported method... should we remove
> it?

The if()? Possible.
 
> >  __init int iommu_setup(char *p)
> >  {
> > @@ -264,6 +302,10 @@ __init int iommu_setup(char *p)
> >  		    iommu_merge = 0;
> >  	    if (!strncmp(p, "forcesac",8))
> >  		    iommu_sac_force = 1;
> > +	    if (!strncmp(p, "allowdac", 8))
> > +		    allow_dac = 1;
> > +	    if (!strncmp(p, "nodac", 5))
> > +		    allow_dac = -1;
> 
> Why <0? we usually set 1 for enabled and 0 for disabled.

For hardware workarounds it is usually best to have three values:

- Force disabled
- Default based on black/white list 
  The black/white list is not active when != 0
- Force enabled

I tend to use -1/0/1 for this. 


-Andi
