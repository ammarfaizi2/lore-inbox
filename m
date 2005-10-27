Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbVJ0VVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbVJ0VVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbVJ0VVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:21:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:61911 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932639AbVJ0VVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:21:44 -0400
Date: Thu, 27 Oct 2005 17:21:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
       <dipankar@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130445820.3586.263.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0510271658510.6660-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Chandra Seetharaman wrote:

> > I agree that updating all the existing definitions would be a little
> > painful.  However, adding a new notifier_head will require doing those 
> > updates anyway.
> 
> That change would be minimal, one have only change the place from which
> the notify_register is called.
> 
> Whereas if we change it to become two types one has to go through the
> corresponding callouts (and the functions they call and so on) to see
> which (BLOCKING or ATOMIC) notifier mechanism to use.

True, the amount of study required would be greater -- but the actual
change is still minimal!  :-)

In many cases the type is obvious.  For instance, there are lots of
callouts that occur in ioctl handlers; they clearly have to be BLOCKING.

In fact there's another sort of problem I neglected to mention: Callouts
that unregister themselves will have to be changed.  I think that's going
to be unavoidable.  Fortunately there probably aren't very many, but
finding them might not be easy.

> Functionally looks good. But there are two problems w.r.t interface
> changes:
>     1. above mentioned problem of making sure of all the places to use
>        the proper one.

This at least is a one-time difficulty, and it doesn't require changing 
many sections of code.  Last time I checked, there were 28 notifier chain 
definitions in the kernel.

>     2. Requiring register and unregister to be able to sleep. (there are
>        few usages that are called with a lock held)

Are there?  I haven't looked at all of them closely.  According to Keith 
Owens, such usages are wrong.

> How does the following code look (only change w.r.t the existing usage
> model is that unregister can now return -EAGAIN, if the list is busy).
> 
> One assumption the following code makes is that the store of a pointer
> (next in the list) is atomic. If that assumption is unacceptable, we can
> do one of two things:
>     1. change notify_register to return -EAGAIN if list is busy.
>     2. move the chain list in call_chain under lock and use that
>        list instead of using the chain in the head, and restore it back
>        before returning.

I see a couple of problems (aside from the trivial one where you increment 
nh->readers before the early exit).

The biggest problem is allowing unregister to return an error.  None of 
its callers will expect that, and they all will have to be changed.  There 
are a lot more calls to unregister than there are chain definitions.

The other problem is that you violated Keith's statement that 
notifier_call_chain shouldn't take any locks.  On the other hand, if we 
put together all the requirements people have listed for notifier chains, 
the resulting set is inconsistent!  That's part of the reason why I 
suggested implementing two different kinds of chains.

Alan Stern

