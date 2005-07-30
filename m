Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVG3SAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVG3SAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVG3R6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:58:35 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:36869 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S263089AbVG3R5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:57:14 -0400
Message-ID: <42EBBF26.3070101@vmware.com>
Date: Sat, 30 Jul 2005 10:55:50 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, akpm@osdl.org, chrisl@vmware.com,
       davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 2/6 i386 serialize-msr
References: <200507300404.j6U44GSC005922@zach-dev.vmware.com> <20050730103207.GD1942@elf.ucw.cz> <42EBBC43.3080803@vmware.com> <Pine.LNX.4.61.0507301157530.29844@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0507301157530.29844@montezuma.fsmlabs.com>
Content-Type: multipart/mixed;
 boundary="------------090503070909010902020205"
X-OriginalArrivalTime: 30 Jul 2005 17:55:48.0718 (UTC) FILETIME=[EAEAB8E0:01C5952F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503070909010902020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

'Apparently' I need to make some coffee :)

Zwane Mwaikambo wrote:

> 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
>-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
>+	/* see 1.07.  Apprent chip bug */
>+	serialize_cpu(); 
>
>1.07 in which document? Also, please just spell 'apparent' correctly, 
>saving 1 byte really just looks lazy.
>
>  
>


--------------090503070909010902020205
Content-Type: text/plain;
 name="serialize-msr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serialize-msr"

i386 arch cleanup.  Introduce the serialize macro to serialize processor state.
Why the microcode update needs it I am not quite sure, since wrmsr() is already
a serializing instruction, but it is a microcode update, so I will keep the
semantic the same, since this could be a timing workaround.  As far as I can
tell, this has always been there since the original microcode update source.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/microcode.c	2005-07-29 15:26:04.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/microcode.c	2005-07-30 10:55:02.000000000 -0700
@@ -164,7 +164,8 @@
 	}
 
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* see notes above for revision 1.07.  Apparent chip bug */
+	serialize_cpu(); 
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], uci->rev);
 	pr_debug("microcode: collect_cpu_info : sig=0x%x, pf=0x%x, rev=0x%x\n",
@@ -377,7 +378,9 @@
 		(unsigned long) uci->mc->bits >> 16 >> 16);
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* see notes above for revision 1.07.  Apparent chip bug */
+	serialize_cpu(); 
+
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
 
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-07-29 15:26:53.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-07-30 10:32:44.000000000 -0700
@@ -277,6 +277,11 @@
 	outb((data), 0x23); \
 } while (0)
 
+static inline void serialize_cpu(void)
+{
+	 __asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+}
+
 static inline void __monitor(const void *eax, unsigned long ecx,
 		unsigned long edx)
 {

--------------090503070909010902020205--
