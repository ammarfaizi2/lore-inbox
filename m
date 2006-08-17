Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWHQFyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWHQFyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHQFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:54:41 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:1984 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932443AbWHQFyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:54:40 -0400
Subject: Re: peculiar suspend/resume bug.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200608170744.38446.rjw@sisk.pl>
References: <20060815221035.GX7612@redhat.com>
	 <20060816024140.GA30814@srcf.ucam.org>
	 <1155779070.3369.44.camel@nigel.suspend2.net>
	 <200608170744.38446.rjw@sisk.pl>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:55:02 +1000
Message-Id: <1155794103.17301.26.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for the reply.

On Thu, 2006-08-17 at 07:44 +0200, Rafael J. Wysocki wrote:
> On Thursday 17 August 2006 03:44, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2006-08-16 at 03:41 +0100, Matthew Garrett wrote:
> > > On Tue, Aug 15, 2006 at 08:37:28PM -0400, Dave Jones wrote:
> > > 
> > > > cpufreq-applet crashes as soon as the cpu goes offline.
> > > > Now, the applet should be written to deal with this scenario more
> > > > gracefully, but I'm questioning whether or not userspace should
> > > > *see* the unplug/replug that suspend does at all.
> > > 
> > > As Nigel mentioned, cpu unplug happens just before processes are frozen, 
> > > so I guess there's a chance for it to be scheduled. On the other hand, 
> > > it's not unreasonable for CPUs to be unplugged during runtime anyway - 
> > > perhaps userspace should be able to deal with that?
> > 
> > Agreed.
> > 
> > I've spent a little more time thinking about this, and want to put a few
> > thoughts forward for discussion/ignoring/flame bait/whatever.
> > 
> > I see two main issues at the moment with freezing before hotplugging.
> > The first is that we have cpu specific kernel threads that we're going
> > to want to kill, and the second is that we have userspace threads that
> > we want to migrate to another cpu. Have I missed anything?
> 
> I have bad memories from the time we were not using the CPU-hotplug and
> tried to freeze tasks with all CPUs on-line.  There were some very subtle
> race conditions appearing between the freezer and the running tasks
> which were a nightmare to figure out.  I'm not sure that they will appear
> now, but something tells me so. :-)

I think you'll find that the separate freezing of kernel space will
help. We had SMP support in Suspend2 long before cpu hotplugging was
added, and it was stable and reliable. I'm reasonably certain that the
switch to splitting freezing was pre-cpu hotplugging.

> > The first issue could be helped by splitting the freezing of userspace
> > processes from kernel space. The kernel threads could thus die without
> > us having to worry about userspace seeing what's going on. I haven't
> > looked at vanilla in a while; this might already be in.
> 
> Yes, it is.

Great. Sorry for my slowness. I just keep too many things on the go at
once.

> > Alternatively, if it's viable, per-cpu kernel threads could perhaps be made
> > NO_FREEZE. 
> > 
> > The second issue is migrating userspace threads. I'm no scheduling
> > expert, so I'll just speculate :>. I wondered if it's possible to make
> > the migration happen lazily; in such a way that if, when we come to thaw
> > userspace, the cpu has been hotplugged again, the migration never
> > happens. Does that sound possible?
> 
> The CPU hotplug makes the tasks migrate automatically, but that's not
> a problem, as I see it.  The problem is some tasks may have specific CPU
> affinities set and these should not change accross suspend/resume.

Mmm. My concern was that cpu hotplug might somehow deadlock if the
process it was trying to migrate was frozen. You don't think that's a
possibility?

With affinities, would saving and restoring be a possibility?

Regards,

Nigel

