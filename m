Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRKMUgf>; Tue, 13 Nov 2001 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRKMUgZ>; Tue, 13 Nov 2001 15:36:25 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:37195 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278808AbRKMUgL>; Tue, 13 Nov 2001 15:36:11 -0500
Date: Tue, 13 Nov 2001 15:36:10 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] current changes vs 2.4.15-pre4
Message-ID: <20011113153609.D17578@redhat.com>
In-Reply-To: <20011113022807.C14409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113022807.C14409@redhat.com>; from bcrl@redhat.com on Tue, Nov 13, 2001 at 02:28:07AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Slight update since, as Manfred pointed out, the Pentium and i486 leave the 
upper bits of the register undefined.  Later intel docs claim the upper 
bits are zeroed, but I don't know what to believe anymore.  Also, removing 
the inline asm that was a silly idea lets gcc generate better code:

c0106008:       0f 00 c8                str    %ax
...
c0106012:       25 e0 ff 00 00          and    $0xffe0,%eax
...
c0106023:       8b 34 c5 40 25 3c c0    mov    0xc03c2540(,%eax,8),%esi

As Alan says: "x86 is really just an instruction stream compression format".

		-ben


diff -ur tr.prev/include/asm-i386/smp.h tr-2.4.15-pre4/include/asm-i386/smp.h
--- tr.prev/include/asm-i386/smp.h	Tue Nov 13 15:00:40 2001
+++ tr-2.4.15-pre4/include/asm-i386/smp.h	Tue Nov 13 15:19:39 2001
@@ -117,7 +117,7 @@
 	 * function calls.  Fun!  -ben
 	 */
 	__asm__ ("str %w0" : "=r" (tr) : "m" (dummy_cpu_id));
-	return tr;
+	return tr & 0xffe0;	/* Pentiums leave the high bits undefined. */
 }
 
 #define smp_processor_id()	( (get_TR() >> 5) - (__FIRST_TSS_ENTRY >> 2) )
@@ -128,13 +128,8 @@
  */
 #define smp_per_cpu_data()	\
 	( (struct per_cpu_data *)					\
-	  ({	long idx;						\
-		__asm__("str %w0 ; shll %1,%0"				\
-			: "=r" (idx)					\
-			: "i" (LOG2_PER_CPU_SIZE - 5)			\
-			, "m" (dummy_cpu_id));				\
-		(long)&aligned_data + idx -				\
-			(__FIRST_TSS_ENTRY << (LOG2_PER_CPU_SIZE - 2)); }) )
+	  ( (get_TR() << (LOG2_PER_CPU_SIZE - 5)) + (long)&aligned_data \
+		- (__FIRST_TSS_ENTRY << (LOG2_PER_CPU_SIZE - 2)) ) )
 
 static __inline int hard_smp_processor_id(void)
 {
