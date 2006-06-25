Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWFYNbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWFYNbS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWFYNbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:31:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:15803 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750726AbWFYNbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:31:18 -0400
Date: Sun, 25 Jun 2006 06:31:28 -0700
From: Mike Grundy <grundym@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060625133128.GA23432@localhost.localdomain>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jan Glauber <jan.glauber@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <20060624121541.GD10403@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624121541.GD10403@osiris.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 02:15:41PM +0200, Heiko Carstens wrote:
> > Just do a compare and swap operation on the instruction you want to replace,
> > then do an smp_call_function() with the wait parameter set to 1 and passing
> > a pointer to a function that does nothing but return.
Here's what I came up with Friday before I jumped timezones back east:

void smp_replace_instruction(void *info)
{
	struct ins_replace_args *parms;

	parms = (struct ins_replace_args *) info;
	cmpxchg(parms->addr, parms->oinsn, parms->ninsn);
}

void __kprobes arch_arm_kprobe(struct kprobe *p)
{
	struct ins_replace_args parms;
	parms.addr = p->addr;
	parms.ninsn = BREAKPOINT_INSTRUCTION;
	parms.oinsn = p->opcode;

	on_each_cpu(smp_replace_instruction, &parms, 0, 1);
} etc...

After reading your notes it's probably overkill doing the cs on each cpu, since
the interrupt will discard the prefetched instructions.

-- 
Thanks
Mike

=========================================
Michael Grundy - grundym@us.ibm.com
Advanced Linux Response Team (ALRT)
http://ltc.linux.ibm.com/teamweb/alrt/
845-435-8842 (T/L 295)

If at first you don't succeed, call in an air strike.

