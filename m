Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUFJDbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUFJDbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 23:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUFJDbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 23:31:22 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:10653 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S264482AbUFJDbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 23:31:15 -0400
Subject: Re: Finding user/kernel pointer bugs [no html]
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Al Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 20:31:02 -0700
Message-Id: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the html -- sending mail from home is a PITA for me.  Here
it is again w/o html.

On Mon, 2004-06-07 at 19:52, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> Pardon me, but I will believe it when I see your bug reports.  All
> I had been able to find on MARC was rather unimpressive; if that is
> what you've found using cqual in several months...

To demonstrate cqual's bug finding ability, I ran it on 2.6.7-rc3
yesterday.  I've never run cqual on all of the 2.6 code before, and I'm
still just using about 300 annotations (cqual currently ignores sparse
annotations, although I may change that in the future).  So this is by
no means a complete analysis of the kernel -- it's just a quick demo.

Despite that, I found numerous bugs in seven drivers.  Only one of these
drivers had any __user annotations, so sparse isn't able to provide any
meaningful results on these source files yet.  Even worse, sparse missed
bugs in drivers/usb/core/devio.c:proc_control() even though that
function has been annotated (this is not the first time cqual has found
bugs in code audited by sparse).   I didn't write any annotations in any
driver files -- just a few header files under include.  I've already
submitted patches to fix these bugs.  This is 1 1/2 days work, with
_very_ incomplete annotations.

> the taint analysis is nowhere near "if it gives no warnings, we are
> guaranteed to have no user/kernel pointer mixed".

I overstated this point.  Like sparse, cqual can be fooled by certain
types of code:
  - inline asm
  - misuse of unions
  - buffer overflows
  - certain really nasty casts
  - incomplete or incorrect annotations
  - cqual may have implementation bugs, of course
But besides these cases, it doesn't miss bugs.  It's just like the
regular C type checker -- you can't trick it without doing something
explicitly nasty.

> The real questions are
> 	a) how large subset of tree can $FOO survive?

In my experiment above, I did
  $ make menuconfig # Turn on every driver and feature I could
  $ make C=1 CHECK=kqual
Looks like it checked about 3500 files.  CQual barfed on 5 or 6, all of
which were easily patched.  I'll submit patches later.

> 	b) how many new bugs is $FOO catching?

See above.

> 	c) how much noise does $FOO produce and how hard it is to eliminate
> that noise?

Barring any implementation bugs or improvements to sparse, anything
sparse can verify, cqual should be able to verify, too.  I had 49 files
with false positives in my experiment yesterday.

I discuss the sources of false positives from earlier experiments in the
appendix of the paper I mentioned earlier.  The appendix also describes
methods for fixing false positives -- these methods may be applicable to
sparse, too. You can get the paper from
http://www.cs.berkeley.edu/~rtjohnso/papers/cquk.ps  
The short version: noisier than meca, less noisy than sparse (example
below), noise is almost always easy to fix.

> 	d) how fast $FOO is (it _is_ important, if you hope to get a decent
> code coverage, especially on non-x86 platforms).

~1 to 2 seconds per file.

> 	e) is everything needed for testing available ($FOO itself, patches
> needed to use it on the tree usefully)?

Yes, it's all in cvs, except for about 20 ioctl()-related annotations I
added to the kernel Monday night.  Except for those 5 or 6 problem
files, no patches to the tree are required to get useful results.

> And that's all that matters.  So far you said nothing on (a) or (d), had
> rather unimpressive results posted on (b) and basically waved hands on (c).
> Not sure about (e); are your initial annotations available for download?

(a), (b), and (d) are addressed above.  As for (e), the initial
annotations are all in cvs.

Re: (c).  Here's a toy example of some code that cqual can type check
that sparse cannot.  Think of $kernel as __kernel and $user and __user. 
The key points are:

- cqual infers things, e.g. that x is a kernel pointer from the
  assignment "x = k;" in some_func().  Less annotations required.

- cqual allows a.p to be a kernel pointer and b.p to be a user pointer,
  no code duplication is necessary.

- cqual figures out that, as long as you call copy_something with user
  or kernel pointers and with an appropriately corresponding cpy_func,
  then everything is safe.

- no casts are needed to check this code.  This is important since casts
  can prevent a bug-finding tool from finding real bugs.


/************ Begin Example *************/
unsigned long
copy_from_user(void $user * $kernel, const void * $user, unsigned long);

unsigned long
copy_to_user(void * $user, const void * $kernel, unsigned long);

unsigned long 
memcpy(void * $kernel, const void * $kernel, unsigned long);

typedef unsigned long (*cpy_func)(void *, const void *, unsigned long);

void copy_something (void *dst, void *src, int len, cpy_func cf)
{
  cf(dst, src, len);
}

struct foo 
{
  char *p;
};

void some_func(char * $kernel k, char * $user u)
{
  struct foo a, b;
  char *x, *y, *z, *w;

  a.p = x = k;
  copy_something(y, a.p, 5, memcpy);

  b.p = u;
  copy_something(z, b.p, 5, copy_from_user);

  copy_something(u, w, 5, copy_to_user);
}
/************ End Example *************/

I hope this example gives you a better idea of what cqual is all about. 
CQual and sparse share the same basic idea: create two types, user
pointers and kernel pointers, that refine the basic C type system.  The
main difference between cqual and sparse is that cqual tries to figure
out as many annotations as it can automatically and supports a more
flexible type system, both reducing programmer burden.  It still can
benefit from all the annotations and cleanups you've done so far; using
cqual would not make that wasted effort.

My goal with this discussion is to get kernel developers interested in
using cqual on their own (I'll be glad to answer any questions,
though).  I have my own research agenda, so I don't have time to go
auditing each new kernel release.  I'm hoping some other developers (or
auditers) will pick up cqual and start using it.  Then I can devote more
of my time to making further improvements to cqual, which will in turn
further reduce the work load on kernel developers.

Best,
Rob


