Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbULLMQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbULLMQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 07:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbULLMQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 07:16:40 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:54699 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262066AbULLMQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 07:16:32 -0500
Date: Sun, 12 Dec 2004 13:15:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, Lee Revell <rlrevell@joe-job.com>,
       dipankar@in.ibm.com, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
Message-ID: <20041212121546.GM16322@dualathlon.random>
References: <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BC1BF9.70701@colorfullife.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 11:22:49AM +0100, Manfred Spraul wrote:
> Andrea Arcangeli wrote:
> 
> >On Sun, Dec 12, 2004 at 09:59:00AM +0100, Manfred Spraul wrote:
> > 
> >
> >>It means that our NMI irq return path should check if it points to a hlt 
> >>instruction and if yes, then increase the saved EIP by one before doing 
> >>the iretd, right?
> >>   
> >>
> >
> >I don't think we'll ever post any event through nmi, so it doesn't
> >matter. We only care to be waken by real irqs, not nmi/smi. Idle loop is
> >fine to ignore the actions of the nmi handlers and to hang into the
> >"hlt".
> > 
> >
> No, You misunderstood the problem:
> 
> sti
> ** NMI handler
> ** normal interrupt arrives, is queued by the cpu
> ** irqd from NMI handler
> ** cpu notices the normal interrupt, handles it.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ok. The above just wasn't obvious to me because iret of an nmi is doing
the same thing that sti does (and the nmi itself is like a cli).
Shouldn't iret wait 1 instruction too or is there a special case about
iret?  The specs only tells sti waits 1 instruction, but they don't tell
anything about iret (nor that it waits nor that it doesn't wait).  I
realized now the link posted here assumes iret isn't going to wait 1
instruction before processing pending irqs which is reasonable given the
specs don't tell anything about iret, but I didn't imagine there was a
difference between sti and iret (I mean only when iret is going to
change the interrupt enable flag from 0 to 1 just like sti does).

Overall this is a very minor issue (unless HZ is 0), it would only
introduce a 1/HZ latency to the irq that get posted while the nmi
handler is running, and the nmi handlers never runs in production.
Forcing idle=poll when the nmi watchdog is enabled is probably a
reasonable fix.

As for the SMI, I wonder how you plan to fix it.  To me it sounds like a
minor mistake that iret isn't equivalent to sti when it toggles the irq
enable bitflag (infact I don't see a way to fix it for smi, though I
know very little about smi).

thanks.
