Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbUK3JDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbUK3JDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 04:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUK3JDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 04:03:13 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:16377
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S262028AbUK3I7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:59:46 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Tue, 30 Nov 2004 08:59:43 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <20041123145112.GC13174@suse.de> <200411232149.31701.alan@chandlerfamily.org.uk>
In-Reply-To: <200411232149.31701.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411300859.43422.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 21:49, Alan Chandler wrote:
> On Tuesday 23 November 2004 14:51, Jens Axboe wrote:
> > On Tue, Nov 23 2004, Alan Chandler wrote:
> > > On Monday 22 November 2004 23:48, Alan Chandler wrote:
> > > ...
> > >
> > > > If I make the delay 600ns it works - I guess my hardware is a little
> > > > off spec.
...
> There is good and bad news related to 2.6.10-rc2
>
> The good news is that the acpi problem was the cause of the startup issues.
> adding pci=noacpi to the boot command line fixed that.
>
> The bad news is that with the delay at 800ns in drive_is_ready() I am
> getting the exact same symptoms I got with 2.6.9 before upping the delay to
> over 540ns.
...
>
> Firstly, the symptoms are the same between 2.6.9 and 2.6.10-rc2.  The halt
> seem to always be in exactly the same place. If it was a timing problem I
> would have thought it would have varied.
>
> Secondly, the command before seems to have an expectation of a 2048
> transfer rather than the 0 in the command, before the problem and then you
> get the strange DRQ=1 but 0 in the len register.
>
> Nov 23 20:37:33 kanger kernel: ide-cd:ide_do_rq_cdrom - cmd = 0x0
> Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x0 stat=0x50
> ireason=3 len=2048 rq len=0
> Nov 23 20:37:33 kanger kernel: ide-cd:ide_do_rq_cdrom - cmd = 0x1b
> Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x1b stat=0x58
> ireason=2 len=0 rq len=0
>

I have looked at this "every which way" to try and understand what is 
happening, and now think I have a handle on it.

The Test Unit Ready command (cmd=0x00) is the first command in the sequence 
that is issued with an expectation of no data being returned (rq len=0), but 
for some reason (which I don't know why) the device has decided it has data 
to send us (len=2048). I was confused for a long time because in normal 
circumstances cdrom_newpc_intr() is entered twice for a packet command with a 
data transfer attached, the first time with DRQ asserted and rq len == len, 
and once the transfer has taken place with DRQ not asserted and rq len having 
been set to 0 whilst len remains at its original value.  But in the case 
shown above, the first time cdrom_newpc_intr() is entered rq len (actually 
rq->data_len) is set to zero

In this case and (as far as I can see related to the packet commands) only 
this case, with my drive (CW078D), there is a delay between IRQ being 
asserted to say the command has been completed and DRQ being raised. (DRQ for 
the other cases seems to be asserted by the time of the interrupt).  

Once DRQ is asserted in this way, and until some command tries to read the 
data it wants to send us, it remains asserted.  That is why the start stop 
unit command (0x1b) appears to be the one that is failing.  In one trial I 
conducted I made this command into a no op - returning successfully, and the 
problem just full into the next command in sequence.

I was also experiencing different symptoms between 2.6.9 and 2.6.10-rc2, in 
that a change made to solve the problem in 2.6.9 (changing the delay in 
drive_is_ready to 600ns) did not appear to work in 2.6.10-rc2.  I haven't 
quite got to the bottom of this - but as the patch below shows, I have 
plugged what might be race conditions similar to the one identified by Alan 
Cox.  I do not fully understand the logic of the Alan's race condition, as 
from comments elsewhere in the code (and I really don't know how it really 
works) it says linux does not allow rentrant interrupts on the same unit - so 
I don't understand why the spinlocks need to be there, so my logic maybe 
totally spurious in this case - except it did make the difference between it 
working in 2.6.9 and getting it to work in 2.6.10-rc2.

 I did attempt in early tests I did with 2.6.9 to determine the accurately the 
size of the delay needed, it appeared to be around 540ns (400ns was not 
enough).  I have done all recent tests with 2.6.10-rc2 and 400ns is not 
enough 600ns is.  I have searched all over the ATAPI spec, but I can not see 
any really definitive statement on DRQ assertion in this case.  There is of 
course the 400ns delay in removing IRQ after either reading the status 
register or writing to the command register (clause 5.2.9), which the code 
seems to interpret as 400ns after either occurrence, but which my reading of 
the spec would be 400ns after the first occurence of one of these.  As I 
indicated in a previous note on this, as we always read the status register 
at the start of interrupt processing (in drive_is_ready), perhaps the 
solution is to store jiffies at this point and then delay 400ns - difference 
between jiffies now and as we exit ide_intr().

The other place where any delay is mentioned is when transitioning from bus 
idle state to various command state following issue of a command. Again the 
400ns is mentioned.  In the specific case of the packet command, this delay 
seems to need to be when the packet command is written - and before the 
command packet is transfered.  The only delay mentioned after that point is 
the one pio cycle (where it recommends reading the alt status reg) before 
checking status.  Given that we read the status twice (drive_is_ready and 
cdrom_decode_status) it appears we fufil this rule.

In fact, unless someone can point me at another place in the spec, the 
implication is that DRQ will be correct at the time of the interrupt and two 
reads of the status register that we do when entering cdrom_newpc_intr.  So I 
Have to conclude that my CD is operating outside of spec in this case.

This patch below is not a definitive answer to the issue, rather an 
illustration of the test envionment I was using to show things working.  You 
will see from the patches in drivers/ide/ide-iops.c that I have removed most 
of the timing delays, mainly to get a real handle on what was needed in 
ide-cd.c.  I never had any problem with delays apart from the one described 
above 

Index: drivers/ide/ide-iops.c
===================================================================
--- drivers/ide/ide-iops.c (.../vendor/2.6.10-rc2) (revision 14)
+++ drivers/ide/ide-iops.c (.../akc/delay) (revision 14)
@@ -476,10 +476,6 @@
  if (drive->waiting_for_dma)
   return hwif->ide_dma_test_irq(drive);
 
-#if 0
- /* need to guarantee 400ns since last command was issued */
- udelay(1);
-#endif
 
 #ifdef CONFIG_IDEPCI_SHARE_IRQ
  /*
@@ -560,7 +556,6 @@
   return 1;
  }
 
- udelay(1); /* spec allows drive 400ns to assert "BUSY" */
  if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
   local_irq_set(flags);
   timeout += jiffies;
@@ -589,11 +584,13 @@
   * rather than expensively fail things immediately.
   * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
   */
- for (i = 0; i < 10; i++) {
-  udelay(1);
+ 
+ /* take out this fix temporarily to test out what is happening without 
distractions*/
+/* for (i = 0; i < 10; i++) {
+  udelay(1);*/
   if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
    return 0;
- }
+/* }*/
  *startstop = DRIVER(drive)->error(drive, "status error", stat);
  return 1;
 }
