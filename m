Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276429AbRJKO22>; Thu, 11 Oct 2001 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJKO2T>; Thu, 11 Oct 2001 10:28:19 -0400
Received: from [202.135.142.195] ([202.135.142.195]:42763 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S276429AbRJKO2A>; Thu, 11 Oct 2001 10:28:00 -0400
Date: Thu, 11 Oct 2001 16:50:19 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-Id: <20011011165019.66294c59.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0110100230170.1518-100000@penguin.transmeta.com>
In-Reply-To: <20011010182730.0077454b.rusty@rustcorp.com.au>
	<Pine.LNX.4.33.0110100230170.1518-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 02:36:13 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> 
> On Wed, 10 Oct 2001, Rusty Russell wrote:
> >
> > If noone *holds* a reference, you can remove it "sometime later",
> > where "sometime later" is (for example) after every CPU has scheduled.
> 
> Ehh.. One of those readers can hold on to the thing while waiting for
> something else to happen.
> 
> Looking up a data structure and copying it to user space or similar is
> _the_ most common operation for any lookup.

Woah!  So now we're abandoning spinlocks for semaphores, given your
enlightened reasoning?  What are you going to call your new OS?

If you needed reference counts before, you need them still.  But you can
frequently get rid of the spinlock/rwlock protecting the list as a whole.

No, it's not possible everywhere.  But naive profiling doesn't show the
damage from grabbing a read lock, since the penalty is paid by other CPUs
(running unrelated code) as well as the one dirtying the cache, so the
penalty gets smeared across the profile.

As Dave says: the cost is not spinning for the lock, it's the cacheline,
and that's the same with a rwlock as a spinlock, and it's going to get
*worse* with new architectures.

Rusty.
