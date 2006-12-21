Return-Path: <linux-kernel-owner+w=401wt.eu-S1423084AbWLUUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423084AbWLUUry (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423085AbWLUUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:47:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49205 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423084AbWLUUrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:47:53 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	<20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
	<20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
	<20061217145714.GA2987@melchior.yamamaya.is-a-geek.org>
	<m1bqm1s5vv.fsf@ebiederm.dsl.xmission.com>
	<20061218152333.GA2400@melchior.yamamaya.is-a-geek.org>
	<m1tzztqkev.fsf@ebiederm.dsl.xmission.com>
	<86802c440612190000k7eb5e68et9c0a776ef85b5177@mail.gmail.com>
	<m1ac1kqg6b.fsf@ebiederm.dsl.xmission.com>
	<86802c440612192250l50805d40h71baa7ce6f99a3e5@mail.gmail.com>
Date: Thu, 21 Dec 2006 13:46:50 -0700
In-Reply-To: <86802c440612192250l50805d40h71baa7ce6f99a3e5@mail.gmail.com>
	(Yinghai Lu's message of "Tue, 19 Dec 2006 22:50:33 -0800")
Message-ID: <m164c5nfid.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> On 12/19/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> So the pin2 case should be tested right after the pin1 case as we do
>> currently.  On most new boards that will be a complete noop.
>>
>> But it is better than our current blind guess at using ExtINT mode.
>>
>> I figure after we try what the BIOS has told us about and that
>> has failed we should first try the common irq 0 apic mappings,
>> and then try the common ExtINT mappings.
>
> Please check if this one is ok.
>
> [PATCH] x86_64: check_timer with io apic setup before try_apic_pin
>
> add io apic setup before try_apic_pin
>
> cc: Andi Kleen <ak@suse.de>
> cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
>
> diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
> index 2a1dcd5..6d09fc0 100644
> --- a/arch/x86_64/kernel/io_apic.c
> +++ b/arch/x86_64/kernel/io_apic.c
> @@ -273,10 +273,17 @@ static void add_pin_to_irq(unsigned int irq, int apic, int
> pin)
>  	struct irq_pin_list *entry = irq_2_pin + irq;
>  
>  	BUG_ON(irq >= NR_IRQS);
> -	while (entry->next)
> +	while (entry->next) {
> +		if (entry->apic == apic && entry->pin == pin) 
> +			return;
> +		if (entry->pin == -1) 
> +			break;
>  		entry = irq_2_pin + entry->next;
> +	}
>  
>  	if (entry->pin != -1) {
> +		if (entry->apic == apic && entry->pin == pin) 
> +			return;
>  		entry->next = first_free_entry;
>  		entry = irq_2_pin + entry->next;
>  		if (++first_free_entry >= PIN_MAP_SIZE)

This change to add_pin_to_irq looks dubious.

We especially shouldn't hit a pin == -1 while next is still valid.
The problem is that the code that reads this at irq time does not
skip entries with entry->pin == -1.

Fixing the infrastructure should probably be a separate patch
so we don't get too many concepts confused in here.

> @@ -286,6 +293,24 @@ static void add_pin_to_irq(unsigned int irq, int apic, int
> pin)
>  	entry->pin = pin;
>  }
>  
> +static void remove_pin_to_irq(unsigned int irq, int apic, int pin)
> +{
> +	struct irq_pin_list *entry = irq_2_pin + irq;
> +
> +	BUG_ON(irq >= NR_IRQS);
> +
> +	while (entry) {
> +		if (entry->apic == apic && entry->pin == pin) {
> +			entry->apic = -1;
> +			entry->pin = -1;
> +			break;
> +		}
> +		if (entry->next) 
> +			entry = irq_2_pin + entry->next;
> +	}
> +
> +}
> +
This change to remove_pin_to_irq is simply wrong.

> +static int add_irq_entry(int type, int irqflag, int bus, int irq, int apic, int
> pin)
> +{
> +        struct mpc_config_intsrc intsrc;
> +	int idx;
> +
> +        intsrc.mpc_type = MP_INTSRC;
> +        intsrc.mpc_irqflag = irqflag; /* conforming */
> +        intsrc.mpc_srcbus = bus;
> + intsrc.mpc_dstapic = (apic != -1) ? mp_ioapics[apic].mpc_apicid: MP_APIC_ALL;
> +
> +        intsrc.mpc_irqtype = type;
> +
> +        intsrc.mpc_srcbusirq = irq;
> +        intsrc.mpc_dstirq = pin;
> +
> +        mp_irqs [mp_irq_entries] = intsrc;
> +        Dprintk("Int: type %d, pol %d, trig %d, bus %d,"
> +                " IRQ %02x, APIC ID %x, APIC INT %02x\n",
> +                        intsrc.mpc_irqtype, intsrc.mpc_irqflag & 3,
> +                        (intsrc.mpc_irqflag >> 2) & 3, intsrc.mpc_srcbus,
> + intsrc.mpc_srcbusirq, intsrc.mpc_dstapic, intsrc.mpc_dstirq);
> +        idx = mp_irq_entries;
> +	if (++mp_irq_entries >= MAX_IRQ_SOURCES)
> +                panic("Max # of irq sources exceeded!!\n");
> +	return idx;

This is fairly sane but probably belongs in mptable.c as a helper.

>  /*
>   * Find the pin to which IRQ[irq] (ISA) is connected
>   */
> @@ -1570,6 +1658,22 @@ static inline void unlock_ExtINT_logic(void)
>   * fanatically on his truly buggy board.
>   */
>  
> +static void set_try_apic_pin(int apic, int pin, int type)
> +{
> +	int idx;
> +	int irq = 0;
> +	int bus = 0; /* MP_ISA_BUS */
> +	int irqflag = 5; /* MP_IRQ_TRIGGER_EDGE|MP_IRQ_POLARITY_HIGH */
> +
> +	idx = find_irq_entry(apic,pin,type);
> +
> +	if (idx == -1) 
> +		idx = add_irq_entry(type, irqflag, bus, irq, apic, pin);
> +
> +	add_pin_to_irq(irq, apic, pin);
> +	setup_IO_APIC_irq(apic, pin, idx, irq);
> +}
> +
>  static int try_apic_pin(int apic, int pin, char *msg)
>  {
>  	apic_printk(APIC_VERBOSE, KERN_INFO
> @@ -1588,7 +1692,7 @@ static int try_apic_pin(int apic, int pin, char *msg)
>  		}
>  		return 1;
>  	}
> -	clear_IO_APIC_pin(apic, pin);
> +
>  	apic_printk(APIC_QUIET, KERN_ERR " .. failed\n");
>  	return 0;
>  }
> @@ -1599,12 +1703,13 @@ static void check_timer(void)
>  	int apic1, pin1, apic2, pin2;
>  	int vector;
>  	cpumask_t mask;
> +	int i;
>  
>  	/*
>  	 * get/set the timer IRQ vector:
>  	 */
> -	disable_8259A_irq(0);
>  	vector = assign_irq_vector(0, TARGET_CPUS, &mask);
> +	disable_8259A_irq(0);

Moving disable_8259A_irq(0) appears to be useless code motion.
  
>  	/*
>  	 * Subtle, code in do_timer_interrupt() expects an AEOI
> @@ -1621,33 +1726,51 @@ static void check_timer(void)
>  	pin2  = ioapic_i8259.pin;
>  	apic2 = ioapic_i8259.apic;
>  
> -	/* Do this first, otherwise we get double interrupts on ATI boards */
> - if ((pin1 != -1) && try_apic_pin(apic1, pin1,"with 8259 IRQ0 disabled"))
> -		return;
> + apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d
> apic2=%d pin2=%d\n",
> +		vector, apic1, pin1, apic2, pin2);
>  
> -	/* Now try again with IRQ0 8259A enabled.
> -	   Assumes timer is on IO-APIC 0 ?!? */
> -	enable_8259A_irq(0);
> -	unmask_IO_APIC_irq(0);
> -	if (try_apic_pin(apic1, pin1, "with 8259 IRQ0 enabled"))
> -		return;
> -	disable_8259A_irq(0);
> +	if (pin1 != -1) {
> + /* Do this first, otherwise we get double interrupts on ATI boards */
> +		/* set_try_apic_pin will call disable_8259A_irq */
> +		set_try_apic_pin(apic1, pin1, mp_INT);
> +		unmask_IO_APIC_irq(0);
> +		if (try_apic_pin(apic1, pin1,"with 8259 IRQ0 disabled"))
> +			return;
>  
> -	/* Always try pin0 and pin2 on APIC 0 to handle buggy timer overrides
> -	   on Nvidia boards */
> -	if (!(apic1 == 0 && pin1 == 0) &&
> -	    try_apic_pin(0, 0, "fallback with 8259 IRQ0 disabled"))
> -		return;
> -	if (!(apic1 == 0 && pin1 == 2) &&
> -	    try_apic_pin(0, 2, "fallback with 8259 IRQ0 disabled"))
> -		return;
> +		/* Now try again with IRQ0 8259A enabled.
> +		   Assumes timer is on IO-APIC 0 ?!? */
> +		enable_8259A_irq(0);
> +		if (try_apic_pin(apic1, pin1, "with 8259 IRQ0 enabled"))
> +			return;
> +		disable_8259A_irq(0);

I am still trying to understand this enable_8259A_irq(0) case.
As far as I can tell this is a very backwards way of enabling
an ExtINT, as such it shouldn't be used until later.

YH do you have any insight why on some Nvidia chipsets we apic 0 pin 2 doesn't
work for the timer interrupt.  I thought that was what we were using in LinuxBIOS
for the mptable.

Eric
