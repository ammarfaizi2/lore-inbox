Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSBLXNp>; Tue, 12 Feb 2002 18:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291245AbSBLXNZ>; Tue, 12 Feb 2002 18:13:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291243AbSBLXNR>;
	Tue, 12 Feb 2002 18:13:17 -0500
Message-ID: <3C69A159.2BF483FF@zip.com.au>
Date: Tue, 12 Feb 2002 15:12:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
CC: Hugh Dickins <hugh@veritas.com>
Subject: [patch] make BUG preserve registers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Final version (I hope) of the BUG patch.  It still
will offend the disassembler (sorry, Hugh).

CONFIG_DEBUG_BUGVERBOSE has disappeared again.

--- linux-2.4.18-pre9/include/asm-i386/page.h	Thu Feb  7 13:04:22 2002
+++ linux-akpm/include/asm-i386/page.h	Tue Feb 12 01:05:46 2002
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
--- linux-2.4.18-pre9/arch/i386/kernel/traps.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/arch/i386/kernel/traps.c	Tue Feb 12 01:08:32 2002
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
--- linux-2.4.18-pre9/arch/i386/kernel/i386_ksyms.c	Thu Feb  7 13:04:11 2002
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Tue Feb 12 01:05:46 2002
@@ -168,9 +168,5 @@ EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-EXPORT_SYMBOL(do_BUG);
-#endif
-
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
--- linux-2.4.18-pre9/arch/i386/config.in	Thu Feb  7 13:04:11 2002
+++ linux-akpm/arch/i386/config.in	Tue Feb 12 01:05:46 2002
@@ -421,7 +421,6 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
-   bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
 endmenu
--- linux-2.4.18-pre9/arch/i386/mm/fault.c	Thu Feb  7 13:04:11 2002
+++ linux-akpm/arch/i386/mm/fault.c	Tue Feb 12 01:05:46 2002
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
