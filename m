Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWDYHgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDYHgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWDYHgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:36:01 -0400
Received: from [202.125.80.34] ([202.125.80.34]:57890 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932098AbWDYHgA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:36:00 -0400
Subject: Problem Simulating REMOVAL Media
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Tue, 25 Apr 2006 13:06:38 +0530
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3FD46D@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem Simulating REMOVAL Media
Thread-Index: AcZoOvy7+NGlaKMeQ/OOZJvzsAGVwg==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Linux Kernel Govers,

Here I am making an attempt to simulate the Removable media in a Simple
block driver module.
It results in a segmentation fault raising the kernel module count to 1
which makes me to reboot it.

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

    /* Simple memcpy based on the request ; 
  Returns success or failure which is passed to end_that_request_first()
*/
      status = sbd_transfer(&Device, req->sector,
req->current_nr_sectors,
                 req->buffer, rq_data_dir(req));

      // end_request(req, 1);
      if(!end_that_request_first(req, status, req->current_nr_sectors))
{
                  blkdev_dequeue_request(req);
                  end_that_request_last(req);
            }
    }

I issue an IOCTL from the application after the module is loaded and
memory device is mounted.
The IOCTL code executed is as follows:

/* Simulate the Removal Media Disk */
Case REMOVE_MOUNTED_DISK:
            if(Device.bdev)
                  invalidate_bdev(Device.bdev,1);
            del_gendisk(Device.gd);
            put_disk(Device.gd);
            blk_cleanup_queue(Queue);
            vfree(Device.data);
            return 0;

After this, I get a segmentation fault either when I issue a 
#ls /mnt
	OR
When I try to unload the driver module?

Result is module cannot be unloaded, and some times it hangs the console
terminal.

Regards,
Mukund Jampala


