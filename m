Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265596AbSKAEil>; Thu, 31 Oct 2002 23:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSKAEik>; Thu, 31 Oct 2002 23:38:40 -0500
Received: from bozo.vmware.com ([65.113.40.131]:49668 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265596AbSKAEih>; Thu, 31 Oct 2002 23:38:37 -0500
Date: Thu, 31 Oct 2002 20:46:46 -0800
From: chrisl@vmware.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sasha Malchik <sasha@vmware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: IDE CDROM packet command buffer size restriction.
Message-ID: <20021101044646.GB8603@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Jens seems too busy to check out this patch. I post it here again
hopefully to get boarder audiences:

VMware try to use the generic packet interface (CDROM_SEND_PACKET)
for cdrom simulation. There are some packet command used by windows
can return different data size, depend on the type of CD in the CDROM.
Current linux kernel will fail the ioctl call if packet command return
data less than expected.

ide-scsi driver do not have this problem.

We make a patch allow kernel return successful and return the actual
transfer data size. Is it the prefer behavior in this case? If not,
what is the best way to solve this problem?

The original email and the patch as follows.

Thanks

Chris

P.S. I am very surprised to find out that, vmware suffers from bugs
in cdrom driver for years. Developers give up after some attempt to
submit patches to kernel, it is not easy to make it right at the first
time. The broken sense data bug should have been fix long time ago if
they try hard enough.



"Alexander (Sasha) Malchik" wrote:
> 
> Hello Jens,
> I would like to propose another patch to the Linux IDE CD driver.
> The driver fails any packet command operation in case the amount of data
> written into the buffer was less than the buflen passed with the packet
> command. It happens in the interrupt handler ide-cd:cdrom_pc_intr() in
> these lines:
>         /* If DRQ is clear, the command has completed.
>            Complain if we still have data left to transfer. */
>         if ((stat & DRQ_STAT) == 0) {
>                 /* ... deleted - pad buffer with 0's for REQUEST_SENSE command */
>                 if (pc->buflen == 0)
>                         cdrom_end_request (1, drive);
>                 else {
>                         /* Comment this out, because this always happens
>                            right after a reset occurs, and it is annoying to
>                            always print expected stuff.  */
>                         /*
>                         printk ("%s: cdrom_pc_intr: data underrun %d\n",
>                                 drive->name, pc->buflen);
>                         */
>                         pc->stat = 1;
>                         cdrom_end_request (1, drive);
>                 }
>                 return ide_stopped;
> The SCSI driver does no such thing. It does not care if less than
> pc->buflen amount of data existed. It simply writes to the buffer and
> returns the whole thing to userland.
> 
> We are trying to use the generic packet interface (CDROM_SEND_PACKET)
> for all CDROM accesses in VMware. The idea is to pass through all ATAPI
> packets to the host driver. But this strict behaviour of ide-cd driver
> presents a big problem to using this interface. There is no way to know
> the amount of data in flight for most packets in PIO mode, other than
> trying to figure it out from the Allocation Length part of the packets
> themselves. Unfortunately, the packets routinely issued by Windows OSes
> have allocation length far greater than the amount of data available
> from the device. For example, it issues READ_TOC packet (0x43) with
> allocation length 0x03 0x24, i.e. 804 bytes. In case data CD is in the
> drive, there are in fact only 20 bytes returned by the device, and in
> case of audio CD - 124 bytes. Passing cgc->buflen any larger than 20 or
> 124 bytes, correspondingly, fails that ioctl() call. The READ_TOC packet
> in question coming from the guest OS is identical. There are similar
> problems for MODE_SENSE, READ_CD, and many other commands - including
> multiple variations for all of their parameters. In the DMA case, those
> "incorrect" buflen's are also the values determined from the scatter
> gather table, so the situation is the same.c
> 
> I don't see a reason why IDE CD driver has to fail the requests in this
> case, and differ from the SCSI driver. Because ioctl() is flagged as
> failing, the buffer is then NOT copied into the userland in
> cdrom.c:cdrom_do_cmd():
>         ret = cdi->ops->generic_packet(cdi, cgc);
>         __copy_to_user(usense, cgc->sense, sizeof(*usense));
>         if (!ret && cgc->data_direction == CGC_DATA_READ)     <== ret is !=0
>                 __copy_to_user(ubuf, cgc->buffer, cgc->buflen);
> 
> Why not just return buflen actually written into the buffer instead?
> Here is the patch that does just that.
> Thank you very much for your review,
> Sasha Malchik.
> 

--- 1.17/drivers/ide/ide-cd.c   Mon Sep 16 22:39:10 2002
+++ edited/ide-cd.c     Thu Oct 31 14:08:08 2002
@@ -1322,8 +1322,7 @@
        ireason = IN_BYTE (IDE_NSECTOR_REG);
        len = IN_BYTE (IDE_LCYL_REG) + 256 * IN_BYTE (IDE_HCYL_REG);

-       /* If DRQ is clear, the command has completed.
-          Complain if we still have data left to transfer. */
+       /* If DRQ is clear, the command has completed. */
        if ((stat & DRQ_STAT) == 0) {
                /* Some of the trailing request sense fields are optional, and
                   some drives don't send them.  Sigh. */
@@ -1336,19 +1335,8 @@
                        }
                }

-               if (pc->buflen == 0)
-                       cdrom_end_request (1, drive);
-               else {
-                       /* Comment this out, because this always happens
-                          right after a reset occurs, and it is annoying to
-                          always print expected stuff.  */
-                       /*
-                       printk ("%s: cdrom_pc_intr: data underrun %d\n",
-                               drive->name, pc->buflen);
-                       */
-                       pc->stat = 1;
-                       cdrom_end_request (1, drive);
-               }
+               cdrom_end_request (1, drive);
+
                return ide_stopped;
        }

@@ -2202,6 +2190,7 @@
        pc.quiet = cgc->quiet;
        pc.timeout = cgc->timeout;
        pc.sense = cgc->sense;
+       cgc->buflen -= pc.buflen;
        return cgc->stat = cdrom_queue_packet_command(drive, &pc);
 }


