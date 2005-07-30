Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVG3Ro4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVG3Ro4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVG3Ro4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:44:56 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:15109 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261409AbVG3Roz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:44:55 -0400
Message-ID: <42EBBC43.3080803@vmware.com>
Date: Sat, 30 Jul 2005 10:43:31 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 2/6 i386 serialize-msr
References: <200507300404.j6U44GSC005922@zach-dev.vmware.com> <20050730103207.GD1942@elf.ucw.cz>
In-Reply-To: <20050730103207.GD1942@elf.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------030403070700070407040105"
X-OriginalArrivalTime: 30 Jul 2005 17:43:31.0234 (UTC) FILETIME=[33579820:01C5952E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030403070700070407040105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:

>Hi!
>
>  
>
>>i386 arch cleanup.  Introduce the serialize macro to serialize processor state.
>>Why the microcode update needs it I am not quite sure, since wrmsr() is already
>>a serializing instruction, but it is a microcode update, so I will keep the
>>semantic the same, since this could be a timing workaround.  As far as I can
>>tell, this has always been there since the original microcode update
>>source.
>>    
>>
>
>Can we get better name, like "serialize_cpu()"?
>									Pavel
>  
>

No objections to changing the name by me.  In fact, looks like serialize 
was a rather poor choice in the context of the microcode update source, 
since there are already references to lock based serialization right 
around the same code.  Updated comments as well.

Zach

--------------030403070700070407040105
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
+++ linux-2.6.13/arch/i386/kernel/microcode.c	2005-07-30 10:35:27.000000000 -0700
@@ -164,7 +164,8 @@
 	}
 
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* see 1.07.  Apprent chip bug */
+	serialize_cpu(); 
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], uci->rev);
 	pr_debug("microcode: collect_cpu_info : sig=0x%x, pf=0x%x, rev=0x%x\n",
@@ -377,7 +378,9 @@
 		(unsigned long) uci->mc->bits >> 16 >> 16);
 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* see 1.07.  Apprent chip bug */
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

--------------030403070700070407040105--
