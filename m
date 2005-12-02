Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVLBSOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVLBSOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVLBSOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:14:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10663 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750894AbVLBSOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:14:16 -0500
Date: Fri, 2 Dec 2005 19:13:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Message-ID: <20051202181351.GB1854@elf.ucw.cz>
References: <20051201173649.GA22168@hexapodia.org> <200512012242.44995.rjw@sisk.pl> <20051202005514.GA1770@elf.ucw.cz> <200512021054.03245.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512021054.03245.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> > > > 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> > > > successful suspend/resume cycles.  But now that I'm running
> > > > 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:
> > > 
> > > Thanks a lot for the report.
> > > 
> > > The problem is apparently caused by my recent patch intended to speed up
> > > suspend.  Could you please apply the appended debug patch, try to reproduce
> > > the problem and send full dmesg output back to me?
> > > 
> > > Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
> > > ===================================================================
> > > --- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-01 22:13:17.000000000 +0100
> > > +++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-01 22:24:56.000000000 +0100
> > > @@ -635,12 +635,18 @@
> > >  	printk("Shrinking memory...  ");
> > >  	do {
> > >  #ifdef FAST_FREE
> > > -		tmp = count_data_pages() + count_highmem_pages();
> > > +		tmp = count_data_pages();
> > > +		printk("Data pages: %ld\n", tmp);
> > > +		tmp += count_highmem_pages();
> > 
> > You need at least count_data_pages() + 2*count_highmem_pages() free
> > pages (in lowmem).
> 
> Do you mean a separate page is needed for each kmalloc() in
> save_highmem_zone()?

No, but notice get_zeroed_page() there, and that still needs to be
atomically copied.

So each higmem page takes:

1 get_zeroed_page()
1 kmalloc(struct(highmem_page))
+ copies of those into snapshot.

								Pavel
-- 
Thanks, Sharp!
