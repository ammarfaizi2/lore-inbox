Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVI0RZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVI0RZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVI0RZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:25:40 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:44813 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965024AbVI0RZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:25:39 -0400
Date: Tue, 27 Sep 2005 13:25:15 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Al Boldi <a1426z@gawab.com>
Cc: Matthew Helsley <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Resource limits
Message-ID: <20050927172515.GC5947@hmsreliant.homelinux.net>
References: <200509251712.42302.a1426z@gawab.com> <200509271642.07864.a1426z@gawab.com> <20050927143651.GB5947@hmsreliant.homelinux.net> <200509271850.01977.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509271850.01977.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 06:50:01PM +0300, Al Boldi wrote:
> Neil Horman wrote:
> > On Tue, Sep 27, 2005 at 04:42:07PM +0300, Al Boldi wrote:
> > > Neil Horman wrote:
> > > > On Tue, Sep 27, 2005 at 08:08:21AM +0300, Al Boldi wrote:
> > > > > Neil Horman wrote:
> > > > > > On Mon, Sep 26, 2005 at 11:26:10PM +0300, Al Boldi wrote:
> > > > > > > Neil Horman wrote:
> > > > > > > > On Mon, Sep 26, 2005 at 08:32:14PM +0300, Al Boldi wrote:
> > > > > > > > > Neil Horman wrote:
> > > > > > > > > > On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> > > > > > > > > > > Rik van Riel wrote:
> > > > > > > > > > > > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > > > > > > > > > > > Too many process forks and your system may crash.
> > > > > > > > > > > > > This can be capped with threads-max, but may lead
> > > > > > > > > > > > > you into a lock-out.
> > > > > > > > > > > > >
> > > > > > > > > > > > > What is needed is a soft, hard, and a special
> > > > > > > > > > > > > emergency limit that would allow you to use the
> > > > > > > > > > > > > resource for a limited time to circumvent a
> > > > > > > > > > > > > lock-out.
> > > > > > > > > > > >
> > > > > > > > > > > > How would you reclaim the resource after that limited
> > > > > > > > > > > > time is over ?  Kill processes?
> > > > > > > > > > >
> > > > > > > > > > > That's one way,  but really, the issue needs some deep
> > > > > > > > > > > thought. Leaving Linux exposed to a lock-out is rather
> > > > > > > > > > > frightening.
> > > > > > > > > >
> > > > > > > > > > What exactly is it that you're worried about here?
> > > > > > > > >
> > > > > > > > > Think about a DoS attack.
> > > > > > > >
> > > > > > > > Be more specific.  Are you talking about a fork bomb, a ICMP
> > > > > > > > flood, what?
> > > > >
> > > > > Consider this dilemma:
> > > > > Runaway proc/s hit the limit.
> > > > > Try to kill some and you are denied due to the resource limit.
> > > > > Use some previously running app like top, hope it hasn't been killed
> > > > > by some OOM situation, try killing some procs and another one takes
> > > > > it's place because of the runaway situation.
> > > > > Raise the limit, and it gets filled by the runaways.
> > > > > You are pretty much stuck.
> > > >
> > > > Not really, this is the sort of thing ulimit is meant for.  To keep
> > > > processes from any one user from running away.  It lets you limit the
> > > > damage it can do, until such time as you can control it and fix the
> > > > runaway application.
> > >
> > > threads-max = 1024
> > > ulimit = 100 forks
> > > 11 runaway procs hitting the threads-max limit
> >
> > This is incorrect.  If you ulimit a user to 100 forks, and 11 processes
> > running with that uid
> 
> Different uid.
> 
Then yes, if you set a system-wide limit that is less than the sum of the limits
imposed on each accountable part of the system you can have lock out.  But thats
your fault for misconfiguring the system.  Don't do that.

> > If you have a user process that for some reason legitimately needs to try
> > use every process resource available in the system, then yes, you are prone
> > to a lock out condition
> 
> Couldn't this be easily fixed in kernel-space?
> 
You're not getting it.  The resource limits applied by ulimit (and CKRM as
far as I know), _are_ inforced in kernel space.  The ulimit library call and its
corresponding setrlimit system call set resource limitations in the rlim array
thats part of each task struct.  These limits are queried whenever an instance
of the corresponding resource is requested by a user space process, if the
requesting process is over its limit, the request is deined.

Regards
Neil

> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
