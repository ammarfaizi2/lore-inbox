Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUHBFme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUHBFme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 01:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUHBFmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 01:42:32 -0400
Received: from digitalimplant.org ([64.62.235.95]:50859 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266273AbUHBFm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 01:42:28 -0400
Date: Sun, 1 Aug 2004 22:42:11 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [0/25] Merge pmdisk and swsusp
In-Reply-To: <20040720164640.GH10921@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408012220160.8159-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
 <20040720164640.GH10921@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jul 2004, Pavel Machek wrote:

> Followup patch:
>
> * if machine halt fails, it is very dangerous to continue.
>
> diff -ur linux.middle/kernel/power/disk.c linux/kernel/power/disk.c
> --- linux.middle/kernel/power/disk.c	2004-07-19 08:58:08.000000000 -0700
> +++ linux/kernel/power/disk.c	2004-07-19 15:00:16.000000000 -0700
> @@ -63,6 +63,9 @@
>  		break;
>  	}
>  	machine_halt();
> +	/* Valid image is on the disk, if we continue we risk serious data corruption
> +	   after resume. */
> +	while(1);
>  	device_power_up();
>  	local_irq_restore(flags);
>  	return 0;

This is nasty. We have to fail gracefully, ideally without expecting user
input.

Adding 'while(1)' will cause the CPU to enter a busy loop, artificially
increasing the power consumption of the system, which would be counter-
productive in a system that was configured to suspend when the battery was
low.

We need to at least print a message specifying what happened and
instructing them to reboot. It's dorky, but over time, all every system
should eventually be fixed to either enter a low-power mode or shut down
properly.

Perhaps we could also fill in machine_halt(), which the patch below also
does.

> * software_suspend() did not check for smp, this fixes it.

Applied, thanks.

> * copy_page() is dangerous. This is actually my fault.

Why is copy_page() dangerous? Shouldn't it be fixed if that is the case?

Thanks,


	Pat
===== arch/i386/kernel/reboot.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/reboot.c	2004-07-05 03:28:50 -07:00
+++ edited/arch/i386/kernel/reboot.c	2004-08-01 22:40:58 -07:00
@@ -367,6 +367,8 @@

 void machine_halt(void)
 {
+	while (1)
+		asm volatile ("hlt":::"memory");
 }

 EXPORT_SYMBOL(machine_halt);
===== kernel/power/disk.c 1.16 vs edited =====
--- 1.16/kernel/power/disk.c	2004-08-01 20:36:39 -07:00
+++ edited/kernel/power/disk.c	2004-08-01 22:38:19 -07:00
@@ -59,6 +59,7 @@
 		machine_restart(NULL);
 		break;
 	}
+	printk(KERN_EMERG "Suspend-to-disk succeeded, but power-down failed. Please reboot.\n");
 	machine_halt();
 	device_power_up();
 	local_irq_restore(flags);
