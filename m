Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274908AbRIYMzH>; Tue, 25 Sep 2001 08:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274983AbRIYMy6>; Tue, 25 Sep 2001 08:54:58 -0400
Received: from empr3-188.menta.net ([62.57.108.188]:32083 "EHLO www.bosch.es")
	by vger.kernel.org with ESMTP id <S274908AbRIYMyj>;
	Tue, 25 Sep 2001 08:54:39 -0400
Message-ID: <3BB07EA2.4010804@juridicas.com>
Date: Tue, 25 Sep 2001 14:54:58 +0200
From: Jorge =?ISO-8859-1?Q?Ner=EDn?= <jnerin@juridicas.com>
Reply-To: comandante@zaralinux.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: es-es, es, en
MIME-Version: 1.0
To: tegeran@home.com
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924173210.A7630@emma1.emma.line.org> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight wrote:

>On Monday 24 September 2001 08:32 am, Matthias Andree wrote:
>
>>On Mon, 24 Sep 2001, Beau Kuiper wrote:
>>
>>>Also, the performace problems seem to be very dependant on the
>>>hardware being used. 5400rpm drives get hurt a lot, while 7200 rpm
>>>drives seem to handle it better. Decent write caching on IDE
>>>devices (like the 2meg buffer on the IBM) can completely hide this
>>>issue.
>>>
>>Decent write caching on IDE devices can eat your whole file system.
>>
>>Turn it off (I have no idea of internals, but I presume it'll still
>>be a write-through cache, so reading back will still be served from
>>the buffer). Do hdparm -W0 /dev/hd[a-h].
>>
>
>I'm sorry, but that's not acceptable.
>Please note the dd timings at the bottom of this message.
>
>This is consistant with real workload on my and other peoples systems, 
>200-300MB+ files, clear up to 1GB+ files are at times ROUTINE for 
>writing. This is esspecialy applicable if dealing with disk images, etc.
>Disabling write cache creates times that are twice as large or more 
>than WITH write cache. Unless the system or drive has a serious, 
>SPECIFIC fault with its write cache, disabling it can cause an 
>unacceptable performance hit.
>
>Yes, a typical desktop user isn't going to notice much, even a normal 
>webserver or fileserver not dealing with constant updates may not, but 
>certain workloads will. These workloads are real enough that telling 
>people to disable write caching out of hand is a bad idea.
>There's no way in hell I'm going to accept having my performance cut in 
>half or more on my daily workload due to the remote possibility that 
>something may happen to my data/filesystem in mid-write. That's what 
>the cheap little UPS sitting beside my desk that gives me ample time to 
>power down is for.
>Short of a catastrophic power supply, motherboard, or other component 
>failure (which often stands a good chance of destroying the drive 
>anyway), a power failure is the main problem here.
>Keep in mind also, that you may be putting your data and filesystems in 
>more risk by not using a write cache as with using it.
>
>
>
>(below timings are all on an IBM 75GXP DTLA-307045, 46.11BB("GB") 
>7200RPM ATA/100 drive on an off-board Promise Ultra/100 (ATA/100) 
>controller on an 800Mhz Athlon 100Mhz FSB PC100 RAM CAS3@100Mhz.)
>
>root@c779218-a:/home/nnkk# hdparm -W0 /dev/hde
>
>/dev/hde:
> setting drive write-caching to 0 (off)
>root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
>count=128
>128+0 records in
>128+0 records out
>
>real    0m18.178s
>user    0m0.000s
>sys     0m1.740s
>root@c779218-a:/home/nnkk# rm -f test.zero
>root@c779218-a:/home/nnkk# hdparm -W1 /dev/hde
>
>/dev/hde:
> setting drive write-caching to 1 (on)
>root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
>count=128
>128+0 records in
>128+0 records out
>
>real    0m7.809s
>user    0m0.020s
>sys     0m1.890s
>root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
>count=256
>256+0 records in
>256+0 records out
>
>real    0m44.328s
>user    0m0.010s
>sys     0m3.510s
>root@c779218-a:/home/nnkk# hdparm -W1 /dev/hde
>
>/dev/hde:
> setting drive write-caching to 1 (on)
>root@c779218-a:/home/nnkk# rm -f test.zero
>root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
>count=256
>256+0 records in
>256+0 records out
>
>real    0m18.790s
>user    0m0.000s
>sys     0m3.780s
>
Who says test.zero is a linear file and it's not scattered around the 
whole disk and the fs layer is filling holes...? If it's the case the 
write cache is a BIG win, just think that the fs writes a chunk at the 
beggining of the disk, then another chunk at the end, then another near 
the beginning, then...  you get the picture, in this case the disk 
reorders the seeks to best fit.

If you want to try a REAL linear write do a dd if=/dev/zero of=/dev/hde7 
or whatever unused partition you have.

-- 
Jorge Nerin
<comandante@zaralinux.com>