Index: drivers/ide/ide-cd.c
===================================================================
--- drivers/ide/ide-cd.c (.../vendor/2.6.10-rc2) (revision 14)
+++ drivers/ide/ide-cd.c (.../akc/delay) (revision 14)
@@ -890,8 +890,13 @@
   ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, 
cdrom_timer_expiry);
   return ide_started;
  } else {
-  /* packet command */
-  HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+  unsigned long flags;
+
+                /* packet command */
+  spin_lock_irqsave(&ide_lock, flags);
+  HWIF(drive)->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
+  ndelay(400);
+  spin_unlock_irqrestore(&ide_lock, flags);
   return (*handler) (drive);
  }
 }
@@ -938,8 +943,12 @@
   cmd_len = ATAPI_MIN_CDB_BYTES;
 
  /* Send the command to the device. */
+ unsigned long flags; 
+ spin_lock_irqsave(&ide_lock, flags);
  HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);
-
+ ndelay(400);
+ spin_unlock_irqrestore(&ide_lock, flags);
+ 
  /* Start the DMA if need be */
  if (info->dma)
   hwif->dma_start(drive);
@@ -1649,6 +1658,8 @@
  xfer_func_t *xferfunc;
  unsigned long flags;
 
+ /* delay here enough to ensure the command has had time to complete and 
decide if its going to set DRQ */
+ ndelay(600);
  /* Check for errors. */
  dma_error = 0;
  dma = info->dma;
@@ -1665,7 +1676,6 @@
   */
  if (dma) {
   if (dma_error) {
-   printk("ide-cd: dma error\n");
    __ide_dma_off(drive);
    return DRIVER(drive)->error(drive, "dma error", stat);
   }
@@ -1737,10 +1747,19 @@
   if (blen > thislen)
    blen = thislen;
 
-  xferfunc(drive, ptr, blen);
-
   thislen -= blen;
   len -= blen;
+  
+  if((thislen <=0) && (len<=0)) {
+   unsigned long flags;
+   /* this is the last of this output */
+   spin_lock_irqsave(&ide_lock, flags);
+   xferfunc(drive, ptr, blen);
+   ndelay (400);
+   spin_unlock_irqrestore(&ide_lock, flags);
+  } else
+   xferfunc(drive,ptr,blen);
+  
   rq->data_len -= blen;
 
   if (rq->bio)
@@ -1748,7 +1767,7 @@
   else
    rq->data += blen;
  }
-
+ 
  /*
   * pad, if necessary
   */
@@ -1756,10 +1775,19 @@
   while (len > 0) {
    int pad = 0;
 
-   xferfunc(drive, &pad, sizeof(pad));
    len -= sizeof(pad);
+   if (len <= 0) {
+    unsigned long flags;
+
+    /* last output */
+    spin_lock_irqsave(&ide_lock,flags);
+    xferfunc(drive, &pad, sizeof(pad));
+    ndelay(400);
+    spin_unlock_irqrestore(&ide_lock,flags);
+   } else
+    xferfunc(drive, &pad, sizeof(pad));
   }
- }
+ } 
 
  if (HWGROUP(drive)->handler != NULL)
   BUG();



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
