Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbUCOWOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbUCOWOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:14:42 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:21364 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262824AbUCOWLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:11:54 -0500
Date: Mon, 15 Mar 2004 14:11:27 -0800
To: Andrew Morton <akpm@osdl.org>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040315221127.GA23743@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <20040314172809.31bd72f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314172809.31bd72f7.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 05:28:09PM -0800, Andrew Morton wrote:
> - Added the new per-address_space block unplugging code.  This is designed
>   to reduce the locking contention against the global plug list's lock and it
>   also allows us to avoid unplugging all the queues in the machine when we
>   want just a single queue to kick off its I/O.

Looks pretty good, same benchmark as last time (though hopefully the
profiles look a little nicer--sorry David, I wasn't able to get qprof
working today).

10 qla2200 fc controllers, 64 cpus, 112 disks

-------------------------------------
2.6.4 ~43252 I/Os per second

[root@revenue sio]# readprofile -p /root/profile.out -m /root/System.map | sort -nr | head -20
926930 total                                      0.1601
508304 snidle                                   1323.7083
170017 cpu_idle                                 354.2021
148308 default_idle                             4634.6250
 21765 blk_run_queues                            37.7865
 16914 __make_request                             4.6775
 16897 scsi_request_fn                            8.9497
  6478 scsi_end_request                          11.9081
  6111 schedule                                   1.1233
  4750 dio_bio_end_io                            12.3698
  3749 qla2x00_start_scsi                         1.5215
  3475 qla2x00_queuecommand                       0.8484
  3062 sn_dma_flush                               4.5565
  1313 scsi_dispatch_cmd                          0.9118
   997 scsi_device_unbusy                         2.3966
   917 dio_await_one                              1.5920
   910 get_request                                0.5687
   890 __end_that_request_first                   0.8428
   873 mempool_alloc                              0.9094
   834 __mod_timer                                0.8145

vmstat:
procs                      memory      swap          io     system cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 4 113      0 252927360  12112   4288    0    0 14649     0 73289 56926  0  7 45 48
 3 114      0 252927424  12112   4288    0    0 23187     1 75524 91055  0 13  1 85
 5 111      0 252927424  12112   4288    0    0 23142     0 75440 90893  0 13  0 87
 5 112      0 252927552  12112   4288    0    0 23581     0 75750 92907  0 12  0 88
 9 108      0 252927552  12112   4288    0    0 23224     0 75698 91226  0 14  0 86
 3 114      0 252927680  12112   4288    0    0 23474     0 75912 92509  0 12  1 87
 2 114      0 252927680  12112   4288    0    0 22651     0 75092 88730  0 15  0 85
 7 114      0 252927872  12112   4288    0    0 22915     0 75298 89525  0 15  0 84
 4 112      0 252927872  12112   4288    0    0 23106     0 75348 90598  0 15  0 85
 0  0      0 252951488  12112  20688    0    0 21193     0 89210 85060  0 17  5 79

-------------------------------------
2.6.4-mm2 ~46655 I/Os per second

[root@revenue sio]# readprofile -p /root/profile.out -m /root/System.map | sort -nr | head -20
935122 total                                      0.1656
543734 snidle                                   1415.9740
182199 cpu_idle                                 379.5813
158268 default_idle                             4945.8750
  6850 scsi_request_fn                            3.6282
  6067 scsi_end_request                          11.1526
  4695 __make_request                             1.3338
  4347 dio_bio_end_io                            12.3494
  3782 schedule                                   0.6677
  3323 sn_dma_flush                               4.9449
  3314 pci_cacheline_size                         4.5027
  1753 sd_rw_intr                                 1.5652
  1313 dio_await_one                              1.7840
  1259 scsi_device_unbusy                         3.0264
  1201 scsi_dispatch_cmd                          0.8340
   847 sd_open                                    1.2031
   671 __mod_timer                                0.5825
   661 __end_that_request_first                   0.6259
   593 mempool_free                               1.1582
   568 scsi_io_completion                         0.2863

vmstat:
procs                      memory      swap          io     system cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2 112      0 253452832  12128  69872    0    0  7703    17 77455 25398  0  2 94  4
 4 112      0 253452640  12128  69872    0    0 24694     0 76935 84163  0  8 79 13
 2 114      0 253452512  12128  69872    0    0 24744     8 76523 86890  0  8 71 21
 6 110      0 253452512  12128  69872    0    0 24614     0 76418 86889  0  8 70 22
 3 113      0 253452448  12128  69872    0    0 24652     0 76427 87022  0  8 68 24
 4 112      0 253452640  12128  69872    0    0 24504     0 76552 87179  0  8 67 25
 2 114      0 253452640  12128  69872    0    0 24540     0 76559 86955  0  8 66 27
 5 111      0 253452640  12128  69872    0    0 24525    17 76521 87415  0  8 66 26
 7 109      0 253452640  12128  69872    0    0 24528     0 76526 87092  0  8 66 27
 2 114      0 253452768  12128  69872    0    0 24488     0 76619 87209  0  8 66 27
 0  0      0 253498848  12128  69872    0    0  5789     0 84614 21581  0  2 91  6
