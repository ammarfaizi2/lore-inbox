Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUEGUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUEGUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUEGUVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:21:31 -0400
Received: from mail.aknet.ru ([217.67.122.194]:14343 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261913AbUEGUMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:12:35 -0400
Message-ID: <409BE997.709@aknet.ru>
Date: Fri, 07 May 2004 23:55:03 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040410
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch][rfc] Larger IO bitmap
Content-Type: multipart/mixed;
 boundary="------------080305050809010007060602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------080305050809010007060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello.

This topic was already discussed many times
on that list and it seems there was not too
much opposition to enlarging the IO bitmap.

The previous discussion was started here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.0/0477.html
but in 2.4 times this was kind of problematic.

Now, with the lazy bitmap allocation and
per-CPU TSS, this will really not drain any
resources I think. 8K TSS increase and 8K
per process *that does ioperm()* - I think
it is not very bad.
The reasons why I need that, are described
in the URL above. Basically this will
allow to use full-screen VESA under dosemu
(without LFB though), and this may be also
helpfull for the XFree project and some
other projects:
http://www.uwsg.iu.edu/hypermail/linux/kernel/9807.1/1079.html

I made the patch, it seems to work well.
It is attached. I am wondering are there
any chances to ever get that in? Or why
not? It can also be made as a config
option, but taking the lazy allocation
into account, I think this is not really
necessary. But I can do that if needed.

So would it be possible to ever have the
full IO bitmap under linux, or the current
solution is permanent?

--------------080305050809010007060602
Content-Type: text/plain;
 name="iobitm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iobitm.diff"


--- linux/include/asm-i386/desc.h	2004-01-09 09:59:02.000000000 +0300
+++ linux/include/asm-i386/desc.h	2004-03-15 12:35:33.000000000 +0300
@@ -44,7 +44,8 @@
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr, 235, 0x89);
+	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr,
+		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
 }
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
--- linux/include/asm-i386/processor.h	2004-01-09 09:59:06.000000000 +0300
+++ linux/include/asm-i386/processor.h	2004-03-15 13:51:13.317081840 +0300
@@ -302,9 +302,9 @@
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
 
 /*
- * Size of io_bitmap, covering ports 0 to 0x3ff.
+ * Size of io_bitmap.
  */
-#define IO_BITMAP_BITS  1024
+#define IO_BITMAP_BITS  65536
 #define IO_BITMAP_BYTES (IO_BITMAP_BITS/8)
 #define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
@@ -396,7 +396,7 @@
 	/*
 	 * pads the TSS to be cacheline-aligned (size is 0x100)
 	 */
-	unsigned long __cacheline_filler[5];
+	unsigned long __cacheline_filler[37];
 	/*
 	 * .. and then another 0x100 bytes for emergency kernel stack
 	 */
--- linux/include/asm-mips/processor.h	2004-01-09 09:59:05.000000000 +0300
+++ linux/include/asm-mips/processor.h	2004-03-15 13:47:05.602740144 +0300
@@ -172,9 +172,9 @@
 #endif
 
 /*
- * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
+ * Size of io_bitmap in longwords.
  */
-#define IO_BITMAP_SIZE	32
+#define IO_BITMAP_SIZE	2048
 
 #define NUM_FPU_REGS	32
 
--- linux/include/asm-i386_64/processor.h	2004-02-02 13:22:51.000000000 +0300
+++ linux/include/asm-i386_64/processor.h	2004-03-15 13:47:46.174572288 +0300
@@ -179,9 +179,9 @@
 	(test_thread_flag(TIF_IA32) ? TASK_UNMAPPED_32 : TASK_UNMAPPED_64)  
 
 /*
- * Size of io_bitmap, covering ports 0 to 0x3ff.
+ * Size of io_bitmap.
  */
-#define IO_BITMAP_BITS  1024
+#define IO_BITMAP_BITS  65536
 #define IO_BITMAP_BYTES (IO_BITMAP_BITS/8)
 #define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)

--------------080305050809010007060602
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------080305050809010007060602--
