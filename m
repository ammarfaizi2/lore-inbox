Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265923AbSKBJCi>; Sat, 2 Nov 2002 04:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265924AbSKBJCi>; Sat, 2 Nov 2002 04:02:38 -0500
Received: from 12-234-207-200.client.attbi.com ([12.234.207.200]:59264 "EHLO
	chrisl-um.vmware.com") by vger.kernel.org with ESMTP
	id <S265923AbSKBJCd>; Sat, 2 Nov 2002 04:02:33 -0500
Date: Sat, 2 Nov 2002 01:10:49 -0800
From: chrisl@vmware.com
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sasha Malchik <sasha@vmware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE CDROM packet command buffer size restriction.
Message-ID: <20021102091049.GA1673@vmware.com>
References: <20021101044646.GB8603@vmware.com> <20021101121045.GK8428@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101121045.GK8428@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 01:10:45PM +0100, Jens Axboe wrote:
> > We make a patch allow kernel return successful and return the actual
> > transfer data size. Is it the prefer behavior in this case? If not,
> > what is the best way to solve this problem?
> 
> The patch does look good, thanks.

Sasha just find my change to the patch has some fault. The pc.buflen
changed after cdrom_queue_packet_command. So his original patch
is more correct.

I paste it here again. I am sorry for the confusion.

Chris


--- 1.17/drivers/ide/ide-cd.c   Mon Sep 16 22:39:10 2002
+++ edited/ide-cd.c     Sat Nov  2 01:02:43 2002
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

@@ -2202,7 +2190,9 @@
        pc.quiet = cgc->quiet;
        pc.timeout = cgc->timeout;
        pc.sense = cgc->sense;
-       return cgc->stat = cdrom_queue_packet_command(drive, &pc);
+       cgc->stat = cdrom_queue_packet_command(drive, &pc);
+       cgc->buflen -= pc.buflen;
+       return cgc->stat;
 }
