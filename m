Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbSJOVSk>; Tue, 15 Oct 2002 17:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbSJOVRg>; Tue, 15 Oct 2002 17:17:36 -0400
Received: from florence.buici.com ([206.124.142.26]:30665 "HELO
	florence.buici.com") by vger.kernel.org with SMTP
	id <S264853AbSJOVRU>; Tue, 15 Oct 2002 17:17:20 -0400
Date: Tue, 15 Oct 2002 14:23:10 -0700
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Subject: AMD Elan SC520 CPU speed problem w/patches
Message-ID: <20021015212310.GA30117@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be cleverly hidden problem with the Elan SC520 CPU
speed when running the Linux kernel.  The speed is controlled by a
memory-mapped registers that the CPU always offers at the physical
address 0xfffef000.  Some BIOSs--at least General Systems--enable an
alias of these registers at 0x000df000 for the sake of real-mode
programs.  It appears that something in the kernel writes to
0x000df002 because the CPU speed at the start of kernel initialization
is correct at 133MHz, but when user-mode applications start running
the CPU speed has been reduced to 100MHz.  Disabling the unnecessary
aliasing solves the problem.  Note that the BOGOMIPS calculation is
early enough to preceed the speed change.

  <http://www.buici.com/elan>

Here, you'll find source to a program that verifies the problem.
You'll also find a patch for linux-2.2.22 that fixes this bug as well
as programming the PIT timer for Elan CPUs.  Last, there is a watchdog
driver that works when the above mentioned aliasing is disabled.

Kindly copy replies to my email address.

Cheers,
  Marc Singer


============================================================================

For the speed problem, the important part of the patch reads as below.
The code is executed at the top of init_amd().

--- linux-2.2.22-original/arch/i386/kernel/setup.c      Mon Sep 16 09:26:11 2002
+++ linux-2.2.22/arch/i386/kernel/setup.c       Tue Oct 15 11:35:17 2002
@@ -662,6 +662,29 @@
        
        int r=get_model_name(c);
        
+#ifdef CONFIG_ELAN_COMPATIBILITY 
+       if (c->x86 == 4 && (c->x86_model == 9 || c->x86_model == 10)) {
+         /* There appears to be a driver that clobbers one of the
+            system control registers because these registers are
+            mapped to 0xdf000.  So, this code disables that mapping.
+            It isn't necessary anyway and is a legacy of the BIOS. */
+#define CBAR           (0xfffc) /* Configuration Base Address  (32-bit) */
+#define CBAR_ENB       (0x80000000)
+#define CBAR_KEY       (0X000000CB)
+               if (inl (CBAR) & CBAR_ENB)
+                       outl (0 | CBAR_KEY, CBAR);

