Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUGPOlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUGPOlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUGPOlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:41:06 -0400
Received: from ns.sysgo.de ([213.68.67.98]:45194 "EHLO mailgate.sysgo.de")
	by vger.kernel.org with ESMTP id S266486AbUGPOk7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:40:59 -0400
Message-ID: <40F7E8FB.4000807@sysgo.com>
Date: Fri, 16 Jul 2004 16:40:59 +0200
From: Hans-Juergen Tappe <hjt@sysgo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: floppy.c - workaround for FDC initialization error
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.26.0.5; VDF: 6.26.0.31; host: mailgate.sysgo.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I worked on a problem with linux-2.6.7 and linux-2.4.25 not detecting 
the floppy controller:
When compiled into the kernel, the kernel said: "no floppy controllers 
found", even though linux had been loaded from floppy via BIOS access. 
When loaded as a module, everything worked fine.
This sounded very much like the bug at
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=57253 ,
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=60887 and
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=75687 , but this 
problem occurs again on the new hardware.

It seems that the interrupt mask had not been set, so the answering 
interrupt never reaches the system and the driver initialization times out.

The controller is part of a Winbond W83627HF SuperIO, connected via LPC 
and Intel ICH4 to a Pentium mobile Processor system.

The workaround was to insert a udelay() for the controller to settle 
from it's first reset, if compiled as a module and only on the 
initializing reset, if the version is still FDC_NONE.

For other tests, I moved around the code in the process of linking and 
with my own entry point within main.c. I wanted to figure out, whether 
any dependency on other modules or processes before init() would become 
visible. This did not help, as did inserting waiting code as found in 
fdc_dtr, where similar circumstances have been documented.


Some questions to this mailing list:
- Does anyone have an idea of what the winbond controller is waiting
   for?
- Is this an appropriate workaround or patch?
- Is this the right place to wait or should I wait within floppy_init()
   somewhere before user_reset_fdc(-1,FD_RESET_ALWAYS,0)?
- Is this the right way of waiting 2200 usec?
- Are there any other experiences with the Winbond W83627HF SuperIO
   regarding floppy functionality?

Regards,
Hans-Jürgen Tappe



--- linux/drivers/block/floppy.c_orig   2004-06-16 07:18:59 +0200
+++ linux/drivers/block/floppy.c        2004-07-16 15:51:53 +0200
@@ -4458,6 +4458,12 @@
                 if (FDCS->address != -1) {
                         reset_fdc_info(1);
                         fd_outb(FDCS->dor, FD_DOR);
+#ifndef MODULE
+                       /* only before initialization */
+                       if (FDCS->version == FDC_NONE)
+                               /* Wait for the FDC to be ready */
+                               udelay(2200);
+#endif
                 }
         }
         fdc = 0;

-- 
Hans-Jürgen Tappe
SYSGO AG
Am Pfaffenstein 14
55270 Klein-Winternheim
Phone: +49-61 36-99 48-0
Fax:   +49-61 36-99 48-10
hjtappe@sysgo.com
www.sysgo.com
www.elinos.com

