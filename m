Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSKRT3y>; Mon, 18 Nov 2002 14:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSKRT2r>; Mon, 18 Nov 2002 14:28:47 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:62629 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264749AbSKRTYy> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (14/16): warnings.
Date: Mon, 18 Nov 2002 20:22:58 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182022.58758.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings.

diff -urN linux-2.5.48/arch/s390/kernel/smp.c linux-2.5.48-s390/arch/s390/kernel/smp.c
--- linux-2.5.48/arch/s390/kernel/smp.c	Mon Nov 18 05:29:20 2002
+++ linux-2.5.48-s390/arch/s390/kernel/smp.c	Mon Nov 18 20:12:06 2002
@@ -274,7 +274,7 @@
 
 void do_ext_call_interrupt(struct pt_regs *regs, __u16 code)
 {
-        int bits;
+        unsigned long bits;
 
         /*
          * handle bit signal external calls
@@ -282,9 +282,7 @@
          * For the ec_schedule signal we have to do nothing. All the work
          * is done automatically when we return from the interrupt.
          */
-        do {
-                bits = atomic_read(&S390_lowcore.ext_call_fast);
-        } while (atomic_compare_and_swap(bits,0,&S390_lowcore.ext_call_fast));
+	bits = xchg(&S390_lowcore.ext_call_fast, 0);
 
 	if (test_bit(ec_call_function, &bits)) 
 		do_call_function();
@@ -296,13 +294,12 @@
  */
 static sigp_ccode smp_ext_bitcall(int cpu, ec_bit_sig sig)
 {
-        struct _lowcore *lowcore = lowcore_ptr[cpu];
         sigp_ccode ccode;
 
         /*
          * Set signaling bit in lowcore of target cpu and kick it
          */
-        atomic_set_mask(1<<sig, &lowcore->ext_call_fast);
+	set_bit(sig, (unsigned long *) &lowcore_ptr[cpu]->ext_call_fast);
         ccode = signal_processor(cpu, sigp_external_call);
         return ccode;
 }
@@ -323,7 +320,7 @@
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
                  */
-                atomic_set_mask(1<<sig, &lowcore->ext_call_fast);
+		set_bit(sig, (unsigned long *) &lowcore_ptr[i]->ext_call_fast);
                 while (signal_processor(i, sigp_external_call) == sigp_busy)
 			udelay(10);
         }
diff -urN linux-2.5.48/arch/s390/kernel/time.c linux-2.5.48-s390/arch/s390/kernel/time.c
--- linux-2.5.48/arch/s390/kernel/time.c	Mon Nov 18 05:29:20 2002
+++ linux-2.5.48-s390/arch/s390/kernel/time.c	Mon Nov 18 20:12:06 2002
@@ -140,7 +140,6 @@
  */
 static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
 {
-	int cpu = smp_processor_id();
 	__u64 tmp;
 	__u32 ticks;
 
diff -urN linux-2.5.48/arch/s390/mm/init.c linux-2.5.48-s390/arch/s390/mm/init.c
--- linux-2.5.48/arch/s390/mm/init.c	Mon Nov 18 05:29:51 2002
+++ linux-2.5.48-s390/arch/s390/mm/init.c	Mon Nov 18 20:12:06 2002
@@ -188,7 +188,7 @@
 		free_page(addr);
 		totalram_pages++;
         }
-        printk ("Freeing unused kernel memory: %dk freed\n",
+        printk ("Freeing unused kernel memory: %ldk freed\n",
 		((unsigned long)&__init_end - (unsigned long)&__init_begin) >> 10);
 }
 
diff -urN linux-2.5.48/arch/s390x/kernel/time.c linux-2.5.48-s390/arch/s390x/kernel/time.c
--- linux-2.5.48/arch/s390x/kernel/time.c	Mon Nov 18 05:29:52 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/time.c	Mon Nov 18 20:12:06 2002
@@ -126,7 +126,6 @@
  */
 static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
 {
-	int cpu = smp_processor_id();
 	__u64 tmp;
 	__u32 ticks;
 
diff -urN linux-2.5.48/include/asm-s390/lowcore.h linux-2.5.48-s390/include/asm-s390/lowcore.h
--- linux-2.5.48/include/asm-s390/lowcore.h	Mon Nov 18 05:29:45 2002
+++ linux-2.5.48-s390/include/asm-s390/lowcore.h	Mon Nov 18 20:12:06 2002
@@ -136,7 +136,7 @@
 
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xc80 */
-	atomic_t     ext_call_fast;            /* 0xc88 */
+	__u32        ext_call_fast;            /* 0xc88 */
         __u8         pad11[0xe00-0xc8c];       /* 0xc8c */
 
         /* 0xe00 is used as indicator for dump tools */

