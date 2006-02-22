Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWBVMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWBVMWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWBVMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:22:39 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29694 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750710AbWBVMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:22:38 -0500
Date: Wed, 22 Feb 2006 07:22:26 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rt17
In-Reply-To: <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0602220715460.4164@gandalf.stny.rr.com>
References: <20060221155548.GA30146@elte.hu> <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2006, Michal Piotrowski wrote:

> Hi,
>
> On 21/02/06, Ingo Molnar <mingo@elte.hu> wrote:
> > i have released the 2.6.15-rt17 tree, which can be downloaded from the
> > usual place:
> [snip]
> > to build a 2.6.15-rt17 tree, the following patches should be applied:
> >
> >   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
> >   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt17
> >
> >         Ingo
>
> I have noticed some bugs
>
> ----------------------------->
> | new stack-footprint maximum: swapper/0, 788 bytes (out of 4044 bytes).
> ------------|
> {   24} [<c0135e7d>] debug_stackoverflow+0x80/0xb2
> {   28} [<c01364e9>] __mcount+0x3b/0xb2
> {   20} [<c010ebd8>] mcount+0x14/0x18
> {  124} [<c01dc5cf>] number+0xe/0x204
> {   76} [<c01dcbc3>] vsnprintf+0x3fe/0x438
> {   28} [<c01dcc18>] vscnprintf+0x1b/0x2b
> {  128} [<c011bd04>] vprintk+0x7a/0x23d
> {   20} [<c011bc88>] printk+0x18/0x1a
> {  172} [<c010ec2a>] MP_processor_info+0x4a/0x1b4
> {   36} [<c010ee2e>] mp_register_lapic+0x9a/0xa0
> {   24} [<c0482d5e>] acpi_parse_lapic+0x45/0x56
> {   28} [<c048dda6>] acpi_table_parse_madt_family+0xb0/0x100
> {   28} [<c048de10>] acpi_table_parse_madt+0x1a/0x1c
> {   32} [<c048312a>] acpi_parse_madt_lapic_entries+0x49/0x9a
> {    8} [<c048327d>] acpi_process_madt+0x23/0xb3
> {   24} [<c0483540>] acpi_boot_init+0x3c/0x4c
> {   20} [<c04805d4>] setup_arch+0x1af/0x1ed
> {   24} [<c047c72f>] start_kernel+0x30/0x19a
>

Ingo,

Maybe the following patch is needed, so that people know that this is not
a bug.

-- Steve

Index: linux-2.6.15-rt17/kernel/latency.c
===================================================================
--- linux-2.6.15-rt17.orig/kernel/latency.c	2006-02-21 11:44:54.000000000 -0500
+++ linux-2.6.15-rt17/kernel/latency.c	2006-02-22 07:20:55.000000000 -0500
@@ -418,6 +418,8 @@ static notrace void __print_worst_stack(
 	printk("| new stack-footprint maximum: %s/%d, %ld bytes (out of %ld bytes).\n",
 		worst_stack_comm, worst_stack_pid,
 		MAX_STACK-worst_stack_left, (long)MAX_STACK);
+	printk("| This is not a BUG\n");
+	printk("| turn off CONFIG_DEBUG_STACK_OVERFLOW if you don't want this\n");
 	printk("------------|\n");

 	show_stackframe();
