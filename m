Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267526AbTACOAe>; Fri, 3 Jan 2003 09:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267523AbTACOAe>; Fri, 3 Jan 2003 09:00:34 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:1293 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267522AbTACOAc>; Fri, 3 Jan 2003 09:00:32 -0500
Date: Sat, 4 Jan 2003 01:08:59 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: sparclinux@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.54-sparc64 compile errors
In-Reply-To: <Pine.LNX.3.96.1030102191604.22760J-100000@ligur.expressz.com>
Message-ID: <Mutt.LNX.4.44.0301040101070.17638-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, BODA Karoly jr. wrote:

> o And an error which with I can't do anything... :(
> 
>   sparc64-linux-gcc -Wp,-MD,arch/sparc64/kernel/.head.o.d -D__ASSEMBLY__
> -D__KERNEL__ -Iinclude -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
> -nostdinc -iwithprefix include  -ansi  -c -o arch/sparc64/kernel/head.o
> arch/sparc64/kernel/head.S
> In file included from include/linux/cache.h:4,
>                  from include/asm/smp.h:11,
>                  from arch/sparc64/kernel/entry.S:15,
>                  from arch/sparc64/kernel/head.S:734:
> include/linux/kernel.h:31: warning: `ALIGN' redefined
> include/linux/linkage.h:24: warning: this is the location of the previous definition
> 

This is a namespace collision introduced with ALIGN() being moved to
kernel.h.  A patch below resolves this for sparc64 by not including some
non-asm headers when compiling assembler, although the namespace issue
itself may still need to be fixed (e.g. change ALIGN() to ALIGN_TO() 
in kernel.h ?).  

It looks like sparc32 has a similar problem.


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.54.orig/include/asm-sparc64/smp.h linux-2.5.54.w1/include/asm-sparc64/smp.h
--- linux-2.5.54.orig/include/asm-sparc64/smp.h	Wed Oct  9 22:39:39 2002
+++ linux-2.5.54.w1/include/asm-sparc64/smp.h	Sat Jan  4 00:43:28 2003
@@ -7,13 +7,14 @@
 #define _SPARC64_SMP_H
 
 #include <linux/config.h>
-#include <linux/threads.h>
-#include <linux/cache.h>
 #include <asm/asi.h>
 #include <asm/starfire.h>
 #include <asm/spitfire.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/threads.h>
+#include <linux/cache.h>
+
 /* PROM provided per-processor information we need
  * to start them all up.
  */

