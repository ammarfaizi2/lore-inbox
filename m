Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272116AbRHVU4X>; Wed, 22 Aug 2001 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272117AbRHVU4M>; Wed, 22 Aug 2001 16:56:12 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:3746
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272116AbRHVU4G>; Wed, 22 Aug 2001 16:56:06 -0400
Message-ID: <3B841CC3.E7040002@nortelnetworks.com>
Date: Wed, 22 Aug 2001 16:57:39 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (comments requested) adding finer-grained timing to PPC 
 add_timer_randomness()
Content-Type: multipart/mixed;
 boundary="------------E2B174322316AF30D3A7BCF9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E2B174322316AF30D3A7BCF9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I'd like some comments on the following patch.

This patch is designed to add finer-grained timing (similar to the i386 timing)
to add_timer_randomness().  The only tricky bit is that the PPC601 doesn't
support the timebase registers.  Accordingly, I've added a flag to the PPC port
that is used to keep track of whether or not the processor supports the timebase
register.

Is there a better way to keep track of this information?  i386 has a struct with
useful information stored, but it doesn't look like PPC does.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
--------------E2B174322316AF30D3A7BCF9
Content-Type: text/plain; charset=us-ascii;
 name="random.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="random.patch"

diff -ru linux-2.2.19-clean/arch/ppc/kernel/setup.c linux-2.2.19/arch/ppc/kernel/setup.c
--- linux-2.2.19-clean/arch/ppc/kernel/setup.c	Sun Mar 25 11:31:49 2001
+++ linux-2.2.19/arch/ppc/kernel/setup.c	Wed Aug 22 16:34:51 2001
@@ -103,6 +103,14 @@
 unsigned long vgacon_remap_base;
 #endif
 
+/* the PPC601 chip does not support timebase registers,
+ * so this is used to keep track of whether or not we 
+ * support them
+ */
+#ifdef CONFIG_6xx
+extern int have_timebase = 1;
+#endif /* CONFIG_6xx */
+
 /* copy of the residual data */
 #ifndef CONFIG_MBX
 unsigned char __res[sizeof(RESIDUAL)] __prepdata = {0,};
@@ -243,6 +251,7 @@
 		{
 		case 1:
 			len += sprintf(len+buffer, "601\n");
+			have_timebase = 0;
 			break;
 		case 3:
 			len += sprintf(len+buffer, "603\n");
diff -ru linux-2.2.19-clean/drivers/char/random.c linux-2.2.19/drivers/char/random.c
--- linux-2.2.19-clean/drivers/char/random.c	Sun Mar 25 11:31:25 2001
+++ linux-2.2.19/drivers/char/random.c	Wed Aug 22 16:35:34 2001
@@ -699,6 +699,7 @@
  * are used for a high-resolution timer.
  *
  */
+ 
 static void add_timer_randomness(struct random_bucket *r,
 				 struct timer_rand_state *state, unsigned num)
 {
@@ -715,6 +716,16 @@
 			:"=a" (time), "=d" (high));
 		num ^= high;
 	} else {
+		time = jiffies;
+	}
+#elif defined (CONFIG_6xx)
+	if (have_timebase) {
+		__u32 high;
+		__asm__ __volatile__("mftbu %0" : "=r" (high) : );
+		__asm__ __volatile__("mftb %0" : "=r" (time) : );
+		num ^= high;
+	}
+	else {
 		time = jiffies;
 	}
 #else
diff -ru linux-2.2.19-clean/include/asm-ppc/processor.h linux-2.2.19/include/asm-ppc/processor.h
--- linux-2.2.19-clean/include/asm-ppc/processor.h	Sun Mar 25 11:31:08 2001
+++ linux-2.2.19/include/asm-ppc/processor.h	Wed Aug 22 16:34:51 2001
@@ -216,6 +216,14 @@
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 void release_thread(struct task_struct *);
 
+/* the PPC601 chip does not support timebase registers,
+ * so this is used to keep track of whether or not we 
+ * support them
+ */
+#ifdef CONFIG_6xx
+extern int have_timebase;
+#endif /* CONFIG_6xx */
+
 /*
  * Create a new kernel thread.
  */

--------------E2B174322316AF30D3A7BCF9--

