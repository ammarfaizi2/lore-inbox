Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUHJSqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUHJSqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267673AbUHJSnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:43:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23778 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267598AbUHJSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:40:03 -0400
Date: Tue, 10 Aug 2004 20:39:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: [patch] 2.6.8-rc4: compile error with gcc 2.95
Message-ID: <20040810183955.GR26174@fs.tum.de>
References: <Pine.LNX.4.58.0408091958450.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408091958450.1839@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still getting a flood of the following errors when using gcc 2.95:


<--  snip  -->

...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.8-rc4; fi
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/ymfpci/snd-ymfpci.ko 
needs unknown symbol free_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/ymfpci/snd-ymfpci.ko
needs unknown symbol request_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/vx222/snd-vx222.ko
needs unknown symbol free_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/vx222/snd-vx222.ko
needs unknown symbol request_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/trident/snd-trident.ko
needs unknown symbol free_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/trident/snd-trident.ko
needs unknown symbol request_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/snd-via82xx.ko needs
unknown symbol free_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/snd-via82xx.ko needs
unknown symbol request_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/snd-sonicvibes.ko needs
unknown symbol free_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/snd-sonicvibes.ko needs
unknown symbol request_irq
WARNING: /lib/modules/2.6.8-rc4/kernel/sound/pci/snd-rme96.ko needs
unknown symbol free_irq
... [several hundred similar lines siped] 

<--  snip  -->


The following patch (as 268-rc2-mm1-link-errors.patch already in -mm)
fixes this issue:


<-- snip  -->


From: Dave Hansen <haveblue@us.ibm.com>

Investigation of why the build is failing due to bogus detection of
undefined symbols: We're getting this warning:

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

I've been told that I can fix it with a carefully crafted assembly file and
maybe a change to the linker script, but all that it buys us is a little
space in the uncompressed kernel image.  Plus, the warning will still be
there at compile-time.  

I say, put them back in plain old BSS.  Patch attached.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
---

 25-akpm/arch/i386/kernel/irq.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/irq.c~268-rc2-mm1-link-errors arch/i386/kernel/irq.c
--- 25/arch/i386/kernel/irq.c~268-rc2-mm1-link-errors	2004-07-28 22:11:29.652159016 -0700
+++ 25-akpm/arch/i386/kernel/irq.c	2004-07-28 22:11:29.658158104 -0700
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
_
