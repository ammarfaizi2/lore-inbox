Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWCGXpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWCGXpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWCGXpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:45:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28382 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964810AbWCGXpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:45:51 -0500
To: vgoyal@in.ibm.com
Cc: Andi Kleen <ak@muc.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] kdump: x86_64 timer interrupt lockup due to
 pending interrupt
References: <20060306164034.GB10594@in.ibm.com>
	<20060306214332.GA18529@muc.de> <20060307222052.GD9106@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 16:43:07 -0700
In-Reply-To: <20060307222052.GD9106@in.ibm.com> (Vivek Goyal's message of
 "Tue, 7 Mar 2006 17:20:52 -0500")
Message-ID: <m1hd69zur8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Mar 06, 2006 at 10:43:32PM +0100, Andi Kleen wrote:
>> On Mon, Mar 06, 2006 at 11:40:34AM -0500, Vivek Goyal wrote:
>> > 
>> > o check_timer() routine fails while second kernel is booting after a crash
>> > on an opetron box. Problem happens because timer vector (0x31) seems to be
>> >   locked.
>> > 
>> > o After a system crash, it is not safe to service interrupts any more, hence
>> >   interrupts are disabled. This leads to pending interrupts at LAPIC. LAPIC
>> > sends these interrupts to the CPU during early boot of second kernel. Other
>> > pending interrupts are discarded saying unexpected trap but timer interrupt
>> >   is serviced and CPU does not issue an LAPIC EOI because it think this
>> > interrupt came from i8259 and sends ack to 8259. This leads to vector 0x31
>> >   locking as LAPIC does not clear respective ISR and keeps on waiting for
>> >   EOI.
>> > 
>> > o In this patch, one extra EOI is being issued in check_timer() to unlock
> the
>> >   vector. Please suggest if there is a better way to handle this situation.
>> 
>> Shouldn't we rather do this for all interrupts when the APIC is set up? 
>> I don't see how the timer is special here.
>>
>
> Timer is a special case here.
>
> In other cases, the moment interrupts are enabled on cpu, LAPIC pushes pending
> interrupts to cpu and it is ignored as bad irq using ack_bad_irq(). This
> still sends EOI to LAPIC if LPAIC support is compiled in.
>
> But for timer, the moment pending interrupt is pushed to cpu, it is handled
> as valid interrupt and cpu assumes that it came from 8259 and sends ack to
> 8259 and not to LAPIC. Hence leads to missing EOI for timer vector and 
> deadlock.
>
> But still doing it generic manner for all interrupts while setting up LAPIC
> probably makes more sense. Please find attached the patch.

A couple of questions. 

Does this need to be in #ifdef CONFIG_CRASS_DUMP?
If this code is truly safe I expect we could run it on every bootup
simply to be more robust.

Why is APIC_ISR_NR a hard code?  I think there is an apic register
that tells the count.

Does ack_APIC_irq take an argument?  I am confused that we are calling
ack_APIC_irq() potentially 8*32 times without passing it anything.


Eric
