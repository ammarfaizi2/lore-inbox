Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSGVM7t>; Mon, 22 Jul 2002 08:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSGVM7t>; Mon, 22 Jul 2002 08:59:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50395 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316889AbSGVM7s>;
	Mon, 22 Jul 2002 08:59:48 -0400
Date: Mon, 22 Jul 2002 15:01:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722014018.A31813@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221248250.4519-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Russell King wrote:

> On Mon, Jul 22, 2002 at 02:31:16AM +0200, Ingo Molnar wrote:
> > +drivers that want to disable local interrupts (interrupts on the
> > +current CPU), can use the following four macros:
> > +
> > +  __cli(), __sti(), __save_flags(flags), __restore_flags(flags)
> 
> Last mail before zzz (hopefully) - what about
> local_irq_{enable,disable,save,restore} ?
> 
> With the exception of local_irq_save() which is actually
> local_irq_save_disable(), I find these to be more "descriptive" of their
> function.

i actually had something much more drastic in mind! :-) Now that the
global IRQ lock is no more, there's no 'local' and 'global' distinction
anymore between various irq disabling mechanizms.

So what i did in my tree was to introduce the following 5 core means of
manipulating the local interrupt flags:

	irq_off()
	irq_on()
	irq_save(flags)
	irq_save_off(flags)
	irq_restore(flags)

the equivalencies are:

	local_irq_save(flags)	 == irq_save_off(flags)
	local_irq_restore(flags) == irq_restore(flags)
	local_irq_disable()	 == irq_off()
	local_irq_enable()	 == irq_on()
	__cli()			 == irq_off()
	__sti()			 == irq_on()
	__save_flags(flags)	 == irq_save(flags)
	__restore_flags(flags)	 == irq_restore(flags)
	__save_and_cli(flags)	 == irq_save_off(flags)

the advantages this rename has:

- consistency - no dual naming for the same thing, we had 9 names for 5 
  entities.

- __cli, __sti are based on similarly named x86 instruction names which
  are often named differently on other architectures. 'irq_off()' and
  'irq_on()' on the other hand is a generic description. Also, cli and sti 
  are more cryptic than need to be.

- the names are actually shorter, more compact, making the source easier
  to read and understand.

- there's no conceptual confusion between local_irq_disable() and
  irq_disable(), or local_irq_enable() and irq_enable(), which are a
  completely separate set of APIs.

- there's no local_ prefix either - we know that interrupts can only be
  disabled locally.

- the confusion wrt. local_irq_save() is fixed too. local_irq_save() used
  to disable interrupt, although intuition tells that it saves flags only.

- the 5 new names do not create any namespace collision either.

some of these advantages are pretty 'small' in scope - but they all add
up. So in my opinion this is something we should do.

to ease the decision further, here's a patch against Linus' latest BK tree
that does all of this, in the whole kernel tree, for every architecture
and driver:

  http://redhat.com/~mingo/remove-irqlock-patches/cli-sti-cleanup-2.5.27-A2

(the patch also cleans up every architecture's include/asm/system.h's irq
macros.)

the patch shaves off a total of 4 KB from the kernel source code size. It
compiles, boots & works just fine on x86 UP and SMP.

	Ingo

