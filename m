Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSFWNMm>; Sun, 23 Jun 2002 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317021AbSFWNMl>; Sun, 23 Jun 2002 09:12:41 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:1196 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317020AbSFWNMj>; Sun, 23 Jun 2002 09:12:39 -0400
Date: Sun, 23 Jun 2002 16:12:26 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: clock@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc size too large
Message-ID: <20020623131226.GE1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	clock@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20020623104012.B532@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020623104012.B532@ghost.cybernet.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 10:40:12AM +0200, you [clock@atrey.karlin.mff.cuni.cz] wrote:
> Hello
> 
> when dumping tracks from an IDE CD using cdda2wav I sometimes get this
> kernel message:
> 
> Jun 23 10:34:18 ghost kernel: kmalloc: Size (4294852048) too large
> Jun 23 10:34:18 ghost kernel: kmalloc: Size (4294852048) too large
> Jun 23 10:37:55 ghost last message repeated 29 times
> Jun 23 10:37:55 ghost last message repeated 29 times
> 
> It is not deterministic but looks like some tracks cause it often and some
> not.

4294852048 = 0xfffe3dd0, ie. 115247 bytes less than 2^32. Someone is trying
to allocate -115247 bytes. Is the number 4294852048 always?

You could first check if 2.2.21rc4 has any updates to ide cd relative to
2.2.20. (Better yet, try reproducing it on 2.2.21rc4).

To fix the bug one has find out which function does the faulty kmalloc()
call. You could try kdb, kgdb etc. Or, you could add the show_stack() helper
(patch below, I think it's originally by Keith Owens) and add

	show_stack(NULL);

right below the "kmalloc: Size (4294852048) too large" printk() call (find
it with grep.) Once you trigger the bug with that patch, you should get a
stack dump. Then you need to convert the addresses to symbol named using
system.map (I'm not sure if ksymoops can do it directly, or if you have to
do it by hand.) 

One more thing: I'm not sure about the 4095 below. If the stack dump makes
no sense, try 8195. (2.4 uses THREAD_SIZE-1 and THREAD_SIZE is 2*PAGE_SIZE
(2*4096) on i386). ISTR the value changed during 2.2, but perhaps I'm
wrong... Can anyone clarify this?
 
> Kernel 2.2.20


-- v --

v@iki.fi


diff -aur ../linux/arch/i386/kernel/traps.c ./arch/i386/kernel/traps.c
--- ../linux/arch/i386/kernel/traps.c	Fri Nov  2 18:39:05 2001
+++ ./arch/i386/kernel/traps.c	Sun Jun 23 16:00:29 2002
@@ -120,6 +120,56 @@
 #define VMALLOC_OFFSET (8*1024*1024)
 #define MODULE_RANGE (8*1024*1024)
 
+
+/* Separate show_stack() so adhoc debugging code can use it */
+void show_stack(const unsigned long *esp)
+{
+       int i;
+       unsigned long *stack, *save_stack, addr, module_start, module_end;
+       printk("Stack: ");
+       /* show_registers passes a real esp, adhoc debugging passes NULL */
+       if (esp)
+               stack = (unsigned long *) esp;
+       else
+               asm("movl %%esp,%0": "=m" (stack));
+       save_stack = stack;
+       for(i=0; i < kstack_depth_to_print; i++) {
+               if (((long) stack & 4095) == 0)
+                       break;
+               if (i && ((i % 8) == 0))
+                       printk("\n       ");
+               printk("%08lx ", *stack++);
+       }
+       printk("\nCall Trace: ");
+       stack = save_stack;
+       i = 1;
+       module_start = PAGE_OFFSET + (max_mapnr << PAGE_SHIFT);
+       module_start = ((module_start + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1));
+       module_end = module_start + MODULE_RANGE;
+       while (((long) stack & 4095) != 0) {
+               addr = *stack++;
+               /*
+                * If the address is either in the text segment of the
+                * kernel, or in the region which contains vmalloc'ed
+                * memory, it *may* be the address of a calling
+                * routine; if so, print it so that someone tracing
+                * down the cause of the crash will be able to figure
+                * out the call path that was taken.
+                */
+               if (((addr >= (unsigned long) &_stext) &&
+                    (addr <= (unsigned long) &_etext)) ||
+                   ((addr >= module_start) && (addr <= module_end))) {
+                       if (i && ((i % 8) == 0))
+                               printk("\n       ");
+                       printk("[<%08lx>] ", addr);
+                       i++;
+               }
+       }
+       printk("\n");
+}
+
+
+
 static void show_registers(struct pt_regs *regs)
 {
 	int i;
diff -aur ../linux/include/linux/kernel.h ./include/linux/kernel.h
--- ../linux/include/linux/kernel.h	Sun Mar 25 19:31:03 2001
+++ ./include/linux/kernel.h	Mon Dec 10 19:53:42 2001
@@ -53,6 +53,7 @@
 extern int vsprintf(char *buf, const char *, va_list);
 
 extern int session_of_pgrp(int pgrp);
+extern void show_stack(const unsigned long *); /* For adhoc debugging */
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
