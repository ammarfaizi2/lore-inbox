Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWFZIKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWFZIKD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 04:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWFZIKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 04:10:02 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:39747 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S964863AbWFZIKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 04:10:01 -0400
Date: Mon, 26 Jun 2006 10:09:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060626080910.GA9418@osiris.boeblingen.de.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <20060624121541.GD10403@osiris.ibm.com> <20060625133128.GA23432@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625133128.GA23432@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's what I came up with Friday before I jumped timezones back east:
> 
> void smp_replace_instruction(void *info)
> {
> 	struct ins_replace_args *parms;
> 
> 	parms = (struct ins_replace_args *) info;
> 	cmpxchg(parms->addr, parms->oinsn, parms->ninsn);
> }
> 
> void __kprobes arch_arm_kprobe(struct kprobe *p)
> {
> 	struct ins_replace_args parms;
> 	parms.addr = p->addr;
> 	parms.ninsn = BREAKPOINT_INSTRUCTION;
> 	parms.oinsn = p->opcode;
> 
> 	on_each_cpu(smp_replace_instruction, &parms, 0, 1);
> } etc...
> 
> After reading your notes it's probably overkill doing the cs on each cpu, since
> the interrupt will discard the prefetched instructions.

Indeed. Another thing that should not be forgotten: it could be that the
whole kernel text segment resides in a shared read only segment. So it can
be shared by multiple z/VM guests.
In that case the cs instruction will fail. Looks like you need to write the
part that replaces the instruction in assembly and supply a fixup section
which in turn makes sure that -EFAULT is returned.
