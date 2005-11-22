Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVKVRXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVKVRXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVKVRXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:23:42 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:31340 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965023AbVKVRXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:23:41 -0500
Message-ID: <438354B4.10604@tmr.com>
Date: Tue, 22 Nov 2005 12:26:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lars Roland <lroland@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux RAID M/L <linux-raid@vger.kernel.org>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
In-Reply-To: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland wrote:
> I have created a stripe across two 500Gb disks located on separate IDE
> channels using:
> 
> mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd
> 
> the performance is awful on both kernel 2.6.12.5 and 2.6.14.2 (even
> with hdparm and blockdev tuning), both bonnie++ and hdparm (included
> below) shows a single disk operating faster than the stripe:

In looking at this I found something interesting, even though you 
identified your problem before I was able to use the data for the 
intended purpose. So other than suggesting that the stripe size is too 
small, nothing on that, your hardware is the issue.

I have two ATA drives connected, and each has two partitions. The first 
partition of each is mirrored for reliability with default 64k chunks, 
and the second is striped, with 512k chunks (I write a lot of 100MB 
files to this f/s).

Reading the individual devices with dd, I saw a transfer rate of about 
60MB/s, while the striped md1 device gave just under 120MB/s. (60.3573 
and 119.6458) actually. However, the mirrored md0 also gave just 60MB/s 
read speed.

One of the advantages of mirroring is that if there is heavy read load 
when one drive is busy there is another copy of the data on the other 
drive(s). But doing 1MB reads on the mirrored device did not show that 
the kernel took advantage of this in any way. In fact, it looks as if 
all the reads are going to the first device, even with multiple 
processes running. Does the md code now set "write-mostly" by default 
and only go to the redundant drives if the first fails?

I won't be able to do a lot of testing until Thursday, or perhaps 
Wednesday night, but that is not as I expected and not what I want, I do 
mirroring on web and news servers to spread the head motion, now I will 
be looking at the stats to see if that's happening.

I added the raid M/L to the addresses, since this is getting to be 
general RAID question.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
