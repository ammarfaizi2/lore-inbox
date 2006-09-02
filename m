Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWIBRD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWIBRD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 13:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWIBRD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 13:03:27 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:2259 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751198AbWIBRD0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 13:03:26 -0400
Date: Sat, 2 Sep 2006 21:03:23 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Hobein <ah2@delair.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
Message-ID: <20060902170323.GA369@oleg>
References: <200608312305.47515.ah2@delair.de> <200609010936.39015.ah2@delair.de> <20060901004920.7643a40e.akpm@osdl.org> <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01, Linus Torvalds wrote:
>
> On Fri, 1 Sep 2006, Andrew Morton wrote:
> > On Fri, 1 Sep 2006 09:36:38 +0200
> > Andreas Hobein <ah2@delair.de> wrote:
> >
> > > There is also a reply from Roland McGrath (see
> > > http://lkml.org/lkml/2005/11/9/460) who mentioned that there may occur some
> > > problems in "some real programs out there". May be I'm the first one who is
> > > affected by this new behaviour.
> >
> > When you have names, please cc them..
>
> Andreas isn't the first, but in the almost-a-year that the patch has been
> part of the kernel, he's the second.
>
> And for the first one I found a reasonable way to avoid the problem: the
> debugging thread can do a "vfork()" (or, if vfork() does something bad in
> libc, do the direct "clone(CLONE_VFORK|CLONE_MM)" thing) to have a new
> thread that is in a _different_ thread group, but is able to ptrace and
> also is "synchronized" with the VM, simply because it shares it with all
> the other threads it might want to debug.
>
> That "new" (last November) check isn't likely going away. It solved _so_
> many problems (both security and stability), and considering that
>
>  (a) in a year, only two people have ever even _noticed_
>  (b) there's a work-around as per above that isn't horribly invasive
>
> I have to say that in order to actually go back to the old behaviour, we'd
> have to have somebody who cares _deeply_, go back and check every single
> special case, deadlock, and race.

I can't say whether it is safe to restore an old behaviour. This all is
tricky, and there were so many changes in that area since then.

At least we need to remove 'current->tgid != p->tgid' check in eligible_child().
Currently this is a dead code. But if we restore an old behaviour, this
allows to release ->group_leader too early and crash the kernel.

I personally do not see other problems right now, but this doesn't mean
they are not present...

On the other hand, if we are not going to go back, we can remove subtle
'tsk->parent->signal->flags & SIGNAL_GROUP_EXIT' check in exit_notify(),
and a similar one in may_ptrace_stop().

Oleg.


-- 
VGER BF report: H 0
