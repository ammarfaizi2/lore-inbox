Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSFHPhg>; Sat, 8 Jun 2002 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSFHPhf>; Sat, 8 Jun 2002 11:37:35 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:9611 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317406AbSFHPhe>; Sat, 8 Jun 2002 11:37:34 -0400
Message-ID: <3D0223AD.4030208@quark.didntduck.org>
Date: Sat, 08 Jun 2002 11:33:01 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing GET_CPU_IDX in i386 entry.S
Content-Type: multipart/mixed;
 boundary="------------050106080605090804080607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050106080605090804080607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

resume_kernel uses CPU_IDX but never uses GET_CPU_IDX to get the index. 
  This is an issue when smp and preemption are both enabled.  I also 
removed the unused GET_CURRENT_CPU_IDX.

--
				Brian Gerst

--------------050106080605090804080607
Content-Type: text/plain;
 name="cpu_idx-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_idx-1"

diff -urN linux-bk/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-bk/arch/i386/kernel/entry.S	Wed May 29 15:06:00 2002
+++ linux/arch/i386/kernel/entry.S	Sat Jun  8 10:44:44 2002
@@ -83,13 +83,9 @@
 #define GET_CPU_IDX \
 		movl TI_CPU(%ebx), %eax;  \
 		shll $irq_array_shift, %eax
-#define GET_CURRENT_CPU_IDX \
-		GET_THREAD_INFO(%ebx); \
-		GET_CPU_IDX
 #define CPU_IDX (,%eax)
 #else
 #define GET_CPU_IDX
-#define GET_CURRENT_CPU_IDX GET_THREAD_INFO(%ebx)
 #define CPU_IDX
 #endif
 
@@ -236,6 +232,7 @@
 	movl TI_FLAGS(%ebx), %ecx
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
+	GET_CPU_IDX
 	movl irq_stat+local_bh_count CPU_IDX, %ecx
 	addl irq_stat+local_irq_count CPU_IDX, %ecx
 	jnz restore_all

--------------050106080605090804080607--

