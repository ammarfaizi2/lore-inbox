Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbULHHDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbULHHDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbULHHCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:02:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27805 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262039AbULHHC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:02:27 -0500
Date: Wed, 8 Dec 2004 08:01:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][1/2] fix unchecked returns from kmalloc() (in kernel/module.c)
Message-ID: <20041208070136.GI3035@suse.de>
References: <Pine.LNX.4.61.0412072203070.3320@dragon.hygekrogen.localhost> <20041207212958.GD10083@suse.de> <20041207225741.GA4715@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207225741.GA4715@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Andries Brouwer wrote:
> On Tue, Dec 07, 2004 at 10:29:58PM +0100, Jens Axboe wrote:
> 
> > > diff -up linux-2.6.10-rc3-bk2-orig/kernel/module.c linux-2.6.10-rc3-bk2/kernel/module.c
> > > --- linux-2.6.10-rc3-bk2-orig/kernel/module.c	2004-12-06 22:24:56.000000000 +0100
> > > +++ linux-2.6.10-rc3-bk2/kernel/module.c	2004-12-07 21:17:00.000000000 +0100
> > > @@ -334,6 +334,10 @@ static int percpu_modinit(void)
> > >  	pcpu_num_allocated = 2;
> > >  	pcpu_size = kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
> > >  			    GFP_KERNEL);
> > > +	if (!pcpu_size) {
> > > +		printk(KERN_ERR "Unable to allocate per-cpu memory for modules.");
> > > +		return -ENOMEM;
> > > +	}
> > 
> > I'd say these cases are similar to SLAB_PANIC. Since it runs at boot, if
> > it fails it's likely an indication of some other problem, so dealing
> > with it here is silly. Perhaps just panic() on a NULL return.
> > 
> > Both of these fortify cases aren't real problems, imho. They trip a
> > stupid (no offense to the analyzer, but it's not human :) static
> > analyzer, that's all.
> 
> Hi Jens -
> 
> I think I disagree a little. Experience shows that if the stupid
> static analyzer spits out a hundred complaints, there are maybe five
> real problems.  If the source is not fixed in some way then the real
> problem cases drown in the noise of "harmless" warnings.

I completely agree. But that's a case of silencing the cases that aren't
interesting, so the interesting bits don't get lost in old noise.

> Remains the question how to fix the source without causing bloat by
> inserting lots of strings. Easiest is perhaps to write debug_printk()
> instead of printk() so that the string is compiled away for everyone
> except for me when I need debugging help to find out why my kernel
> does not boot.

The GFP_PANIC would at least only need one string :-)

-- 
Jens Axboe

