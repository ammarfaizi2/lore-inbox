Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289334AbSAILHl>; Wed, 9 Jan 2002 06:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289333AbSAILHc>; Wed, 9 Jan 2002 06:07:32 -0500
Received: from [212.169.100.200] ([212.169.100.200]:9726 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S289332AbSAILHW>; Wed, 9 Jan 2002 06:07:22 -0500
Date: Wed, 9 Jan 2002 12:07:03 +0100
From: Morten Helgesen <admin@nextframe.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] drivers/scsi/psi240i.c - io_request_lock fix
Message-ID: <20020109120703.C31729@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <20020108150738.B6168@sexything> <3C3B9853.740E71DA@torque.net> <20020109114638.S19814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020109114638.S19814@suse.de>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jens.

I did the changes based on the changes done to the aha1740.c driver. Below is a diff
between a clean 2.4.15 and a clean 2.5.2-pre10, which shows the changes done to aha1740.c :

--- tars/linux/drivers/scsi/aha1740.c   Sun Sep 30 21:26:07 2001
+++ clean-linux-2.5.2-pre10/drivers/scsi/aha1740.c      Tue Jan  8 10:56:27 2002
@@ -213,6 +213,7 @@
 /* A "high" level interrupt handler */
 void aha1740_intr_handle(int irq, void *dev_id, struct pt_regs * regs)
 {
+    struct Scsi_Host *host = aha_host[irq - 9];
     void (*my_done)(Scsi_Cmnd *);
     int errstatus, adapstat;
     int number_serviced;
@@ -221,11 +222,10 @@
     unsigned int base;
     unsigned long flags;
 
-    spin_lock_irqsave(&io_request_lock, flags);
-
-    if (!aha_host[irq - 9])
+    if (!host)
        panic("aha1740.c: Irq from unknown host!\n");
-    base = aha_host[irq - 9]->io_port;
+    spin_lock_irqsave(&host->host_lock, flags);
+    base = host->io_port;
     number_serviced = 0;
 
     while(inb(G2STAT(base)) & G2STAT_INTPEND)
@@ -299,7 +299,7 @@
        number_serviced++;
     }
 
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&host->host_lock, flags);
 }
 
 int aha1740_queuecommand(Scsi_Cmnd * SCpnt, void (*done)(Scsi_Cmnd *))


I guess this is not the way to do it.
I now see the problem you guys have pointed out. Sorry, my bad.

== Morten


On Wed, Jan 09, 2002 at 11:46:38AM +0100, Jens Axboe wrote:
> On Tue, Jan 08 2002, Douglas Gilbert wrote:
> > Morten Helgesen wrote:
> > > 
> > > Hey Linus and the rest of you.
> > > 
> > > A simple fix for the io_request_lock issue leftovers in drivers/scsi/psi240i.c.
> > > Not tested, but compiles. Diffed against 2.5.2-pre10. Please apply.
> > > 
> > 
> > Morten,
> > There is a bit more involved than just switching
> > io_request_lock to host_lock. The former is global
> > so it could be called from anywhere.
> > 
> > >From the look of this line in the patch:
> > > +       struct Scsi_Host *host = PsiHost[irq - 10];
> > 
> > It will work if the first controller is allocated irq 10,
> > the second one irq 11, etc.   Unlikely ...
> 
> Irk yes, that is very ugly! And it's even used currently in the driver
> as well. How about passing the scsi host as device_id for the isr
> instead?
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Det er ikke lett å være menneske" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
