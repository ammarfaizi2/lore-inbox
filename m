Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRCSHvF>; Mon, 19 Mar 2001 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCSHu4>; Mon, 19 Mar 2001 02:50:56 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:32007 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S131365AbRCSHut>; Mon, 19 Mar 2001 02:50:49 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 19 Mar 2001 08:50:05 +0100
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-23159
Subject: 2.4.2: kernel patch for <asm-i386/delay.h>, nanosleep
Message-ID: <3AB5C83F.5913.2E5BFE@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-23159
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hello,

originally intended for my PPSkit patch I found out that the "normal" 
kernel might like this patch as well:

nanosleep() currently uses "udelay()" from <asm/delay.h> as there is no 
"ndelay()". I implemented "ndelay()" for i386 and adjusted the other 
macros. During that I found that some files have or use their own 
"delay()" routines. The original delay is dangerous, because depending 
on the CPU it requires loop cycles or clock cycles as argument, giving 
non-reliable code. Affected sources:

drivers/net/hamradio/yam.c: "delay(100)"
drivers/scsi/wd

I also found that the scaling factor used in the existing code should 
be rounded up (increased by one) for a more exact value.

With the new code there are two possible disadvantages: 1) Reduced 
accuracy, and 2) possible overflow. I hope both are not really a 
problem.

Regards,
Ulrich



--Message-Boundary-23159
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'ndelay24.diff'

Index: arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /root/LinuxCVS/Kernel/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 i386_ksyms.c
--- arch/i386/kernel/i386_ksyms.c	2001/03/11 13:51:19	1.1.1.3
+++ arch/i386/kernel/i386_ksyms.c	2001/03/17 18:08:20
@@ -82,9 +82,9 @@
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
-EXPORT_SYMBOL(__udelay);
+EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__const_sndelay);
 
 EXPORT_SYMBOL_NOVERS(__get_user_1);
 EXPORT_SYMBOL_NOVERS(__get_user_2);
Index: arch/i386/lib/delay.c
===================================================================
RCS file: /root/LinuxCVS/Kernel/arch/i386/lib/delay.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 delay.c
--- arch/i386/lib/delay.c	2001/01/08 20:17:36	1.1.1.2
+++ arch/i386/lib/delay.c	2001/03/17 18:12:36
@@ -64,16 +64,27 @@
 		__loop_delay(loops);
 }
 
-inline void __const_udelay(unsigned long xloops)
+/* convert scaled nanoseconds to execution loops and delay */
+inline void __const_sndelay(unsigned long scaled_nsecs)
 {
 	int d0;
 	__asm__("mull %0"
-		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
-        __delay(xloops * HZ);
+		:"=d" (scaled_nsecs), "=&a" (d0)
+		:"1" (scaled_nsecs),"0" (current_cpu_data.loops_per_jiffy));
+        __delay(scaled_nsecs * HZ);
 }
 
-void __udelay(unsigned long usecs)
+void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	/* 2**32 / 1000000000 == 4.2946... */
+	if (nsecs > NDELAY_LIMIT) {
+		static	int	complaints = 7;
+
+		if (complaints > 0) {
+			--complaints;
+			printk(KERN_ERR "__ndelay(%lu) exceeds limit\n", nsecs);
+		}
+		nsecs = NDELAY_LIMIT;
+	}
+	__const_sndelay((nsecs * 429) / 100);
 }
Index: include/asm-i386/delay.h
===================================================================
RCS file: /root/LinuxCVS/Kernel/include/asm-i386/delay.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 delay.h
--- include/asm-i386/delay.h	2001/01/08 20:22:29	1.1.1.2
+++ include/asm-i386/delay.h	2001/03/17 17:58:33
@@ -7,14 +7,19 @@
  * Delay routines calling functions in arch/i386/lib/delay.c
  */
  
-extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
 
-extern void __udelay(unsigned long usecs);
-extern void __const_udelay(unsigned long usecs);
-extern void __delay(unsigned long loops);
+extern void __ndelay(unsigned long nsecs);
+extern void __const_sndelay(unsigned long scaled_nsecs);
+extern void __delay(unsigned long xloops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
-	__udelay(n))
+#define	NDELAY_LIMIT	20000000	/* 20 ms (2 / HZ)? */
+
+#define ndelay(n) (__builtin_constant_p(n) ? \
+	((n) > NDELAY_LIMIT ? \
+		__bad_ndelay() : __const_sndelay(((n) * 429ul) / 100)) : \
+	__ndelay(n))
+
+#define udelay(n) ndelay(n * 1000)
 
 #endif /* defined(_I386_DELAY_H) */
Index: kernel/timer.c
===================================================================
RCS file: /root/LinuxCVS/Kernel/kernel/timer.c,v
retrieving revision 1.1.1.2.8.1
diff -u -r1.1.1.2.8.1 timer.c
--- kernel/timer.c	2001/03/11 15:29:17	1.1.1.2.8.1
+++ kernel/timer.c	2001/03/17 17:22:57
@@ -592,10 +592,11 @@
 		/*
 		 * Short delay requests up to 2 ms will be handled with
 		 * high precision by a busy wait for all real-time processes.
+		 * Anything else will be delayed for at least 1/HZ.
 		 *
 		 * Its important on SMP not to do this holding locks.
 		 */
-		udelay((t.tv_nsec + 999) / 1000);
+		ndelay(t.tv_nsec);
 		return 0;
 	}
 

--Message-Boundary-23159--
