Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbTHUWoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTHUWoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:44:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18885
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262923AbTHUWoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:44:11 -0400
Date: Fri, 22 Aug 2003 00:44:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: manfred@colorfullife.com, tejun@aratech.co.kr,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030821224411.GK29612@dualathlon.random>
References: <3F44FAF3.8020707@colorfullife.com> <20030821172721.GI29612@dualathlon.random> <20030821234824.37497c08.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821234824.37497c08.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 11:48:24PM +0200, Stephan von Krawczynski wrote:
> 
> > smb_rmb is enough in practice for x86 (in asm-i386), but not the right
> > barrier in general because rmb only serializes reads against reads, so
> > it would also make little sense while reading the i386 code. here you've
> > to serialize a write against a read so it would be misleading unless you
> > know exactly the lowlevel implementations of those barriers.
> > 
> > smp_mb() before the while loop should be the correct barrier for all
> > archs and the asm generated on x86 will be the same.
> > 
> > alpha, ia64 and x86-64 (and probably others) needs it too.
> 
> Can some kind soul please provide me with the needed mini-patch. I would like
> to try that on my constantly crashing SMP test box...

--- 2.4.22pre7aa1/include/asm-i386/hardirq.h.~1~	2003-07-20 18:39:04.000000000 +0200
+++ 2.4.22pre7aa1/include/asm-i386/hardirq.h	2003-08-22 00:24:08.000000000 +0200
@@ -71,6 +71,8 @@ static inline void irq_enter(int cpu, in
 {
 	++local_irq_count(cpu);
 
+	smp_mb();
+
 	while (test_bit(0,&global_irq_lock)) {
 		cpu_relax();
 	}

Andrea
