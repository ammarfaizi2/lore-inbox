Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132000AbRCYOXQ>; Sun, 25 Mar 2001 09:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRCYOXG>; Sun, 25 Mar 2001 09:23:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:47889 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132000AbRCYOW6>; Sun, 25 Mar 2001 09:22:58 -0500
Message-ID: <3ABDFC38.9558DF6C@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:10:00 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Christian Bodmer <cbinsec01@freesurf.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <200103231508.f2NF83xY001147@pincoya.inf.utfsm.cl> <3ABC5143.167A649E@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> Horst von Brand wrote:
> >
> > "Christian Bodmer" <cbinsec01@freesurf.ch> said:
> >
> > > I can't say I understand the whole MM system, however the random killing
> > > of processes seems like a rather unfortunate solution to the problem. If
> > > someone has a spare minute, maybe they could explain to me why running
> > > out of free memory in kswapd results in a deadlock situation.
> >
> > OOM is not "normal operations", it is a machine under very extreme stress,
> > and should *never* happen. To complicate (or even worse, slow down or
> > otherwise use up resources like memory) normal operations for "better
> > handling of OOM" is total nonsense.
> 
> Puh-Leeze.   Let's inject some reality into this conversation:
> 
> [dledford@aic-cvs dledford]$ more kill-list
> Mar 10 22:02:34 monster kernel: Out of Memory: Killed process 475 (identd).
> Mar 10 22:03:25 monster kernel: Out of Memory: Killed process 660 (xfs).
...
> Mar 22 15:45:54 monster kernel: Out of Memory: Killed process 504 (atd).
> Mar 22 16:12:13 monster kernel: Out of Memory: Killed process 524 (sshd).
> [dledford@aic-cvs dledford]$
> 
> What was that you were saying about "should *never* happen"?  Oh, and let's
> not overlook the fact that it killed off mostly system daemons to start off
> with while leaving the real culprits alone.  Once it did get around to the
> real culprits (diff and tar), it wasn't even killing them because they were
> overly large, it was killing them because it wasn't reclaiming space from the
> buffer cache and page cache.  All of the programs running on this machine were
> never more than roughly 256MB of program code, and this is a 1GB machine.

This is due to the fact that Riks killer doesn't normalize the
resource units it's using for measure. Basically the current
penatly calculations are a good random number generator.

> This behavior is totally unacceptable and, as Alan put it, is a bug in the
> code.  It should never trigger the oom killer with 750+MB of cache sitting
> around, but it does.  If you want people to buy into the value of the oom
> killer, you've at least got to get it to quit killing shit when it absolutely
> doesn't need to.
> 
> To those people that would suggest I send in code I only have this to say.
> Fine, I'll send in a patch to fix this bug.  It will make the oom killer call
> the cache reclaim functions and never kill anything.  That would at least fix
> the bug you see above.

Please just apply it to the patch I have recently send... It will help
more :-).
