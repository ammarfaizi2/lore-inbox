Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290793AbSAaBIS>; Wed, 30 Jan 2002 20:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSAaBIJ>; Wed, 30 Jan 2002 20:08:09 -0500
Received: from codepoet.org ([166.70.14.212]:22720 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S290790AbSAaBHx>;
	Wed, 30 Jan 2002 20:07:53 -0500
Date: Wed, 30 Jan 2002 18:07:52 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] fix for 2.4.18-pre7 SCSI namespace conflict
Message-ID: <20020131010752.GA26871@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020130234847.GA25577@codepoet.org> <E16W5AC-0000a5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16W5AC-0000a5-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 31, 2002 at 12:33:16AM +0000, Alan Cox wrote:
> > This is in the latest -ac kernels?  Cool, I'll go take a close
> > look.  I'm very anxious to see a SCSI layer that doesn't suck
> > get put in place,
> 
> The scsi mid layer is a seperate problem, and its getting there already in
> 2.5. Chunks of nasty scsi special cases keep dissappearing with the bio stuff
> 
> The NCR5380 stuff fixes what was an amazingly crufty unmaintained driver

Nice work.  Just for giggles I decided to compile in the whole
pile of SCSI drivers.  Some namespace issues vs NCR5380 popped up
pretty quickly...  It turns out that pas16.c, t128.c, dmx3191d.c,
and dtc.c have taken the misguided approach of doing a 
    #include "NCR5380.c" 
Ick!  Clearly there is an important uniform SCSI driver layer
that is entirely missing since driver authors are tempted to save  
time by doing wholesale #includes of other drivers....

Anyways, here is the bug:

    pas16.o: In function `NCR5380_timer_fn':
    pas16.o(.text+0x35c): multiple definition of `NCR5380_timer_fn'
    g_NCR5380.o(.text+0x2ec): first defined here
    t128.o: In function `NCR5380_timer_fn':
    t128.o(.text+0x2cc): multiple definition of `NCR5380_timer_fn'
    g_NCR5380.o(.text+0x2ec): first defined here
    dmx3191d.o: In function `NCR5380_timer_fn':
    dmx3191d.o(.text+0x2bc): multiple definition of `NCR5380_timer_fn'
    g_NCR5380.o(.text+0x2ec): first defined here
    dtc.o: In function `NCR5380_timer_fn':
    dtc.o(.text+0x30c): multiple definition of `NCR5380_timer_fn'
    g_NCR5380.o(.text+0x2ec): first defined here
    make[3]: *** [scsidrv.o] Error 1
    make[3]: Leaving directory `/home/andersen/imager/linux/drivers/scsi'
    make[2]: *** [first_rule] Error 2
    make[2]: Leaving directory `/home/andersen/imager/linux/drivers/scsi'
    make[1]: *** [_subdir_scsi] Error 2
    make[1]: Leaving directory `/home/andersen/imager/linux/drivers'
    make: *** [_dir_drivers] Error 2


Here is a trivial and "obviously correct" fix.

--- linux/drivers/scsi.orig/NCR5380.c	Fri Dec 21 10:41:55 2001
+++ linux/drivers/scsi/NCR5380.c	Wed Jan 30 17:56:42 2002
@@ -612,7 +612,7 @@
  *	Locks: disables irqs, takes and frees io_request_lock
  */
  
-void NCR5380_timer_fn(unsigned long unused)
+static void NCR5380_timer_fn(unsigned long unused)
 {
 	struct Scsi_Host *instance;
 
 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
