Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWARHYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWARHYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWARHYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:24:51 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:24195 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030269AbWARHY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:24:26 -0500
X-Sasl-enc: e1N7R0RqbDWZASkIMFHijZoWKl4YwRT+0MxUI1+53p2V 1137569064
Message-ID: <43CDED23.5060701@fastmail.co.uk>
Date: Wed, 18 Jan 2006 15:24:19 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060116)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CD2405.4070902@cfl.rr.com>
In-Reply-To: <43CD2405.4070902@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Did you direct the program to use O_DIRECT?

I'm just using the s/w (iorate/bonnie++) with default options - I'm no 
expert. I could try though.

> If not then I believe the 
> problem you are seeing is that the generic block layer is not performing 
> large enough readahead to keep all the disks in the array reading at 
> once, because the stripe width is rather large.  What stripe factor did 
> you format the array using?

I left the stripe size at the default, which, I believe, is 64K bytes; 
same as your fakeraid below.

I did play with 'blockdev --setra' too.

I noticed it was 256 with a single disk, and, with s/w raid, it 
increased by 256 for each extra disk in the array. IE for the raid 0 
array with 4 drives, it was 1024.

With h/w raid, however, it did not increase when I added disks. Should I 
use 'blockdev --setra 320' (ie 64 x 5 = 320, since we're now running 
RAID5 on 5 drives)?

> I have a sata fakeraid at home of two drives using a stripe factor of 64 
> KB.  If I don't issue O_DIRECT IO requests of at least 128 KB ( the 
> stripe width ), then throughput drops significantly.  If I issue 
> multiple async requests of smaller size that totals at least 128 KB, 
> throughput also remains high.  If you only issue a single 32 KB request 
> at a time, then two requests must go to one drive and be completed 
> before the other drive gets any requests, so it remains idle a lot of 
> the time.

I think that makes sense (which is a change in this RAID performance 
business :( ).

Thanks.

Max.

> Max Waterman wrote:
>> Hi,
>>
>> I've been referred to this list from the linux-raid list.
>>
>> I've been playing with a RAID system, trying to obtain best bandwidth
>> from it.
>>
>> I've noticed that I consistently get better (read) numbers from kernel 
>> 2.6.8
>> than from later kernels.
>>
>> For example, I get 135MB/s on 2.6.8, but I typically get ~90MB/s on later
>> kernels.
>>
>> I'm using this :
>>
>> <http://www.sharcnet.ca/~hahn/iorate.c>
>>
>> to measure the iorate. I'm using the debian distribution. The h/w is a 
>> MegaRAID
>> 320-2. The array I'm measuring is a RAID0 of 4 Fujitsu Max3073NC 
>> 15Krpm drives.
>>
>> The later kernels I've been using are :
>>
>> 2.6.12-1-686-smp
>> 2.6.14-2-686-smp
>> 2.6.15-1-686-smp
>>
>> The kernel which gives us the best results is :
>>
>> 2.6.8-2-386
>>
>> (note that it's not an smp kernel)
>>
>> I'm testing on an otherwise idle system.
>>
>> Any ideas to why this might be? Any other advice/help?
>>
>> Thanks!
>>
>> Max.
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
> 

