Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVAGM7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVAGM7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVAGM7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:59:54 -0500
Received: from one.firstfloor.org ([213.235.205.2]:12220 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261398AbVAGM7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:59:52 -0500
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, stsp@aknet.ru
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org>
	<20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru>
	<20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru>
	<20041207055348.GA1305@in.ibm.com> <41B5FA1B.9090507@aknet.ru>
	<20041209124738.GB5528@in.ibm.com> <41B8A759.80806@aknet.ru>
	<20050107113732.GB16906@in.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Fri, 07 Jan 2005 13:59:51 +0100
In-Reply-To: <20050107113732.GB16906@in.ibm.com> (Prasanna S. Panchamukhi's
 message of "Fri, 7 Jan 2005 17:07:32 +0530")
Message-ID: <m1ekgxv1h4.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:


> +	/* Check if the application is using LDT entry for its code segment and
> +	 * calculate the address by reading the base address from the LDT entry.
> +	 */
> +	if ((regs->xcs & 4) && (current->mm)) {
> +		lp = (unsigned long *) ((unsigned long)((regs->xcs >> 3) * 8)
> +					+ (char *) current->mm->context.ldt);
> +		addr = (kprobe_opcode_t *) ((((*lp) >> 16 &  0x0000ffff)
> +				| (*(lp +1) & 0xff000000)
> +				| ((*(lp +1) << 16) & 0x00ff0000))
> +				+ regs->eip - sizeof(kprobe_opcode_t));
> +	} else {
> +		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
> +	}

With that patch we would have LDT reading code three times in the kernel
now (ptrace, prefetch workaround and now this). How about you factor
this out into a common helper function? This stuff is tricky enough
that there are likely bugs in there anyways and it would be best 
to only fix them at one place then.

-Andi
