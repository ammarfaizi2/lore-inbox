Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQJ3PSm>; Mon, 30 Oct 2000 10:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQJ3PSX>; Mon, 30 Oct 2000 10:18:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38150 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129043AbQJ3PSS>;
	Mon, 30 Oct 2000 10:18:18 -0500
Date: Mon, 30 Oct 2000 15:18:14 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
Message-ID: <20001030151814.F2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk> <39FAD698.2FF9C8C8@didntduck.org> <20001028145312.B2272@parcelfarce.linux.theplanet.co.uk> <39FADAC9.DC1255D1@didntduck.org> <20001028160537.C2272@parcelfarce.linux.theplanet.co.uk> <39FAF5BE.C79801A2@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39FAF5BE.C79801A2@didntduck.org>; from bgerst@didntduck.org on Sat, Oct 28, 2000 at 11:50:22AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 11:50:22AM -0400, Brian Gerst wrote:
> Philipp Rumpf wrote:
> > 
> > On Sat, Oct 28, 2000 at 09:55:21AM -0400, Brian Gerst wrote:
> > > Yes, but they can be called (and sleep) with module refcount == 0.  This
> > > is because the file descripter used to perform the ioctl isn't directly
> > > associated with the network device, thereby not incrementing the
> > > refcount on open.
> > 
> > According to my proposal, it is perfectly safe to call a function in a module
> > while the module's use count is 0.  This function would typically look like this:
> > 
> > foo()
> > {
> >         MOD_INC_USE_COUNT;
> > 
> >         copy_*_user() (or anything else that sleeps);
> > 
> >         MOD_DEC_USE_COUNT;
> > 
> >         return bar;
> > }
> > 
> > The only difference to the "old" module scheme is that the above currently isn't
> > safe on SMP systems.
> 
> This will only work while the kernel is not preemptable.  Once the
> kernel thread can be rescheduled, all bets are off.

The implementation will need adjusting for preemptable kernel threads.  The
concept still works fine.	

> With or without your patch, the network ioctls are unsafe, since they
> don't currently do refcounting at all.

I was under the impression most network ioctls didn't sleep.

> Adding it in the layer above thTe
> driver is the easier and cleaner solution.

I disagree.  I dislike special-casing inter-module calls (and that's not even
taking into account that the current implementation of an inter-module call is
quite ugly).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
