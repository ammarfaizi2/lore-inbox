Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVI3FTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVI3FTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 01:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVI3FTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 01:19:43 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:10191 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932245AbVI3FTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 01:19:42 -0400
Date: Thu, 29 Sep 2005 22:19:41 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Guy <bugzilla@watkins-home.com>
cc: "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Holger Kiehl'" <Holger.Kiehl@dwd.de>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>,
       "'linux-raid'" <linux-raid@vger.kernel.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Where is the performance bottleneck?
In-Reply-To: <200509300452.j8U4qKw17804@www.watkins-home.com>
Message-ID: <Pine.LNX.4.63.0509292208100.27188@twinlark.arctic.org>
References: <200509300452.j8U4qKw17804@www.watkins-home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005, Guy wrote:

> My old 500MHz P3 can xor at 1GB/sec.  I don't think the RAID5 logic is the
> issue!  Also, I have not seen hardware that fast!  Or even half as fast.
> But I must admit, I have not seen a hardware RAID5 in a few years.  :(
> 
>    8regs     :   918.000 MB/sec
>    32regs    :   469.600 MB/sec
>    pIII_sse  :   994.800 MB/sec
>    pII_mmx   :  1102.400 MB/sec
>    p5_mmx    :  1152.800 MB/sec
> raid5: using function: pIII_sse (994.800 MB/sec)

those are cache based timings... an old 500mhz p3 probably has pc100 
memory and main memory can't even go that fast.  in fact i've got one of 
those here and it's lucky to get 600MB/s out of memory.

in fact, to compare sw raid to a hw raid you should count every byte of 
i/o somewhere between 2 and 3 times.  this is because every line you read 
into cache might knock out a dirty line, but it's definitely going to 
replace something which would still be there on a hw raid.  (i.e. it 
decreases the cache effectiveness and you end up paying later after the sw 
raid xor to read data back in which wouldn't leave the cache on a hw 
raid.)

then add in the read/write traffic required on the parity block (which as 
a fraction of i/o is worse with fewer drives) ... and it's pretty crazy to 
believe that sw raid is "free" just because the kernel prints those 
fantastic numbers at boot :)


> Humm..  It did not select the fastest?

this is related to what i'm describing -- iirc the pIII_sse code uses a 
non-temporal store and/or prefetchnta to reduce memory traffic.

-dean

p.s. i use sw raid regardless, i just don't like seeing these misleading 
discussions pointing at the kernel raid timings and saying "hw offload is 
pointless!"
