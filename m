Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262439AbTCMPNa>; Thu, 13 Mar 2003 10:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbTCMPNa>; Thu, 13 Mar 2003 10:13:30 -0500
Received: from mail.ithnet.com ([217.64.64.8]:1293 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262439AbTCMPN1>;
	Thu, 13 Mar 2003 10:13:27 -0500
Date: Thu, 13 Mar 2003 16:23:07 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-Id: <20030313162307.72f81028.skraw@ithnet.com>
In-Reply-To: <E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
References: <20030227221017.4291c1f6.skraw@ithnet.com>
	<E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003 20:47:37 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> > 
> > Code;  c0213ab3 <idescsi_pc_intr+63/360>
> > 00000000 <_EIP>:
> > Code;  c0213ab3 <idescsi_pc_intr+63/360>   <=====
> >   0:   ff 42 18                  incl   0x18(%edx)   <=====
> > Code;  c0213ab6 <idescsi_pc_intr+66/360>
> >   3:   89 3c 24                  mov    %edi,(%esp,1)
> > Code;  c0213ab9 <idescsi_pc_intr+69/360>
> >   6:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
> > Code;  c0213ac0 <idescsi_pc_intr+70/360>
> >   d:   00 
> > Code;  c0213ac1 <idescsi_pc_intr+71/360>
> >   e:   e8 ae fc ff ff            call   fffffcc1 <_EIP+0xfffffcc1> c0213774
> >   <idescsi_do_end_request+a4/e0>
> > Code;  c0213ac6 <idescsi_pc_intr+76/360>
> >  13:   31 00                     xor    %eax,(%eax)
> 
> Does this patch fix the problem?
> [attached patch]

Hello Herbert, hello all,

first of all: your patch does not apply at all on -pre5. Anyway I got your idea
and re-did it accordingly.
Interestingly the machine does not crash any more! And I have some useful
output from mounting:

>From "modprobe ide-scsi":

Mar 13 16:11:30 admin kernel:   Vendor: AOPEN     Model: CD-RW CRW2440     Rev:
2.02
Mar 13 16:11:30 admin kernel:   Type:   CD-ROM                             ANSI
SCSI revision: 02
Mar 13 16:11:30 admin kernel: Attached scsi CD-ROM sr0 at scsi2, channel 0, id
0, lun 0
Mar 13 16:11:30 admin kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw
xa/form2 cdda tray

>From "mount /dev/sr0 /mnt":

Mar 13 16:12:12 admin kernel: scsi : aborting command due to timeout : pid
114491, scsi2, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00 00 02 00 
Mar 13 16:12:12 admin kernel: hdc: timeout waiting for DMA
Mar 13 16:12:12 admin kernel: hdc: timeout waiting for DMA
Mar 13 16:12:12 admin kernel: hdc: (__ide_dma_test_irq) called while not
waiting
Mar 13 16:12:12 admin kernel: hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar 13 16:12:12 admin kernel: hdc: drive not ready for command
Mar 13 16:12:12 admin kernel: hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar 13 16:12:12 admin kernel: hdc: drive not ready for command
Mar 13 16:12:12 admin kernel: hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar 13 16:12:12 admin kernel: hdc: drive not ready for command
Mar 13 16:12:12 admin kernel: hdc: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar 13 16:12:12 admin kernel: hdc: drive not ready for command
Mar 13 16:12:12 admin kernel: hdc: ATAPI reset complete
Mar 13 16:12:12 admin kernel:  I/O error: dev 0b:00, sector 0

It looks like the serverworks ide-driver produces some error, and that is
absolutely poor-handled inside ide-scsi. After this output the mounted CD is
accessible, btw.

And another thing: this error only occurs the _first_ time a mount is performed
(the above CD is completely ok). From the second mount on everything looks
normal.

Regards,
Stephan


My patch:

diff -Nur linux/drivers/scsi/ide-scsi.c linux-patch/drivers/scsi/ide-scsi.c
--- linux/drivers/scsi/ide-scsi.c       2003-03-13 15:37:06.000000000 +0100
+++ linux-patch/drivers/scsi/ide-scsi.c 2003-03-13 16:19:41.000000000 +0100
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


