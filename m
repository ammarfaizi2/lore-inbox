Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVI0OhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVI0OhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVI0OhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:37:17 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:52236 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964950AbVI0OhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:37:15 -0400
Date: Tue, 27 Sep 2005 10:36:51 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Al Boldi <a1426z@gawab.com>
Cc: Matthew Helsley <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Resource limits
Message-ID: <20050927143651.GB5947@hmsreliant.homelinux.net>
References: <200509251712.42302.a1426z@gawab.com> <200509270808.21821.a1426z@gawab.com> <20050927120840.GA5947@hmsreliant.homelinux.net> <200509271642.07864.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509271642.07864.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 04:42:07PM +0300, Al Boldi wrote:
> Neil Horman wrote:
> > On Tue, Sep 27, 2005 at 08:08:21AM +0300, Al Boldi wrote:
> > > Neil Horman wrote:
> > > > On Mon, Sep 26, 2005 at 11:26:10PM +0300, Al Boldi wrote:
> > > > > Neil Horman wrote:
> > > > > > On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > > > > > > Neil Horman wrote:
> > > > > > > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > > > > > > Rik van Riel wrote:
> > > > > > > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > > > > > > Too many process forks and your system may crash.
> > > > > > > > > > > This can be capped with threads-max, but may lead you
> > > > > > > > > > > into a lock-out.
> > > > > > > > > > >
> > > > > > > > > > > What is needed is a soft, hard, and a special emergency
> > > > > > > > > > > limit that would allow you to use the resource for a
> > > > > > > > > > > limited time to circumvent a lock-out.
> > > > > > > > > >
> > > > > > > > > > How would you reclaim the resource after that limited time
> > > > > > > > > > is over ?  Kill processes?
> > > > > > > > >
> > > > > > > > > That's one way,  but really, the issue needs some deep
> > > > > > > > > thought. Leaving Linux exposed to a lock-out is rather
> > > > > > > > > frightening.
> > > > > > > >
> > > > > > > > What exactly is it that you're worried about here?
> > > > > > >
> > > > > > > Think about a DoS attack.
> > > > > >
> > > > > > Be more specific.  Are you talking about a fork bomb, a ICMP
> > > > > > flood, what?
> > >
> > > Consider this dilemma:
> > > Runaway proc/s hit the limit.
> > > Try to kill some and you are denied due to the resource limit.
> > > Use some previously running app like top, hope it hasn't been killed by
> > > some OOM situation, try killing some procs and another one takes it's
> > > place because of the runaway situation.
> > > Raise the limit, and it gets filled by the runaways.
> > > You are pretty much stuck.
> >
> > Not really, this is the sort of thing ulimit is meant for.  To keep
> > processes from any one user from running away.  It lets you limit the
> > damage it can do, until such time as you can control it and fix the
> > runaway application.
> 
> threads-max = 1024
> ulimit = 100 forks
> 11 runaway procs hitting the threads-max limit
> 
This is incorrect.  If you ulimit a user to 100 forks, and 11 processes running
with that uid start to fork repeatedly, they will get fork failures after they
have, in aggregate called fork 89 times.  That user can have no more than 100
processes running in the system at any given time.  Another user (or root) can
fork another process to kill one of the runaways.

If you have a user process that for some reason legitimately needs to try use
every process resource available in the system, the yes, you are prone to a lock
out condition, if you have no way of killing those processes from a controlling
terminal, then yes, you are prone to lock out.  In those conditions I would set
my ulimit on processes for the user running this process to something less than
threads-max, so that I could have some wiggle room to get out of that situation.
I would of course also file a bug report with the application author, but thats
another discussion :).
Regards
Neil

> This example is extreme, but it's possible, and there should be a safe and 
> easy way out.
> 
> What do you think?
> 
> Thanks!
> --
> Al

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
