Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWDYOsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWDYOsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWDYOsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:48:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:8075 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932244AbWDYOsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:48:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SP16W02bEBYye3n2J8/7tulA4ijl27cCI2pAwGycRMTpJrGq17VuhC2z28ylNbCEqNr9239n82JHVgtFz5TrL/o1uGtNiVc1+CcXoEqm2qWPlmbhO+L7VdnTzRa5zwF9w5Vf6O1I5a2Z9CdXFlR7NizrqVJ2FgNBTBHc0QkdxGM=
Message-ID: <6db17a060604250748u5fd3905ej23e5f7f1092bacc2@mail.gmail.com>
Date: Tue, 25 Apr 2006 20:18:07 +0530
From: "nani jampala" <nani.bhanu007@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Issues with removable media
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Govers,

I have read through the LDD3 & LWN and got a fair understanding about
implementing Linux removable block driver. I made an attempt to
simulate the Removable media in a Simple block driver module.

I am doing the following when trying to simulate the Removable media:

/******* Simple block Driver request ********/

 static void sbd_request(request_queue_t *q)
 {
    struct request *req;
    int status;

    while ((req = elv_next_request(q)) != NULL) {
      if (! blk_fs_request(req)) {
          printk (KERN_NOTICE "Skip non-CMD request\n");
          end_request(req, 0);
          continue;
      }

      /* Simple memcpy based on the request ; Returns success or
        failure which is passed to end_that_request_first() */
      status = sbd_transfer(&Device, req->sector, req->current_nr_sectors,
                 req->buffer, rq_data_dir(req));

      if(!end_that_request_first(req, status, req->current_nr_sectors)) {
                  blkdev_dequeue_request(req);
                  end_that_request_last(req);
            }
  }

Then, I prepared an IOCTL to simulate the removable media to the kernel.

When the applications issues IOCTL, it performs the following to
notify the kernel of removed disk.

/* Simulate the Removal Media Disk */
Case REMOVE_MOUNTED_DISK:

            if(Device.bdev)
                  invalidate_bdev(Device.bdev,1);
            del_gendisk(Device.gd);
            put_disk(Device.gd);
            blk_cleanup_queue(Queue);
            vfree(Device.data);
            return 0;

when I issue #ls /mnt (mount point) ( i.e. after the application
issues the IOCTL)
the Kernel crashes,
	OR
it crashes when tried to unload the module.

I have been trying hard to understand the real problem with this
module a long time from now.

What wrong am I doing in this module?
I will provide you with source code if you need it any time.
Please let me know what additional things should I handle when writing
code for removable media?

Regards,
Mukund Jampala
