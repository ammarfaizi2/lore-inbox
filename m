Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWIDMQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWIDMQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWIDMQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:16:09 -0400
Received: from mx.delair.de ([62.80.31.6]:9391 "EHLO mx.delair.de")
	by vger.kernel.org with ESMTP id S964801AbWIDMQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:16:07 -0400
From: Andreas Hobein <ah2@delair.de>
Organization: delair Air Traffic Systems GmbH
To: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
Date: Mon, 4 Sep 2006 14:16:03 +0200
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
References: <200608312305.47515.ah2@delair.de> <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org> <20060902170323.GA369@oleg>
In-Reply-To: <20060902170323.GA369@oleg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609041416.03945.ah2@delair.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 September 2006 19:03, Oleg Nesterov wrote:
> On 09/01, Linus Torvalds wrote:
> > On Fri, 1 Sep 2006, Andrew Morton wrote:
> > > On Fri, 1 Sep 2006 09:36:38 +0200
> > >
> > > Andreas Hobein <ah2@delair.de> wrote:
> > > > There is also a reply from Roland McGrath (see
> > > > http://lkml.org/lkml/2005/11/9/460) who mentioned that there may
> > > > occur some problems in "some real programs out there". May be I'm the
> > > > first one who is affected by this new behaviour.
> > >
> > > When you have names, please cc them..
> >
> > Andreas isn't the first, but in the almost-a-year that the patch has been
> > part of the kernel, he's the second.
> >
> > And for the first one I found a reasonable way to avoid the problem: the
> > debugging thread can do a "vfork()" (or, if vfork() does something bad in
> > libc, do the direct "clone(CLONE_VFORK|CLONE_MM)" thing) to have a new
> > thread that is in a _different_ thread group, but is able to ptrace and
> > also is "synchronized" with the VM, simply because it shares it with all
> > the other threads it might want to debug.
> >
> > That "new" (last November) check isn't likely going away. It solved _so_
> > many problems (both security and stability), and considering that
> >
> >  (a) in a year, only two people have ever even _noticed_
> >  (b) there's a work-around as per above that isn't horribly invasive
> >
> > I have to say that in order to actually go back to the old behaviour,
> > we'd have to have somebody who cares _deeply_, go back and check every
> > single special case, deadlock, and race.
>
> I can't say whether it is safe to restore an old behaviour. This all is
> tricky, and there were so many changes in that area since then.
>
> At least we need to remove 'current->tgid != p->tgid' check in
> eligible_child(). Currently this is a dead code. But if we restore an old
> behaviour, this allows to release ->group_leader too early and crash the
> kernel.
>
> I personally do not see other problems right now, but this doesn't mean
> they are not present...
>
> On the other hand, if we are not going to go back, we can remove subtle
> 'tsk->parent->signal->flags & SIGNAL_GROUP_EXIT' check in exit_notify(),
> and a similar one in may_ptrace_stop().

Thank you all for your kind assistance. It turned out that using vfork() or 
clone() would make a considerable redesign of my code necessary. While the 
added overhead from a "real" fork plus communication of the result over pipes 
is still acceptable, I currently have a lack of time to restructure my 
application to work with vfork or clone and its intrinsic restrictions. Also 
some more non-portable code would be added, which discourages me a bit also.

On the other hand I understand that this kernel change helped to fix a number 
of problems while the now forbidden feature of self attaching to threads is 
rarely used and could be achieved by other means like forking before 
attaching.

Since I'm rather clueless with regard to the kernel internals I'm afraid I 
can't add more value to this discussion other than to prove there is at least 
a second application out there being affected by this patch.

Thank you once again and best regards,

	Andreas

-- 
VGER BF report: U 0.5
