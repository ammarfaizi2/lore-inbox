Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131789AbRBQPPC>; Sat, 17 Feb 2001 10:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131801AbRBQPOx>; Sat, 17 Feb 2001 10:14:53 -0500
Received: from jalon.able.es ([212.97.163.2]:25816 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131789AbRBQPOg>;
	Sat, 17 Feb 2001 10:14:36 -0500
Date: Sat, 17 Feb 2001 16:14:26 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        Keith Owens <kaos@ocs.com.au>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
Message-ID: <20010217161426.A981@werewolf.able.es>
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com> <Pine.LNX.4.21.0102171200530.2029-100000@localhost.localdomain> <20010217152240.A2641@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010217152240.A2641@werewolf.able.es>; from jamagallon@able.es on Sat, Feb 17, 2001 at 15:22:40 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.17 J . A . Magallon wrote:
> #if 1
>   extern void *__io_virt_debug(unsigned long x, const char *file, int line);
>   extern unsigned long __io_phys_debug(unsigned long x, const char *file, int
> li
> ne);
>   #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)
> //#define __io_phys(x) __io_phys_debug((unsigned long)(x), __FILE__, __LINE__)
> #else
>   #define __io_virt(x) ((void *)(x))
> //#define __io_phys(x) __pa(x)
> #endif
> ..

Loking at it (arch/i386/lib/iodebug.c):
void * __io_virt_debug(unsigned long x, const char *file, int line)
{
    if (x < PAGE_OFFSET) {
        printk("io mapaddr 0x%05lx not valid at %s:%d!\n", x, file, line);
        return __va(x);
    }
    return (void *)x;
}

is changed (if you turn off the #if 1), from 1_function_call+1_if+cache
pollution with the function code to nothing (just a cast).
This will make some difference in performance, won't it ?
 
-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac17 #1 SMP Sat Feb 17 01:47:56 CET 2001 i686

