Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTEHHQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTEHHQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:16:55 -0400
Received: from zero.aec.at ([193.170.194.10]:59908 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261216AbTEHHQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:16:53 -0400
Date: Thu, 8 May 2003 09:29:17 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, ak@muc.de,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: garbled oopsen
Message-ID: <20030508072917.GA21868@averell>
References: <20030508011013$3d80@gated-at.bofh.it> <20030508015008$481c@gated-at.bofh.it> <m34r46dufb.fsf@averell.firstfloor.org> <23400000.1052364724@[10.10.2.4]> <20030507225310.609ae215.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507225310.609ae215.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 07:53:10AM +0200, Andrew Morton wrote:
> A recursive oops is easy enough to detect anyway.
> 
> 	preempt_disable();
> 	if (oops_cpu == -1 || oops_cpu != smp_processor_id()) {
> 		_raw_spin_lock(&oops_lock);
> 		oops_cpu = smp_processor_id();
> 	}
> 	<current stuff>
> 	oops_cpu = -1;
> 	spin_lock_init(&oops_lock);
> 	preempt_enable();
> 
> or something like that.

yes I did it this way in my old 2.4 x86-64 patch.  But i never
felt comfortable enough about it to commit it.

(the in_interrupt thing was to avoid an interrupt stack problem on 
x86-64, not needed anymore or on i386)

But I would prefer the spinlock timeout I think. It's an safer and more
obviously correct algorithm.

-Andi

Index: arch/x86_64/mm/fault.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/x86_64/mm/fault.c,v
retrieving revision 1.33
diff -u -u -r1.33 fault.c
--- arch/x86_64/mm/fault.c	2002/10/02 15:41:14	1.33
+++ arch/x86_64/mm/fault.c	2003/01/13 08:42:35
@@ -30,6 +30,9 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 
+spinlock_t pcrash_lock; 
+int crashing_cpu;
+
 extern spinlock_t console_lock, timerlist_lock;
 
 void bust_spinlocks(int yes)
@@ -251,6 +254,14 @@
 	console_verbose();
 	bust_spinlocks(1); 
 
+	if (!in_interrupt()) { 
+		if (!spin_trylock(&pcrash_lock)) { 
+			if (crashing_cpu != smp_processor_id()) 
+				spin_lock(&pcrash_lock);  		    
+		} 
+		crashing_cpu = smp_processor_id();
+	} 
+
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
@@ -259,7 +270,14 @@
 	printk(" printing rip:\n");
 	printk("%016lx\n", regs->rip);
 	dump_pagetable(address);
+
 	die("Oops", regs, error_code);
+
+	if (!in_interrupt()) { 
+		crashing_cpu = -1;  /* small harmless window */ 
+		spin_unlock(&pcrash_lock);
+	}
+
 	bust_spinlocks(0); 
 	do_exit(SIGKILL);
 


