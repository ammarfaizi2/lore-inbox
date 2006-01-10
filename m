Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWAJWX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWAJWX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWAJWX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:23:56 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:52107 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932572AbWAJWX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:23:56 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][repost] parport: add parallel port support for SGI O2
References: <87ace5jfgj.fsf@groumpf.homeip.net>
	<20060109185611.14202427.rdunlap@xenotime.net>
From: Arnaud Giersch <arnaud.giersch@free.fr>
X-Face: &yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date: Tue, 10 Jan 2006 23:23:52 +0100
In-Reply-To: <20060109185611.14202427.rdunlap@xenotime.net> (Randy Dunlap's
 message of "Mon, 9 Jan 2006 18:56:11 -0800")
Message-ID: <87hd8bhgcn.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mardi 10 janvier 2006, vers 03:56:11 (+0100), Randy.Dunlap a écrit:

> On Mon, 09 Jan 2006 21:47:56 +0100 Arnaud Giersch wrote:
>
>> diff -Naurp linux-2.6.15.orig/drivers/parport/parport_ip32.c linux-2.6.15/drivers/parport/parport_ip32.c
>> --- linux-2.6.15.orig/drivers/parport/parport_ip32.c	1970-01-01 01:00:00.000000000 +0100
>> +++ linux-2.6.15/drivers/parport/parport_ip32.c	2006-01-09 20:41:03.000000000 +0100

Hi Randy,

Thank you very much for your answer.  I will make the corrections and
come back with an updated version of my code.

> I scanned over the driver.  It seems to be in pretty good shape,
> but I have to wonder about the use of "volatile" and the
> barriers [wmb() and barrier()].  Are those really needed?

The "volatile" is needed for type consistency.  For the memory
barriers, I was not sure and I preferred to take a safe bet.  I will
try to investigate them further.  Any help or pointer to documentation
would be appreciated.  I have already read the documentation
distributed with the Linux source code, and the "Linux Device Drivers"
book by J. Corbet, A. Rubini, and G. Kroah-Hartman.

> Oh, and a really large inline function plus lots of smaller
> ones.

Ok, I will remove some "inline", and only keep them for the smaller
functions.

> Plus some comments below.

>> +static inline void parport_ip32_dma_setup_context(unsigned int limit)
>> +{
>> +	if (down_trylock(&parport_ip32_dma.lock)) {
>> +		/* Come back later please.  The MACE keeps sending interrupts
>> +		 * when a context is invalid, so there is no problem with this
>> +		 * early return. */
>> +		return;
>> +	}
>> +	if (parport_ip32_dma.left > 0) {
>> +		volatile u64 __iomem *ctxreg = (parport_ip32_dma.ctx == 0)?
>> +			&mace->perif.ctrl.parport.context_a:
>> +			&mace->perif.ctrl.parport.context_b;

The "volatile" is here because mace->perif.ctrl.parport.context_a and
context_b are from type "volatile u64".

>> +/**
>> + * parport_ip32_interrupt - interrupt handler
>
> Needs function parameters in kernel-doc.

>> +/**
>> + * parport_ip32_init_state - for core parport code
>
> Missing params in kernel-doc.

>> +/**
>> + * parport_ip32_save_state - for core parport code
>
> Missing params in kernel-doc (or just don't make it look like
> kernel-doc).

Ok.  Those are mostly functions whose parameters are dictated by an
external API.  I didn't want to duplicate their documentation.

>> +/*--- EPP mode functions -----------------------------------------------*/
>
> Why are a lot of the short EPP functions not inline?

They are not inline because their only use is via pointers in struct
parport_operations.

>> +		if (count > left) {
>> +			count = left;
>> +		}
>
> Style:  one-line if's don't use braces.

Ok.

>> +	return (len - left);
>
> Style:  no parens on return unless needed.

Ok.

>> +/*--- Default parport operations ---------------------------------------*/
>> +
>> +static __initdata struct parport_operations parport_ip32_ops = {
>
> Are you sure that it's safe for this to be __initdata?

Yes it is.  Its contents is copied in the parport_ip32_probe_port()
initialization function (see below).

>> +static __init struct parport *parport_ip32_probe_port(void)
>> +{
>> +	struct parport_ip32_regs regs;
>> +	struct parport_ip32_private *priv = NULL;
>> +	struct parport_operations *ops = NULL;
>> +	struct parport *p = NULL;
>> +	int err;
>> +
>> +	parport_ip32_make_isa_registers(&regs, &mace->isa.parallel,
>> +					&mace->isa.ecp1284, 8 /* regshift */);
>> +
>> +	ops = kmalloc(sizeof(struct parport_operations), GFP_KERNEL);
>> +	priv = kmalloc(sizeof(struct parport_ip32_private), GFP_KERNEL);
>> +	p = parport_register_port(0, PARPORT_IRQ_NONE, PARPORT_DMA_NONE, ops);
>> +	if (ops == NULL || priv == NULL || p == NULL) {
>> +		err = -ENOMEM;
>> +		goto fail;
>> +	}
>> +	p->base = MACE_BASE + offsetof(struct sgi_mace, isa.parallel);
>> +	p->base_hi = MACE_BASE + offsetof(struct sgi_mace, isa.ecp1284);
>> +	p->private_data = priv;
>> +
>> +	*ops = parport_ip32_ops;

Here is the only use of parport_ip32_ops.

>> +	return IS_ERR(this_port)? PTR_ERR(this_port): 0;
>
> Please use spaces before and after '?' and ':'.

Ok.

        Arnaud
