Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285812AbRLHElP>; Fri, 7 Dec 2001 23:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285814AbRLHElG>; Fri, 7 Dec 2001 23:41:06 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:10374 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285812AbRLHEkt>; Fri, 7 Dec 2001 23:40:49 -0500
Date: Fri, 7 Dec 2001 23:40:48 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Would the father of init_mem_lth please stand up
Message-ID: <20011207234048.A31442@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Really someone needs slapping across. What kind of code is that
(in 2.5.1-pre6):

drivers/scsi/sd.c:sd_init()

        /* allocate memory */
#define init_mem_lth(x,n)       x = kmalloc((n) * sizeof(*x), GFP_ATOMIC)
#define zero_mem_lth(x,n)       memset(x, 0, (n) * sizeof(*x))

        init_mem_lth(rscsi_disks, sd_template.dev_max);
        init_mem_lth(sd_sizes, maxparts);
        init_mem_lth(sd_blocksizes, maxparts);
        init_mem_lth(sd, maxparts);
        init_mem_lth(sd_gendisks, N_USED_SD_MAJORS);
        init_mem_lth(sd_max_sectors, sd_template.dev_max << 4);

        if (!rscsi_disks || !sd_sizes || !sd_blocksizes || !sd || !sd_gendisks)
                goto cleanup_mem;
#undef init_mem_lth
#undef zero_mem_lth
.....................
cleanup_mem:
        kfree(sd_gendisks);
        kfree(sd);
        kfree(sd_blocksizes);
        kfree(sd_sizes);
        kfree(rscsi_disks);


However, it's not only about the puking and keyboard cleanups.
The code is buggy as well. Scenario:

 0. User inserts a large number of FC-AL adapters with 56 disks each
 1. modprobe sd_mod
    No SCSI hosts, sd_init() is NOT called.
 2. modprobe qla_something
    sd_init is called and fails on sd_gendisks. modprobe fails.
    sd_sizes, sd_blocksizes, etc. are LEFT DANGLING
 3. modprobe qla_something
    sd_init is called and fails on sd_sizes.
    kfree is called with a bunch of dangling pointers

I stringly urge Linus to drop this so-called "cleanup" from 2.5.1.

No doubt, the existing code was bad. I fixed it somewhat for 2.4,
and am feeding it to Marcelo. I can forward-port that to 2.5
if anyone is interested.

-- Pete
