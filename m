Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbUK0BQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbUK0BQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUK0BOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:14:14 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:22171 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263082AbUK0BKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 20:10:17 -0500
Message-ID: <41A7D3EF.3030002@yahoo.com.au>
Date: Sat, 27 Nov 2004 12:10:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Out of memory, but no OOM Killer? (2.6.9-ac11)
References: <20041126224722.GK30987@charite.de> <41A7C2CA.1030008@yahoo.com.au> <20041127003353.GQ30987@charite.de>
In-Reply-To: <20041127003353.GQ30987@charite.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au>:
> 
> 
>>This could be the problem where fragmented memory causes atomic higher
>>order allocations to fail, for which there is a fix in -mm, which should
>>make its way into 2.6.11.
> 
> 
> I see. rsync requested a big chunk of memory, but failed due to the
> fragmentation of free memory? my "sar" output shows lots of free memory and
> lots of unused swap:
> 

Basically, yes. Well not *exactly* rsync - your network drivers. I guess
rsync is showing up in process context most often because that is the
process causing most of the network activity.

Yep, it looks like fragmentation is indeed the problem here. See you have
a lot of memory that is able to be reclaimed, but the failing allocations
themselves can't reclaim any of it because they are happening from
interrupts. What they should be doing is telling `kswapd` to start freeing
memory for them - however this currently doesn't happen properly for
allocations which are order greater than 0.

Fortunately that is usually not a big problem, but as you have seen, it
can be. Anyway, expect 2.6.10 to be better (ie. good enough), and 2.6.11
should have even more complete fixes.

> 
>>As a temporary workaround, you can increase /proc/sys/vm/min_free_kbytes
> 
> 
> # cat /proc/sys/vm/min_free_kbytes
> 724
> 
> I increased that to 7240 now.
> 

OK that should be fine. If you should upgrade to a 2.6.10 or later kernel,
put this value back to the default, and report further problems if they
occur.

> 
>>BTW. what does `free` say when the allocation failures are happening?
> 
> 
> see sar output above.
> 

Thanks Ralf.
