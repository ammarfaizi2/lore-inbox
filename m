Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277572AbRJHWgz>; Mon, 8 Oct 2001 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277570AbRJHWgq>; Mon, 8 Oct 2001 18:36:46 -0400
Received: from t2.redhat.com ([199.183.24.243]:62192 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277577AbRJHWgf>; Mon, 8 Oct 2001 18:36:35 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BC1FE35.2050704@zk3.dec.com> 
In-Reply-To: <3BC1FE35.2050704@zk3.dec.com>  <15294.16913.2117.383987@cargo.ozlabs.ibm.com> <1573466920.1002300846@mbligh.des.sequent.com> <15294.24873.866942.423260@cargo.ozlabs.ibm.com> 
To: Peter Rival <frival@zk3.dec.com>
Cc: paulus@samba.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 23:36:26 +0100
Message-ID: <13962.1002580586@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While we're on the subject of stupidly named routines and x86-isms, I'm 
having trouble reconciling this text in Documentation/cachetlb.txt:

	1) void flush_cache_all(void)

	        The most severe flush of all.  After this interface runs,
	        the entire cpu cache is flushed.

... with this implementation in include/asm-i386/pgtable.h:

	#define flush_cache_all()			do { } while (0)

That really doesn't seem to be doing what it says on the tin.

Some people have asserted, falsely, that it's never sane to want an i386 to
flush its cache. Even if that were true, it wouldn't really be an excuse for
the above discrepancy.

It's probably too late to fix it - this function seems to have evolved
completely undocumented and different semantics, and many architectures now
have a NOP implementation of it. Maybe we need to introduce a new call which
actually _does_ flush the cache, called simon_says_flush_cache_all() ?


Index: Documentation/cachetlb.txt
===================================================================
RCS file: /inst/cvs/linux/Documentation/Attic/cachetlb.txt,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 cachetlb.txt
--- Documentation/cachetlb.txt	2001/04/05 14:06:40	1.1.2.6
+++ Documentation/cachetlb.txt	2001/10/08 22:29:25
@@ -163,6 +163,11 @@
 	This is usually invoked when the kernel page tables are
 	changed, since such translations are "global" in nature.
 
+	NB. Some architecture maintainers have decided that their
+	architecture should treat this call as a NOP. Those 
+	architectures may implement simon_says_flush_cache_all()
+	which actually does as it's told. YMMV.
+
 2) void flush_cache_mm(struct mm_struct *mm)
 
 	This interface flushes an entire user address space from
Index: arch/i386/kernel/mtrr.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/kernel/mtrr.c,v
retrieving revision 1.2.2.30
diff -u -r1.2.2.30 mtrr.c
--- arch/i386/kernel/mtrr.c	2001/09/22 17:36:09	1.2.2.30
+++ arch/i386/kernel/mtrr.c	2001/10/08 22:29:25
@@ -394,13 +394,13 @@
 	write_cr4(ctxt->cr4val & (unsigned char) ~(1<<7));
     }
 
-    /*  Disable and flush caches. Note that wbinvd flushes the TLBs as
-	a side-effect  */
+    /*  Disable and flush caches. Note that simon_says_flush_cache_all
+	flushes the TLBs as a side-effect  */
     {
 	unsigned int cr0 = read_cr0() | 0x40000000;
-	wbinvd();
+	simon_says_flush_cache_all();
 	write_cr0( cr0 );
-	wbinvd();
+	simon_says_flush_cache_all();
     }
 
     if ( mtrr_if == MTRR_IF_INTEL ) {
@@ -424,7 +424,7 @@
     }
 
     /*  Flush caches and TLBs  */
-    wbinvd();
+    simon_says_flush_cache_all();
 
     /*  Restore MTRRdefType  */
     if ( mtrr_if == MTRR_IF_INTEL ) {
@@ -784,7 +784,7 @@
      *	The writeback rule is quite specific. See the manual. Its
      *	disable local interrupts, write back the cache, set the mtrr
      */
-	wbinvd();
+	simon_says_flush_cache_all();
 	wrmsr (MSR_K6_UWCCR, regs[0], regs[1]);
     if (do_safe) set_mtrr_done (&ctxt);
 }   /*  End Function amd_set_mtrr_up  */
Index: arch/i386/kernel/setup.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/kernel/setup.c,v
retrieving revision 1.4.2.70
diff -u -r1.4.2.70 setup.c
--- arch/i386/kernel/setup.c	2001/10/08 16:25:04	1.4.2.70
+++ arch/i386/kernel/setup.c	2001/10/08 22:29:25
@@ -1213,7 +1213,7 @@
 					unsigned long flags;
 					l=(1<<0)|((mbytes/4)<<1);
 					local_irq_save(flags);
-					wbinvd();
+					simon_says_flush_cache_all();
 					wrmsr(MSR_K6_WHCR, l, h);
 					local_irq_restore(flags);
 					printk(KERN_INFO "Enabling old style K6 write allocation for %d Mb\n",
@@ -1234,7 +1234,7 @@
 					unsigned long flags;
 					l=((mbytes>>2)<<22)|(1<<16);
 					local_irq_save(flags);
-					wbinvd();
+					simon_says_flush_cache_all();
 					wrmsr(MSR_K6_WHCR, l, h);
 					local_irq_restore(flags);
 					printk(KERN_INFO "Enabling new style K6 write allocation for %d Mb\n",
Index: drivers/acpi/hardware/hwsleep.c
===================================================================
RCS file: /inst/cvs/linux/drivers/acpi/hardware/Attic/hwsleep.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 hwsleep.c
--- drivers/acpi/hardware/hwsleep.c	2001/09/23 20:45:20	1.1.2.4
+++ drivers/acpi/hardware/hwsleep.c	2001/10/08 22:29:25
@@ -199,7 +199,7 @@
 
 	/* flush caches */
 
-	wbinvd();
+	simon_says_flush_cache_all();
 
 	/* write #2: SLP_TYP + SLP_EN */
 
Index: drivers/acpi/include/platform/acgcc.h
===================================================================
RCS file: /inst/cvs/linux/drivers/acpi/include/platform/Attic/acgcc.h,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 acgcc.h
--- drivers/acpi/include/platform/acgcc.h	2001/09/23 20:45:20	1.1.2.3
+++ drivers/acpi/include/platform/acgcc.h	2001/10/08 22:29:25
@@ -39,7 +39,6 @@
 #define BREAKPOINT3
 #define disable() __cli()
 #define enable()  __sti()
-#define wbinvd()
 
 /*! [Begin] no source code translation */
 
@@ -101,7 +100,6 @@
 #define disable() __cli()
 #define enable()  __sti()
 #define halt()    __asm__ __volatile__ ("sti; hlt":::"memory")
-#define wbinvd()  __asm__ __volatile__ ("wbinvd":::"memory")
 
 /*! [Begin] no source code translation
  *
Index: include/asm-i386/system.h
===================================================================
RCS file: /inst/cvs/linux/include/asm-i386/system.h,v
retrieving revision 1.2.2.19
diff -u -r1.2.2.19 system.h
--- include/asm-i386/system.h	2001/09/07 11:08:42	1.2.2.19
+++ include/asm-i386/system.h	2001/10/08 22:29:26
@@ -124,7 +124,7 @@
 
 #endif	/* __KERNEL__ */
 
-#define wbinvd() \
+#define simon_says_flush_cache_all() \
 	__asm__ __volatile__ ("wbinvd": : :"memory");
 
 static inline unsigned long get_limit(unsigned long segment)

--
dwmw2


