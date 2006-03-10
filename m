Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752238AbWCJWm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbWCJWm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbWCJWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:42:29 -0500
Received: from smtp-out.google.com ([216.239.45.12]:48326 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752238AbWCJWm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:42:28 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
	b=pUgJAPctGYESuegl7SpbEOXxHuNR6/OYCu5YNBpWvgzon8N9WIdxt240b75bC5Oyd
	EA54/Q3TiTIKAcO30Q1VA==
Message-ID: <441200C4.8040502@google.com>
Date: Fri, 10 Mar 2006 14:42:12 -0800
From: Markus Gutschke <markus@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, dkegel@google.com
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode
 on i386 (updated patch)
References: <4410BB32.1020905@google.com>	<20060309184759.591e3551.akpm@osdl.org>	<4410EC8A.4020808@google.com> <20060309192232.2fd4767c.akpm@osdl.org>
In-Reply-To: <20060309192232.2fd4767c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090808030906060907030309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808030906060907030309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

From: Markus Gutschke <markus@google.com>

Gcc reserves %ebx when compiling position-independent-code on i386. This 
means, the _syscallX() macros in include/asm-i386/unistd.h will not 
compile. This patch is against 2.6.15.6 and changes the existing macros 
to take special care to preserve %ebx.

The bug can be tracked at http://bugzilla.kernel.org/show_bug.cgi?id=6204

Signed-off-by: Markus Gutschke <markus@google.com>

---

Andrew Morton wrote:
> Markus Gutschke <markus@google.com> wrote:
>>That is certainly possible. The new macros work in both modes, but they 
>>are slightly less efficient than the old macros, if you have access to 
>>%ebx (i.e. in non-PIC code). If you prefer, we could just remove the old 
>>macros and unconditionally replace them with the new ones. 
> 
> I'd be OK with that - the kernel doesn't (shouldn't) care about the
> performance of __KERNEL_SYSCALLS__ stuff.  I doubt if glibc is borrowing
> the kernel's macros.

Would you like this patch better? It now unconditionally replaces the 
old macros with a fixed version. This will entail a minor performance 
penalty in non-PIC mode. But for the vast majority of applications the 
difference should be entire negligible.

Once this change has made it into the kernel, I will try to get it 
propagated into libc.


Markus

--------------090808030906060907030309
Content-Type: text/x-patch;
 name="unistd.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unistd.h.diff"

--- linux-2.6.15.6/include/asm-i386/unistd.h.orig	2006-03-05 11:07:54.000000000 -0800
+++ linux-2.6.15.6/include/asm-i386/unistd.h	2006-03-10 14:33:10.000000000 -0800
@@ -330,9 +330,9 @@
 type name(type1 arg1) \
 { \
 long __res; \
-__asm__ volatile ("int $0x80" \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
 	: "=a" (__res) \
-	: "0" (__NR_##name),"b" ((long)(arg1)) : "memory"); \
+	: "0" (__NR_##name),"ri" ((long)(arg1)) : "memory"); \
 __syscall_return(type,__res); \
 }
 
@@ -340,9 +340,10 @@
 type name(type1 arg1,type2 arg2) \
 { \
 long __res; \
-__asm__ volatile ("int $0x80" \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
 	: "=a" (__res) \
-	: "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)) : "memory"); \
+	: "0" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)) \
+	: "memory"); \
 __syscall_return(type,__res); \
 }
 
@@ -350,9 +351,9 @@
 type name(type1 arg1,type2 arg2,type3 arg3) \
 { \
 long __res; \
-__asm__ volatile ("int $0x80" \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
 	: "=a" (__res) \
-	: "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
+	: "0" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
 		  "d" ((long)(arg3)) : "memory"); \
 __syscall_return(type,__res); \
 }
@@ -361,9 +362,9 @@
 type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
 { \
 long __res; \
-__asm__ volatile ("int $0x80" \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
 	: "=a" (__res) \
-	: "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
+	: "0" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
 	  "d" ((long)(arg3)),"S" ((long)(arg4)) : "memory"); \
 __syscall_return(type,__res); \
 } 
@@ -373,10 +374,12 @@
 type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
 { \
 long __res; \
-__asm__ volatile ("int $0x80" \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; movl %1,%%eax ; " \
+                  "int $0x80 ; pop %%ebx" \
 	: "=a" (__res) \
-	: "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
-	  "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5)) : "memory"); \
+	: "i" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
+	  "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5)) \
+	: "memory"); \
 __syscall_return(type,__res); \
 }
 
@@ -385,11 +388,14 @@
 type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,type6 arg6) \
 { \
 long __res; \
-__asm__ volatile ("push %%ebp ; movl %%eax,%%ebp ; movl %1,%%eax ; int $0x80 ; pop %%ebp" \
-	: "=a" (__res) \
-	: "i" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
-	  "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5)), \
-	  "0" ((long)(arg6)) : "memory"); \
+  struct { long __a1; long __a6; } __s = { (long)arg1, (long)arg6 }; \
+__asm__ volatile ("push %%ebp ; push %%ebx ; movl 4(%2),%%ebp ; " \
+                  "movl 0(%2),%%ebx ; movl %1,%%eax ; int $0x80 ; " \
+                  "pop %%ebx ;  pop %%ebp" \
+	: "=a" (__res) \
+	: "i" (__NR_##name),"0" ((long)(&__s)),"c" ((long)(arg2)), \
+	  "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5)) \
+	: "memory"); \
 __syscall_return(type,__res); \
 }
 

--------------090808030906060907030309--
