Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbTK0SOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbTK0SOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:14:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:48041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264575AbTK0SOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:14:33 -0500
Message-ID: <3FC63D60.8020304@colorfullife.com>
Date: Thu, 27 Nov 2003 19:07:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: pinotj@club-internet.fr, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
References: <mnet1.1069781435.24380.pinotj@club-internet.fr> <Pine.LNX.4.58.0311251443280.1524@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311251443280.1524@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 25 Nov 2003 pinotj@club-internet.fr wrote:
>  
>
>>3. 2.6.0-test10 vanilla + PREEMPT_CONFIG=y + patch printk + patch magic numbers
>>The patch solves the problem, I can compile 4 times a kernel and do heavy work in parallele (load average around 1.2 during 2 hours) without any problems.
>>    
>>
>
>Those magic numbers don't make any sense. In particular, SLAB_LIMIT is
>clearly bogus both in the original version and in the "magic number
>patch". The only place that uses SLAB_LIMIT is the code that decides how
>many entries fit in one slab, and quite frankly, it makes no _sense_ to
>have a SLAB_LIMIT that is big enough to be unsigned.
>
Object numbers  (kmem_bufctl_t) are unsigned, but some values have a 
special meaning:
"-1" is the magic value for end-of-list.
"-2" is the magic value for object in use.
All other values are valid object numbers. Right now object numbers are 
unsigned int, but initially I considered unsigned char or unsigned 
short. And then an explicit SLAB_LIMIT is necessary - with unsigned 
char, the limit would be 253 objects per slab, which could be reached if 
someone creates objects smaller than 16 bytes.

In Jerome's case, the debug checks noticed that the object-in-use 
sentinel was not in the bufctl entry during free, instead there was a 
"-1". There are several sources for the "-1": My initial guess was 
either a bug in slab, or a bad memory cell (only one bit difference). 
Thus I sent him a patch that changes multiple bits. Result: It remained 
a single bit change, i.e it's proven that slab doesn't write BUFCTL_END 
into the wrong slot.

--
    Manfred

