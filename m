Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbTCYL36>; Tue, 25 Mar 2003 06:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbTCYL35>; Tue, 25 Mar 2003 06:29:57 -0500
Received: from dial-ctb05113.webone.com.au ([210.9.245.113]:20751 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S262045AbTCYL3v>;
	Tue, 25 Mar 2003 06:29:51 -0500
Message-ID: <3E803FDF.1070401@cyberone.com.au>
Date: Tue, 25 Mar 2003 22:39:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@digeo.com>, dougg@torque.net, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
References: <200303211056.04060.pbadari@us.ibm.com> <3E7C4251.4010406@torque.net> <20030322030419.1451f00b.akpm@digeo.com> <3E7C4D05.2030500@torque.net> <20030322040550.0b8baeec.akpm@digeo.com> <20030325105629.GS2371@suse.de>
In-Reply-To: <20030325105629.GS2371@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Sat, Mar 22 2003, Andrew Morton wrote:
>
>>Douglas Gilbert <dougg@torque.net> wrote:
>>
>>>Andrew Morton wrote:
>>>
>>>>Douglas Gilbert <dougg@torque.net> wrote:
>>>>
>>>>
>>>>>>Slab:           464364 kB
>>>>>>
>>>>It's all in slab.
>>>>
>>>>
>>>>
>>>>>I did notice a rather large growth of nodes
>>>>>in sysfs. For 84 added scsi_debug pseudo disks the number
>>>>>of sysfs nodes went from 686 to 3347.
>>>>>
>>>>>Does anybody know what is the per node memory cost of sysfs?
>>>>>
>>>>
>>>>Let's see all of /pro/slabinfo please.
>>>>
>>>Andrew,
>>>Attachments are /proc/slabinfo pre and post:
>>>  $ modprobe scsi_debug add_host=42 num_devs=2
>>>which adds 84 pseudo disks.
>>>
>>>
>>OK, thanks.  So with 48 disks you've lost five megabytes to blkdev_requests
>>and deadline_drq objects.  With 4000 disks, you're toast.  That's enough
>>request structures to put 200 gigabytes of memory under I/O ;)
>>
>>We need to make the request structures dymanically allocated for other
>>reasons (which I cannot immediately remember) but it didn't happen.  I guess
>>we have some motivation now.
>>
>
>Here's a patch that makes the request allocation (and io scheduler
>private data) dynamic, with upper and lower bounds of 4 and 256
>respectively. The numbers are a bit random - the 4 will allow us to make
>progress, but it might be a smidgen too low. Perhaps 8 would be good.
>256 is twice as much as before, but that should be alright as long as
>the io scheduler copes. BLKDEV_MAX_RQ and BLKDEV_MIN_RQ control these
>two variables.
>
>We loose the old batching functionality, for now. I can resurrect that
>if needed. It's a rough fit with the mempool, it doesn't _quite_ fit our
>needs here. I'll probably end up doing a specialised block pool scheme
>for this.
>
>Hasn't been tested all that much, it boots though :-)
>
Nice Jens. Very good in theory but I haven't looked at the
code too much yet.

Would it be possible to have all queues allocate out of
the one global pool of free requests. This way you could
have a big minimum (say 128) and a big maximum
(say min(Mbytes, spindles).

This way memory usage is decoupled from the number of
queues, and busy spindles could make use of more
available free requests.

Oh and the max value can easily be runtime tunable, right?

