Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTDUTqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTDUTqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:46:47 -0400
Received: from mail.ithnet.com ([217.64.64.8]:44042 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261877AbTDUTqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:46:39 -0400
Date: Mon, 21 Apr 2003 21:58:24 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1
Message-Id: <20030421215824.5f5cec7e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003 15:47:32 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.

Hello Marcelo,

please consider below patch for inclusion. It prevents ide-scsi from freezing
the box under certain CD-burning activities. This is a bugfix. "rq->buffer"
gets trashed under certain conditions.

Rediffed to 2.4.21-rc1.

Thanks,
Stephan


--- linux/drivers/scsi/ide-scsi.c-orig     2003-04-21 21:41:05.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c  2003-04-21 21:42:11.000000000 +0200
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




