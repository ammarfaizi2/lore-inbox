Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUI1D7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUI1D7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 23:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUI1D7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 23:59:20 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:41810 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267527AbUI1D7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 23:59:15 -0400
Message-ID: <4158DC27.9010603@yahoo.com.au>
Date: Tue, 28 Sep 2004 13:36:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>
CC: piggin@cyberone.com.au, William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com> <20040908193036.GH4284@logos.cnet> <413FC8AC.7030707@sgi.com> <20040909030916.GR3106@holomorphy.com> <4158C45B.8090409@sgi.com>
In-Reply-To: <4158C45B.8090409@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

> Nick,
>
> As reported to you elsewhere (and duplicated here to get on this thread),
> application of the patch you sent (attached) dramatically changes the
> swappiness behavior of the 2.6.9-rc1 (and presumably the rc2) kernel.
>
> Here are the updated results:
>
> Previously:
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
> With Nick Piggin et al fix:
>
> Kernel Version: linux-2.6.9-rc1-mm3-kswapdfix
>
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   279.97 MB/s     89 MB (    12,   265)   3062 MB (  2947,  3267)
>   20   283.55 MB/s    161 MB (    15,   372)   3190 MB (  3011,  3427)
>   40   282.32 MB/s    204 MB (     6,   407)   3187 MB (  2995,  3331)
>   60   279.42 MB/s     72 MB (    15,   171)   3091 MB (  3027,  3155)
>   80   283.34 MB/s    920 MB (   144,  3028)   3904 MB (  3106,  5957)
>  100   160.55 MB/s  26008 MB ( 26007, 26008)  28473 MB ( 28455, 28487)
>
> (The drop at swappiness of 60 may just be randomness, not sure it
> is significant, but these results are all based on 5 trials.)
>
> At any rate, this patch appears to fix the problems I was seeing before.
> (See
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=109449778320333&w=2
>
> for further details of the benchmark and the test environment).
>
>

Thanks Ray. From looking over your old results, it appears that -kswapdfix
probably has the nicest swappiness ramp, which is probably to be expected,
as the problem that is being fixed did exist in all other kernels you 
tested,
but the later ones just had other aggrivating changes.

The swappiness=60 weirdness might just be some obscure interaction with the
workload. If that is the case, it is probably not too important, however it
could be due to a possible oversight in my patch....

I'm not in front of the code right now, so I can't give you a new patch to
try yet... if you're up for modifying it yourself though: we possibly should
be updating "zone->prev_priority" after each 32 (SWAP_CLUSTER_MAX) pages 
freed.
So change the following:

==>    if (total_reclaimed >= 32)
==>       break;
    }
out:
    for (i = 0; i < pgdat->nr_zones; i++) {
       ... /* this updates zone->prev_priority */
    }
=>  if (!all_zones_ok)
=>     goto loop_again;
    return total_reclaimed;
}

so it looks something like that.

If you could run your tests again on that, it would be great.

Thanks
Nick
