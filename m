Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311579AbSCTGA2>; Wed, 20 Mar 2002 01:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311580AbSCTGAT>; Wed, 20 Mar 2002 01:00:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:16389 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311579AbSCTGAH>; Wed, 20 Mar 2002 01:00:07 -0500
Message-ID: <3C982505.F340B421@zip.com.au>
Date: Tue, 19 Mar 2002 21:58:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] x86 BUG handling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been in 2.5 for a few weeks, no problems reported.

We embed the file-and-line info inline after the invalid opcode
in the program text.  This means that when we hit the invalid
opcode handler, the stacked machine register info is correct.
Fixes the problem where the printk() wrecks the non-call-preserved
registers.

CONFIG_DEBUG_BUGVERBOSE goes away.  Fixes the problem where kernel
developers don't know where their BUGs are.

On my fairly lean kernel build, kernel size is reduced by 90 kbytes
relative to a CONFIG_DEBUG_BUGVERBOSE=y build, due to all the do_BUG()
calls which aren't there any more.


--- 2.4.19-pre3/include/asm-i386/page.h~BUG	Tue Mar 19 21:11:43 2002
+++ 2.4.19-pre3-akpm/include/asm-i386/page.h	Tue Mar 19 21:11:43 2002
@@ -91,16 +91,18 @@ typedef struct { unsigned long pgprot; }
 /*
  * Tell the user there is some problem. Beep too, so we can
  * see^H^H^Hhear bugs in early bootup as well!
+ * The offending file and line are encoded after the "officially
+ * undefined" opcode for parsing in the trap handler.
  */
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-extern void do_BUG(const char *file, int line);
-#define BUG() do {					\
-	do_BUG(__FILE__, __LINE__);			\
-	__asm__ __volatile__("ud2");			\
-} while (0)
+#if 1	/* Set to zero for a slightly smaller kernel */
+#define BUG()				\
+ __asm__ __volatile__(	"ud2\n"		\
+			"\t.word %c0\n"	\
+			"\t.long %c1\n"	\
+			 : : "i" (__LINE__), "i" (__FILE__))
 #else
-#define BUG() __asm__ __volatile__(".byte 0x0f,0x0b")
+#define BUG() __asm__ __volatile__("ud2\n")
 #endif
 
 #define PAGE_BUG(page) do { \
--- 2.4.19-pre3/arch/i386/kernel/traps.c~BUG	Tue Mar 19 21:11:43 2002
+++ 2.4.19-pre3-akpm/arch/i386/kernel/traps.c	Tue Mar 19 21:11:43 2002
@@ -237,6 +237,41 @@ bad:
 	printk("\n");
 }	
 
+static void handle_BUG(struct pt_regs *regs)
+{
+	unsigned short ud2;
+	unsigned short line;
+	char *file;
+	char c;
+	unsigned long eip;
+
+	if (regs->xcs & 3)
+		goto no_bug;		/* Not in kernel */
+
+	eip = regs->eip;
+
+	if (eip < PAGE_OFFSET)
+		goto no_bug;
+	if (__get_user(ud2, (unsigned short *)eip))
+		goto no_bug;
+	if (ud2 != 0x0b0f)
+		goto no_bug;
+	if (__get_user(line, (unsigned short *)(eip + 2)))
+		goto bug;
+	if (__get_user(file, (char **)(eip + 4)) ||
+		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
+		file = "<bad filename>";
+
+	printk("kernel BUG at %s:%d!\n", file, line);
+
+no_bug:
+	return;
+
+	/* Here we know it was a BUG but file-n-line is unavailable */
+bug:
+	printk("Kernel BUG\n");
+}
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -244,6 +279,7 @@ void die(const char * str, struct pt_reg
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
+	handle_BUG(regs);
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
 	bust_spinlocks(0);
--- 2.4.19-pre3/arch/i386/kernel/i386_ksyms.c~BUG	Tue Mar 19 21:11:43 2002
+++ 2.4.19-pre3-akpm/arch/i386/kernel/i386_ksyms.c	Tue Mar 19 21:11:43 2002
@@ -169,9 +169,5 @@ EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-EXPORT_SYMBOL(do_BUG);
-#endif
-
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
--- 2.4.19-pre3/arch/i386/config.in~BUG	Tue Mar 19 21:11:43 2002
+++ 2.4.19-pre3-akpm/arch/i386/config.in	Tue Mar 19 21:11:43 2002
@@ -424,7 +424,6 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
-   bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
 endmenu
--- 2.4.19-pre3/arch/i386/mm/fault.c~BUG	Tue Mar 19 21:11:43 2002
+++ 2.4.19-pre3-akpm/arch/i386/mm/fault.c	Tue Mar 19 21:11:43 2002
@@ -125,12 +125,6 @@ void bust_spinlocks(int yes)
 	}
 }
 
-void do_BUG(const char *file, int line)
-{
-	bust_spinlocks(1);
-	printk("kernel BUG at %s:%d!\n", file, line);
-}
-
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 extern unsigned long idt;
 

-
