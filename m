Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbTFMQ3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTFMQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:29:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15073 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265424AbTFMQ2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:28:49 -0400
Date: Fri, 13 Jun 2003 09:42:16 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613164216.GB5799@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <3EE9F2E5.1050407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE9F2E5.1050407@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 08:51:01AM -0700, Steven Dake wrote:
> >I now respond:
> >Bootup time reduction would be a great thing to have.  And I agree for
> >situations where 1 second is a considerable amount of time, it is
> >important.  However, 99.99% of the people running Linux out there, do
> >not have those problems.  And even then, for those 00.01% of the people
> >who do, they do whatever they possibly can to keep from having to reboot
> >at all.  I still say the measurable ammount of time to plug in a new
> >disk and have it's device node created is not measurable, from using
> >/sbin/hotplug and udev, and using your character node.  Also, the
> >ultimate solution for these kinds of people is the in-kernel devfs, or
> >the current static /dev.  If they use either of them, it's guaranteed to
> >be faster then yours or mine implementation.
> > 
> >
> I suppose it is possible that devfs could be faster, however, there are 
> significant amounts of policies that can never be done in devfs which 
> must be done in user space.  For these types of applications, it makes 
> sense to provide the fastest mechanism available, even when it may only 
> improve boot performance by 1 second.

That's what devfsd can be used for.  It provides you with a way to get
those events, in a binary fashion, with no out-of-order issues, in a
"quick" way.  People have implemented persistant device naming schemes
by using this interface in the past.  Don't write something new when
what you are looking for is already there.

> I understand what you mean by saying that 99.99% of users don't care 
> about availability.  While those particular users may spend significant 
> amounts of time improving Linux, it is the remaining folks that care 
> about availability that are interested in investing money into r&d to 
> improve availability while also improving feature set.  It is this set 
> of folks, (the people that do care about availability) that this patch 
> is targeted towards.

Like Pat said, until you prove the speed and uptime differences between
the following, I don't see how you can say this with a straight face:
	- The default /sbin/hotplug for Redhat 9 systems
	- The default /sbin/hotplug for Montavista systems.
	- my mini-hotplug
	- Your sdeq
	- devfsd
After running those numbers, please let us know what you find out.
	
> >I now respond:
> >Doing a mknod() on a node that is already present doesn't harm anything.
> >And since you have to keep a database around of what devices are
> >present, and what you have called them, removing them after already
> >removing them again, is detectable.  So handing the same event twice
> >isn't a problem.
> > 
> >
> I suppose you could handle multiple events twice, but the ability to 
> detect a replacement without the OS removing the initial kobject is now 
> removed.  This is a real case which should be handled.

Um, huh?  How can the OS not remove a kobject, and not tell userspace?
And if a device is unplugged, and then plugged right back in again, in
the same place, with the same attributes (which is the only way you
would not be able to detect this easily), what is the big problem?  You
would act apon that device in the same way, again, which would be just
fine.

> >As for the memory issues, if no one ever reads from the character node,
> >it will constantly fill up with events, right?  Shouldn't they be
> >eventually flushed out at some point in time?
> >
> This is a problem...  I wasn't quite sure how to handle this.  The two 
> choices are to include timeouts in events (after a certain amount of 
> time, events are timed out and freed) or to allow only a certain number 
> of events, after which events at the front of the queue are flushed.
> 
> The reality though, is that the user will be running the daemon to clear 
> out the events.  If they don't, then they get what they deserve :)

Heh, then your kernel which _has_ to stay up (due to your previous
guarantees of uptime) keels over.  I don't think that by requiring that
a kernel _has_ to have a specific userspace program running in order for
it to stay healthy would be anying any "carrier grade" user would ever
agree to.

:)

> >Also for trying to remove events, why is userspace allowed to remove a
> >multiple of events at once?  I would think that a valid read would
> >remove that event, you can have two applications grab the same event,
> >which is not what I think you want to have happen.
> >
> I probably should have explained why this decision was made.  I believe 
> it is desireable to be able to handle multiple events at once.  The 
> process is: user reads all events on event queue, user processes events, 
> user deletes all events atomically.  This solves the problem of what 
> happens if the daemon crashes during deletion of events, or during 
> processing of events.  The daemon will be able to totally recover and 
> process events properly.

But your implementation does not do this, so you added features and
complexity before they were needed :)

Again, you are relying on a userspace program to keep the kernel safe,
not a wise choice.

> >So, because of this, I still think that everything you are trying to do
> >can be successfully done from userspace today (or use devfsd today, it
> >will give you the same info!)  And due to that, I do not think this code
> >is necessary to be in the kernel.
> > 
> >
> Everything could possibly be done in userspace, but performance is poor, 
> and I am still concerned about the out-of-order events issue.

We just solved the out-of-order events issue.  I don't see any proof of
your performance claims.  Hence, I don't think this patch should be
applied.

thanks,

greg k-h
