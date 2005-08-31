Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVHaQbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVHaQbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVHaQbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:31:55 -0400
Received: from [67.137.28.189] ([67.137.28.189]:35763 "EHLO vger")
	by vger.kernel.org with ESMTP id S964865AbVHaQby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:31:54 -0400
Message-ID: <4315C9EB.2030506@utah-nac.org>
Date: Wed, 31 Aug 2005 09:16:59 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de> <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831162053.GG4018@suse.de>
In-Reply-To: <20050831162053.GG4018@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have seen an 80GB/sec limitation in the kernel unless this value is 
changed in the SCSI I/O layer
for 3Ware and other controllers during testing of 2.6.X series kernels.

Change these values in include/linux/blkdev.h and performance goes from 
80MB/S to over 670MB/S on the 3Ware controller.


//#define BLKDEV_MIN_RQ    4
//#define BLKDEV_MAX_RQ    128    /* Default maximum */
#define BLKDEV_MIN_RQ    4096
#define BLKDEV_MAX_RQ    8192    /* Default maximum */

Jeff



Jens Axboe wrote:

>On Wed, Aug 31 2005, Holger Kiehl wrote:
>  
>
>>On Wed, 31 Aug 2005, Jens Axboe wrote:
>>
>>    
>>
>>>Nothing sticks out here either. There's plenty of idle time. It smells
>>>like a driver issue. Can you try the same dd test, but read from the
>>>drives instead? Use a bigger blocksize here, 128 or 256k.
>>>
>>>      
>>>
>>I used the following command reading from all 8 disks in parallel:
>>
>>   dd if=/dev/sd?1 of=/dev/null bs=256k count=78125
>>
>>Here vmstat output (I just cut something out in the middle):
>>
>>procs -----------memory---------- ---swap-- -----io---- --system-- 
>>----cpu----^M
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id 
>> wa^M
>> 3  7   4348  42640 7799984   9612    0    0 322816     0 3532  4987  0 22  
>> 0 78
>> 1  7   4348  42136 7800624   9584    0    0 322176     0 3526  4987  0 23  
>> 4 74
>> 0  8   4348  39912 7802648   9668    0    0 322176     0 3525  4955  0 22 
>> 12 66
>> 1  7   4348  38912 7803700   9636    0    0 322432     0 3526  5078  0 23  
>>    
>>
>
>Ok, so that's somewhat better than the writes but still off from what
>the individual drives can do in total.
>
>  
>
>>>You might want to try the same with direct io, just to eliminate the
>>>costly user copy. I don't expect it to make much of a difference though,
>>>feels like the problem is elsewhere (driver, most likely).
>>>
>>>      
>>>
>>Sorry, I don't know how to do this. Do you mean using a C program
>>that sets some flag to do direct io, or how can I do that?
>>    
>>
>
>I've attached a little sample for you, just run ala
>
># ./oread /dev/sdX
>
>and it will read 128k chunks direct from that device. Run on the same
>drives as above, reply with the vmstat info again.
>
>  
>
>------------------------------------------------------------------------
>
>#include <stdio.h>
>#include <stdlib.h>
>#define __USE_GNU
>#include <fcntl.h>
>#include <stdlib.h>
>#include <unistd.h>
>
>#define BS		(131072)
>#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) & ~(4095))
>#define BLOCKS		(8192)
>
>int main(int argc, char *argv[])
>{
>	char *p;
>	int fd, i;
>
>	if (argc < 2) {
>		printf("%s: <dev>\n", argv[0]);
>		return 1;
>	}
>
>	fd = open(argv[1], O_RDONLY | O_DIRECT);
>	if (fd == -1) {
>		perror("open");
>		return 1;
>	}
>
>	p = ALIGN(malloc(BS + 4095));
>	for (i = 0; i < BLOCKS; i++) {
>		int r = read(fd, p, BS);
>
>		if (r == BS)
>			continue;
>		else {
>			if (r == -1)
>				perror("read");
>
>			break;
>		}
>	}
>
>	return 0;
>}
>  
>

