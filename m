Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266398AbUBFCfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 21:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266404AbUBFCfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 21:35:22 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:1681 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266398AbUBFCfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 21:35:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Nick Piggin <piggin@cyberone.com.au>
Date: Fri, 6 Feb 2004 13:34:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16418.64825.5919.694924@notabene.cse.unsw.edu.au>
Cc: Mattias Wadenstein <maswan@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Performance issue with 2.6 md raid0
In-Reply-To: message from Nick Piggin on Friday February 6
References: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
	<402263E7.6010903@cyberone.com.au>
	<Pine.A41.4.58.0402051647460.28218@lenin.acc.umu.se>
	<4022F94C.30605@cyberone.com.au>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 6, piggin@cyberone.com.au wrote:
> 
> 
> Mattias Wadenstein wrote:
> 
> >On Fri, 6 Feb 2004, Nick Piggin wrote:
> >
> >
> >>Mattias Wadenstein wrote:
> >>
> >>
> >>>Greetings.
> >>>
> >>>While testing a file server to store a couple of TB in resonably large
> >>>files (>1G), I noticed an odd performance behaviour with the md raid0 in a
> >>>pristine 2.6.2 kernel as compared to a 2.4.24 kernel.
> >>>
> >>>When striping two md raid5:s, instead of going from about 160-200MB/s for
> >>>a single raid5 to 300M/s for the raid0 in 2.4.24, the 2.6.2 kernel gave
> >>>135M/s in single stream read performance.
> >>>
> >>Can you try booting with elevator=deadline please?
> >>
> >
> >Ok, then I get 253267 kB/s write and 153187 kB/s read from the raid0. A
> >bit better, but still nowhere near the 2.4.24 numbers.
> >
> >For a single raid5, 158028 kB/s write and 162944 kB/s read.
> >
> >
> 
> Any idea what is holding back performance? Is it IO or CPU bound?
> Can you get a profile of each kernel while doing a read please?
> 

Possibly the read-ahead size isn't getting set correctly.

What chunksize are you using on the raid0?
Are you free to rebuild the raid0 array?
If so, please rebuild it with a chunksize that is 2 or 4 times the
size of a raid5 stripe (i.e. raid5-chunksize * (raid5-drives - 1) ).

If not, can you change:

		if (mddev->queue->backing_dev_info.ra_pages < stripe)
			mddev->queue->backing_dev_info.ra_pages = stripe;

at about line 327 of drives/md/raid1.c to something like:

		mddev->queue->backing_dev_info.ra_pages = stripe * 32;

or whatever is needed to make ra_pages big enough to gold a couple of
raid5 stripes.

Thanks,
NeilBrown

