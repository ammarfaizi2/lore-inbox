Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTLQLj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTLQLj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:39:57 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:37058 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S264430AbTLQLjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:39:54 -0500
Subject: Re: raid0 slower than devices it is assembled of?
From: Peter Zaitsev <peter@mysql.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
References: <200312151434.54886.adasi@kernel.pl>
	 <20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no>
	 <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
	 <20031216205853.GC1402@matchmail.com>
	 <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1071657159.2155.76.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 14:39:37 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-17 at 00:11, Linus Torvalds wrote:

> >
> > Larger stripes may help in general, but I'd suggest that for raid5 (ie, not
> > raid0), the stripe size should not be enlarged as much.  On many
> > filesystems, a bitmap change, or inode table update shouldn't require
> > reading a large stripe from several drives to complete the pairity
> > calculations.
> 
> Oh, absolutely. I only made the argument as it works for RAID0, ie just
> striping.  There the only downside of a large stripe is the potential for
> a lack of parallelism, but as mentioned, I don't think that downside much
> exists with modern disks - the platter density and throughput (once you've
> seeked to the right place) are so high that there is no point to try to
> parallelise it at the data transfer point.

I'm pretty curious about this argument,

Practically as RAID5 uses XOR for checksum computation you do not have
to read the whole stripe to recompute the checksum.

If you have lets say 1Mb stripe but modify  just  few bytes somewhere,
there is no reason why you can't read lets say 4KB blocks from 2
devices, and write updated 4K blocks back.

The problem here lies what some (many?) RAID controllers have cache-line
equals to stripe size,  so working with whole stripes only. Some (at
least Mylex) however have different settings for cache line size and
stripe size.

What is about it in Linux software RAID5 implementation  ?


One more issue with smaller stripes both for RAID5 and RAID0 (at least
for DBMS workloads) is - you normally want multi-block IO (ie fetching
many sequentially located pages) to be close in cost to reading single
page, which is true for single hard drive. However with small stripe
size you will hit many of underlying devices  putting excessive not
necessary load. 

I was also wondering is there any way in Linux to make sure files are
aligned to stripe size ?   Performing IO in some particular page size
you would not like these to come on stripe  border touching two devices
instead of one. 



-- 
Peter Zaitsev, Full-Time Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification

