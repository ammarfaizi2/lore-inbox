Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTH0LH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTH0LH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:07:58 -0400
Received: from dyn-ctb-203-221-73-100.webone.com.au ([203.221.73.100]:39175
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263330AbTH0LHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:07:53 -0400
Message-ID: <3F4C90F1.8070605@cyberone.com.au>
Date: Wed, 27 Aug 2003 21:07:29 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cache limit
References: <oJ5P.699.21@gated-at.bofh.it> <oJ5P.699.23@gated-at.bofh.it> <oJ5P.699.25@gated-at.bofh.it> <oJ5P.699.27@gated-at.bofh.it> <oJ5P.699.19@gated-at.bofh.it> <oQh2.4bQ.13@gated-at.bofh.it> <3F4BB043.6010805@softhome.net> <20030826192333.GA1258@matchmail.com> <3F4C8619.4020505@softhome.net>
In-Reply-To: <3F4C8619.4020505@softhome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ihar 'Philips' Filipau wrote:

> Mike Fedyk wrote:
>
>>
>> That was because they wanted the non-streaming files to be left in 
>> the cache.
>>
>>>  I will try to produce some benchmarktings tomorrow with different 
>>> 'mem=%dMB'. I'm afraid to confirm that it will make difference.
>>>  But in advance: mantainance of page tables for 1GB and for 128MB of 
>>> RAM are going to make a difference.
>>
>>
>> I'm sorry to say, but you *will* get lower performance if you lower 
>> the mem=
>> value below your working set.  This will also lower the total amount of
>> memory available for your applications, and force your apps, to swap and
>> balance cache, and app memory.
>>
>> That's not what you are looking to benchmark.
>>
>
>   Okay. I'm completely puzzled.
>   I will qute here only one test - and I really do not understand this 
> stuff.
>
>   Three boots with the same parameters and only mem=nMB, n = 
> {512,256,128} (I have 512MB RAM)
>
>   hdparm tests:
> [root@hera ifilipau]# hdparm -t /dev/hda
> /dev/hda:
>  Timing buffered disk reads:  64 MB in  1.56 seconds = 41.03 MB/sec
> [root@hera ifilipau]# hdparm -T /dev/hda
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.44 seconds =290.91 MB/sec
> [root@hera ifilipau]#
>
>   Before tests I was doing 'swapoff -a; sync'
>   RedHat's 2.4.20-20.9 kernel.
>
>   What has really puzzled me.
>   Operation: "cat *.bz2 >big_file", where *.bz2 is just two bzipped 
> kernels. Total size: 29MB+32MB (2.4.22 + 2.6.0-test1)
>
>   To be bsolutely fair in this unfair benchmark I have run test only 
> once. Times in seconds as shown by bash's time.
>
>            cat      sync
>   512MB:  1.565    0.007
>   256MB:  1.649    0.008
>   128MB:  2.184    0.007
>
>   Kill me - shoot me, but how it can be?
>   Resulting file fits RAM.
>   Not hard to guess that source files, which no one cares about 
> already - are still hanging in the RAM...
>
>   That's not right: as long as resulting file fits memory - and it 
> fits memory in all (512MB, 256MB, 128MB) cases - this operation should 
> take the _same_ time. (Actually before 128MB test, vmstat was saying 
> that I have +70MB of free non-touched memory)
>
>   So resume is quite simple: kernel loses *terribly* much time 
> resorting read()s against write()s. Way _too_ _much_ time. 


The kernel spends _very_ little time in the disk elevator actually. The
2.4 elevator can send very suboptimal orderings of requests to the disk
when reads and writes are going to the disk at the same time. That might
be happening here. The VM might also be doing more work if you have other
things in RAM as well, although its unlikely to cause such a big
difference.


