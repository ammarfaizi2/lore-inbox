Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319340AbSH2UvQ>; Thu, 29 Aug 2002 16:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319342AbSH2UvQ>; Thu, 29 Aug 2002 16:51:16 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13471 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319340AbSH2UvO>; Thu, 29 Aug 2002 16:51:14 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208292055.g7TKte224951@eng2.beaverton.ibm.com>
Subject: Re: 2.5.32 IO performance issues
To: akpm@zip.com.au (Andrew Morton)
Date: Thu, 29 Aug 2002 13:55:40 -0700 (PDT)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org,
       gerrit@us.ibm.com (Gerrit Huizenga),
       hjt@us.ibm.com (Hans-J Tannenberger),
       janetmor@us.ibm.com (Janet Morgan), andmike@us.ibm.com (Mike Anderson),
       mjbligh@us.ibm.com (Martin Bligh)
In-Reply-To: <3D6E6B64.66203783@zip.com.au> from "Andrew Morton" at Aug 29, 2002 10:43:48 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Badari Pulavarty wrote:
> > 
> > Hi,
> > 
> > I am having severe IO performance problems with 2.5.32 (2.5.31 works fine).
> > I was wondering what caused this.
> > 
> > As you can see, IO rate went from
> > 
> >                 384MB/sec with 6% CPU utilization on 2.5.31
> >                         to
> >                 120MB/sec with 19% CPU utilization on 2.5.32
> > 
> > ...
> > 151712 default_idle                             2370.5000
> > 21622 __scsi_end_request                       122.8523
> 
> block-highmem is bust for scsi. (aic7xxx at least).  Does
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm2/broken-out/scsi_hack.patch
> fix it?

Hmm !! This patch fixed it. I remember you gave me this patch for 2.5.31. But 2.5.31 
was doing fine without it. But 2.5.32 seem to need it.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1 38  0      0 3811160      0  23532   0   0 384461     0 3981  6346   0   5  95
 0 39  0      0 3811152      0  23532   0   0 384499     0 3967  6354   0   5  95
 0 39  0      0 3811148      0  23532   0   0 384154     0 3974  6341   0   5  95
 0 39  0      0 3811144      0  23532   0   0 384013     0 3964  6344   0   5  95
 0 39  0      0 3811204      0  23532   0   0 384154     0 3966  6357   0   5  95
 0 39  0      0 3811176      0  23532   0   0 384256     0 3973  6341   0   5  95
 0 39  0      0 3811168      0  23532   0   0 384320     0 3969  6329   0   5  95
 0 39  0      0 3811152      0  23532   0   0 384294     0 3980  6335   0   5  95

Here is the profile output with this patch:

# readprofile  | sort -nr +2 
221145 default_idle                             3455.3906
  3163 do_softirq                                16.4740
  1489 __scsi_end_request                         8.4602
  1696 scsi_dispatch_cmd                          2.7895
   371 dio_bio_complete                           2.1080
   509 blk_rq_map_sg                              1.3255
   198 dio_await_one                              1.2375
    57 dio_prep_bio                               1.1875
    56 bio_put                                    1.1667
    71 __generic_copy_to_user                     1.1094
   630 do_direct_IO                               0.9157
    42 __wake_up                                  0.8750
   297 __set_page_dirty_buffers                   0.8438
   622 schedule                                   0.6942
   629 __make_request                             0.5460
   402 get_user_pages                             0.5346
    17 scsi_sense_valid                           0.5312
    42 bio_destructor                             0.5250
   198 bio_alloc                                  0.4760
    32 dio_get_page                               0.4000

