Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbVIJF6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVIJF6I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVIJF6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:58:08 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:53765
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S1030495AbVIJF6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:58:07 -0400
Message-ID: <432276DF.9070606@acquerra.com.au>
Date: Sat, 10 Sep 2005 16:02:07 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nate.diller@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness - FIXED
References: <432151B0.7030603@acquerra.com.au>	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>	 <5c49b0ed05090914394dba42bf@mail.gmail.com>	 <432225E0.9030606@acquerra.com.au>	 <5c49b0ed0509091735436260bb@mail.gmail.com>	 <432231B7.2060200@acquerra.com.au>	 <5c49b0ed0509091847135834c0@mail.gmail.com>	 <432243AA.4000508@acquerra.com.au> <5c49b0ed05090922021b8f8112@mail.gmail.com>
In-Reply-To: <5c49b0ed05090922021b8f8112@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nate Diller wrote:

> just found the culprit.  guess i should have read the code the first 
> time.  get_dirty_limits() in drivers/block/page_writeback.c has a 
> hard-coded upper limit to dirty_ratio.  it's capped to half of the 
> unmapped pages, so maybe 30-40% of your system's memory.  so if you are 
> brave, just remove the "/ 2" parts from the 'if (dirty_ratio > 
> unmapped_ratio / 2) dirty_ratio = unmapped_ratio / 2;' check, and you 
> can have all the OOM goodness you want.

Well well well.

Thank you Nate!

I changed that bit of code to:

	if (dirty_ratio > unmapped_ratio - 10) 
		dirty_ratio = unmapped_ratio - 10;

and added a couple of sanity checks so that it couldn't get below 5 or above 95.

Then set /proc/sys/vm/dirty_ratio to 95 and dirty_background_ratio to 1.

Guess what? Now my video streams for 120 seconds before being throttled. This is *much better*.
It's now quite feasible to reach 30 seconds by finding a faster disk and/or adding another 512M
or RAM.

I guess the hard-coded limit is in there for a reason, but I sure wish it was adjustable without
this sort of hacking.

regards, Anthony

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836
