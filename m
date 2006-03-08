Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWCHEHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWCHEHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbWCHEHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:07:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44000 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750913AbWCHEHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:07:15 -0500
To: vgoyal@in.ibm.com
Cc: Andi Kleen <ak@muc.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] kdump: x86_64 timer interrupt lockup due to
 pending interrupt
References: <20060306164034.GB10594@in.ibm.com>
	<20060306214332.GA18529@muc.de> <20060307222052.GD9106@in.ibm.com>
	<m1hd69zur8.fsf@ebiederm.dsl.xmission.com>
	<20060308012654.GB25543@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 21:04:47 -0700
In-Reply-To: <20060308012654.GB25543@in.ibm.com> (Vivek Goyal's message of
 "Tue, 7 Mar 2006 20:26:54 -0500")
Message-ID: <m18xrlzin4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Tue, Mar 07, 2006 at 04:43:07PM -0700, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@in.ibm.com> writes:
>> > On Mon, Mar 06, 2006 at 10:43:32PM +0100, Andi Kleen wrote:
>> >> On Mon, Mar 06, 2006 at 11:40:34AM -0500, Vivek Goyal wrote:
>> >> > 
>
> [..]
>> >> > 
>> >> > o In this patch, one extra EOI is being issued in check_timer() to unlock
>> > the
>> >> > vector. Please suggest if there is a better way to handle this situation.
>> >> 
>> >> Shouldn't we rather do this for all interrupts when the APIC is set up? 
>> >> I don't see how the timer is special here.
>> >>
>> >
>> > Timer is a special case here.
>> >
>> > In other cases, the moment interrupts are enabled on cpu, LAPIC pushes
> pending
>> > interrupts to cpu and it is ignored as bad irq using ack_bad_irq(). This
>> > still sends EOI to LAPIC if LPAIC support is compiled in.
>> >
>> > But for timer, the moment pending interrupt is pushed to cpu, it is handled
>> > as valid interrupt and cpu assumes that it came from 8259 and sends ack to
>> > 8259 and not to LAPIC. Hence leads to missing EOI for timer vector and 
>> > deadlock.
>> >
>> > But still doing it generic manner for all interrupts while setting up LAPIC
>> > probably makes more sense. Please find attached the patch.
>> 
>> A couple of questions. 
>> 
>> Does this need to be in #ifdef CONFIG_CRASS_DUMP?
>> If this code is truly safe I expect we could run it on every bootup
>> simply to be more robust.
>> 
>
> AFAIK, we can run this code safely on every bootup and can get rid of
> CONFIG_CRASH_DUMP. I have simply put it under it because I observed it
> only for crashdump scenarios. But removing this should be good as it
> protectets agains buggy boards. Modified patch is attached.
>
>
>> Why is APIC_ISR_NR a hard code?  I think there is an apic register
>> that tells the count.
>> 
>
> I did not find any such register. Basically ISR is a 256bit register. We
> are reading 32 bits at a time, so logically we can view it as 8, 32 bit
> registers. I had two options. Either I put a constant number in for()
> loop or #define it. I chose later one.
>
>> Does ack_APIC_irq take an argument?  I am confused that we are calling
>> ack_APIC_irq() potentially 8*32 times without passing it anything.
>> 
>
> It does not take any argument. Whenever a zero is written to EOI register
> LAPIC resets one ISR register bit corresponding to highest priority
> interrupt. So if all the ISR bits are set, we will call ack_APIC_irq()
> 8*32 times to reset them all.

Ok.  That makes sense.

Looks good to me.

Eric
