Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTIBSLP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbTIBSIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:08:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:29343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263947AbTIBSIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:08:01 -0400
Date: Tue, 2 Sep 2003 11:13:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Mathieu LESNIAK <maverick@eskuel.com>
cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       <ebrunet@quatramaran.ens.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
In-Reply-To: <3F51F274.9050300@eskuel.com>
Message-ID: <Pine.LNX.4.44.0309021108040.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Running with 2.6.0-test4-mm4:
> > 
> > # echo 4 > /proc/acpi/sleep
> > 
> > Stopping tasks: ======|
> > Freeing memory: ..|
> > hdc: start_power_step(step: 0)
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> >  printing eip:
> > 00000000
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > CPU:    0
> > EIP:    0060:[<00000000>]    Not taintled VLI
> > EFLAGS: 00010282
> > EIP is at 0x0
> > eax: c032f180   ebx: c039588c   ecx: c02f7b50   edx: 00000282
> > esi: 00000000   edi: cffa1e2c   ebp: c13ce780   esp: cffa1d40
> > ds: 007b   es: 007b   ss: 0068
> > Process bash (pid: 1, threadinfo=cffa0000 task=c12bb940)
> > Stack: c01fbcd1 c039588c cffa1e2c 00000000 00000088 0000001e 0000000f
> > cffa1e2c
> >        c039588c c03957e0 c01fc063 c039588c cffa1e2c 00000001 cffa0000
> > c13cd600
> >        cffa0000 cffa1e2c 00000202 00000001 c01fc8a3 c13ce780 ffffffff
> > 00000001
> > Call Trace:
> >  [<c01fbcd1>] start_request+0x131/0x290
> >  [<c01fc063>] ide_do_request+0x203/0x3b0
> >  [<c01fc8a3>] ide_do_drive_cmd+0xd3/0x130
> >  [<c0205592>] generic_ide_suspend+0x92/0xc0
	...

I apologize for the delay in getting back to you - I wanted to test an 
actual fix, rather than just a work around.

I encountered this problem by having an IDE CD-ROM, but not having the 
ide-cd drier compiled in. The patch below is from Benh, who wrote the IDE 
power managment handlers. 

He mentioned producing a cleaner patch, but this should at least fix the 
Oops. Please give it a try and report if it helps or not.

Thanks,


	Pat


===== drivers/ide/ide-io.c 1.21 vs edited =====
--- 1.21/drivers/ide/ide-io.c	Mon Sep  1 10:21:10 2003
+++ edited/drivers/ide/ide-io.c	Tue Sep  2 09:58:19 2003
@@ -609,6 +609,22 @@
 EXPORT_SYMBOL(execute_drive_cmd);
 
 /**
+ *	do_start_power_step	- wrapper on subdriver start_power_step()
+ *
+ *	This is called by start_request instead of directly calling
+ *	the subdriver's start_power_step() to deal with either no
+ *	subdriver or no start_power_step method in the subdriver
+ *	properly.
+ */
+static ide_startstop_t do_start_power_step(ide_drive_t *drive, struct request *rq)
+{
+	if (DRIVER(drive) && DRIVER(drive)->start_power_step)
+		return DRIVER(drive)->start_power_step(drive, rq);
+	rq->pm->pm_step = ide_pm_state_completed;
+	return ide_stopped;
+}
+
+/**
  *	start_request	-	start of I/O and command issuing for IDE
  *
  *	start_request() initiates handling of a new I/O request. It
@@ -700,7 +716,7 @@
 			printk("%s: start_power_step(step: %d)\n",
 				drive->name, rq->pm->pm_step);
 #endif
-			startstop = DRIVER(drive)->start_power_step(drive, rq);
+			startstop = do_start_power_step(drive, rq);
 			if (startstop == ide_stopped &&
 			    rq->pm->pm_step == ide_pm_state_completed)
 				ide_complete_pm_request(drive, rq);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> > Running with 2.6.0-test4-mm4:
> > 
> > # echo 4 > /proc/acpi/sleep
> > 
> > Stopping tasks: ======|
> > Freeing memory: ..|
> > hdc: start_power_step(step: 0)
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> >  printing eip:
> > 00000000
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > CPU:    0
> > EIP:    0060:[<00000000>]    Not taintled VLI
> > EFLAGS: 00010282
> > EIP is at 0x0
> > eax: c032f180   ebx: c039588c   ecx: c02f7b50   edx: 00000282
> > esi: 00000000   edi: cffa1e2c   ebp: c13ce780   esp: cffa1d40
> > ds: 007b   es: 007b   ss: 0068
> > Process bash (pid: 1, threadinfo=cffa0000 task=c12bb940)
> > Stack: c01fbcd1 c039588c cffa1e2c 00000000 00000088 0000001e 0000000f
> > cffa1e2c
> >        c039588c c03957e0 c01fc063 c039588c cffa1e2c 00000001 cffa0000
> > c13cd600
> >        cffa0000 cffa1e2c 00000202 00000001 c01fc8a3 c13ce780 ffffffff
> > 00000001
> > Call Trace:
> >  [<c01fbcd1>] start_request+0x131/0x290
> >  [<c01fc063>] ide_do_request+0x203/0x3b0
> >  [<c01fc8a3>] ide_do_drive_cmd+0xd3/0x130
> >  [<c0205592>] generic_ide_suspend+0x92/0xc0
	...

I apologize for the delay in getting back to you - I wanted to test an 
actual fix, rather than just a work around.

I encountered this problem by having an IDE CD-ROM, but not having the 
ide-cd drier compiled in. The patch below is from Benh, who wrote the IDE 
power managment handlers. 

He mentioned producing a cleaner patch, but this should at least fix the 
Oops. Please give it a try and report if it helps or not.

Thanks,


	Pat


===== drivers/ide/ide-io.c 1.21 vs edited =====
--- 1.21/drivers/ide/ide-io.c	Mon Sep  1 10:21:10 2003
+++ edited/drivers/ide/ide-io.c	Tue Sep  2 09:58:19 2003
@@ -609,6 +609,22 @@
 EXPORT_SYMBOL(execute_drive_cmd);
 
 /**
+ *	do_start_power_step	- wrapper on subdriver start_power_step()
+ *
+ *	This is called by start_request instead of directly calling
+ *	the subdriver's start_power_step() to deal with either no
+ *	subdriver or no start_power_step method in the subdriver
+ *	properly.
+ */
+static ide_startstop_t do_start_power_step(ide_drive_t *drive, struct request *rq)
+{
+	if (DRIVER(drive) && DRIVER(drive)->start_power_step)
+		return DRIVER(drive)->start_power_step(drive, rq);
+	rq->pm->pm_step = ide_pm_state_completed;
+	return ide_stopped;
+}
+
+/**
  *	start_request	-	start of I/O and command issuing for IDE
  *
  *	start_request() initiates handling of a new I/O request. It
@@ -700,7 +716,7 @@
 			printk("%s: start_power_step(step: %d)\n",
 				drive->name, rq->pm->pm_step);
 #endif
-			startstop = DRIVER(drive)->start_power_step(drive, rq);
+			startstop = do_start_power_step(drive, rq);
 			if (startstop == ide_stopped &&
 			    rq->pm->pm_step == ide_pm_state_completed)
 				ide_complete_pm_request(drive, rq);


