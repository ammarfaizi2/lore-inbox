Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTJTTbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTJTTbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:31:14 -0400
Received: from gprs144-63.eurotel.cz ([160.218.144.63]:4225 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262750AbTJTTbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:31:06 -0400
Date: Mon, 20 Oct 2003 21:31:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Strange cleanups in -test8 kernel/acpi/wakeup.S
Message-ID: <20031020193100.GB540@elf.ucw.cz>
References: <20031018201214.GA12037@elf.ucw.cz> <Pine.LNX.4.44.0310201115270.13116-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310201115270.13116-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > bkcvs info is:
> > BitKeeper to RCS/CVS export
> > ----------------------------
> > revision 1.5
> > date: 2003/10/08 22:55:45;  author: mochel;  state: Exp;  lines: +37
> > -89
> > [power] Clean up ACPI STR assembly.
> 
> It might help if you read the full changeset comments. 

Sorry, I did not see them anywhere :-(.

> > diff -Nru a/arch/i386/kernel/acpi/wakeup.S
> > b/arch/i386/kernel/acpi/wakeup.S
> > --- a/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
> > +++ b/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
> > @@ -172,14 +172,13 @@
> >  .org   0x1000
> > 
> >  wakeup_pmode_return:
> > -       movl    $__KERNEL_DS, %eax
> > -       movl    %eax, %ds
> > -       movw    $0x0e00 + 'u', %ds:(0xb8016)
> > -
> > -       # restore other segment registers
> > -       xorl    %eax, %eax
> > +       movw    $__KERNEL_DS, %ax
> > +       movw    %ax, %ss
> > +       movw    %ax, %ds
> > +       movw    %ax, %es
> >         movw    %ax, %fs
> >         movw    %ax, %gs
> > +       movw    $0x0e00 + 'u', 0xb8016
> > 
> >         # reload the gdt, as we need the full 32 bit address
> >         lgdt    saved_gdt
> > 	~~~~~~~~~~~~~~~~~
> > 
> > Notice lgdt here. You have moved setup of segment registers before
> > loading gdt. This is actually okay, if you can be sure that all such
> > registers are in gdt (and not in ldt, for example).
> 
> All segments are in the GDT, as we use the same GDT in real mode as we do 
> in protected mode. However, you must reload the GDT in protected mode 
> because the GDTR is only 24 bits in real mode, but 32 in protected
> mode. 

Ok, sorry.

> >         # and restore the stack ... but you need gdt for this to work
> > -       movl    $__KERNEL_DS, %eax
> > -       movw    %ax, %ss
> > -       movw    %ax, %ds
> > -       movw    %ax, %es
> > -       movw    %ax, %fs
> > -       movw    %ax, %gs
> > -       movl    saved_esp, %esp
> > +       movl    saved_context_esp, %esp
> > 
> > ...
> > 
> > -       movw    $0x0e00 + 'W', %ds:(0xb8018)
> > -       movl    $(1024*1024*3), %ecx
> > -       movl    $0, %esi
> > -       rep     lodsb
> > -       movw    $0x0e00 + 'O', %ds:(0xb8018)
> > +       movw    $0x0e00 + 'W', 0xb8018
> > +       outl    %eax, $0x80
> > +       outl    %eax, $0x80
> > +       movw    $0x0e00 + 'O', 0xb8018
> > 
> > What are these outl-s? I do not see %ax being initialized... Some kind
> > of debugging hack? If you are trying to emulate delays, those are not
> > needed, what you killed were debugging hacks.
> 
> Debugging hacks that did what? AFAICT, it only implemented a small delay 
> by loading %eax with 0 a few million times. 

One was test "is stack working or do we get fault", and second was "do
our page tables look reasonable". I was not trying to pause.

Anyway it was undocumented and it was hack. Best thing is probably to
kill it. Here's a patch.

								Pavel

--- tmp/linux/arch/i386/kernel/acpi/wakeup.S	2003-10-18 20:26:27.000000000 +0200
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-10-20 21:16:06.000000000 +0200
@@ -193,11 +193,6 @@
 	# and restore the stack ... but you need gdt for this to work
 	movl	saved_context_esp, %esp
 
-	movw	$0x0e00 + 'W', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + 'O', 0xb8018
-
 	movl	%cs:saved_magic, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_magic
@@ -205,9 +200,6 @@
 	# jump to place where we left off
 	movl	saved_eip,%eax
 	movw	$0x0e00 + 'x', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + '!', 0xb801a
 	jmp	*%eax
 
 bogus_magic:


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
