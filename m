Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbULGW5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbULGW5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbULGW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:57:48 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:19983 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261961AbULGW5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:57:46 -0500
Date: Tue, 7 Dec 2004 23:57:41 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][1/2] fix unchecked returns from kmalloc() (in kernel/module.c)
Message-ID: <20041207225741.GA4715@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0412072203070.3320@dragon.hygekrogen.localhost> <20041207212958.GD10083@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207212958.GD10083@suse.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 10:29:58PM +0100, Jens Axboe wrote:

> > diff -up linux-2.6.10-rc3-bk2-orig/kernel/module.c linux-2.6.10-rc3-bk2/kernel/module.c
> > --- linux-2.6.10-rc3-bk2-orig/kernel/module.c	2004-12-06 22:24:56.000000000 +0100
> > +++ linux-2.6.10-rc3-bk2/kernel/module.c	2004-12-07 21:17:00.000000000 +0100
> > @@ -334,6 +334,10 @@ static int percpu_modinit(void)
> >  	pcpu_num_allocated = 2;
> >  	pcpu_size = kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
> >  			    GFP_KERNEL);
> > +	if (!pcpu_size) {
> > +		printk(KERN_ERR "Unable to allocate per-cpu memory for modules.");
> > +		return -ENOMEM;
> > +	}
> 
> I'd say these cases are similar to SLAB_PANIC. Since it runs at boot, if
> it fails it's likely an indication of some other problem, so dealing
> with it here is silly. Perhaps just panic() on a NULL return.
> 
> Both of these fortify cases aren't real problems, imho. They trip a
> stupid (no offense to the analyzer, but it's not human :) static
> analyzer, that's all.

Hi Jens -

I think I disagree a little. Experience shows that if the stupid static analyzer
spits out a hundred complaints, there are maybe five real problems.
If the source is not fixed in some way then the real problem cases
drown in the noise of "harmless" warnings.

Remains the question how to fix the source without causing bloat by inserting
lots of strings. Easiest is perhaps to write debug_printk() instead of printk()
so that the string is compiled away for everyone except for me when I need
debugging help to find out why my kernel does not boot.

Andries
