Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWIYFvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWIYFvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 01:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWIYFvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 01:51:20 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:43123 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S932184AbWIYFvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 01:51:20 -0400
X-IronPort-AV: i="4.09,210,1157342400"; 
   d="scan'208"; a="10191560:sNHT21261618"
Message-Id: <6.1.1.1.0.20060925011906.01ecea00@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 25 Sep 2006 01:51:34 -0400
To: Paul Mundt <lethal@linux-sh.org>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 3/3] [BFIN] Blackfin documents and MAINTAINER patch
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, luke Yang <luke.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul indicated:
> > +cache-lock.txt
> > +     - HOWTO for blackfin cache locking.
> > +
>
>This is a generic enough of a feature that I suspect we should hash out a 
>common API for it rather than having people roll their own.

That sounds like a good idea. From the few people that use this, I think a 
much simpler interface would be desirable.

For data, it is easy - something similar to the processor specific 
xx_flush_range(start,end) - have a xxx_lock_range(start,end) would be good, 
and easy to implement.

The only thing I am not sure of - is how to force things into cache. For 
data - it is easy - do a read, and then lock it. For instruction - for 
those architectures which have separate instruction cache (like Blackfin) 
it is much harder. The only way to get code into cache is to execute it. 
(ergo the existing interface).

Normally - what we do when locking things in cache is specific to the hardware.
   - to prevent isr polluting cache, we disable interrupts
   - If the code to be locked has a possibility of already being in the 
instruction cache, we invalidate the entire cache first
   - we locks 3/4 of the cache - forcing any code to be put into a specific 
location.
   - execute the code of interest (once)
   - unlock the 3/4 of cache, and lock the 1/4 where the code of interest 
is located.
   - turn back on interrupts.

Because the algorithm is so specific to the hardware - I am not sure how to 
make instruction as generic as data could be.

How does SH cache handle things like this?

-Robin
