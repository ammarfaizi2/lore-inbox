Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUCJVg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUCJVg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:36:28 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:36282 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262852AbUCJVfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:35:23 -0500
Date: Wed, 10 Mar 2004 13:35:09 -0800
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040310213509.GA10888@sgi.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040310115545.16cb387f.akpm@osdl.org> <200403102003.i2AK3qm16576@unix-os.sc.intel.com> <20040310202025.GH15087@suse.de> <20040310204532.GA10281@sgi.com> <20040310204936.GJ15087@suse.de> <20040310205237.GK15087@suse.de> <20040310210104.GA10406@sgi.com> <20040310210249.GM15087@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310210249.GM15087@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 10:02:50PM +0100, Jens Axboe wrote:
> On Wed, Mar 10 2004, Jesse Barnes wrote:
> > On Wed, Mar 10, 2004 at 09:52:37PM +0100, Jens Axboe wrote:
> > > And what fs, if any? The XFS changes probably need someone knowledgable
> > > about XFS internals to verify them.
> > 
> > Yeah, sorry.  I forgot to post CPU time info too (I'm putting that
> > together now).  The benchmark is doing small, direct I/O requests
> > directly to the block devices (e.g. /dev/sdd1).
> 
> Neat thanks, looking forward to seeing them.

Here's a bit more info.  I can probably do some more benchmarking later
if you need it (though sometimes getting time on that machine can be
hard).

The benchmark creates a thread for each block device.  Each one opens
the device with O_DIRECT and starts doing I/O.

10 qla2200 fc controllers, 64 cpus, 112 disks

-------------------------------------
stock BK tree: ~43945 I/Os per second

  [root@revenue sio]# readprofile -m /root/System.map | sort -nr +2 | head -20
  204038 default_idle                             6376.1875
  700889 snidle                                   1825.2318
  234641 cpu_idle                                 488.8354
   25954 blk_run_queues                            45.0590
    4475 dio_bio_end_io                            11.6536
    6137 scsi_end_request                          11.2812
   18002 scsi_request_fn                            9.5350
     447 ia64_spinlock_contention                   6.9844
   19326 __make_request                             5.3446
    3020 sn_dma_flush                               4.4940
     856 generic_unplug_device                      2.4318
     961 scsi_device_unbusy                         2.3101
     360 current_kernel_time                        1.8750
     547 put_io_context                             1.7094
     932 dio_await_one                              1.6181
     409 blk_queue_bounce                           1.5977
    3484 qla2x00_start_scsi                         1.4140
     147 pid_alive                                  1.1484
     436 as_set_request                             1.1354
     283 kmem_cache_alloc                           1.1055

CPU time from vmstat:
 usr sys id wa
   0  15 20 65
   0  19  0 81
   0  17  0 83
   0  19  0 81
   0  16  0 83
   0  18  0 82
   0  18  0 82
   0  13  0 87
   0  16  0 84
   0  12 26 62

-------------------------------------
w/Jens' patch: ~47149 I/Os per second

  [root@revenue sio]# readprofile -m /root/System.map | sort -nr +2 | head -20
  181993 default_idle                             5687.2812
  624772 snidle                                   1627.0104
  209129 cpu_idle                                 435.6854
    4755 dio_bio_end_io                            12.3828
    6593 scsi_end_request                          12.1195
     435 ia64_spinlock_contention                   6.7969
    2959 sn_dma_flush                               4.4033
    7459 scsi_request_fn                            3.9507
     449 blk_run_backing_dev                        3.5078
    1452 scsi_device_unbusy                         3.4904
     250 kobject_put                                2.6042
     590 put_io_context                             1.8438
     995 dio_await_one                              1.6365
     313 current_kernel_time                        1.6302
     361 kmem_cache_alloc                           1.4102
    3435 qla2x00_start_scsi                         1.3941
    5032 __make_request                             1.3674
     480 as_set_request                             1.2500
     603 scsi_put_command                           1.1085
    6019 schedule                                   1.1064

CPU time from vmstat:
 usr sys id wa
   0   5 60 35
   0   8 28 64
   0   8 20 72
   0   8 19 73
   0   8 17 75
   0   8 15 77
   0   8 15 77
   0   8 12 80
   0   8 11 81
   0   8 11 81
