Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUKASvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUKASvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUKASvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:51:14 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:46479 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S269873AbUKAS27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:28:59 -0500
Message-ID: <418685AE.2020508@drdos.com>
Date: Mon, 01 Nov 2004 11:51:26 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] bio.c: make bio_destructor static
References: <20041030164450.GN4374@stusta.de> <20041101180348.GB5299@suse.de>
In-Reply-To: <20041101180348.GB5299@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Sat, Oct 30 2004, Adrian Bunk wrote:
>  
>
>>bio_destructor in fs/bio.c isn't used outside of this file, and after 
>>quickly thinking about it I didn't find a reason why it should.
>>
>>The patch below makes it static.
>>
>>
>>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>    
>>
>
>Acked-by: Jens Axboe <axboe@suse.de>
>
>  
>
>>--- linux-2.6.10-rc1-mm2-full/fs/bio.c.old	2004-10-30 13:53:41.000000000 +0200
>>+++ linux-2.6.10-rc1-mm2-full/fs/bio.c	2004-10-30 13:56:16.000000000 +0200
>>@@ -91,7 +91,7 @@
>> /*
>>  * default destructor for a bio allocated with bio_alloc()
>>  */
>>-void bio_destructor(struct bio *bio)
>>+static void bio_destructor(struct bio *bio)
>> {
>> 	const int pool_idx = BIO_POOL_IDX(bio);
>> 	struct biovec_pool *bp = bvec_array + pool_idx;
>>
>>
>>    
>>
>
>  
>
Jens,

This change does not break me either. Seems benign. One thing to 
consider is the ability to remap
block addresses from bios for mv operations that occur across mount 
points. At present, do_rename
returns -EXDEV if someone attempts an mv operation accross mount points 
which point to
physical storage in the same system, and requires all the data copy up 
to user space then back
down. This seems wasteful of cycles and inefficient.

A better model, and one I have implemented in the dsfs file system (I 
changed do_rename extensively)
is to cache the mv'd file and alias the bio chain to point to the new 
disk location during mv commands,
even across mount points, and allow the data to DMA directly between 
local mount points without
moving the data up to user space and back down.

I am doing this with some heavy modifications, but I think it more 
appropriately should be a kernel
feature "fait acompli." The bio interface in the buffer cache (and some 
triggers in do rename) has to
be able to remap data chains to another device on the fly.

Why? If you are using remote Fiber Channel adapters that map storage 
local as SCSI it's super fast
and low cycle overhead to simply mv the files and have them dma out on 
the storage and skip the
inefficient user space copy.

Just a suggestion.

Jeff



