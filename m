Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTLQUPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTLQUPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:15:12 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:1207 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S264540AbTLQUPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:15:04 -0500
Subject: Re: raid0 slower than devices it is assembled of?
From: Peter Zaitsev <peter@mysql.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <brq26h$6ei$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
	 <1071657159.2155.76.camel@abyss.local>  <brq26h$6ei$1@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1071692092.2149.196.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 23:14:53 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-17 at 20:02, bill davidsen wrote:
> In article <1071657159.2155.76.camel@abyss.local>,
> Peter Zaitsev  <peter@mysql.com> wrote:
> 
> | One more issue with smaller stripes both for RAID5 and RAID0 (at least
> | for DBMS workloads) is - you normally want multi-block IO (ie fetching
> | many sequentially located pages) to be close in cost to reading single
> | page, which is true for single hard drive. However with small stripe
> | size you will hit many of underlying devices  putting excessive not
> | necessary load. 
> 
> All this depends on what you're trying to optimize and the speed of the
> drives. I spent several years running on software raid and got to look
> harder than I wanted at the tuning.

Well I'm obviously interested mainly in Database workloads, both OLTP
(which is mainly random IO from many clients) as well as multi user
concurrent "scans" which are typical for some of some OLAP applications.
Yes of course speed of the drive makes sense here. However even lower
end IDE drives can do some 40Mb/sec now, which means  (some 100 random
req/sec drive can do)  you can transfer 400Kb in about the same time as
you can do random IO request, 

> 
> If the read size is large enough for transfer time to matter, not hidden
> in the latency, adjusting the stripe size so that you use many drives is
> a win. You want to avoid having a user i/o generate more than one i/o
> per drive if you can, which can lead to large stripe sizes.

Yes this is true.  However looking at the same logic as below we can
identify what transfer time starts to matter (compared to seek time
which you needed to do to start it)  if  400Kb+ is transferred from
single drive. Which means there is not much sense to have stripe sizes 
less than 256-512Kb if you're looking at single scan. If you have many
concurrent scans you might even with to have blocks larger. 


> 
> Also, the read to write ratio is important. RAID-5 does poorly with
> write, since the CRC needs to be recalculated and written each time. On
> read, unless you are in fallback mode, you just read the data and the
> performance is similar to RAID-0.

Yes sure. Reads are sort of trivial unless you're running in degraded
mode. I was just wondering how write handling is implemented in Linux
kernel.

RAID5 write speed is quite sensitive to the cache size.  Which cache
Linux software RAID5 is using (if any) for write optimization ?

> 
> If you have (a) a high read to write load, and (b) a very heavy read
> load, then RAID-1 works better, possibly with more than two copies of
> the data to reduce head motion contention.

Yes. That is actually interesting question. Lets take a look at
read-only cases. This is obvious if you have few concurrent clients (or
actually concurrent IO requests), as with RAID0 there is probability to
have IO unbalanced on devices, with RAID1 we have full copies so we
always can balance reads as we need. 

However with growing number of concurrent clients the probability uneven
device load decreases.  If I remember correctly with 100 concurrent
clients I had quite similar performance from RAID0 and RAID1. 

Yes there is other risk with RAID0 - boundary reads which would require
2 reads instead of one. I however used perfectly aligned reads in my
test so it could not happen :)


-- 
Peter Zaitsev, Full-Time Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification

