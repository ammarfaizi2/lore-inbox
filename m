Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTHTKtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 06:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTHTKtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 06:49:52 -0400
Received: from ns.suse.de ([195.135.220.2]:17127 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261884AbTHTKtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 06:49:51 -0400
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: BKL on reboot ?
References: <3F434BD1.9050704@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Aug 2003 12:49:47 +0200
In-Reply-To: <3F434BD1.9050704@suse.de.suse.lists.linux.kernel>
Message-ID: <p73wud861tg.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <Hannes.Reinecke@suse.de> writes:

> I've got a dumb question: Why is the BKL held on entering sys_reboot()
> in kernel/sys.c:405 ?

Interesting. I have a few SMP deadlocks on x86-64 in reboot too 
and it's possible that it is the same problem.

I would hold it during exection of the notifiers, but drop
it before calling into machine_*

-Andi

--- linux-2.6.0test3-amd64/kernel/sys.c-o	2003-07-28 19:18:18.000000000 +0200
+++ linux-2.6.0test3-amd64/kernel/sys.c	2003-08-20 12:48:59.000000000 +0200
@@ -409,6 +409,7 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
+		unlock_kernel();
 		machine_restart(NULL);
 		break;
 
@@ -425,8 +426,8 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
-		machine_halt();
 		unlock_kernel();
+		machine_halt();
 		do_exit(0);
 		break;
 
@@ -435,8 +436,8 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
-		machine_power_off();
 		unlock_kernel();
+		machine_power_off();
 		do_exit(0);
 		break;
 
@@ -451,6 +452,7 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
+		unlock_kernel();
 		machine_restart(buffer);
 		break;
 
