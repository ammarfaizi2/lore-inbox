Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUFCQrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUFCQrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUFCQrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:47:07 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:7654 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S265649AbUFCQqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:46:37 -0400
Message-ID: <40BF8E1F.1060009@drdos.com>
Date: Thu, 03 Jun 2004 14:46:23 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: submit_bh leaves interrupts on upon return
References: <40BE93DC.6040501@drdos.com> <20040603085002.GG28915@suse.de>
In-Reply-To: <20040603085002.GG28915@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Wed, Jun 02 2004, Jeff V. Merkey wrote:
>  
>
>>Any reason why submit_bh should turn on interrupts after being called by 
>>a process with ints off in 2.4.20?  I see it's possible to sleep during 
>>elevatoring, but why does it need to leave interrupts on if the calling 
>>state was with ints off.  
>>    
>>
>
>It's illegal to call it with interrupts off, so... __make_request()
>doesn't save interrupt state, so you will always leave with interrupts
>enabled.
>
>  
>
Jens

I noticed in the code it does not check for this when make_request is 
called, so I altered the calling sequence to call with ints on. I don't 
see much of a performance difference either way, so calling with ints on 
was easy to instrument. I am posting about 80,000+ buffer heads per 
second in with what I am doing, so filling out buffer_head structures 
and submitting them ad hoc was causing some interrupt windows where the 
chains were getting corrupted. I altered the calling sequence and added 
atomic counters so I can submit and call with ints on to avoid the 
corruption. One of the troublesome aspects of the manner in which 
make_request is implemented in always needing a context of a thread for 
sleeping to submit asynch I/O limits the ability to gang schedule large 
disk I/O from the b_end_io callback. Would make performance a lot more 
spectacular if it worked this way, but I am seeing good enough 
performance with it left the way it is. 3Ware's 66Mhz ATA adapter in 
this implementation is reaching almost 400 MB/S throughput on 2.4.20. I 
have not tried this on 2.6 yet, but will later this month.

Also, I ported the kernel debugger from MANOS to Linux and made a lot of 
significant enhancements and www.devicelogics.com is distributing it 
from their website. If anyone wants a more pleasant debugger for the 
kernel to work with, they are allowing downloads of the modules with a 
patch. Not free (what is in this world) but very nice to work with.

Thanks for the response. Sorry I was out of touch for about a year. I 
was going through a very nasty divorce with my wife of 24 years and I 
discovered when something like that is happening in your life, you don't 
have much attention for much else.

Jeff


