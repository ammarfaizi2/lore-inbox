Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269037AbUIHDmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269037AbUIHDmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUIHDky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:40:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269028AbUIHDjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:39:22 -0400
Date: Tue, 7 Sep 2004 23:18:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, raybry@sgi.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040908021816.GB2942@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907212051.GC3492@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Spent some time doing a few tests.
> 
> A contained test (512MB box, allocate 450MB of memory, touch and sleep + 
> huge dd) show's that 2.6.6 and 2.6.7 are equivalent (swapout 120-150M when the "dd" 
> starts writing out data).
> 
> 2.6.9-rc1 swaps out 350M on the same test. Doenst seem nice, I'll try to isolate 
> what causes this tomorrow (this is probably what is hitting desktop users which
> is fixed by Con's patches). Thats problem #1. Something needs a little tweaking 
> I think. 
> 
> Ray, I see the additional swapouts increase the dd performance for your particular testcase:
> 
> on 2.6.6:
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   242.47 MB/s      0 MB (     0,     0)   3195 MB (  3138,  3266)
>   20   256.06 MB/s      0 MB (     0,     0)   3170 MB (  3074,  3234)
>   40   267.29 MB/s      0 MB (     0,     0)   3189 MB (  3137,  3234)
>   60   289.43 MB/s    666 MB (    72,  1680)   3847 MB (  3296,  4817)		<---------- 
> 
> So for this one testcase it is being beneficial. 
> 
> However, decreasing the "swappiness" value does not seem to make much of a difference:
> 
> Kernel Version 2.6.8.1-mm4:
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   287.28 MB/s    710 MB (    46,  3060)   4082 MB (  3426,  6308)
>   20   288.05 MB/s    508 MB (    94,  1417)   3848 MB (  3442,  4739)
>   40   287.03 MB/s    588 MB (   199,  1251)   3909 MB (  3570,  4515)
>   60   290.08 MB/s    640 MB (   210,  1190)   3976 MB (  3538,  4531)
>   80   287.73 MB/s    693 MB (   316,  1195)   4049 MB (  3713,  4545)
>  100   166.17 MB/s  26001 MB ( 26001, 26002)  28798 MB ( 28740, 28852)
>                                                                                                                                                                                    
> Kernel Version 2.6.9-rc1-mm3:
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   274.80 MB/s  10511 MB (  5644, 14492)  13293 MB (  8596, 17156)
>   20   267.02 MB/s  12624 MB (  5578, 16287)  15298 MB (  8468, 18889)
>   40   267.66 MB/s  13541 MB (  6619, 17461)  16199 MB (  9393, 20044)
>   60   233.73 MB/s  18094 MB ( 16550, 19676)  20629 MB ( 19103, 22192)
>   80   213.64 MB/s  20950 MB ( 15844, 22977)  23450 MB ( 18496, 25440)
>  100   164.58 MB/s  26004 MB ( 26004, 26004)  28410 MB ( 28327, 28455)
> 
> And that is a problem #2 - swappinness not being honoured. Guys, 
> any ideas on the reason for that?

Hum I just tested it on my 512MB box and swappiness is working fine on 2.6.8.. (it
has expected effects), unlike Ray's tests.

> 
> Andrew, dirty_ratio and dirty_background_ratio (as low as 5% each) did not significantly 
> affect the amount of swapped out data, only a small effect on _how soon_ anonymous 
> memory was swapped out.
> 
> And finally, Ray, the difference you see between 2.6.6 and 2.6.7 can be explained, 
> as noted by others in this thread, to vmscan.c changes (page replacement/scanning policy
> changes were made).
> 
> Will continue with more tests tomorrow.
