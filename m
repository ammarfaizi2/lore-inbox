Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUE1Mdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUE1Mdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUE1Mdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:33:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47578 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262050AbUE1MdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:33:06 -0400
Date: Fri, 28 May 2004 14:32:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rik van Riel <riel@redhat.com>
Cc: John Cherry <cherry@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [patch] 2.6.7-rc1-mm1: fix set_8042_nomux warning
Message-ID: <20040528123259.GI16099@fs.tum.de>
References: <1085675112.4249.33.camel@cherrybomb.pdx.osdl.net> <Pine.LNX.4.44.0405272254590.30062-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405272254590.30062-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 10:57:46PM -0400, Rik van Riel wrote:
> On Thu, 27 May 2004, John Cherry wrote:
> 
> >   CC      arch/i386/kernel/dmi_scan.o
> > arch/i386/kernel/dmi_scan.c:410: warning: `set_8042_nomux' defined but
> > not used
> 
> It's called from the dmi routines, with the function
> defined in the DMI table.  No idea why this would
> give a warning while the other similar functions
> (eg broken_ps2_resume) don't ...

He's using a .config with CONFIG_ACPI_BOOT=n.

A fix is below.

cu
Adrian

--- linux-2.6.7-rc1-mm1-full/arch/i386/kernel/dmi_scan.c.old	2004-05-28 13:09:22.000000000 +0200
+++ linux-2.6.7-rc1-mm1-full/arch/i386/kernel/dmi_scan.c	2004-05-28 13:10:51.000000000 +0200
@@ -401,23 +401,6 @@
 }
 
 /*
- * HP Proliant 8500 systems can't use i8042 in mux mode,
- * or they instantly reboot.
- */
-#ifdef CONFIG_SERIO_I8042
-extern unsigned int i8042_nomux;
-static __init int set_8042_nomux(struct dmi_blacklist *d)
-{
-	if (i8042_nomux == 0)
-	{
-		i8042_nomux = 1;
-		printk(KERN_INFO "Disabling i8042 mux mode\n");
-	}
-	return 0;
-}
-#endif
-
-/*
  * This bios swaps the APM minute reporting bytes over (Many sony laptops
  * have this problem).
  */
@@ -516,6 +499,24 @@
 
 
 #ifdef	CONFIG_ACPI_BOOT
+
+/*
+ * HP Proliant 8500 systems can't use i8042 in mux mode,
+ * or they instantly reboot.
+ */
+#ifdef CONFIG_SERIO_I8042
+extern unsigned int i8042_nomux;
+static __init int set_8042_nomux(struct dmi_blacklist *d)
+{
+  if (i8042_nomux == 0)
+    {
+      i8042_nomux = 1;
+      printk(KERN_INFO "Disabling i8042 mux mode\n");
+    }
+  return 0;
+}
+#endif
+
 extern int acpi_force;
 
 static __init __attribute__((unused)) int dmi_disable_acpi(struct dmi_blacklist *d) 
