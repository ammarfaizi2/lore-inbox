Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbTC0QO5>; Thu, 27 Mar 2003 11:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbTC0QO4>; Thu, 27 Mar 2003 11:14:56 -0500
Received: from mail.ithnet.com ([217.64.64.8]:19729 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263272AbTC0QOz>;
	Thu, 27 Mar 2003 11:14:55 -0500
Date: Thu, 27 Mar 2003 17:25:54 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.21-pre6
Message-Id: <20030327172554.4f4399ac.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003 21:08:42 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> Here goes -pre6.
> [...]
>   o fix ide-scsi hang on SMP boxes

Sorry, no bonus.
Whatever this patch was, it did not work on my box (SMP, ide-scsi). The only
patch that I know of solving complete freeze is attached, diffed to -pre6.

Regards,
Stephan


--- linux1/drivers/scsi/ide-scsi.c       2003-03-27 15:45:55.000000000 +0100
+++ linux2/drivers/scsi/ide-scsi.c       2003-03-27 15:46:49.000000000 +0100
@@ -321,7 +321,7 @@
 {
        idescsi_scsi_t *scsi = drive->driver_data;
        struct request *rq = HWGROUP(drive)->rq;
-       idescsi_pc_t *pc = (idescsi_pc_t *) rq->buffer;
+       idescsi_pc_t *pc = rq->special;
        int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
        u8 *scsi_buf;
        unsigned long flags;
@@ -587,7 +587,7 @@
 #endif /* IDESCSI_DEBUG_LOG */
 
        if (rq->cmd == IDESCSI_PC_RQ) {
-               return idescsi_issue_pc(drive, (idescsi_pc_t *) rq->buffer);
+               return idescsi_issue_pc (drive, rq->special);
        }
        printk(KERN_ERR "ide-scsi: %s: unsupported command in request "
                "queue (%x)\n", drive->name, rq->cmd);
@@ -1083,7 +1083,7 @@
        }
 
        ide_init_drive_cmd(rq);
-       rq->buffer = (char *) pc;
+       rq->special = pc;
        rq->bh = idescsi_dma_bh(drive, pc);
        rq->cmd = IDESCSI_PC_RQ;
        spin_unlock_irq(&io_request_lock);
