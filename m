Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSLKWyl>; Wed, 11 Dec 2002 17:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSLKWyk>; Wed, 11 Dec 2002 17:54:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57885 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263333AbSLKWyi>; Wed, 11 Dec 2002 17:54:38 -0500
Date: Wed, 11 Dec 2002 18:03:17 -0500
From: Doug Ledford <dledford@redhat.com>
To: Oliver Jehle <oliver.jehle@monex.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems using /proc/scsi/gdth/ with 2.4.20aa1
Message-ID: <20021211230317.GD6513@redhat.com>
Mail-Followup-To: Oliver Jehle <oliver.jehle@monex.li>,
	linux-kernel@vger.kernel.org
References: <1039502939.1054.12.camel@vorab.monex.li>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1039502939.1054.12.camel@vorab.monex.li>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2002 at 07:49:00AM +0100, Oliver Jehle wrote:
> Running linux 2.4.20-aa1 and the gdth driver works ,but accessing
> /proc/scsi/gdth/0 for example with cat or the supplied icpcon utility
> don't work...
> 
> these messages are in system log when accessing /proc/scsi/gdth/0 with
> cat for example (works with 2.4.18)
> ...
> 
> Dec 10 06:37:47 arena1 kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> Dec 10 06:37:47 arena1 kernel:  printing eip:
> Dec 10 06:37:47 arena1 kernel: c024c879
> Dec 10 06:37:47 arena1 kernel: *pde = 00000000
> Dec 10 06:37:47 arena1 kernel: Oops: 0002 2.4.20aa1 #2 SMP Mon Dec 9
> 16:55:18 CET 2002
> Dec 10 06:37:47 arena1 kernel: CPU:    0
> Dec 10 06:37:47 arena1 kernel: EIP:   
> 0010:[scsi_release_commandblocks+17/92]    Not tainted

/me chuckles

That looks *amazingly* familiar...a patch I wrote introduced that bug,
sorry.  It's fix is attached (assuming that Andrea picked up the same
version of the 2.4.x iorl contention patch that we are using now, which 
is what introduced this problem for us here).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.9-gdthoops.patch"

--- linux/drivers/scsi/scsi.c-stock	Fri Oct 25 15:41:03 2002
+++ linux/drivers/scsi/scsi.c	Fri Oct 25 15:47:04 2002
@@ -2672,10 +2672,10 @@
         SDpnt->type = -1;
         SDpnt->queue_depth = 1;
         
-	scsi_build_commandblocks(SDpnt);
-
 	scsi_initialize_queue(SDpnt, SHpnt);
 
+	scsi_build_commandblocks(SDpnt);
+
 	SDpnt->online = TRUE;
 
         /*
@@ -2705,13 +2705,12 @@
                 panic("Attempt to delete wrong device\n");
         }
 
-        blk_cleanup_queue(&SDpnt->request_queue);
-
         /*
          * We only have a single SCpnt attached to this device.  Free
          * it now.
          */
 	scsi_release_commandblocks(SDpnt);
+        blk_cleanup_queue(&SDpnt->request_queue);
         kfree(SDpnt);
 }
 

--9amGYk9869ThD9tj--
