Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTEOXEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTEOXEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:04:30 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38310
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264274AbTEOXE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:04:26 -0400
Date: Fri, 16 May 2003 01:17:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030515231714.GL1429@dualathlon.random>
References: <20030514103421.197f177a.akpm@digeo.com> <82240000.1052934152@baldur.austin.ibm.com> <20030515004915.GR1429@dualathlon.random> <20030515013245.58bcaf8f.akpm@digeo.com> <20030515085519.GV1429@dualathlon.random> <20030515022000.0eb9db29.akpm@digeo.com> <20030515094041.GA1429@dualathlon.random> <1053016706.2693.10.camel@ibm-c.pdx.osdl.net> <20030515191921.GJ1429@dualathlon.random> <1053036250.2696.33.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053036250.2696.33.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 03:04:10PM -0700, Daniel McNeil wrote:
> On Thu, 2003-05-15 at 12:19, Andrea Arcangeli wrote:
> > On Thu, May 15, 2003 at 09:38:26AM -0700, Daniel McNeil wrote:
> > > On Thu, 2003-05-15 at 02:40, Andrea Arcangeli wrote:
> > > > On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > > > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > > > >
> > > > > > and it's still racy
> > > > > 
> > > > > damn, and it just booted ;)
> > > > > 
> > > > > I'm just a little bit concerned over the ever-expanding inode.  Do you
> > > > > think the dual sequence numbers can be replaced by a single generation
> > > > > counter?
> > > > 
> > > > yes, I wrote it as a single counter first, but was unreadable and it had
> > > > more branches, so I added the other sequence number to make it cleaner.
> > > > I don't mind another 4 bytes, that cacheline should be hot anyways.
> > > 
> > > You could use the seqlock.h sequence locking.  It only uses 1 sequence
> > > counter.  The 2.5 isize patch 1 has a sequence lock without the spinlock
> > > so it only uses 4 bytes and it is somewhat more readable.  I don't
> > > think it has more branches.
> > > 
> > > I've attached the isize seqlock.h patch.
> > 
> > what do you think of the rmb vs mb in the reader side? Can I use rmb
> > too? I used mb() to go safe. I mean gettimeofday is a no brainer since
> > it does only reads inside the critical section anyways. But here I feel
> > I need mb().
> > 
> > 
> > And yes, there are no more branches sorry, just an additional or.
> > 
> > Andrea
> 
> rmb() is safe on the read side.  In fact, The mb()s only need to be
> smp_rmb()s and the wmb()s only need to be smp_wmb()s.

they all can be smp_ things indeed

> Also, the mb() after the spin_lock(&mm->page_table_lock);
> is not even needed since spin_lock() acts as a memory barrier.

no, the spin_lock only acts as a barrier in one way, not both ways, so
an smp_something is still needed.

But yes, I think it can be a smp_rmb, so I can use the seqlock code.

> Why do you feel you need the mb()?

just because there are both reads and writes in the critical section,
but what matters is what we read not what we wrote. we must make sure
that we have read a real pagecache page outside the page_table_lock,
doesn't matter anything else, doesn't matter when our writes are
excuted (the code is just robust against not-oopsing), so s/mb/smp_rmb/
should do fine here and we can use the seqlock framework.

> Isn't everything the reader might do protected already?
> You just using the sequence value to know whether you should
> cleanup and retry.
> 
> Also, I like using the seqlock.h approach since it gives consistent
> use of sequence locks, is a bit more readable, and documents and hides
> all the memory barrier stuff.

Well, that was a quick patch I was more focused on the design than the
implementation, so yes, now that we cleared the mb thing we can convert
it to the seqlock. As said my tree is still using the old names and
implementation of the seqlock, I don't think it's very important to
upgrade it, but maybe I should, comments? (I've a few patches that can
make a difference in my queue, so it will probably happen later if
something)

> 
> Is there any possibility that the truncate side can run faster than
> the reader side?  

speed doesn't matter.

thanks for the help!

Andrea
