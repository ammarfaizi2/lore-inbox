Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVAKJ4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVAKJ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVAKJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:56:16 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38221
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262664AbVAKJ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:56:03 -0500
Date: Tue, 11 Jan 2005 10:56:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Edjard Souza Mota <edjard@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050111095616.GH26799@dualathlon.random>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <4d6522b90501101803523eea79@mail.gmail.com> <1105433093.17853.78.camel@tglx.tec.linutronix.de> <4d6522b905011101202918f361@mail.gmail.com> <1105435846.17853.85.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105435846.17853.85.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:30:46AM +0100, Thomas Gleixner wrote:
> > > > 2) killing just gets the first candidate from the list and kills it.
> > > > No need to calculate
> > > >     at kernel level.
> 
> So I need a userspace change in order to solve a kernel problem ?

Allowing userspace to tune is a great idea. However we cannot invoke
userland at oom-time to make the decision, or it would be deadlock prone
(userland may be swapped out or it might require minor allocations of
memory, if we were to allow userspace to do the decision it would be
required to be a mlockall userland and not allowed to do syscalls, and
even then it could mess up with the stack or signal handlers). So the
safe thing to do is to assign different ratings to different userspace
tasks. Of course this is inherited from the childs. That is a reasonable
approach IMHO. Kurt wrote that patch, I only ported it to a more recent
codebase.

This way you can rate your important services and the not important
ones.

Anyway as you've mentioned in a earlier email, there were more
fundamental problems than the selection algorithm, the userspace rating
was the lowest one in the prio list.
