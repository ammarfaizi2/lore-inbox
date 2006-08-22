Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWHVEJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWHVEJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 00:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWHVEJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 00:09:53 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:50387 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932092AbWHVEJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 00:09:52 -0400
Subject: Re: [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
From: Magnus Damm <magnus@valinux.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <m1u045sagu.fsf@ebiederm.dsl.xmission.com>
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	 <m13bbpu7i5.fsf@ebiederm.dsl.xmission.com>
	 <1156208306.21411.85.camel@localhost>
	 <m1u045sagu.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 13:10:07 +0900
Message-Id: <1156219807.21411.100.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 21:41 -0600, Eric W. Biederman wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
> 
> > On Mon, 2006-08-21 at 15:02 -0600, Eric W. Biederman wrote:
> >> Magnus Damm <magnus@valinux.co.jp> writes:
> >> 
> >> > x86_64: Reload CS when startup_64 is used.
> >> >
> >> > The current x86_64 startup code never reloads CS during the early boot
> > process
> >> > if the 64-bit function startup_64 is used as entry point. The 32-bit entry 
> >> > point startup_32 does the right thing and reloads CS, and this is what most
> >> > people are using if they use bzImage.
> >> >
> >> > This patch fixes the case when the Linux kernel is booted into using kexec
> >> > under Xen. The Xen hypervisor is using large CS values which makes the
> > x86_64
> >> > kernel fail - but only if vmlinux is booted, bzImage works well because it
> >> > is using the 32-bit entry point.
> >> >
> >> > The main question is if we require that the boot loader should setup CS
> >> > to some certain offset to be able to boot the kernel. The sane solution IMO
> >> > should be that the kernel requires that the loaded descriptors are correct,
> >> > but that the exact offset within the GDT the boot loader is using should not
> >> > matter. This is the way the i386 boot works if I understand things
> > correctly.
> >> 
> >> What extra reload of cs does Xen introduce?
> >
> > None, but Xen is using CS values that are very different from Linux:
> >
> > xen/include/public/arch-x86_64.h:
> >
> > #define FLAT_RING3_CS32 0xe023  /* GDT index 260 */
> > #define FLAT_RING3_CS64 0xe033  /* GDT index 261 */
> > #define FLAT_RING3_DS32 0xe02b  /* GDT index 262 */
> > #define FLAT_RING3_DS64 0x0000  /* NULL selector */
> > #define FLAT_RING3_SS32 0xe02b  /* GDT index 262 */
> > #define FLAT_RING3_SS64 0xe02b  /* GDT index 262 */
> >
> > The main problem is that startup_64 depends on that CS is set to
> > __KERNEL_CS when it shouldn't. On top of that the purgatory code in
> > kexec-tools doesn't setup CS when using a 64-bit entry point. The
> > following (mangled) patch solves that for me:
> 
> I believe the cs shadow registers are fine.

Yeah, I know you do. =)

> > --- 0001/purgatory/arch/x86_64/entry64.S
> > +++ work/purgatory/arch/x86_64/entry64.S        2006-08-18
> > 15:34:23.000000000 +0900
> > @@ -37,8 +37,9 @@ entry64:
> >         movl    %eax, %fs
> >         movl    %eax, %gs
> >
> > -       /* In 64bit mode the code segment is meaningless */
> 
> Would you care to explain to me how the above comment is not true.
> As I recall the only meaning %cs has is if you are a kernel
> or user space process.  The base address and everything else
> mean nothing.
> 
> In addition the value in %cs never means anything.  It is the
> values in the cs shadow registers that count.  The value in %cs
> just reflects where those values in %cs came from.
> 
> So if we never reload %cs and only use the shadow values why does 
> the value in %cs matter?

Well, I cannot explain it well myself. But if you try setting CS to
something else than 0x18 and start the x86_64 kernel using startup_64
you will see what I am talking about. It does not work. 

A good example of when this doesn't work is when my page_table_a patches
are used on x86_64 to boot a vmlinux. It does not work because CS is set
to something else then __KERNEL_CS.

Things just happen to work in most cases today (excluding being rebooted
from Xen) because either
a) vmlinux is booted and CS is set to 0x18 by Linux before kexec:ing.
or
b) bzImage is booted (32 bit entry point)

> >> I'm not really comfortable with a half virtualized case.
> >
> > That I don't understand, care to explain more?
> 
> The only case where I can think of that the value in %cs would matter
> is if you change %cs.  The only way I can see that is if you are
> half para-virtualized.  Because we are running privileged
> instructions in startup_64 it shouldn't work for the paravirtualized
> case, and it should work just like it does today in the
> fully virtualized case.

I'm not talking about running Linux under Xen, this is a standard
non-virtualized kernel that is started _from_ a Xen environment using
kexec-tools. Think kdump kernel being started by the Xen hypervisor on
panic. Does that make sense?

Thanks,

/ magnus

