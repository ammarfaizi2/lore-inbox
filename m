Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130642AbRBQKUm>; Sat, 17 Feb 2001 05:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130829AbRBQKUb>; Sat, 17 Feb 2001 05:20:31 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:26129 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130642AbRBQKUU>; Sat, 17 Feb 2001 05:20:20 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A8E3BA5.4B98E94E@yahoo.com>
Date: Sat, 17 Feb 2001 03:51:49 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.2-pre3 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] a more efficient BUG() macro
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was poking around in a vmlinux the other day and was surprised at the 
amount of repetitive crap text that was in there.  For example, try:

strings vmlinux|grep $PWD|wc -c

which gets some 70KB in my case - depends on strlen($PWD) obviously.  The 
culprit is BUG() in a static inline that is in a header file.  In this 
case cpp expands __FILE__ to the full path of the header file in question. 
(IIRC there is a __BASEFILE__ that would be a better choice than __FILE__)

There is also some 5 to 10k worth of "kernel BUG at %s:%d!\n" scattered 
through a typical vmlinux.  Note that neither of these show up in [b]zImage 
size since they compress to something like 99%, but they do cost memory once 
the kernel is booted.

Anyway this small patch makes sure there is only one "kernel BUG..." string,
and dumps __FILE__ in favour of an address value since System.map data is 
needed to make full use of the BUG() dump anyways.  The memory stats of two 
otherwise identical kernels:

Memory: 22004k/24576k available (1163k kernel code, 2184k reserved,
				 309k data, 64k init, 0k highmem)
Memory: 22076k/24576k available (1163k kernel code, 2112k reserved,
				 238k data, 64k init, 0k highmem)

so the lightweight BUG() nets a worthwhile (IMHO) saving of 72KB for this 
particular kernel. (Which is even more than the __init goodies recover.)
Patch is against 2.4.2pre3 and is fully contained within i386 files.
I can supply a 2.2.x version of the patch if there is demand for it.

Paul.


diff -ur linux~/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-g/arch/i386/kernel/i386_ksyms.c	Thu Jan 11 09:06:12 2001
+++ linux-g-bug/arch/i386/kernel/i386_ksyms.c	Thu Feb 15 03:50:18 2001
@@ -78,6 +78,7 @@
 EXPORT_SYMBOL_NOVERS(__down_write_failed);
 EXPORT_SYMBOL_NOVERS(__down_read_failed);
 EXPORT_SYMBOL_NOVERS(__rwsem_wake);
+EXPORT_SYMBOL_NOVERS(bugstring);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
diff -ur linux~/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-g/arch/i386/kernel/setup.c	Wed Feb 14 02:39:58 2001
+++ linux-g-bug/arch/i386/kernel/setup.c	Thu Feb 15 04:13:31 2001
@@ -105,6 +105,8 @@
 char ignore_irq13;		/* set if exception 16 works */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
+const char *bugstring="<1>kernel BUG at 0x%p\n";
+
 unsigned long mmu_cr4_features;
 
 /*
diff -ur linux~/include/asm-i386/page.h linux/include/asm-i386/page.h
--- linux-g/include/asm-i386/page.h	Sat Dec 16 04:02:20 2000
+++ linux-g-bug/include/asm-i386/page.h	Thu Feb 15 04:25:29 2001
@@ -86,10 +86,13 @@
  * Tell the user there is some problem. Beep too, so we can
  * see^H^H^Hhear bugs in early bootup as well!
  */
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+extern const char *bugstring;	/* ...is in i386/kernel/setup.c - Paul G. */
+#define BUG() ({ \
+	__label__ bugaddr;			\
+bugaddr:					\
+	printk(bugstring, &&bugaddr);		\
 	__asm__ __volatile__(".byte 0x0f,0x0b"); \
-} while (0)
+})
 
 #define PAGE_BUG(page) do { \
 	BUG(); \





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

