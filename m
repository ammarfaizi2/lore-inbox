Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbTHUR1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTHUR1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:27:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58780
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262806AbTHUR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:27:23 -0400
Date: Thu, 21 Aug 2003 19:27:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: TeJun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030821172721.GI29612@dualathlon.random>
References: <3F44FAF3.8020707@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F44FAF3.8020707@colorfullife.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 07:01:39PM +0200, Manfred Spraul wrote:
> TeJun wrote:
> >static inline void irq_enter(int cpu, int irq)
> >{
> >	++local_irq_count(cpu);
> >
> >	while (test_bit(0,&global_irq_lock)) {
> >		cpu_relax();
> >	}
> >}
> >
> > Is it a race condition or am I getting it horribly wrong?  Thx in
> >advance.
> 
> Yes, it's a race. Actually a variant of the race that lead to the 
> introduction of set_current_state():
> 
> test_bit is a simple read instruction. i386 cpus are free to execute it 
> early, i.e. they can execute it before the write part of 
> "++local_irq_count(cpu)".
> 
> I think smp_rmb() is the right barrier - could you write a patch and send 
> it to Marcelo?

smb_rmb is enough in practice for x86 (in asm-i386), but not the right
barrier in general because rmb only serializes reads against reads, so
it would also make little sense while reading the i386 code. here you've
to serialize a write against a read so it would be misleading unless you
know exactly the lowlevel implementations of those barriers.

smp_mb() before the while loop should be the correct barrier for all
archs and the asm generated on x86 will be the same.

alpha, ia64 and x86-64 (and probably others) needs it too.

Andrea
