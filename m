Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316904AbSE1Upx>; Tue, 28 May 2002 16:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316942AbSE1Unz>; Tue, 28 May 2002 16:43:55 -0400
Received: from [195.39.17.254] ([195.39.17.254]:61596 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316927AbSE1UmH>;
	Tue, 28 May 2002 16:42:07 -0400
Date: Tue, 28 May 2002 21:55:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp in 2.4.19-pre8-ac5
Message-ID: <20020528195546.GC189@elf.ucw.cz>
In-Reply-To: <200205252301.g4PN1A113459@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attached is a patch against 2.4.19-pre8-ac5 fixing some bugs and typos
> in software suspend stuff. It should also make the whole process a lot
> prettier on console.
> 
> Sorry if some of the corrections were already sent by Pavel.

No, I do not think I sent any corrections. Please original Florent's
patch.

								Pavel

diff -u linux-src/Documentation/kernel-parameters.txt:1.1.1.2.12.1 linux-src/Documentation/kernel-parameters.txt:1.1.1.2.14.2
--- linux-src/Documentation/kernel-parameters.txt:1.1.1.2.12.1	Fri May 17 17:56:01 2002
+++ linux-src/Documentation/kernel-parameters.txt	Mon May 20 12:02:54 2002
@@ -45,6 +45,7 @@
 	SERIAL	Serial support is enabled.
 	SMP 	The kernel is an SMP kernel.
 	SOUND	Appropriate sound system support is enabled.
+	SWSUSP  Software suspension is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA 	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
@@ -389,6 +390,8 @@
 			initial RAM disk.
 
 	nointroute	[IA-64]
+
+	noresume	[SWSUSP] Disables resume and restore original swap space.
  
 	no-scroll	[VGA]
 
@@ -507,6 +510,8 @@
 	reboot=		[BUGS=ix86]
 
 	reserve=	[KNL,BUGS] force the kernel to ignore some iomem area.
+
+	resume=		[SWSUSP] specify the partition device for software suspension.
 
 	riscom8=	[HW,SERIAL]
 

Applied to my 2.5-tree.

diff -u linux-src/drivers/block/loop.c:1.1.1.1.14.1.2.1 linux-src/drivers/block/loop.c:1.1.1.1.14.1.2.1.2.2
--- linux-src/drivers/block/loop.c:1.1.1.1.14.1.2.1	Mon May  6 19:26:51 2002
+++ linux-src/drivers/block/loop.c	Thu May  9 14:46:35 2002
@@ -581,7 +581,9 @@
 	atomic_inc(&lo->lo_pending);
 	spin_unlock_irq(&lo->lo_lock);
 
-	current->flags |= PF_NOIO | PF_IOTHREAD;
+	current->flags |= PF_NOIO | PF_IOTHREAD; /* loop can be used in an encrypted device
+						    hence, it mustn't be stopped at all because it could
+						    be indirectly used during suspension */
 
 	/*
 	 * up sem, we are running

Applied.

Index: linux-src/drivers/usb/hub.c
diff -u linux-src/drivers/usb/hub.c:1.1.1.1.12.1.2.1 linux-src/drivers/usb/hub.c:1.1.1.1.12.1.4.2
-X-- linux-src/drivers/usb/hub.c:1.1.1.1.12.1.2.1	Sat May 11 16:52:44 2002
+X++ linux-src/drivers/usb/hub.c	Sat May 11 19:28:56 2002
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/suspend.h>
 #ifdef CONFIG_USB_DEBUG
 	#define DEBUG
 #else
@@ -912,6 +913,8 @@
 	/* Send me a signal to get me die (for debugging) */
 	do {
 		usb_hub_events();
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
 	} while (!signal_pending(current));
 


Applied.

Index: linux-src/include/linux/mm.h
diff -u linux-src/include/linux/mm.h:1.1.1.1.6.1.2.3 linux-src/include/linux/mm.h:1.1.1.1.6.1.2.1.2.3
-X-- linux-src/include/linux/mm.h:1.1.1.1.6.1.2.3	Thu May 23 11:31:49 2002
+X++ linux-src/include/linux/mm.h	Sat May 25 16:39:22 2002
@@ -652,6 +652,9 @@
 #define __GFP_IO	0x40	/* Can start low memory physical IO? */
 #define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
 #define __GFP_FS	0x100	/* Can call down to low-level FS? */
+#if CONFIG_SOFTWARE_SUSPEND
+#define __GFP_FAST	0x200	/* fast return in reschedule if out of page */
+#endif
 
 #define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
 #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)

It should be #if*def*, and you better drop the ifdef too as it is
completely unneccessary.

Index: linux-src/include/linux/sched.h
diff -u linux-src/include/linux/sched.h:1.1.1.1.6.1.2.2 linux-src/include/linux/sched.h:1.1.1.1.6.1.2.1.2.2
--- linux-src/include/linux/sched.h:1.1.1.1.6.1.2.2	Thu May 23 11:31:49 2002
+++ linux-src/include/linux/sched.h	Sat May 25 16:39:22 2002
@@ -428,7 +428,6 @@
 #define PF_FROZEN	0x00008000	/* frozen for system suspend */
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
-#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 

Applied.

Index: linux-src/kernel/suspend.c
diff -u linux-src/kernel/suspend.c:1.3.2.2 linux-src/kernel/suspend.c:1.3.2.1.2.6
--- linux-src/kernel/suspend.c:1.3.2.2	Thu May 23 11:31:51 2002
+++ linux-src/kernel/suspend.c	Sat May 25 23:10:03 2002
@@ -1,5 +1,5 @@
 /*
- * linux/kernel/swsusp.c
+ * linux/kernel/suspend.c
  *
  * This file is to realize architecture-independent
  * machine suspend feature using pretty near only high-level routines

Applied.

 			INTERESTING(p);
 			if (p->flags & PF_FROZEN)
 				continue;
-
+			if (p->state == TASK_STOPPED) {	/* this task is a stopped but not frozen one */
+				p->flags |= PF_IOTHREAD;
+				_printk("+");
+				continue;
+			}
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
 			p->flags |= PF_FREEZE;

