Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVD1K7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVD1K7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 06:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD1K7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 06:59:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6104 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262024AbVD1K7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 06:59:23 -0400
Message-ID: <4270C213.80408@in.ibm.com>
Date: Thu, 28 Apr 2005 16:29:31 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][x86_64] Introducing the memmap= kernel command line option
References: <425F5BA3.3050001@in.ibm.com> <20050415173040.GK50241@muc.de>
In-Reply-To: <20050415173040.GK50241@muc.de>
Content-Type: multipart/mixed;
 boundary="------------020605020609080108060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605020609080108060206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andi,

Andi Kleen wrote:
> On Fri, Apr 15, 2005 at 11:43:55AM +0530, Hariprasad Nellitheertha wrote:
> 
>>Hi Andi,
>>
>>In order to port kdump to x86_64, we need to have the 
>>memmap= kernel command line option available. This is so 
>>that the dump-capture kernel can be booted with a custom 
>>memory map.
>>
>>The attached patch adds the memmap= functionality to the 
>>x86_64 kernel. It is against 2.6.12-rc2-mm3. I have done 
>>some amount of testing and it is working fine.
>>
>>Could you kindly review this patch and let me know your 
>>thoughts on it.
> 
> 
> You should add a __setup somewhere, otherwise the kernel
> will complain about unknown arguments or generate a memmap
> variable in inits environment. 

The memmap= option does not introduce any new variables that 
we would need at a later point of time. Its very similar in 
the way it handles the maps to the "mem=" option. Hence I 
have not added the __setup in the attached patch.

> 
> Comma parsing would be nice.

I have introduced comma parsing. The patch for doing the 
same in i386 follows in a separate patch.

Please review and let me know your comments.

Regards, Hari

--------------020605020609080108060206
Content-Type: text/plain;
 name="x8664-memmap-command-line-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x8664-memmap-command-line-option.patch"


This patch adds the 'memmap=' kernel command line option for the
x86_64 kernel.

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc2-hari/Documentation/kernel-parameters.txt |    2 
 linux-2.6.12-rc2-hari/arch/x86_64/kernel/e820.c           |   32 ++++++++++++++
 linux-2.6.12-rc2-hari/arch/x86_64/kernel/setup.c          |    3 +
 linux-2.6.12-rc2-hari/include/asm-x86_64/e820.h           |    2 
 4 files changed, 38 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/e820.c~x8664-memmap-command-line-option arch/x86_64/kernel/e820.c
--- linux-2.6.12-rc2/arch/x86_64/kernel/e820.c~x8664-memmap-command-line-option	2005-04-15 10:15:04.000000000 +0530
+++ linux-2.6.12-rc2-hari/arch/x86_64/kernel/e820.c	2005-04-27 16:27:45.000000000 +0530
@@ -513,6 +513,38 @@ void __init parse_memopt(char *p, char *
 	end_user_pfn >>= PAGE_SHIFT;	
 } 
 
+void __init parse_memmapopt(char *p, char **from)
+{
+	do {
+		if (!memcmp(p, "exactmap", 8)) {
+			p += 8;
+			e820.nr_map = 0;
+		} else {
+			unsigned long long start_at, mem_size;
+
+			mem_size = memparse(p, from);
+			p = *from;
+			if (*p == '@') {
+				start_at = memparse(p+1, from);
+				add_memory_region(start_at, mem_size, E820_RAM);
+			} else if (*p == '#') {
+				start_at = memparse(p+1, from);
+				add_memory_region(start_at, mem_size, E820_ACPI);
+			} else if (*p == '$') {
+				start_at = memparse(p+1, from);
+				add_memory_region(start_at, mem_size, E820_RESERVED);
+			} else {
+				end_user_pfn = (mem_size >> PAGE_SHIFT);
+			}
+			p = *from;
+		}
+		if (*p != ',')
+			break;
+		else
+			p += 1;
+	} while(1);
+}
+
 unsigned long pci_mem_start = 0xaeedbabe;
 
 /*
diff -puN arch/x86_64/kernel/setup.c~x8664-memmap-command-line-option arch/x86_64/kernel/setup.c
--- linux-2.6.12-rc2/arch/x86_64/kernel/setup.c~x8664-memmap-command-line-option	2005-04-15 10:15:04.000000000 +0530
+++ linux-2.6.12-rc2-hari/arch/x86_64/kernel/setup.c	2005-04-15 10:15:04.000000000 +0530
@@ -349,6 +349,9 @@ static __init void parse_cmdline_early (
 		if (!memcmp(from, "mem=", 4))
 			parse_memopt(from+4, &from); 
 
+		if (!memcmp(from, "memmap=", 7))
+			parse_memmapopt(from+7, &from);
+
 #ifdef CONFIG_DISCONTIGMEM
 		if (!memcmp(from, "numa=", 5))
 			numa_setup(from+5); 
diff -puN include/asm-x86_64/e820.h~x8664-memmap-command-line-option include/asm-x86_64/e820.h
--- linux-2.6.12-rc2/include/asm-x86_64/e820.h~x8664-memmap-command-line-option	2005-04-15 10:15:04.000000000 +0530
+++ linux-2.6.12-rc2-hari/include/asm-x86_64/e820.h	2005-04-15 10:15:04.000000000 +0530
@@ -54,6 +54,8 @@ extern void e820_setup_gap(void);
 
 extern void __init parse_memopt(char *p, char **end);
 
+extern void __init parse_memmapopt(char *p, char **end);
+
 extern struct e820map e820;
 #endif/*!__ASSEMBLY__*/
 
diff -puN Documentation/kernel-parameters.txt~x8664-memmap-command-line-option Documentation/kernel-parameters.txt
--- linux-2.6.12-rc2/Documentation/kernel-parameters.txt~x8664-memmap-command-line-option	2005-04-15 10:19:37.000000000 +0530
+++ linux-2.6.12-rc2-hari/Documentation/kernel-parameters.txt	2005-04-15 10:19:56.000000000 +0530
@@ -794,7 +794,7 @@ running once the system is up.
 	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
 			memory.
 
-	memmap=exactmap	[KNL,IA-32] Enable setting of an exact
+	memmap=exactmap	[KNL,IA-32,X86-64] Enable setting of an exact
 			E820 memory map, as specified by the user.
 			Such memmap=exactmap lines can be constructed based on
 			BIOS output or other requirements. See the memmap=nn@ss
_

--------------020605020609080108060206--
