Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWH3OQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWH3OQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWH3OQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:16:43 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:21441 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750832AbWH3OQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:16:42 -0400
Subject: Re: [PATCH 3/6] provide kernel_execve on all architectures
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20060830125037.876668000@klappe.arndb.de>
References: <20060830124356.567568000@klappe.arndb.de>
	 <20060830125037.876668000@klappe.arndb.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 30 Aug 2006 16:16:37 +0200
Message-Id: <1156947397.18390.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 14:43 +0200, Arnd Bergmann wrote:
> This adds the new kernel_execve function on all architectures
> that were using _syscall3() to implement execve.

Doesn't compile for s390. Patch attached, issues fixed:
1) Include unistd.h for __NR_execve
2) The compiler warns about __arg2 and __arg3 assignments (watch out for
the *const* - isn't C a lovely language ;-)
3) The inline assembly does not clobber register "1", nor the condition
code. The call to kernel_execve does clobber both so it is not really a
problem, but nit-picking is fun >:-)

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

---
diff -urpN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-patched/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	2006-08-30 15:23:14.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/sys_s390.c	2006-08-30 15:18:37.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/file.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
+#include <linux/unistd.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -273,14 +274,15 @@ s390_fadvise64_64(struct fadvise64_64_ar
 int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 {
 	register const char *__arg1 asm("2") = filename;
-	register void *__arg2 asm("3") = argv;
-	register void *__arg3 asm("4") = envp;
+	register char *const*__arg2 asm("3") = argv;
+	register char *const*__arg3 asm("4") = envp;
 	register long __svcres asm("2");
-	asm volatile ("svc %b1"
+	asm volatile(
+		"svc %b1"
 		: "=d" (__svcres)
 		: "i" (__NR_execve),
 		  "0" (__arg1),
 		  "d" (__arg2),
-		  "d" (__arg3) : "1", "cc", "memory");
+		  "d" (__arg3) : "memory");
 	return __svcres;
 }


