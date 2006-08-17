Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWHQFkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWHQFkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWHQFkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:40:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:22198 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932307AbWHQFkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:40:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: peculiar suspend/resume bug.
Date: Thu, 17 Aug 2006 07:44:38 +0200
User-Agent: KMail/1.9.3
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060815221035.GX7612@redhat.com> <20060816024140.GA30814@srcf.ucam.org> <1155779070.3369.44.camel@nigel.suspend2.net>
In-Reply-To: <1155779070.3369.44.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170744.38446.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 03:44, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2006-08-16 at 03:41 +0100, Matthew Garrett wrote:
> > On Tue, Aug 15, 2006 at 08:37:28PM -0400, Dave Jones wrote:
> > 
> > > cpufreq-applet crashes as soon as the cpu goes offline.
> > > Now, the applet should be written to deal with this scenario more
> > > gracefully, but I'm questioning whether or not userspace should
> > > *see* the unplug/replug that suspend does at all.
> > 
> > As Nigel mentioned, cpu unplug happens just before processes are frozen, 
> > so I guess there's a chance for it to be scheduled. On the other hand, 
> > it's not unreasonable for CPUs to be unplugged during runtime anyway - 
> > perhaps userspace should be able to deal with that?
> 
> Agreed.
> 
> I've spent a little more time thinking about this, and want to put a few
> thoughts forward for discussion/ignoring/flame bait/whatever.
> 
> I see two main issues at the moment with freezing before hotplugging.
> The first is that we have cpu specific kernel threads that we're going
> to want to kill, and the second is that we have userspace threads that
> we want to migrate to another cpu. Have I missed anything?

I have bad memories from the time we were not using the CPU-hotplug and
tried to freeze tasks with all CPUs on-line.  There were some very subtle
race conditions appearing between the freezer and the running tasks
which were a nightmare to figure out.  I'm not sure that they will appear
now, but something tells me so. :-)

> The first issue could be helped by splitting the freezing of userspace
> processes from kernel space. The kernel threads could thus die without
> us having to worry about userspace seeing what's going on. I haven't
> looked at vanilla in a while; this might already be in.

Yes, it is.

> Alternatively, if it's viable, per-cpu kernel threads could perhaps be made
> NO_FREEZE. 
> 
> The second issue is migrating userspace threads. I'm no scheduling
> expert, so I'll just speculate :>. I wondered if it's possible to make
> the migration happen lazily; in such a way that if, when we come to thaw
> userspace, the cpu has been hotplugged again, the migration never
> happens. Does that sound possible?

The CPU hotplug makes the tasks migrate automatically, but that's not
a problem, as I see it.  The problem is some tasks may have specific CPU
affinities set and these should not change accross suspend/resume.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
