Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKXVaM>; Fri, 24 Nov 2000 16:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129588AbQKXVaC>; Fri, 24 Nov 2000 16:30:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23557 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S129518AbQKXV3p>;
        Fri, 24 Nov 2000 16:29:45 -0500
Date: Fri, 24 Nov 2000 21:59:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Boszormenyi Zoltan <zboszor@externet.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Jens Axboe's blk-11 causing problems
Message-ID: <20001124215933.H11366@suse.de>
In-Reply-To: <Pine.LNX.4.02.10011240902070.4804-100000@prins.externet.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.02.10011240902070.4804-100000@prins.externet.hu>; from zboszor@externet.hu on Fri, Nov 24, 2000 at 09:10:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24 2000, Boszormenyi Zoltan wrote:
> Hi!
> 
> I tried 2.4.0-test11 (plain, +ac1/2) with and without
> Jens' blk-11 patch. This indeed performs (much) better
> when there is only high disk activity but cdrecord
> starts up _very_ slowly if the kernel was compiled with 
> blk-11. It does not happen if blk-11 is not applied.
> 
> I stopped cdrecord before it started writing because of
> this suspicious slowness and I did not want to create a bad CD.
> 
> Other data points:
> The CD-writer is a Yamaha-6416 (SCSI version).
> The SCSI card is a Diamond Fireport-40 (Symbios 53c875j)
> I tested both the in-kernel 1.6b and 1.7.2 versions of the
> sym53c8xx driver.
> 
> The slowdown was experienced in every case where
> the kernel contained blk-11.

You might want to send messages such as this one to me
as well, so I don't miss them :-)

The problem is due to sg assuming that scsi_do_req will
fire the request queue immediately to let the command
inject complete. This was never really the case, even
in the stock kernel. Here's a quick-and-dirty patch
against test11+blk-11 attached, untested but it should
fix the delays.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=blk-11-sg-1

--- /opt/kernel/linux-2.4.0-test11/drivers/scsi/sg.c	Tue Oct 24 22:58:20 2000
+++ drivers/scsi/sg.c	Fri Nov 24 21:57:50 2000
@@ -689,6 +689,7 @@
 		(void *)SRpnt->sr_buffer, hp->dxfer_len,
 		sg_cmd_done_bh, timeout, SG_DEFAULT_RETRIES);
     /* dxfer_len overwrites SRpnt->sr_bufflen, hence need for b_malloc_len */
+    generic_unplug_device(&SRpnt->sr_device->request_queue);
     return 0;
 }
 

--Dxnq1zWXvFF0Q93v--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
