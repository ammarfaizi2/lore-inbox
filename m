Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTDMXBC (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTDMXBC (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:01:02 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:60432 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262620AbTDMXBB (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 19:01:01 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Robert Love <rml@tech9.net>
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
Date: Mon, 14 Apr 2003 01:12:05 +0200
User-Agent: KMail/1.5.1
Cc: David Brown <dave@codewhore.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030412152951.GA10367@codewhore.org> <200304140103.26761.m.c.p@wolk-project.de> <1050275256.767.9.camel@localhost>
In-Reply-To: <1050275256.767.9.camel@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F7em+gUjw/ji36p"
Message-Id: <200304140112.05673.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_F7em+gUjw/ji36p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 April 2003 01:07, Robert Love wrote:

Hi Robert,

> On Sun, 2003-04-13 at 19:03, Marc-Christian Petersen wrote:
> > This is an incremental diff snipplet. The second preempt_disable();
> > should be a preempt_enable(); no?
> Yep.  Thanks.
np. Two other small fixes you may want to include are attached.

1. fix "Exited with preempt count" if you exit kernel-nfsd
2. fix "Exited with preempt count" at machine_halt(); and machine_power_off();

Attached in this order.

ciao, Marc
--Boundary-00=_F7em+gUjw/ji36p
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="00_preempt-kernel-rml-2.4.20-nfsd-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="00_preempt-kernel-rml-2.4.20-nfsd-fix.patch"

--- linux-old/fs/nfsd/nfssvc.c	2002-12-18 01:03:59.000000000 +0100
+++ linux-wolk4/fs/nfsd//nfssvc.c	2003-01-01 06:53:44.000000000 +0100
@@ -250,6 +250,7 @@ nfsd(struct svc_rqst *rqstp)
 	svc_exit_thread(rqstp);
 
 	/* Release module */
+	unlock_kernel();
 	MOD_DEC_USE_COUNT;
 }
 

--Boundary-00=_F7em+gUjw/ji36p
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01_preempt-kernel-rml-2.4.20-halt-reboot-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01_preempt-kernel-rml-2.4.20-halt-reboot-fix.patch"

--- linux-old/kernel/sys.c	2003-01-06 17:57:12.000000000 +0100
+++ linux-wolk4/kernel/sys.c	2003-01-06 18:34:59.000000000 +0100
@@ -354,6 +354,7 @@ asmlinkage long sys_reboot(int magic1, i
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
+		unlock_kernel();
 		do_exit(0);
 		break;
 
@@ -361,6 +362,7 @@ asmlinkage long sys_reboot(int magic1, i
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
+		unlock_kernel();
 		do_exit(0);
 		break;
 

--Boundary-00=_F7em+gUjw/ji36p--

