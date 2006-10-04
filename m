Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWJDTnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWJDTnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWJDTnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:43:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750937AbWJDTnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:43:12 -0400
Date: Wed, 4 Oct 2006 12:43:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Must check what?
Message-Id: <20061004124310.10c9939b.akpm@osdl.org>
In-Reply-To: <20061004192537.GH28596@parisc-linux.org>
References: <20061004183752.GG28596@parisc-linux.org>
	<20061004120242.319a47e4.akpm@osdl.org>
	<20061004192537.GH28596@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 13:25:37 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Wed, Oct 04, 2006 at 12:02:42PM -0700, Andrew Morton wrote:
> > I blame kernel-doc.  It should have a slot for documenting the return value,
> > but it doesn't, so nobody documents return values.
> 
> There's also the question about where the documentation should go.  By
> the function prototype in the header?  That's the easy place for people
> using the function to find it.  By the code?  That's the place where it
> stands the most chance (about 10%) of somebody bothering to update it
> when they change the code.

yes, by the code, if it's C.  In .h if it's C++.

> > It should have a slot for documenting caller-provided locking requirements
> > too.  And for permissible calling-contexts.  They're all part of the
> > caller-provided environment, and these two tend to be a heck of a lot more
> > subtle than the function's formal arguments.
> 
> Indeed.  And reference count assumptions.  It's almost like we want a
> pre-condition assertion ...

We have might_sleep(), assert_spin_locked(), BUG_ON(!irqs_disabled()), etc.

I like assertions personally.  If we had something like:

void foo(args)
{
	locals;

	assert_irqs_enabled();
	assert_spin_locked(some_lock);
	assert_in_atomic();
	assert_mutex_locked(some_mutex);

then we get documentation which is (optionally) checked at runtime - best
of both worlds.  Better than doing it in kernel-doc.  Automatically
self-updating (otherwise kernels go BUG).

But we'd need to sell the idea ;)

And we still need to document those return values in English.

(Or we do

	return assert_zero_or_errno(ret);

which is a bit ug, but gets us there)
