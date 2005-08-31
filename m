Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVHaQ6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVHaQ6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHaQ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:58:23 -0400
Received: from bud.tessco.com ([63.160.135.12]:46051 "EHLO bud.tessco.com")
	by vger.kernel.org with ESMTP id S964878AbVHaQ6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:58:23 -0400
Date: Wed, 31 Aug 2005 12:58:01 -0400
From: Tom Callahan <callahant@tessco.com>
Subject: Re: Where is the performance bottleneck?
In-reply-to: <4315C9EB.2030506@utah-nac.org>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Jens Axboe <axboe@suse.de>, Holger Kiehl <Holger.Kiehl@dwd.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4315E199.3060003@tessco.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
References: <4315C9EB.2030506@utah-nac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From linux-kernel mailing list.....

Don't do this. BLKDEV_MIN_RQ sets the size of the mempool reserved
requests and will only get slightly used in low memory conditions, so
most memory will probably be wasted.....

Change /sys/block/xxx/queue/nr_requests

Tom Callahan
TESSCO Technologies
(443)-506-6216
callahant@tessco.com



jmerkey wrote:

>I have seen an 80GB/sec limitation in the kernel unless this value is 
>changed in the SCSI I/O layer
>for 3Ware and other controllers during testing of 2.6.X series kernels.
>
>Change these values in include/linux/blkdev.h and performance goes from 
>80MB/S to over 670MB/S on the 3Ware controller.
>
>
>//#define BLKDEV_MIN_RQ    4
>//#define BLKDEV_MAX_RQ    128    /* Default maximum */
>#define BLKDEV_MIN_RQ    4096
>#define BLKDEV_MAX_RQ    8192    /* Default maximum */
>
>Jeff
>
>
>
>Jens Axboe wrote:
>
>  
>
>>On Wed, Aug 31 2005, Holger Kiehl wrote:
>> 
>>
>>    
>>
>>>On Wed, 31 Aug 2005, Jens Axboe wrote:
>>>
>>>   
>>>
>>>      
>>>
>>>>Nothing sticks out here either. There's plenty of idle time. It
>>>>        
>>>>
>smells
>  
>
>>>>like a driver issue. Can you try the same dd test, but read from the
>>>>drives instead? Use a bigger blocksize here, 128 or 256k.
>>>>
>>>>     
>>>>
>>>>        
>>>>
>>>I used the following command reading from all 8 disks in parallel:
>>>
>>>  dd if=/dev/sd?1 of=/dev/null bs=256k count=78125
>>>
>>>Here vmstat output (I just cut something out in the middle):
>>>
>>>procs -----------memory---------- ---swap-- -----io---- --system-- 
>>>----cpu----^M
>>>r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us
>>>      
>>>
>sy id 
>  
>
>>>wa^M
>>>3  7   4348  42640 7799984   9612    0    0 322816     0 3532  4987
>>>      
>>>
>0 22  
>  
>
>>>0 78
>>>1  7   4348  42136 7800624   9584    0    0 322176     0 3526  4987
>>>      
>>>
>0 23  
>  
>
>>>4 74
>>>0  8   4348  39912 7802648   9668    0    0 322176     0 3525  4955
>>>      
>>>
>0 22 
>  
>
>>>12 66
>>>1  7   4348  38912 7803700   9636    0    0 322432     0 3526  5078
>>>      
>>>
>0 23  
>  
>
>>>   
>>>
>>>      
>>>
>>Ok, so that's somewhat better than the writes but still off from what
>>the individual drives can do in total.
>>
>> 
>>
>>    
>>
>>>>You might want to try the same with direct io, just to eliminate the
>>>>costly user copy. I don't expect it to make much of a difference
>>>>        
>>>>
>though,
>  
>
>>>>feels like the problem is elsewhere (driver, most likely).
>>>>
>>>>     
>>>>
>>>>        
>>>>
>>>Sorry, I don't know how to do this. Do you mean using a C program
>>>that sets some flag to do direct io, or how can I do that?
>>>   
>>>
>>>      
>>>
>>I've attached a little sample for you, just run ala
>>
>># ./oread /dev/sdX
>>
>>and it will read 128k chunks direct from that device. Run on the same
>>drives as above, reply with the vmstat info again.
>>
>> 
>>
>>-----------------------------------------------------------------------
>>    
>>
>-
>  
>
>>#include <stdio.h>
>>#include <stdlib.h>
>>#define __USE_GNU
>>#include <fcntl.h>
>>#include <stdlib.h>
>>#include <unistd.h>
>>
>>#define BS		(131072)
>>#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) &
>>    
>>
>~(4095))
>  
>
>>#define BLOCKS		(8192)
>>
>>int main(int argc, char *argv[])
>>{
>>	char *p;
>>	int fd, i;
>>
>>	if (argc < 2) {
>>		printf("%s: <dev>\n", argv[0]);
>>		return 1;
>>	}
>>
>>	fd = open(argv[1], O_RDONLY | O_DIRECT);
>>	if (fd == -1) {
>>		perror("open");
>>		return 1;
>>	}
>>
>>	p = ALIGN(malloc(BS + 4095));
>>	for (i = 0; i < BLOCKS; i++) {
>>		int r = read(fd, p, BS);
>>
>>		if (r == BS)
>>			continue;
>>		else {
>>			if (r == -1)
>>				perror("read");
>>
>>			break;
>>		}
>>	}
>>
>>	return 0;
>>}
>> 
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-raid" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>
