Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTEOVvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTEOVvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:51:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16593 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264259AbTEOVvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:51:33 -0400
Subject: Re: Race between vmtruncate and mapped areas?
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030515191921.GJ1429@dualathlon.random>
References: <20030513181018.4cbff906.akpm@digeo.com>
	 <18240000.1052924530@baldur.austin.ibm.com>
	 <20030514103421.197f177a.akpm@digeo.com>
	 <82240000.1052934152@baldur.austin.ibm.com>
	 <20030515004915.GR1429@dualathlon.random>
	 <20030515013245.58bcaf8f.akpm@digeo.com>
	 <20030515085519.GV1429@dualathlon.random>
	 <20030515022000.0eb9db29.akpm@digeo.com>
	 <20030515094041.GA1429@dualathlon.random>
	 <1053016706.2693.10.camel@ibm-c.pdx.osdl.net>
	 <20030515191921.GJ1429@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1053036250.2696.33.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 May 2003 15:04:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 12:19, Andrea Arcangeli wrote:
> On Thu, May 15, 2003 at 09:38:26AM -0700, Daniel McNeil wrote:
> > On Thu, 2003-05-15 at 02:40, Andrea Arcangeli wrote:
> > > On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > > >
> > > > > and it's still racy
> > > > 
> > > > damn, and it just booted ;)
> > > > 
> > > > I'm just a little bit concerned over the ever-expanding inode.  Do you
> > > > think the dual sequence numbers can be replaced by a single generation
> > > > counter?
> > > 
> > > yes, I wrote it as a single counter first, but was unreadable and it had
> > > more branches, so I added the other sequence number to make it cleaner.
> > > I don't mind another 4 bytes, that cacheline should be hot anyways.
> > 
> > You could use the seqlock.h sequence locking.  It only uses 1 sequence
> > counter.  The 2.5 isize patch 1 has a sequence lock without the spinlock
> > so it only uses 4 bytes and it is somewhat more readable.  I don't
> > think it has more branches.
> > 
> > I've attached the isize seqlock.h patch.
> 
> what do you think of the rmb vs mb in the reader side? Can I use rmb
> too? I used mb() to go safe. I mean gettimeofday is a no brainer since
> it does only reads inside the critical section anyways. But here I feel
> I need mb().
> 
> 
> And yes, there are no more branches sorry, just an additional or.
> 
> Andrea

rmb() is safe on the read side.  In fact, The mb()s only need to be
smp_rmb()s and the wmb()s only need to be smp_wmb()s.

Also, the mb() after the spin_lock(&mm->page_table_lock);
is not even needed since spin_lock() acts as a memory barrier.

Why do you feel you need the mb()?
Isn't everything the reader might do protected already?
You just using the sequence value to know whether you should
cleanup and retry.

Also, I like using the seqlock.h approach since it gives consistent
use of sequence locks, is a bit more readable, and documents and hides
all the memory barrier stuff.

Is there any possibility that the truncate side can run faster than
the reader side?  
-- 
Daniel McNeil <daniel@osdl.org>

