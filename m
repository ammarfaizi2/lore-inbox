Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUBCAeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUBCAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:34:50 -0500
Received: from s4.uklinux.net ([80.84.72.14]:17816 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265258AbUBCAer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:34:47 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>
	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au>
	<87d68xcoqi.fsf@codematters.co.uk> <401EDEF2.6090802@cyberone.com.au>
From: Philip Martin <philip@codematters.co.uk>
Date: Tue, 03 Feb 2004 00:34:14 +0000
In-Reply-To: <401EDEF2.6090802@cyberone.com.au> (Nick Piggin's message of
 "Tue, 03 Feb 2004 10:36:18 +1100")
Message-ID: <87n081vw55.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> Philip Martin wrote:
>
>>Nick Piggin <piggin@cyberone.com.au> writes:
>>>
>>>When the build finishes and there is no other activity, can you
>>>try applying anonymous memory pressure until it starts swapping
>>>to see if everything gets reclaimed properly?
>>
>>How do I apply anonymous memory pressure?
>
> Well just run something that uses a lot of memory and doesn't
> do much else. Run a few of these if you like:
>
> #include <stdlib.h>
> #include <unistd.h>
> #define MEMSZ (64 * 1024 * 1024)
> int main(void)
> {
>     int i;
>     char *mem = malloc(MEMSZ);
>     for (i = 0; i < MEMSZ; i+=4096)
>        mem[i] = i;
>     sleep(60);
>     return 0;
> }

This is what free reports after the build

             total       used       free     shared    buffers     cached
Mem:        516396     215328     301068          0      85084      68364
-/+ buffers/cache:      61880     454516
Swap:      1156664      40280    1116384

then after starting 10 instances of the above program

             total       used       free     shared    buffers     cached
Mem:        516396     513028       3368          0        596       5544
-/+ buffers/cache:     506888       9508
Swap:      1156664     320592     836072

and then after those programs finish

             total       used       free     shared    buffers     cached
Mem:        516396      35848     480548          0        964       5720
-/+ buffers/cache:      29164     487232
Swap:      1156664      54356    1102308

It looks OK to me.

>>You can have the numbers straight after a boot as well.  In this case
>>I rebooted, logged in, ran make clean and make -j4.
>
> Thanks. Much the same, isn't it?

Yes, it is.

> Can you try booting with the kernel argument: elevator=deadline
> and see how 2.6 goes?

Not much difference, these are times for a build straight after a
reboot:

2.6.
246.22user 120.44system 3:34.26elapsed 171%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (468major+3769185minor)pagefaults 0swaps

2.6.1 elevator=deadline
245.61user 120.31system 3:39.29elapsed 166%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (463major+3770456minor)pagefaults 0swaps

I note that the number of major pagefaults is not zero, I did not spot
that before.  In the past I have concentrated on builds when the
system has been running for some time, often having already built the
software one or more times, and in those cases the number of major
pagefaults was always zero, typically

2.6.1
244.08user 116.33system 3:27.40elapsed 173%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3763670minor)pagefaults 0swaps

When running 2.4 the total number of pagefaults is about the same, but
they are split over major and minor

2.4.24
242.27user 81.06system 2:44.18elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1742270major+1942279minor)pagefaults 0swaps


-- 
Philip Martin
