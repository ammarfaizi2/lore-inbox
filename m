Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUHELON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUHELON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbUHELMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:12:13 -0400
Received: from zero.aec.at ([193.170.194.10]:18436 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267643AbUHELKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:10:12 -0400
To: prasanna@in.ibm.com
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@muc.de, akpm@osdl.org,
       suparna@in.ibm.com
Subject: Re: [1/3] kprobes-func-args-268-rc3.patch
References: <2pMJz-13N-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 05 Aug 2004 13:09:46 +0200
In-Reply-To: <2pMJz-13N-9@gated-at.bofh.it> (Prasanna S. Panchamukhi's
 message of "Thu, 05 Aug 2004 11:30:09 +0200")
Message-ID: <m3acx9yh6t.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> traps again to restore processor state and switch back to the
> probed function. Linus noted correctly at KS that we need to be 
> careful as gcc assumes that the callee owns arguments. For the
> time being we try to avoid tailcalls in the probe function; in 
> the long run we should probably also save and restore enough 
> stack bytes to cover argument space.
>
> Sample Usage:
> 	static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
> 	{
> 		... whatever ...
> 		jprobe_return();
> 		/*No tailcalls please */
> 		return 0;
> 	}

I think you misunderstood Linus' suggestion.  The problem with
modifying arguments on the stack frame is always there because the C
ABI allows it. One suggested solution was to use a second function
call that passes the arguments again to get a private copy. But the
compiler's tail call optimization could sabotate that when you a
are not careful.

That's all quite hackish and compiler dependent. I would suggest an 
assembly wrapper that copies the arguments when !CONFIG_REGPARM.
Just assume the function doesn't have more than a fixed number
of arguments, that should be good enough.

This way you avoid any subtle compiler dependencies.
With CONFIG_REGPARM it's enough to just save/restore pt_regs,
which kprobes will do anyways.
>  
>  static struct kprobe *current_kprobe;
>  static unsigned long kprobe_status, kprobe_old_eflags, kprobe_saved_eflags;
> +static struct pt_regs kprobe_saved_regs;
> +static long *kprobe_saved_esp;
> +extern void show_registers(struct pt_regs *regs);

Shouldn't that be in some header? 

  
> +
> +int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
> +{
> +	u8 *addr = (u8 *)(regs->eip-1);
> +
> +	if ((addr > (u8 *)jprobe_return) && (addr < (u8 *)jprobe_return_end)) {

It would be probably safer to use RELOC_HIDE on the function pointer here,
just to be safe against future gcc optimizations

The rest looks ok.

-Andi

