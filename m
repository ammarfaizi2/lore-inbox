Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTELN2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTELN2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:28:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6481 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262148AbTELN2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:28:32 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4 (machine_power_off returning causes problems)
References: <8570000.1052623548@[10.10.2.4]>
	<20030510224421.3347ea78.akpm@digeo.com>
	<8880000.1052624174@[10.10.2.4]>
	<20030510231120.580243be.akpm@digeo.com>
	<12530000.1052664451@[10.10.2.4]>
	<m17k8x72ir.fsf_-_@frodo.biederman.org>
	<19660000.1052710226@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 May 2003 07:37:55 -0600
In-Reply-To: <19660000.1052710226@[10.10.2.4]>
Message-ID: <m11xz45lqk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> Yup, backing out kexec fixes it.
> > 
> > 
> > Ok.  Thinking it through the differences is that I have machine_power_off
> > call stop_apics (which is roughly equivalent to the old smp_send_stop).
> 
> Mmmm. Not sure NUMA-Q will like disconnect_bsp_APIC() much, but I guess
> that's my problem, not yours ;-) I can't do init 6 at the moment, so I'm
> walking on thin ice as is ... if I have to fix a couple of things up for
> NUMA-Q, that's no problem.

Ah ok.  This could explain some of your problems with kexec if you
can't even reboot the box....
 
> > In the kexec patch that does 2 things.
> > 1) It shuts down the secondary cpus, and returns the bootstrap cpu to
> >    virtual wire mode. 
> > 2) It calls set_cpus_allowed to force the reboot to be on the primary
> >    cpu.
> > 
> > After returning from machine_power_off. We run into a problem
> > in flush_tlb_mm.  Because we have a cpu disabled, that is still part
> > of the mm's vm mask.
> 
> OK ... I presume that's just because you shut down the secondaries then.
> If so ... shouldn't it remove them from the relevant vm mask when it
> offlines them? (probably not your code, but still)

Right.  The code is more about shutting down the secondaries then off
lining them.  In a general purpose scenario I expect more would need
to happen.

> > Does anyone know why machine_halt, and machine_power_off return?
> 
> Nope, thats ... odd ;-)

That is what I thought.

I have sent the fixed patches to Andrew and CC'd the list so we will
see what develops.

Eric

