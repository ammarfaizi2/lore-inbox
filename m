Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJUS3P>; Mon, 21 Oct 2002 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJUS3P>; Mon, 21 Oct 2002 14:29:15 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:39173 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261528AbSJUS3K>; Mon, 21 Oct 2002 14:29:10 -0400
Date: Mon, 21 Oct 2002 20:35:00 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: problemn when shutting down, drivers/base/power.c and the global_device_list
Message-ID: <20021021183500.GA501@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20021019153417.GA567@middle.of.nowhere> <Pine.LNX.4.44.0210201117080.963-100000@cherise.pdx.osdl.net> <20021020145947.A11444@eng2.beaverton.ibm.com> <20021021053622.GA493@middle.of.nowhere> <20021021084425.A29967@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021084425.A29967@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Mansfield <patmans@us.ibm.com>
Date: Mon, Oct 21, 2002 at 08:44:25AM -0700
> On Mon, Oct 21, 2002 at 07:36:22AM +0200, Jurriaan wrote:
> > I tried this patch:
> > 
> 
> Mike meant try his patch or my patch, not Patrick Mochel's, just remove one
> of the two duplicate calls to device_register(&shost->host_driverfs_dev),
> either the one in scsi_register_host or the one in scsi_set_pci_device
> and try again.
> 
Excellent work. With this patch:

--- 1.19/drivers/scsi/hosts.h	Wed Oct 16 17:53:47 2002
+++ edited/drivers/scsi/hosts.h	Sun Oct 20 19:45:35 2002
@@ -551,9 +551,6 @@
 {
 	shost->pci_dev = pdev;
 	shost->host_driverfs_dev.parent=&pdev->dev;
-
-	/* register parent with driverfs */
-	device_register(&shost->host_driverfs_dev);
 }
 
and this patch from Manfred Spraul

--- a/arch/i386/kernel/apm.c	2002-10-12 06:21:05.000000000 +0200
+++ b/arch/i386/kernel/apm.new	2002-10-20 19:48:30.000000000 +0200
@@ -912,10 +911,10 @@
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
 	if (smp_processor_id() != 0) {
-		current->cpus_allowed = 1;
-		schedule();
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
+		if (cpu_online(0))
+			set_cpus_allowed(current, 1);
+		else
+			printk(KERN_INFO "apm: CPU 0 is offline, trying apm shutdown from cpu %d\n", smp_processor_id());
 	}
 #endif
 	if (apm_info.realmode_power_off)
@@ -1693,10 +1692,10 @@
 	 * Method suggested by Ingo Molnar.
 	 */
 	if (smp_processor_id() != 0) {
-		current->cpus_allowed = 1;
-		schedule();
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
+		if (cpu_online(0))
+			set_cpus_allowed(current, 1);
+		else
+			printk(KERN_INFO "apm: CPU 0 is offline, trying apm shutdown from cpu %d\n", smp_processor_id());
 	}
 #endif

All my problems are over - shutdown works perfectly here.

Thanks, everybody!

Jurriaan
-- 
The absence of alternatives clears the mind marvelously.
Henry Kissinger
GNU/Linux 2.5.44 SMP/ReiserFS 2x1380 bogomips load av: 3.48 2.08 1.08
