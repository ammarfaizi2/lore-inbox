Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWHVA6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWHVA6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWHVA6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:58:10 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:64187 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750999AbWHVA6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:58:09 -0400
Subject: Re: [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
From: Magnus Damm <magnus@valinux.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <m13bbpu7i5.fsf@ebiederm.dsl.xmission.com>
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	 <m13bbpu7i5.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 09:58:26 +0900
Message-Id: <1156208306.21411.85.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 15:02 -0600, Eric W. Biederman wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
> 
> > x86_64: Reload CS when startup_64 is used.
> >
> > The current x86_64 startup code never reloads CS during the early boot process
> > if the 64-bit function startup_64 is used as entry point. The 32-bit entry 
> > point startup_32 does the right thing and reloads CS, and this is what most 
> > people are using if they use bzImage.
> >
> > This patch fixes the case when the Linux kernel is booted into using kexec
> > under Xen. The Xen hypervisor is using large CS values which makes the x86_64
> > kernel fail - but only if vmlinux is booted, bzImage works well because it
> > is using the 32-bit entry point.
> >
> > The main question is if we require that the boot loader should setup CS
> > to some certain offset to be able to boot the kernel. The sane solution IMO
> > should be that the kernel requires that the loaded descriptors are correct, 
> > but that the exact offset within the GDT the boot loader is using should not 
> > matter. This is the way the i386 boot works if I understand things correctly.
> 
> What extra reload of cs does Xen introduce?

None, but Xen is using CS values that are very different from Linux:

xen/include/public/arch-x86_64.h:

#define FLAT_RING3_CS32 0xe023  /* GDT index 260 */
#define FLAT_RING3_CS64 0xe033  /* GDT index 261 */
#define FLAT_RING3_DS32 0xe02b  /* GDT index 262 */
#define FLAT_RING3_DS64 0x0000  /* NULL selector */
#define FLAT_RING3_SS32 0xe02b  /* GDT index 262 */
#define FLAT_RING3_SS64 0xe02b  /* GDT index 262 */

The main problem is that startup_64 depends on that CS is set to
__KERNEL_CS when it shouldn't. On top of that the purgatory code in
kexec-tools doesn't setup CS when using a 64-bit entry point. The
following (mangled) patch solves that for me:

--- 0001/purgatory/arch/x86_64/entry64.S
+++ work/purgatory/arch/x86_64/entry64.S        2006-08-18
15:34:23.000000000 +0900
@@ -37,8 +37,9 @@ entry64:
        movl    %eax, %fs
        movl    %eax, %gs

-       /* In 64bit mode the code segment is meaningless */
-
+       ljmp    *new_cs_addr(%rip)
+new_cs_exit:
+
        /* Load the registers */
        movq    rax(%rip), %rax
        movq    rbx(%rip), %rbx
@@ -93,8 +94,11 @@ gdt: /* 0x00 unusable segment
        .word   0, 0, 0

        /* 0x10 4GB flat code segment */
-       .word   0xFFFF, 0x0000, 0x9A00, 0x00CF
+       .word   0xFFFF, 0x0000, 0x9A00, 0x00AF

        /* 0x18 4GB flat data segment */
        .word   0xFFFF, 0x0000, 0x9200, 0x00CF
 gdt_end:
+new_cs_addr:
+       .long   new_cs_exit
+       .word   0x10 /* CODE_CS */


> I'm not really comfortable with a half virtualized case.

That I don't understand, care to explain more?

Thanks,

/ magnus

