Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUJSGGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUJSGGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUJSGGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:06:16 -0400
Received: from ozlabs.org ([203.10.76.45]:46476 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268013AbUJSGGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:06:00 -0400
Subject: Re: XFS oops on loading the module
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Scott <nathans@sgi.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Eric Sandeen <sandeen@sgi.com>
In-Reply-To: <20041019004933.GD918@frodo>
References: <20041016165058.GB32324@cirrus.madduck.net>
	 <20041019004933.GD918@frodo>
Content-Type: text/plain
Message-Id: <1098160225.11204.425.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 16:05:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 10:49, Nathan Scott wrote:
> Hi there,
> 
> On Sat, Oct 16, 2004 at 06:50:58PM +0200, martin f krafft wrote:
> > I just tried to mount an XFS filesystem on this AMD K6 machine,
> > booted with the 2.6.8 kernel for FAI
> > (http://www.informatik.uni/koeln.de/fai) (let me know if you need
> > any information about it), and modprobe segfaults with a kernel bug.
> > Have you seen this before? Thanks!
> > 
> > sh-2.05b# modprobe xfs
> > Segmentation fault
> > ------------[ cut here ]------------
> > kernel BUG at kernel/module.c:264!
> 
> IOW... this, I guess:
> 
>         for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
>                 /* Extra for alignment requirement. */
>                 extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
>                 BUG_ON(i == 0 && extra != 0);

Somehow, your per-cpu section was not aligned sufficiently for this
alignment request.  Since you passed the BUG_ON(align > SMP_CACHE_BYTES)
above, it implies that your per-cpu section isn't correctly aligned.

Does this fix it?

Name: Align per-cpu Section Correctly
Status: Untested
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

The per-cpu section must be aligned to a cacheline: it's currently
aligned to a hardcoded 32 bytes on x86, which is wrong in some
configs.  On x86 the .data.cacheline_aligned is also 32-byte aligned,
which seems wrong too.

We can't use SMP_CACHE_BYTES because we can't include linux/cache.h
from asm.

Other archs need similar changes.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26520-linux-2.6.9-rc4-bk2/arch/i386/kernel/vmlinux.lds.S .26520-linux-2.6.9-rc4-bk2.updated/arch/i386/kernel/vmlinux.lds.S
--- .26520-linux-2.6.9-rc4-bk2/arch/i386/kernel/vmlinux.lds.S	2004-10-11 15:16:58.000000000 +1000
+++ .26520-linux-2.6.9-rc4-bk2.updated/arch/i386/kernel/vmlinux.lds.S	2004-10-19 12:45:54.000000000 +1000
@@ -5,6 +5,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/cache.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -47,7 +48,7 @@ SECTIONS
   . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
-  . = ALIGN(32);
+  . = ALIGN(L1_CACHE_BYTES);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
   _edata = .;			/* End of data section */
@@ -96,7 +97,7 @@ SECTIONS
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
-  . = ALIGN(32);
+  . = ALIGN(L1_CACHE_BYTES);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

