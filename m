Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSCKUaL>; Mon, 11 Mar 2002 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSCKUaD>; Mon, 11 Mar 2002 15:30:03 -0500
Received: from zero.tech9.net ([209.61.188.187]:8720 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292852AbSCKU3x>;
	Mon, 11 Mar 2002 15:29:53 -0500
Subject: Re: [PATCH] 2.5.6-pre3 Fix small race in BSD accounting [part 2]
From: Robert Love <rml@tech9.net>
To: Bob Miller <rem@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020311120744.B5995@doc.pdx.osdl.net>
In-Reply-To: <20020311120744.B5995@doc.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 11 Mar 2002 15:30:03 -0500
Message-Id: <1015878604.853.66.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-11 at 15:07, Bob Miller wrote:

> While looking at the bug fix for part 1 I coded up this patch
> to change the BSD accounting code to use a spinlock instead
> of the BKL.

Oh, Good Job - BKL is evil.  And I think that is partly evident in the
resulting code, and I have a couple comments about it.

I suspect the recursive nature of the BKL (and perhaps the locking rules
such that you don't always hold alock, i.e. if name is not NULL) are
responsible for:

	if (!locked)
		spin_lock(&acct_lock);

which really isn't the prettiest or safest thing, although I don't
actually see any problems with it here.  With the BKL removed, it may be
better to rewrite the code in a cleaner and saner way.

I'd much rather see sane locking rules where we knew the callers and
each function entry clearly either held or does not hold the spin_lock. 
Make sure we don't call anything holding the lock, et cetera ...

Also, I like the struct but the defines are a bit ugly.  Why not just
s/acct_lock/acct_globals.lock/, for example, in the code?  Or Just call
the instance of the struct "acct" and have acct.lock, etc.

In other words, good job, but this is a development kernel - rip some of
this cruft up and make it perfect, no?

	Robert Love

