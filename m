Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUG2CGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUG2CGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUG2CGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:06:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35475 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267408AbUG2CGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:06:32 -0400
Subject: Re: 2.6.8-rc2-mm1 link errors
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
In-Reply-To: <20040728164920.5ad4c114.akpm@osdl.org>
References: <1091057256.2871.637.camel@nighthawk>
	 <20040728164920.5ad4c114.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-WZYOeYqshsO9Q6nrx72u"
Message-Id: <1091066773.2871.866.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 19:06:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WZYOeYqshsO9Q6nrx72u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-07-28 at 16:49, Andrew Morton wrote:
> Nope.   Could you take a look at the code in the top-level
> Makefile which is doing this, work out why it broke?

It seems to come down to this warning:

arch/i386/kernel/irq.c
{standard input}: Assembler messages:
{standard input}:3565: Warning: setting incorrect section type for
.bss.page_aligned

Which comes from this code in the 4k stacks code:

static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));

Removing the __section__() fixes it, as does moving to gcc 3.2 or 3.3,
but gcc 2.95 and 3.0 still exhibit the problem.  It seems the 4k stack
developers like newer compilers than I do :) 

The gcc 2.95 section declaration looks like this:
	.section        .bss.page_aligned,"aw",@progbits
while the 3.1 section looks like this:
	.section        .bss.page_aligned,"aw",@nobits

It's definitely a bug that's been fixed:
http://sources.redhat.com/ml/binutils/2002-10/msg00507.html

I've been told that I can fix it with a carefully crafted assembly file
and maybe a change to the linker script, but all that it buys us is a
little space in the uncompressed kernel image.  Plus, the warning will
still be there at compile-time.  

I say, put them back in plain old BSS.  Patch attached.

-- Dave

--=-WZYOeYqshsO9Q6nrx72u
Content-Disposition: attachment; filename=irqstacks-nosection-2.6.8-rc2-mm1-0.patch
Content-Type: text/x-patch; name=irqstacks-nosection-2.6.8-rc2-mm1-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -rup linux-2.6.8-rc2-mm1/arch/i386/kernel/irq.c linux-2.6.8-rc2-mm1-irqstackbss/arch/i386/kernel/irq.c
--- linux-2.6.8-rc2-mm1/arch/i386/kernel/irq.c	2004-07-28 18:10:40.000000000 -0700
+++ linux-2.6.8-rc2-mm1-irqstackbss/arch/i386/kernel/irq.c	2004-07-28 18:52:41.000000000 -0700
@@ -1118,8 +1118,12 @@ void init_irq_proc (void)
 
 
 #ifdef CONFIG_4KSTACKS
-static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
-static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE), __section__(".bss.page_aligned")));
+/* 
+ * These should really be __section__(".bss.page_aligned") as well, but
+ * gcc's 3.0 and earlier don't handle that correctly.
+ */
+static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE)));
+static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE)));
 
 /*
  * allocate per-cpu stacks for hardirq and for softirq processing

--=-WZYOeYqshsO9Q6nrx72u--

