Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSBDMSf>; Mon, 4 Feb 2002 07:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSBDMS0>; Mon, 4 Feb 2002 07:18:26 -0500
Received: from tomts23.bellnexxia.net ([209.226.175.185]:10968 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288946AbSBDMSN>; Mon, 4 Feb 2002 07:18:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: <mingo@elte.hu>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
Date: Mon, 4 Feb 2002 07:18:09 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202041330401.4090-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0202041330401.4090-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204121810.7C5168D1F@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 07:30 am, Ingo Molnar wrote:
> On Sun, 3 Feb 2002, Ed Tomlinson wrote:
> > Maybe we can control this with nice.  Is the the best or only way to
> > do it?  I am not at all sure it is.  After all nice is just another
> > knob.  The fewer knobs we have to tweak the easier linux is to use.
> >
> > [...] On the other hand if we can figure a way to add a simple and
> > understandable knob that let it perform better under load do not think
> > its a bad thing either.
>
> comparing these two paragraphs you'll see what kind of paradox we face.
> I'm trying to keep the number of external knobs down, and i'm trying to
> revive nice levels as a thing that makes some real difference, while still
> handling all the important cases automatically, wherever we can

I am very much aware of this and agree that the fewer knobs one _has_
to play with the better.

> > One point that seems to get missed is that a group of java threads,
> > posix threads or sometimes forked processes combine to make an
> > application. [...]
>
> yes - but what makes them an application is not really the fact that they
> share the VM (i can very much imagine thread-based login servers where
> different users use different threads - a single application as well?),
> but the intention of the application designer, which is hard to guess.
>
> if this becomes inevitable then perhaps a better line we can guess along
> is the child-parent relationship. Looking at 'pstree' output shows some
> clear application boundaries. I'd say an application are 'all children of
> a parent'. Ie. if two threads (shared VM or not shared VM, does not
> matter) have the same parent (which is not init) then they form an
> 'application'. This will cover FreeNet java threads just as well as
> hundreds of Apache processes.

I had though of this too.  This could work ok if we only go back one level.
For my load the ->mm method was more specific though, thinking of Apache,
its probably not general enought.

> but this method is guesswork as well, so it could mishandle certain cases.
> Eg. i'm quite certain that most people would notice the interactive
> effects if we handled all processes forked by kdeinit as a single
> application. So lets do it only if everything else fails to fix your
> workload.

K2 today, will take a day or two to get a real feel of K2 - this week is
going to be a busy one (its time to put our serviced SAP system into
production).

I wonder just how much they will notice though.  If we use a scheme like 
I implemented for the shared mm, it only triggers under load and then still
runs the interactive tasks first.

BTW, there is another buglet in my code.  If we defer a task we need to 
check the expired time and set it if its zero.  Probably it will not be 
but checking it would be a good idea - that is if the code ends up being
required all all.

Ed
