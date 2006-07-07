Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWGGRXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWGGRXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWGGRXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:23:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:52666 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932224AbWGGRXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:23:32 -0400
Date: Fri, 7 Jul 2006 13:23:33 -0400
From: Mike Grundy <grundym@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060707172333.GA12068@localhost.localdomain>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <1151421789.5390.65.camel@localhost> <20060628055857.GA9452@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628055857.GA9452@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 07:58:57AM +0200, Heiko Carstens wrote:
> On Tue, Jun 27, 2006 at 05:23:09PM +0200, Martin Schwidefsky wrote:
> > On Sat, 2006-06-24 at 13:36 +0200, Heiko Carstens wrote:
> > > Just do a compare and swap operation on the instruction you want to replace,
> > > then do an smp_call_function() with the wait parameter set to 1 and passing
> > > a pointer to a function that does nothing but return.
> > Not good enough. An instruction can be fetched multiple times for a
> > single execution (see the other mail). So you have a half executed
> > instruction, the cache line is invalidated, a new instruction is written
> > and the cache line is recreated to finished the half executed
> > instruction. That can easiliy happen on millicoded instructions.
> 
> Yes, looks like I was too optimistic. Seems like we really have to go for
> stop_machine_run() unless somebody comes up with a better idea...

ok, I tried, but my "better ideas" made things worse. stop_machine_run() wins:

void __kprobes arch_arm_kprobe(struct kprobe *p)
{
        struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
        unsigned long status = kcb->kprobe_status;
        struct ins_replace_args args;

        args.ptr = p->addr;
        args.old = p->opcode;
        args.new = BREAKPOINT_INSTRUCTION;

        kcb->kprobe_status = KPROBE_SWAP_INST;
        stop_machine_run(swap_instruction, &args, NR_CPUS);
        kcb->kprobe_status = status;
}

It works, and I guess at this point is the only way to do it. I'll send out a 
full patch with this and the other cleanups later.

Mike
