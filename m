Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUAVO0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 09:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUAVO0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 09:26:40 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:64783 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266187AbUAVO0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 09:26:35 -0500
Message-ID: <400FDDF8.4080600@techsource.com>
Date: Thu, 22 Jan 2004 09:28:08 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Deadline for video capture
References: <200401221608.05924.kernel@kolivas.org> <400F5CE5.6000602@cyberone.com.au>
In-Reply-To: <400F5CE5.6000602@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:
> 
> 
> Con Kolivas wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi all
>>
>> I suspected that the anticipatory scheduler might not have been the 
>> best choice for video capture because of the interruption to writes by 
>> reads and the subsequent anticipatory delay associated with it.  I 
>> have now confirmed that booting with the default anticipatory i/o 
>> elevator I get many dropped frames that I don't get if I boot with 
>> elevator=deadline.
>> briefly: dual 7200 rpm ATA5 IDE drives in software RAID0
>>
>> I guess there isn't really a lot to do about this, it's a compromise 
>> one way or the other. The anticipatory scheduler seems better all 
>> round but in this large streaming write situation it doesn't seem 
>> ideal. Any sysctl settings I could use to blunt the anticipation just 
>> before I do video capture?
>>
> 
> echo 0 > /sys/block/*/queue/iosched/antic_expire
> Turns it off alltogether.
> 
> You could also adjust read and write batch expire settings which are
> heavily biased toward reads.

Please excuse my potentially very stupid questions....


In AS, are there any sorts of "pressure levels" which indicate how many 
read and write blocks are pending?  Perhaps AS itself could be modified 
to strongly favor writes once some water mark of available pages (page 
cache, right?) has been reached.

The main idea behind AS is to increase throughput at the expense of 
additional latency.  It certainly wouldn't hurt us if occasionally there 
was a sudden burst of well-ordered writes.

I'm assuming that AS attempts to order reads and writes in ascending 
block number, right?  Why not order I/O's by ascending block number 
regardless of whether they're reads or writes, especially when the write 
pressure reaches a certain point?


Also, what kind of other system load was going on when the capture was 
happening?  A kernel compile?  Is there any feedback from the process 
scheduler to AS which indicates that an interactive task is what is 
doing the writes?

It seems to me that video playback would be helped by AS.  If capture is 
hurt by AS, that would be a shame.  Who wants to have to reboot or 
change /proc parameters to switch between record and playback?

But then again, anyone doing professional video editing is not likely to 
be doing a kernel compile in the background.  :)

