Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262337AbSJKBdi>; Thu, 10 Oct 2002 21:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262351AbSJKBdi>; Thu, 10 Oct 2002 21:33:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20379 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262337AbSJKBdf>;
	Thu, 10 Oct 2002 21:33:35 -0400
Subject: [whoops][PATCH] linux-2.5.41_cyclone-fixes_A1
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: greg kh <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034298580.19094.53.camel@cog>
References: <1034298580.19094.53.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 18:32:37 -0700
Message-Id: <1034299957.19094.65.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 18:09, john stultz wrote:
> Linus, 
> 	This patch just syncs up the cyclone-timer code w/ Greg's changes from
> this morning. 

Whoops! Exported the wrong changeset. Here is the full patch.

Try this instead.

sorry,
-john

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Thu Oct 10 18:31:05 2002
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Thu Oct 10 18:31:05 2002
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/timex.h>
+#include <linux/errno.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -81,7 +82,7 @@
 	
 	/*make sure we're on a summit box*/
 	/*XXX need to use proper summit hooks! such as xapic -john*/
-	if(!use_cyclone) return 0; 
+	if(!use_cyclone) return -ENODEV; 
 	
 	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
 
@@ -92,12 +93,12 @@
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!reg){
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
-		return 0;
+		return -ENODEV;
 	}
 	base = *reg;	
 	if(!base){
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
-		return 0;
+		return -ENODEV;
 	}
 	
 	/* setup PMCC */
@@ -107,7 +108,7 @@
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!reg){
 		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
-		return 0;
+		return -ENODEV;
 	}
 	reg[0] = 0x00000001;
 
@@ -118,7 +119,7 @@
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!reg){
 		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
-		return 0;
+		return -ENODEV;
 	}
 	reg[0] = 0x00000001;
 
@@ -129,7 +130,7 @@
 	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!cyclone_timer){
 		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
-		return 0;
+		return -ENODEV;
 	}
 
 	/*quick test to make sure its ticking*/
@@ -140,12 +141,12 @@
 		if(cyclone_timer[0] == old){
 			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
 			cyclone_timer = 0;
-			return 0;
+			return -ENODEV;
 		}
 	}
 
 	/* Everything looks good! */
-	return 1;
+	return 0;
 }
 

@@ -166,7 +167,7 @@
 
 /* cyclone timer_opts struct */
 struct timer_opts timer_cyclone = {
-	init: init_cyclone, 
-	mark_offset: mark_offset_cyclone, 
-	get_offset: get_offset_cyclone
+	.init = init_cyclone, 
+	.mark_offset = mark_offset_cyclone, 
+	.get_offset = get_offset_cyclone
 };

