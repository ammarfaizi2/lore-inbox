Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270481AbTGNPMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbTGNPIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:08:02 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:59154 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S270465AbTGNPCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:02:41 -0400
Date: Mon, 14 Jul 2003 16:17:28 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Cc: oprofile-list@lists.sf.net
Subject: [PATCH] OProfile: dynamically allocate MSR struct
Message-ID: <20030714151727.GA69617@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19c54y-000Pv4-M8*..aZDQRazHo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi pointed out to me that cpu_msrs was a source of bloat. Dynamically
allocate it instead. Tested on my SMP box.

Note that we could eventually use per cpu stuff here, but I'd like to
wait on that for now.

regards
john


diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_int.c linux-fixes/arch/i386/oprofile/nmi_int.c
--- linux-cvs/arch/i386/oprofile/nmi_int.c	2003-06-18 15:06:05.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/nmi_int.c	2003-07-14 15:34:29.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 #include <linux/oprofile.h>
 #include <linux/sysdev.h>
+#include <linux/slab.h>
 #include <asm/nmi.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
@@ -20,7 +21,7 @@
 #include "op_x86_model.h"
  
 static struct op_x86_model_spec const * model;
-static struct op_msrs cpu_msrs[NR_CPUS];
+static struct op_msrs * cpu_msrs;
 static unsigned long saved_lvtpc[NR_CPUS];
  
 static int nmi_start(void);
@@ -125,6 +126,10 @@
 
 static int nmi_setup(void)
 {
+	cpu_msrs = kmalloc(sizeof(struct op_msrs) * NR_CPUS, GFP_KERNEL);
+	if (!cpu_msrs)
+		return -ENOMEM;
+
 	/* We walk a thin line between law and rape here.
 	 * We need to be careful to install our NMI handler
 	 * without actually triggering any NMIs as this will
@@ -185,6 +190,7 @@
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
 	unset_nmi_callback();
 	enable_lapic_nmi_watchdog();
+	kfree(cpu_msrs);
 }
 
  
