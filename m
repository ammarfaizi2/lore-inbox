Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUFJEsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUFJEsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266012AbUFJEsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:48:23 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:62114 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S264560AbUFJEsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:48:20 -0400
Subject: Re: Finding user/kernel pointer bugs [no html]
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@math.psu.edu>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> 
	<Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 21:48:17 -0700
Message-Id: <1086842898.32053.380.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 21:10, Linus Torvalds wrote:
> On Wed, 9 Jun 2004, Robert T. Johnson wrote:
> > 
> > Despite that, I found numerous bugs in seven drivers.  Only one of these
> > drivers had any __user annotations, so sparse isn't able to provide any
> > meaningful results on these source files yet.  Even worse, sparse missed
> > bugs in drivers/usb/core/devio.c:proc_control() even though that
> > function has been annotated (this is not the first time cqual has found
> > bugs in code audited by sparse). 
> 
> Hmm.. That code has not been sparse-cleaned up, and as of today sparse 
> gives 34 lines of warnings for that file. I assume the two you refer to is
> 
> 	drivers/usb/core/devio.c:561:40: warning: cast removes address space of expression
> 	drivers/usb/core/devio.c:581:39: warning: cast removes address space of expression
> 
> and I assume those are the ones your thing finds too?
> 
> So I wanted to point out that sparse hasn't missed anything. It's just 
> that the USB people haven't fixed the things it has found yet ;)

Sorry about that mistake.  I see now that the data field has a __user
annotation.

> >			  I didn't write any annotations in any
> > driver files -- just a few header files under include.  I've already
> > submitted patches to fix these bugs.  This is 1 1/2 days work, with
> > _very_ incomplete annotations.
> 
> And part of the reason I much prefer the sparse approach of doing proper C 
> types is that it's (a) the C way and (b) it documents what is up.
> 
> What we do NOT want to have is to continue with these "implied rules". 
> That's what caused the bugs in the first place. I really want the user 
> pointers to be _explicit_, because not only does that mean that a stupid 
> tool can figure it out with purely "local" knowledge, but more 
> importantly, it means that a _programmer_ can figure it out with purely 
> local knowledge.
> 
> Now, I'm obviously biased, and hey, two tools are better than one. I just 
> wanted to point out that your claim that "sparse missed bugs" just isn't 
> true. What _is_ true is that there is quite a bit of non-fixed code out 
> there.

I agree that documenting interfaces is good.  Just because the tool can
infer things automatically doesn't mean they can't also be annotated --
it just means you can get results sooner.  I also understand if you just
want to do it the C way.

QUESTION:  Do you find it's difficult to figure out which fields of
structures should be declared __user?  One feature you might find useful
to add to sparse is the following:

If a structure pointer is __user, but it has some pointer fields that
aren't declared __user, there's a good chance that there's a missing
annotation or something.  This is a simplified version of a rule in
cqual, but I think you might be able to implement it purely locally in
sparse.  It'd be a bit of a hack, but it might help you discover missing
annotations sooner.  Without this, the following code passes sparse w/o
error:

struct foo { char __kernel * p; };
void func (struct foo __user * x)
{
  struct foo y;
  copy_from_user(&y, x, sizeof (y));
  y.p[0] = 0;
}

Best,
Rob