Are you sure this is correct? What if someone wakes it just after you
given it PF_IOTHREAD?

What's the point of all those PRINTS -> __prints changes? I do not
like additional abstractions on the top of printk(). Are they really
neccessary?

@@ -946,24 +959,27 @@
 static void do_software_suspend(void)
 {
 	arch_prepare_suspend();
-	if (!prepare_suspend_console()) {
-		if (!prepare_suspend_processes()) {
-			free_some_memory();
-
-			/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
-			 *
-			 * We sync here -- so you have consistent filesystem state when things go wrong.
-			 * -- so that noone writes to disk after we do atomic copy of data.
-			 */
-			PRINTS( "Syncing disks before copy\n" );
-			do_suspend_sync();
-			drivers_suspend();
-			if(drivers_suspend()==0)
-				do_magic(0);			/* This function returns after machine woken up from resume */
-			PRINTR("Restarting processes...\n");
-			thaw_processes();
-		}
+	if (prepare_suspend_console())
+		__prints( "Can't allocate a console... proceeding\n");
+	if (!prepare_suspend_processes()) {
+		free_some_memory();
+
+		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
+		 *
+		 * We sync here -- so you have consistent filesystem state when things go wrong.
+		 * -- so that noone writes to disk after we do atomic copy of data.
+		 */
+		PRINTS("Syncing disks before copy\n" );
+		do_suspend_sync();
+#if 0
+		schedule_timeout(1*HZ);	/* Is this needed to get data properly to disk? */
+#endif
+		if(drivers_suspend()==0)
+			do_magic(0);			/* This function returns after machine woken up from resume */
+		PRINTR("Restarting processes...\n");
+		thaw_processes();
 	}
+	
 	software_suspend_enabled = 1;
 	PRINTR( "Done resume from %x\n", resume_dev );
 	MDELAY(1000);

Applied.

@@ -1186,9 +1202,49 @@
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
-			name_resume, cur->swh.magic.magic);
+			name_resume, cur->swh.magic.magic); /* even with a noresume option, it is better
+							       to panic here, because that means that the
+							       resume device is not a proper swap one. It
+							       is perhaps a linux or dos partition and we
+							       don't want to risk damaging it. */
+	}
+	if(noresume) {
+	  	struct buffer_head *bh;
+				/* We don't do a sanity check here: we want to restore the swap
+				   whatever version of kernel made the suspend image */
+		__printr( "%s: Fixing swap signatures...\n", resume_file);
+				/* We need to write swap, but swap is *not* enabled so
+				   we must write the device directly */
+		bh = bread(resume_device, 0, PAGE_SIZE);
+		if (!bh || (!bh->b_data)) {
+			error = -EIO;
+			free_page((unsigned long)cur);
+			goto resume_read_error;
+		}
+		if (is_read_only(bh->b_dev)) {
+			__printr(KERN_WARNING "Can't write to read-only device %s\n",
+				 kdevname(bh->b_dev));
+		} else {
+			memcpy(bh->b_data, cur, PAGE_SIZE);
+			generic_make_request(WRITE, bh);
+			wait_on_buffer(bh);
+			if (buffer_uptodate(bh)) {
+				error = 0;
+				brelse(bh);
+			} else {
+				__printr(KERN_WARNING "Warning %s: Fixing swap signatures unsuccessful...\n", resume_file);		
+				error = -EIO;
+				bforget(bh);
+			}
+		}
+		free_page((unsigned long)cur);
+		goto resume_read_error;
 	}
-	printk( "%sSignature found, resuming\n", name_resume );
+
+	
+	if (prepare_suspend_console())
+		__printr( "Can't allocate a console... proceeding\n");
+	_printr( "Signature found, resuming\n");
 	MDELAY(1000);
 
 	READTO(next.val, cur);

Aiee, I guess  I want this one in 2.5. version but it is not quite
trivial to port :-(.

@@ -1207,11 +1263,12 @@
 	pagedir_order = get_bitmask_order(nr_pgdir_pages);
 
 	error = -ENOMEM;
+	free_page((unsigned long)cur);
 	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
 	if(!pagedir_nosave)
 		goto resume_read_error;
 
-	PRINTR( "%sReading pagedir, ", name_resume );
+	PRINTR( "Reading pagedir\n" );
 
 	/* We get pages in reverse order of saving! */
 	error=-EIO;

Why freeing it? This system is going to be overwritten, anyway.

@@ -1277,7 +1334,7 @@
 void software_resume(void)
 {
 #ifdef CONFIG_SMP
-	printk(KERN_WARNING "Software Suspend has a malfunctioning SMP support. Disabled :(\n");
+	__printg(KERN_WARNING "malfunctioning SMP support. Disabled :(\n");
 #else
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
@@ -1285,10 +1342,11 @@
 	if(!resume_status)
 		return;
 
-	printk( "%s", name_resume );
 	if(resume_status == NORESUME) {
-		/* FIXME: Signature should be restored here */
-		printk( "disabled\n" );
+		PRINTG( "resuming disabled\n" );
+		software_suspend_enabled = 0;
+		if(resume_file[0])
+			resume_try_to_read(resume_file,1);
 		return;
 	}
 	MDELAY(1000);

I will want this one, too...

									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
