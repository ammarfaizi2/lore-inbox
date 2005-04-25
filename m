Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVDYUqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDYUqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDYUqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:46:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12247 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261183AbVDYUqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:46:08 -0400
Date: Mon, 25 Apr 2005 22:42:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425204207.GA23724@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425190606.GA23763@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well it seems that people are starting to want to hook the reboot
> notifier, or the device shutdown facility in order to properly shutdown
> pci drivers to make kexec work nicer.
> 
> So here's a patch for the PCI core that allows pci drivers to now just
> add a "shutdown" notifier function that will be called when the system
> is being shutdown.  It happens just after the reboot notifier happens,
> and it should happen in the proper device tree order, so everyone should
> be happy.
> 
> Any objections to this patch?

Yes.

I believe it should just do suspend(PMSG_SUSPEND) before system
shutdown. If you think distintion between shutdown and suspend is
important (I am not 100% convinced it is), we can just add flag
saying "this is system shutdown".

Actually this patch should be in the queue somewhere... We had it in
suse trees for a long time, and IMO it can solve problem easily.

								Pavel

--- clean-git/kernel/sys.c	2005-04-23 23:21:55.000000000 +0200
+++ linux/kernel/sys.c	2005-04-24 00:20:47.000000000 +0200
@@ -404,6 +404,7 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -414,6 +415,7 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -430,6 +432,7 @@
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);


-- 
Boycott Kodak -- for their patent abuse against Java.
