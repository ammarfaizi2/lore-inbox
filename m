Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbTCGIOY>; Fri, 7 Mar 2003 03:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbTCGIOY>; Fri, 7 Mar 2003 03:14:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19706 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261423AbTCGIOW>;
	Fri, 7 Mar 2003 03:14:22 -0500
Message-ID: <3E68573A.4020206@mvista.com>
Date: Fri, 07 Mar 2003 00:24:26 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>	<3E67DF8E.9080005@mvista.com>	<15975.62823.5398.712934@napali.hpl.hp.com>	<3E67F844.2090902@mvista.com> <15975.63734.837748.29150@napali.hpl.hp.com>
In-Reply-To: <15975.63734.837748.29150@napali.hpl.hp.com>
Content-Type: multipart/mixed;
 boundary="------------090100030705000404040100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------090100030705000404040100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Mosberger wrote:
>>>>>>On Thu, 06 Mar 2003 17:39:16 -0800, george anzinger <george@mvista.com> said:
> 
> 
>   George> Ok, I will fix all the above and shoot you a patch.  I
>   George> assume you can test it on a 64-bit platform.  Right?
> 
The patch to fix idr is attached.  Cleans up the int/long confusion 
and also rearranges a couple of structures to honor the sizes involved.

> Sure, except I don't have a test-program. ;-)
> 
That is why you should visit the High-res-timers web site (see URL 
below) and get the "support" patch.  It installs in you kernel tree at 
.../Documentation/high-res-timers/ and has test programs as well as 
man pages, readme files etc.

By the way, I am seeing some reports from the clock_nanosleep test 
about sleeping too long or too short.  The too long appears to be just 
not being able to preempt what ever else is running.  The too short 
(on the x86) is, I believe, due to the fact that more that 1/HZ is 
clocked on the wall clock each jiffie.

Try this:

time sleep 60

On the x86 it reports less than 60, NOT good.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------090100030705000404040100
Content-Type: text/plain;
 name="hrtimer-64bit-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimer-64bit-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/linux/idr.h linux/include/linux/idr.h
--- linux-2.5.64-kb/include/linux/idr.h	2003-03-05 15:09:48.000000000 -0800
+++ linux/include/linux/idr.h	2003-03-06 18:04:26.000000000 -0800
@@ -25,9 +25,12 @@
 
 #define IDR_MASK ((1 << IDR_BITS)-1)
 
-/* Leave the possibility of an incomplete final layer */
-#define MAX_LEVEL (BITS_PER_LONG - RESERVED_ID_BITS + IDR_BITS - 1) / IDR_BITS
-#define MAX_ID_SHIFT (BITS_PER_LONG - RESERVED_ID_BITS)
+/* Leave the possibility of an incomplete final layer 
+ * Note we will return a 32-bit int, not a long, thus the
+ * 32 below
+*/
+#define MAX_LEVEL (32 - RESERVED_ID_BITS + IDR_BITS - 1) / IDR_BITS
+#define MAX_ID_SHIFT (32 - RESERVED_ID_BITS)
 #define MAX_ID_BIT (1L << MAX_ID_SHIFT)
 #define MAX_ID_MASK (MAX_ID_BIT - 1)
 
@@ -36,15 +39,15 @@
 
 struct idr_layer {
 	unsigned long	        bitmap;     // A zero bit means "space here"
-	int                     count;      // When zero, we can release it
 	struct idr_layer       *ary[1<<IDR_BITS];
+	int                     count;      // When zero, we can release it
 };
 
 struct idr {
 	struct idr_layer *top;
-	int		  layers;
-	long		  count;
 	struct idr_layer *id_free;
+	long		  count;
+	int		  layers;
 	int               id_free_cnt;
 	spinlock_t        lock;
 };
Binary files linux-2.5.64-kb/lib/gen_crc32table and linux/lib/gen_crc32table differ
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/lib/idr.c linux/lib/idr.c
--- linux-2.5.64-kb/lib/idr.c	2003-03-05 15:09:50.000000000 -0800
+++ linux/lib/idr.c	2003-03-06 18:04:29.000000000 -0800
@@ -150,7 +150,7 @@
 
 static inline int sub_alloc(struct idr *idp, int shift, void *ptr)
 {
-	long n, v = 0;
+	int n, v = 0;
 	struct idr_layer *p;
 	struct idr_layer **pa[MAX_LEVEL];
 	struct idr_layer ***paa = &pa[0];
@@ -211,7 +211,7 @@
 
 int idr_get_new(struct idr *idp, void *ptr)
 {
-	long v;
+	int v;
 	
 	if (idp->id_free_cnt < idp->layers + 1) 
 		return (-1);
Binary files linux-2.5.64-kb/scripts/docproc and linux/scripts/docproc differ
Binary files linux-2.5.64-kb/scripts/fixdep and linux/scripts/fixdep differ
Binary files linux-2.5.64-kb/scripts/kallsyms and linux/scripts/kallsyms differ
Binary files linux-2.5.64-kb/scripts/mk_elfconfig and linux/scripts/mk_elfconfig differ
Binary files linux-2.5.64-kb/scripts/modpost and linux/scripts/modpost differ
Binary files linux-2.5.64-kb/usr/gen_init_cpio and linux/usr/gen_init_cpio differ
Binary files linux-2.5.64-kb/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------090100030705000404040100--

