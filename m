Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbSIWXwq>; Mon, 23 Sep 2002 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSIWXwq>; Mon, 23 Sep 2002 19:52:46 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:61366 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S261473AbSIWXwp>; Mon, 23 Sep 2002 19:52:45 -0400
Date: Mon, 23 Sep 2002 18:57:56 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Waechtler <pwaechtler@mac.com>, Larry McVoy <lm@bitmover.com>,
       Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923185756.C13340@hexapodia.org>
References: <F425930C-CF2E-11D6-8873-00039387C942@mac.com> <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Sep 23, 2002 at 10:36:28PM +0200
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate big CC lists like this, but I don't know that everyone will see
this if I don't keep the CC list.  Sigh.

On Mon, Sep 23, 2002 at 10:36:28PM +0200, Ingo Molnar wrote:
> On Mon, 23 Sep 2002, Peter Waechtler wrote:
> > Getting into kernel is not the same as a context switch. Return EAGAIN
> > or EWOULDBLOCK is definetly _not_ causing a context switch.
> 
> this is a common misunderstanding. When switching from thread to thread in
> the 1:1 model, most of the cost comes from entering/exiting the kernel. So
> *once* we are in the kernel the cheapest way is not to piggyback to
> userspace to do some userspace context-switch - but to do it right in the
> kernel.
> 
> in the kernel we can do much higher quality scheduling decisions than in
> userspace. SMP affinity, various statistics are right available in
> kernel-space - userspace does not have any of that. Not to talk about
> preemption.

Excellent points, Ingo.  An alternative that I haven't seen considered
is the M:N threading model that NetBSD is adopting, called Scheduler
Activations.  The paper makes excellent reading.

http://web.mit.edu/nathanw/www/usenix/freenix-sa/freenix-sa.html

One advantage of a SA-style system is that the kernel automatically and
very cleanly has a lot of information about the job as a single unit,
for purposes such as signal delivery, scheduling decisions, (and if it
came to that) paging/swapping.  The original Linus-dogma (as I
understood it -- I may well be misrepresenting things here) is that "a
thread is a process, and that's all there is to it".  This has a lovely
clarity, but it ignores the fact that there are times when it's
*important* that the kernel know that "these N threads belong to a
single job".  It appears that the NPTL work is creating a new
"collection-of-threads" object, which will fulfill the role I mention
above...  and this isn't a lot different from the end result of Nathan
Williams' SA work.

Another advantage of keeping a "process" concept is that things like CSA
(Compatible System Accounting, nee Cray System Accounting) need to add
some overhead to process startup/teardown.  If a "thread" can be created
without creating a new "process", this overhead is not needlessly
present at thread-startup time.

-andy
