Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVFLUDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVFLUDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 16:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVFLTWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:22:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12052
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262648AbVFLRBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:01:54 -0400
Date: Sun, 12 Jun 2005 19:01:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050612170147.GE5796@g5.random>
References: <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611210417.GC1299@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 02:04:17PM -0700, Paul E. McKenney wrote:
> Well, I probably should have edited the "TO" and "CC" lines to make it
> clear that I was not singling you out.  Please accept my apologies for
> making it appear that I was singling you out.

No need of apologies, your email was very appreciated. I greatly regret
posting here only after reading the weird emails that some people from
some other company posts. Having to pass emails through the
politically-correct filter before sending them isn't very entertaining
work.

> as well.  As to patent claims, don't get me started...

Well, AFIK we're not supposed to be able to read them cause we're not
lawyers, so I don't feel guilty in not understanding them completely, I
try only to understand and remember the _concept_ of the patent, I don't
even try to understand or remember all the legal details of the claims
which seems completely unreadable for me even though I know it's the
most important part of any patent.

> sort of software tool that scanned the required code to produce such
> guarantee, but I have not heard of anyone actually doing this with
> any Linux-based realtime scheme.

With the nanokernel approach it's quite easy to provide a guarantee
because there are no million of possible paths that the software can
take. So demonstrating that with cold cache it takes less than 50usec to
reach the RT userland regardless whatever path is taken is quite easy
and feasible IMHO.

One still has the risk of the system crashing with memory corruption
from a bad device driver, but the hardware can crash too. At some point
one has to relay on stress testing, but starting from a weak design
doesn't sound correct to me, especially if later something goes wrong in
production (which from my point of view would make the designer liable
if the design was flakey and the proper math wasn't done, it's like a
bridge falling because proper math wasn't done, unless one tells the
customer to use the stuff at his own risk, which doesn't sound a great
form of "guarantee" in the first place ;).

With preempt-RT RTOS there are way too many possible paths to even
attempt at providing a guarantee IMHO.

> is required as well -- the PCI issue with X was a new one for me!

I knew pci hardware can stall the bus, but I seriously hoped core things
like memory controller in the northbridge or embedded in the cpu would
not risk to generate any starvation. So far I thought by ruling out
desktop graphics card or other fancy pci stuff that needs some extreme
performance, one would have been fairly safe after some benchmarking. I
hope on some embedded arch like arm people is careful to design
northbridge to be RT compliant.

> If your realtime application needs every scrap of realtime response that
> the hardware can deliver, then I agree that the dual-OS/dual-core approach
> is very likely the best choice.  But it depends on what OS services the
> realtime portion of the application needs.  Beyond a certain point,
> it might be better to accept some probability of scheduling failure
> from Linux than to accept a perhaps-higher probability of bugs from a
> less-throroughly-tested RTOS.  Or maybe not.  To decide, it is necessary
> to look carefully at the details of the app, the RTOS, and Linux.

Agreed.

I think using preempt-RT RTOS in problems where RTAI/rtlinux is equally
simple would be a big waste and an unnecessary lower reliability. RTOS
tries to keep the userland API as close as possible to the non-RT one,
by increasing the kernel complexity with relative slowdown. So the whole
system is certainly more complicated and slower even though the userland
part alone may be a bit simpler.

Things becomes different if the RT app isn't fully in userland (like
multimedia), once the RT app has to call deep into kernel code, then
RTAI quickly becomes useless (ok it can run nanosleep with fusion fine,
but I don't see how RTAI can run getdents or stuff like that which
requires shared non-RT aware locks). Clearly it's possible to design a
non-RT thread doing the non-RT stuff, and passing up the info to the
RTAI userland RT thread, but RTOS is better at that, since the kernel
locks will have RT awareness and because irqs will get out of the way.

But once somebody calls into the kernel for getdents, one can forget the
word hard-RT, the mutex will get out of the way in the userland, but not
in the kernel code, and kmalloc will swap.

Infact from my point of view preempt-RT and RTAI are fully orthogonal.

My view is still preempt-RT as a much much much improved soft-RT, and
RTAI/rtlinux as the only hard-RT with guaranteed deadline.

If it was me having to call stuff like getdents in userland from a RT
context, I could try using preempt-RT with a soft-RT thread passing up
the getdents results to a RTAI hard-RT thread, mixing RTAI and
preempt-RT in the same system.

As usual when I talk about hard-RT I think at the 1st kind of hard-RT
where missing a deadline is unacceptable. As said before, the hard-RT
type 2 is fine with current soft-RT linux too by just calling
gettimeofday after the deadline was supposed to be met (or by an
equivalent hack in the scheduler calling gettimeofday in kernel space
and killing the task or sending a signal, whatever).

> Excellent point, am adding "mutex code" to the list.  How does the
> following look?
> 
> e.	Any code that holds a lock, mutex, semaphore, or other resource
> 	that is needed by the code implementing your new feature, as
> 	well as the code that actually implements the lock, mutex,
> 	semaphore, or other resource.

Looks fine thanks!

> Glad you liked it, and, again, please accept my apologies for appearing
> to be singling you out.

Don't worry, I didn't feel singled out, and infact I greatly appreciated
your contribution, thanks.
