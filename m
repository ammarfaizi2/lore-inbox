Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSJFNXu>; Sun, 6 Oct 2002 09:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJFNXu>; Sun, 6 Oct 2002 09:23:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62726 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261605AbSJFNXs>; Sun, 6 Oct 2002 09:23:48 -0400
Date: Sun, 6 Oct 2002 14:29:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: Linux Kernel Development List <linux-kernel@vger.kernel.org>
Subject: Re: Good Idea (tm): Code Consolidation for Functions and Macros that Access the Process Address Space
Message-ID: <20021006142922.A31147@flint.arm.linux.org.uk>
References: <20021006105008.B27487@flint.arm.linux.org.uk> <000801c26d35$9d6ac670$81281c43@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000801c26d35$9d6ac670$81281c43@joe>; from wagnerjd@prodigy.net on Sun, Oct 06, 2002 at 07:40:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 07:40:44AM -0500, Joseph D. Wagner wrote:
> >> On Sat, Oct 05, 2002 at 07:58:55PM -0500, Joseph D. Wagner wrote:
> >> SUBJECT: Good Idea (tm): Code Consolidation for Functions and Macros
> >> that Access the Process Address Space
> >>...
> >> Remember, if a function call has no place for a returned value to go,
> >> nothing bad happens; the returned value is simply ignored/discarded.
> 
> > And the compiler warning?
> 
> See WHY THIS SHOULD BE CHANGED #3 "Forces better coding structures and
> procedures..."  Frankly, error controls should have been programmed into
> the code anyway.  It's just good programming practice.

Lets address the compiler warnings point first:

1. If your build of 50,000 files produces 50 warnings per file, that's
   2,500,000 warnings.  You made the mistake of not initialising one
   variable, which produces a different compiler warning.  Are you going
   to spot this?  No.  Can it cause serious run-time errors?  Yes.
   Can it cause security holes?  Yes.

2. You accidentally forget the "return value;" statement at the end of
   a function - same problem as (1)

3. You accidentally leave a "return value;" statement at the end of a
   function - less serious, but you still want to know.

4. Cosmetically it looks bad.

5. It is _bad_ programming practice to write code that blatently violates
   standards for the language you're programming it in.

So, having a build that produces needless warnings is _BAD_.

Now lets address the "forcing better programming standards".  Well, we've
partially covered it above.  In addition, what you're proposing is crap
like:

static int foo(int *user_arg)
{
	struct bar_struct *bar;
	int arg;

	bar = kmalloc(...);
	if (bar)
		return -ENOMEM;

	get_user_ret(arg, user_arg, -EFAULT);

	arg = do_something(bar, arg);

	put_user_ret(arg, user_arg, -EFAULT);

	kfree(bar);

	return 0;
}

Now count the number of errors there _because_ of the hitten function
returns.  Is this good programming practise?  No.  Is it easy to write
the code in a way that doesn't do this?  No.  Is it obvious what its
doing?  No.

Experience has proven that if you give enough rope to driver writers,
they _will_ hang themselves.  They've done it many times in the past.
That is why it should be damned well obvious what the code is doing.
Which is why:

static int foo(int *user_arg)
{
	struct bar_struct *bar;
	int arg;

	bar = kmalloc(...);
	if (bar)
		return -ENOMEM;

	if (get_user(arg, user_arg))
		return -EFAULT;

	arg = do_something(bar, arg);

	if (put_user(arg, user_arg))
		return -EFAULT;

	kfree(bar);

	return 0;
}

is so much better.  You can immediately _see_ the error.  No hidden magic
functions that return underneath you.

> >> SOLUTION:
> 
> > Get rid of the _ret forms.  Their use is frowned on today anyway
> because
> > they hide the real meaning of what the code is trying to do, and
> hiding
> > the fact that a function can return in the middle of what looks like a
> > macro call is _REAL_ _BAD_.
> 
> While I respectively disagree with you, I really don't care which set of
> functions/macros are eliminated for consolidation purposes.

Well, I've got news for you.  Your requested "consolidation" has already
been done.  Months ago.  The xxx_ret forms no longer exist in either 2.4
nor 2.5 for the reasons I've stated above.  And yes, "good programming
practice" is one of the reasons.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

