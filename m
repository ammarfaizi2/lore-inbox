Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUEEJrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUEEJrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUEEJrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:47:35 -0400
Received: from gprs214-31.eurotel.cz ([160.218.214.31]:12160 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264360AbUEEJrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:47:32 -0400
Date: Wed, 5 May 2004 11:47:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp documentation updates
Message-ID: <20040505094719.GA4259@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'd like this to be included. People ask question I should have
answered in the documentation.
							Pavel

--- clean/Documentation/power/swsusp.txt	2004-02-05 01:53:53.000000000 +0100
+++ linux/Documentation/power/swsusp.txt	2004-05-04 23:36:26.000000000 +0200
@@ -123,10 +123,61 @@
 replace ethernet card, resume. If you are fast your users will not
 even see broken connections.
 
-Any other idea you might have tell me!
+Q: Maybe I'm missing something, but why doesn't the regular io paths
+work?
 
-Contacting the author
-If you have any question or any patch that solves the above or detected
-problems please contact me at seasons@falcon.sch.bme.hu. I might delay
-answering, sorry about that.
+A: (Basically) you want to replace all kernel data with kernel data saved
+on disk. How do you do that using normal i/o paths? If you'll read
+"new" data 4KB at a time, you'll crash... because you still need "old"
+data to do the reading, and "new" data may fit on same physical spot
+in memory.
 
+There are two solutions to this:
+
+* require half of memory to be free during suspend. That way you can
+read "new" data onto free spots, then cli and copy
+
+* assume we had special "polling" ide driver that only uses memory
+between 0-640KB. That way, I'd have to make sure that 0-640KB is free
+during suspending, but otherwise it would work...
+
+Q: Does linux support ACPI S4?
+
+A: No.
+
+When swsusp was created, ACPI was not too widespread, so we tried to
+avoid using ACPI-specific stuff. ACPI also is/was notoriously
+buggy. These days swsusp works on APM-only i386 machines and even
+without any power managment at all. Some versions also work on PPC.
+
+That means that machine does not enter S4 on suspend-to-disk, but
+simply enters S5. That has few advantages, you can for example boot
+windows on next boot, and return to your Linux session later. You
+could even have few different Linuxes on your box (not sharing any
+partitions), and switch between them.
+
+It also has disadvantages. On HP nx5000, if you unplug power cord
+while machine is suspended-to-disk, Linux will fail to notice that.
+
+Q: My machine doesn't work with ACPI. How can I use swsusp than ?
+
+A: Do reboot() syscall with right parameters. Warning: glibc gets in
+its way, so check with strace:
+ 
+reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)
+
+(Thanks to Peter Osterlund:)
+
+#include <unistd.h>
+#include <syscall.h>
+
+#define LINUX_REBOOT_MAGIC1     0xfee1dead
+#define LINUX_REBOOT_MAGIC2     672274793
+#define LINUX_REBOOT_CMD_SW_SUSPEND     0xD000FCE2
+
+int main()
+{
+    syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+            LINUX_REBOOT_CMD_SW_SUSPEND, 0);
+    return 0;
+}

-- 
934a471f20d6580d5aad759bf0d97ddc
