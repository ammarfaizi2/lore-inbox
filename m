Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267272AbSIRQZd>; Wed, 18 Sep 2002 12:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSIRQZd>; Wed, 18 Sep 2002 12:25:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30136 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267272AbSIRQZ0>; Wed, 18 Sep 2002 12:25:26 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209181630.g8IGUGe15097@eng2.beaverton.ibm.com>
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Wed, 18 Sep 2002 09:30:16 -0700 (PDT)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
In-Reply-To: <20020918120447.F6398@redhat.com> from "Benjamin LaHaise" at Sep 18, 2002 11:04:47 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Sep 18, 2002 at 08:58:22AM -0700, Badari Pulavarty wrote:
> > Thanks for looking at the patch. Patch needed few cleanups to get it
> > working. Here is the status so far..
> > 
> > 1) I tested synchronous raw read/write. They perform almost same as
> >    without this patch. I am looking at why I can't match the performance.
> >    (I get 380MB/sec on 40 dd's on 40 disks without this patch.
> >     I get 350MB/sec with this patch).
> 
> Hmm, we should try to improve that.  Have you tried profiling a long run?


I took few shortcuts in the patch compared to original DIO code. 
eg., I create a bio all the time.. original code reuses them.
But I don't think that is causing the performance hit. Anyway,
here is the vmstat and profile=2 output.

vmstat:

0 40  2      0 3804628      0  27396   0   0 344909   192 3786  3536   0   5  95
 0 40  1      0 3803268      0  28628   0   0 345686   208 3793  3578   0   5  95
 0 40  1      0 3802452      0  29404   0   0 346983   210 3806  3619   0   5  95
 0 40  1      0 3801888      0  29932   0   0 345178   203 3786  3500   0   5  95
 0 40  1      0 3801804      0  29996   0   0 345792   196 3791  3510   0   5  95
 0 40  1      0 3801652      0  30100   0   0 346048   200 3800  3556   0   5  95

profile:

146796 default_idle                             2293.6875
  1834 __scsi_end_request                        10.4205
  1201 do_softirq                                 6.2552
   891 scsi_dispatch_cmd                          2.3203
    50 __wake_up                                  1.0417
   599 get_user_pages                             0.7341
   362 blk_rq_map_sg                              0.6856
   420 do_direct_IO                               0.5707
    25 dio_prep_bio                               0.5208
   562 __make_request                             0.4878
    55 __scsi_release_command                     0.4167
     6 cap_file_permission                        0.3750
    63 release_console_sem                        0.3580
    55 do_aic7xxx_isr                             0.3438
   141 bio_alloc                                  0.3389
    45 scsi_finish_command                        0.2557
     8 scsi_sense_valid                           0.2500
    16 dio_new_bio                                0.2500
   206 schedule                                   0.2341

> 
> > 2) wait_on_sync_kiocb() needed blk_run_queues() to make regular read/
> >    write perform well.
> 
> That should be somewhat conditional, but for now it sounds like the right 
> thing to do.
> 
> > 3) I am testing aio read/writes. I am using libaio.0.3.92. 
> >    When I try aio_read/aio_write on raw device, I am get OOPS.
> >    Can I use libaio.0.3.92 on 2.5 ? Are there any interface
> >    changes I need to worry  between 2.4 and 2.5 ?
> 
> libaio 0.3.92 should work on 2.5.  Could you send me a copy of the 
> decoded Oops?
> 

My Bad :)

aio_read/aio_write() routines take loff_t not loff_t * (like regular read/writes)

        ssize_t (*read) (struct file *, char *, size_t, loff_t *);
        ssize_t (*aio_read) (struct kiocb *, char *, size_t, loff_t);

I coded for loff_t *. fixed it.  I am testing it now.

Thanks,
Badari


