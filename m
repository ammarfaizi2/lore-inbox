Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUJKBpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUJKBpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 21:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbUJKBpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 21:45:06 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:53252 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268594AbUJKBo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 21:44:59 -0400
Date: Mon, 11 Oct 2004 02:44:54 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Cc: Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [BKPATCH] LAPIC fix for 2.6
In-Reply-To: <1097443183.26647.31.camel@darkstar>
Message-ID: <Pine.LNX.4.58L.0410110132170.4217@blysk.ds.pg.gda.pl>
References: <1097429707.30734.21.camel@d845pe>  <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
  <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl> <1097443183.26647.31.camel@darkstar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2004, [ISO-8859-1] Sérgio Monteiro Basto wrote:

> The problem is: trying enable some local apic's (for example on via
> mother boards on my laptop), cause many problem, like hang on boot (with
> ACPI), hang on Fn-F3 (video switch), power-off fails, etc. and no one
> knows how resolved the problem.  

 Ah, laptops seem to be inherently insane...  Your symptoms suggest your 
firmware/BIOS is buggy, doing probably something under the OS, which 
cannot be controlled and without taking proper care of the state of 
hardware.  That's the infamous SMM code.

 How about only disabling the APIC if power-management is in use?  And 
announcing it so that a user sees the APIC has been kept deliberately 
disabled, as opposed to be unable to be enabled?  Like below -- for ACPI 
only, as I assume APM gives no trouble or the change would have been 
proposed much earlier.  Untested.

> So keep it disable if BIOS vendors say so, can be reasonable idea.

 BIOS vendors usually say so, because they have no clue, or in other 
words, they do not really mean to say anything with this.  They just don't 
enable the APIC as they see no use for it, but the same can be true of 
plenty of other hardware that has no use for the firmware.

 I don't like the idea of "punishing" good hardware, because something 
behaves ill out there.

  Maciej

patch-mips-2.6.9-rc2-20040920-lapic-0
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/acpi/boot.c linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/acpi/boot.c
--- linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/acpi/boot.c	2004-08-25 03:57:43.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/acpi/boot.c	2004-10-11 01:42:34.000000000 +0000
@@ -835,6 +835,19 @@ acpi_boot_init (void)
 	}
 
 	/*
+	 * Don't override BIOS and enable the local APIC
+	 * unless "lapic" specified.
+	 */
+	if (!acpi_disabled && enable_local_apic == 0) {
+		printk(KERN_NOTICE PREFIX
+		       "Local APIC won't be reenabled, "
+		       "because of frequent BIOS bugs\n");
+		printk(KERN_NOTICE PREFIX
+		       "You can enable it with \"lapic\"\n");
+		enable_local_apic = -1;
+	}
+
+	/*
 	 * set sci_int and PM timer address
 	 */
 	acpi_table_parse(ACPI_FADT, acpi_parse_fadt);
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/apic.c linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/apic.c
--- linux-mips-2.6.9-rc2-20040920.macro/arch/i386/kernel/apic.c	2004-09-20 03:57:43.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/i386/kernel/apic.c	2004-10-11 01:37:13.000000000 +0000
@@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
-	/* Disabled by DMI scan or kernel option? */
+	/* Disabled by DMI scan, ACPI or kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
 
