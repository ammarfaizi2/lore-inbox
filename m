Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWAWXjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWAWXjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWAWXjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:39:02 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:4992 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030214AbWAWXjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:39:00 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: philb@gnu.org, tim@cyberelk.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] parport: add parallel port support for SGI O2
References: <87mzhqfq5y.fsf@groumpf.homeip.net>
	<20060122222425.6907656f.akpm@osdl.org>
From: Arnaud Giersch <arnaud.giersch@free.fr>
X-Face: &yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date: Tue, 24 Jan 2006 00:38:57 +0100
In-Reply-To: <20060122222425.6907656f.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 22 Jan 2006 22:24:25 -0800")
Message-ID: <87ek2ycy5q.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lundi 23 janvier 2006, vers 07:24:25 (+0100), Andrew Morton a écrit:

>> From: Arnaud Giersch <arnaud.giersch@free.fr>
>> 
>> Add support for the built-in parallel port on SGI O2 (a.k.a. IP32).
>> Define a new configuration option: PARPORT_IP32.  The module is named
>> parport_ip32.
>
> Nice looking driver.  Big.

Thanks.

> It does rather a lot of
>
> 	if (foo)	do_something();
>
> whereas we prefer
>
> 	if (foo)
> 		do_something();

Those are limited to the parport_ip32_dump_state() function.  The
rationale is that this function is only here for debugging purpose,
and I did not want to make it longer than it already is. 

I will correct the style.


>> +static void parport_ip32_dma_setup_context(unsigned int limit)
[...]
>> +		volatile u64 __iomem *ctxreg = (parport_ip32_dma.ctx == 0) ?
>> +			&mace->perif.ctrl.parport.context_a :
>> +			&mace->perif.ctrl.parport.context_b;
>
> Does this need to be volatile?   writeq() should do the right thing.

The "volatile" is here for type consistency.  Both variables
"mace->perif.ctrl.parport.context_a" and "context_b" (defined in
include/asm-mips/ip32/mace.h) are from type "volatile u64".  Omitting
the "volatile" qualifier for "ctxreg" would make gcc and sparse
complain.

I will add a comment to explain it in the code.


>> +static size_t parport_ip32_epp_read(void __iomem *eppreg,
[...]
>> +	if ((flags & PARPORT_EPP_FAST) && (len > 1)) {
>> +		readsb(eppreg, buf, len);
>
> readsb() is a mips thing, and doesn't seem to be documented.  What does it
> do, and why does the driver use it (only) here?
>
>> +		writesb(eppreg, buf, len);

readsb() and writesb() are like ioread8_rep() and iowrite8_rep().  The
io{read,write} family functions are however not available in the
linux-mips.org tree.

The usage of readsb() here is similar to that of insb() in the
corresponding code of the parport_pc driver.


>> +static unsigned int parport_ip32_fifo_wait_break(struct parport *p,
[...]
>> +	if (signal_pending(current)) {
>> +		printk(KERN_DEBUG PPIP32
>> +		       "%s: Signal pending\n", p->name);
>> +		return 1;
>> +	}
>
> This printk could be a bit noisy, if someone hoses a signal stream at a
> printing program.

I did not realized that.  I will try to correct the problem.


Thank you for your attention.

        Arnaud
