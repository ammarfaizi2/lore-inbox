Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUHWPi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUHWPi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUHWPhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:37:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36552 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265396AbUHWPer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:34:47 -0400
Date: Mon, 23 Aug 2004 11:12:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Karl Vogel <karl.vogel@seagha.com>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.8.1: swap storm of death - CFQ scheduler=culprit
Message-ID: <20040823141206.GE2157@logos.cnet>
References: <200408221527.10303.karl.vogel@seagha.com> <m38yc757pu.fsf@seagha.com> <m33c2f56ck.fsf_-_@seagha.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c2f56ck.fsf_-_@seagha.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 09:18:51PM +0200, Karl Vogel wrote:
> When using elevator=as I'm unable to trigger the swap of death, so it seems
> that the CFQ scheduler is at blame here.
> 
> With AS scheduler, the system recovers in +-10 seconds, vmstat output during
> that time:
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1  0      0 295632  40372  49400   87  278   324   303 1424   784  7  2 78 13
>  0  0      0 295632  40372  49400    0    0     0     0 1210   648  3  1 96  0
>  0  0      0 295632  40372  49400    0    0     0     0 1209   652  4  0 96  0
>  2  0      0 112784  40372  49400    0    0     0     0 1204   630 23 34 43  0
>  1  9 156236    788    264   8128   28 156220  3012 156228 3748  3655 11 31  0 59
>  0 15 176656   2196    280   8664    0 20420   556 20436 1108   374  2  5  0 93
>  0 17 205320    724    232   7960   28 28664   396 28664 1118   503  7 12  0 81
>  2 12 217892   1812    252   8556  248 12584   864 12584 1495   318  2  7  0 91
>  4 14 253268   2500    268   8728  188 35392   432 35392 1844   399  3  7  0 90
>  0 13 255692   1188    288   9152  960 2424  1408  2424 1173  2215 10  5  0 85
>  0  7 266140   2288    312   9276  604 10468   752 10468 1248   644  5  5  0 90
>  0  7 190516 340636    348   9860 1400    0  2016     0 1294   817  4  8  0 88
>  1  8 190516 339460    384  10844  552    0  1556     4 1241   642  3  1  0 96
>  1  3 190516 337084    404  11968 1432    0  2576     4 1292   788  3  1  0 96
>  0  6 190516 333892    420  13612 1844    0  3500     0 1343   850  5  2  0 93
>  0  1 190516 333700    424  13848  480    0   720     0 1250   654  3  2  0 95
>  0  1 190516 334468    424  13848  188    0   188     0 1224   589  3  2  0 95
> 
> With CFQ processes got stuck in 'D' and never left that state. See URL's in my
> initial post for diagnostics.

I can confirm this on a 512MB box with 512MB swap (2.6.8-rc4). Using CFQ the machine swaps out
400 megs, with AS it swaps out 30M.  

That leads to allocation failures/etc. 

CFQ allocates a huge number of bio/biovecs:

 cat /proc/slabinfo | grep bio
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata 52     52      0
biovec-64            265    265    768    5    1 : tunables   54   27    0 : slabdata 53     53      0
biovec-16            260    260    192   20    1 : tunables  120   60    0 : slabdata 13     13      0
biovec-4             272    305     64   61    1 : tunables  120   60    0 : slabdata  5      5      0
biovec-1          121088 122040     16  226    1 : tunables  120   60    0 : slabdata    540    540      0
bio               121131 121573     64   61    1 : tunables  120   60    0 : slabdata   1992   1993      0


biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata 128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata  52     52      0
biovec-64            265    265    768    5    1 : tunables   54   27    0 : slabdata  53     53      0
biovec-16            258    260    192   20    1 : tunables  120   60    0 : slabdata  13     13      0
biovec-4             257    305     64   61    1 : tunables  120   60    0 : slabdata   5      5      0
biovec-1           66390  68026     16  226    1 : tunables  120   60    0 : slabdata 301    301      0
bio                66389  67222     64   61    1 : tunables  120   60    0 : slabdata   1102   1102      0

(which are freed later on, but the cause for the trashing during the swap IO).

While AS does:

[marcelo@yage marcelo]$ cat /proc/slabinfo | grep bio
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            260    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            280    280    192   20    1 : tunables  120   60    0 : slabdata     14     14      0
biovec-4             264    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1            4478   5424     16  226    1 : tunables  120   60    0 : slabdata     24     24      0
bio                 4525   5002     64   61    1 : tunables  120   60    0 : slabdata     81     82      0


Odd thing is the 400M swapped out are not reclaimed after exp (the 512MB callocator) exits. With AS 
almost all swapped out memory is reclaimed on exit.

 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0 492828  13308    320   3716    0    0     0     0 1002     5  0  0 100  0


Jens, is this huge amount of bio/biovec's allocations expected with CFQ? Its really really bad.

