Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUJRMqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUJRMqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 08:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUJRMqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 08:46:08 -0400
Received: from colin2.muc.de ([193.149.48.15]:45574 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266427AbUJRMqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 08:46:02 -0400
Date: 18 Oct 2004 14:46:00 +0200
Date: Mon, 18 Oct 2004 14:46:00 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
Subject: Re: [1/2] PATCH Kernel watchpoint interface-2.6.9-rc4-mm1
Message-ID: <20041018124600.GA6175@muc.de>
References: <20041018084312.GG27204@in.ibm.com> <20041018084525.GA27936@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018084525.GA27936@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +config DEBUGREG
> +	bool "Global Debug Registers"

I agree with Keith that it shouldn't be user visible. I would always
enable it in fact.

> +{
> +	int i;
> +	if (flag == DR_ALLOC_LOCAL) {

[...] This all would be simpler if you used lib/idr.c, no?

> +int dr_free(int regnum)
> +{
> +	spin_lock(&dr_lock);
> +	if (regnum >= DR_MAX || dr_list[regnum].flag == DR_UNUSED) {
> +		spin_unlock(&dr_lock);
> +		return -1;

This should printk

> +#ifdef CONFIG_DEBUGREG
> +{
> +	/*
> +	 * Don't reload global debug registers. Don't touch the global debug
> +	 * register settings in dr7.
> +	 */
> +	unsigned long next_dr7 = next->debugreg[7];
> +	if (unlikely(next_dr7)) {
> +		if (DR7_L0(next_dr7)) loaddebug(next, 0);
> +		if (DR7_L1(next_dr7)) loaddebug(next, 1);
> +		if (DR7_L2(next_dr7)) loaddebug(next, 2);
> +		if (DR7_L3(next_dr7)) loaddebug(next, 3);

I would do this differently - check instead if the registers
are different between the tasks and only reload when different.
This will make updating/freeing more expensive because
you will need to change all tasks, but imho it's worth it.

And then no ifdefs please.

>  	 */
>  clear_dr7:
> -	__asm__("movl %0,%%db7"
> -		: /* no output */
> -		: "r" (0));
> +	load_process_dr7(0);
>  	CHK_REMOTE_DEBUG(1,SIGTRAP,error_code,regs,)

That's mm (and should go away anyways because debug notifiers are better) 
I would do the patch against mainline so that it can be actually merged.

-Andi
