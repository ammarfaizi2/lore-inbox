Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311504AbSCNFGe>; Thu, 14 Mar 2002 00:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311505AbSCNFGY>; Thu, 14 Mar 2002 00:06:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13839 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311504AbSCNFGO>;
	Thu, 14 Mar 2002 00:06:14 -0500
Message-ID: <3C902FA5.5010208@mandrakesoft.com>
Date: Thu, 14 Mar 2002 00:05:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
In-Reply-To: <E16lMzi-0002bb-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

>In message <15504.7958.677592.908691@napali.hpl.hp.com> you write:
>
>>OK, I see this.  Unfortunately, HIDE_RELOC() causes me problems
>>because it prevents me from taking the address of a per-CPU variable.
>>This is useful when you have a per-CPU structure (e.g., cpu_info).
>>Perhaps there should/could be a version of HIDE_RELOC() that doesn't
>>dereference the resulting address?
>>
>
>Yep, valid point.  Patch below: please play.
>
>diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/compiler.h working-2.5.7-pre1-nfarp/include/linux/compiler.h
>--- linux-2.5.7-pre1/include/linux/compiler.h	Fri Mar  8 14:49:29 2002
>+++ working-2.5.7-pre1-nfarp/include/linux/compiler.h	Thu Mar 14 15:32:38 2002
>@@ -13,10 +13,4 @@
> #define likely(x)	__builtin_expect((x),1)
> #define unlikely(x)	__builtin_expect((x),0)
> 
>-/* This macro obfuscates arithmetic on a variable address so that gcc
>-   shouldn't recognize the original var, and make assumptions about it */
>-#define RELOC_HIDE(var, off)					\
>-  ({ __typeof__(&(var)) __ptr;					\
>-    __asm__ ("" : "=g"(__ptr) : "0"((void *)&(var) + (off)));	\
>-    *__ptr; })
> #endif /* __LINUX_COMPILER_H */
>diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/percpu.h working-2.5.7-pre1-nfarp/include/linux/percpu.h
>--- linux-2.5.7-pre1/include/linux/percpu.h	Thu Jan  1 10:00:00 1970
>+++ working-2.5.7-pre1-nfarp/include/linux/percpu.h	Thu Mar 14 15:32:44 2002
>@@ -0,0 +1,28 @@
>+#ifndef __LINUX_PERCPU_H
>+#define __LINUX_PERCPU_H
>+
>+/* This macro obfuscates arithmetic on a variable address so that gcc
>+   shouldn't recognize the original var, and make assumptions about it */
>+#define RELOC_HIDE(ptr, off)					\
>+  ({ __typeof__(ptr) __ptr;					\
>+    __asm__ ("" : "=g"(__ptr) : "0"((void *)(ptr) + (off)));	\
>+    __ptr; })
>
Your other changes look good, but RELOC_HIDE really does belong in 
compiler.h... and percpu.h is a particularly poor choice of destination. 
 Why not satisfy DavidM's objection by creating (or stating you allow 
the creation of) __RELOC_HIDE or similar.  Or perhaps call your version 
__RELOC_HIDE, if yours is not the normal case?

It really shouldn't be moved from where it belongs, linux/compiler.h...

    Jeff



