Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUIAKK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUIAKK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUIAKK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:10:57 -0400
Received: from soundwarez.org ([217.160.171.123]:3242 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S266003AbUIAKHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:07:48 -0400
Date: Wed, 1 Sep 2004 12:07:50 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Robert Love <rml@ximian.com>, greg@kroah.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040901100750.GA23337@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <1094004324.1916.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094004324.1916.63.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 07:05:24PM -0700, Daniel Stekloff wrote:
> On Tue, 2004-08-31 at 14:42, Robert Love wrote:
> > Here is the Kernel Events Layer rewritten as more of an asynchronous
> > sysfs change notifier.  The concept of object and payload have been
> > removed.  Instead, events are modeled as signals emitting from kobjects.
> > It is pretty simple.
> > 
> > The interface is now:
> > 
> > 	int send_kevent(enum kevent type, struct kset *kset,
> > 			struct kobject *kobj, const char *signal)
> > 
> > Say your processor (with kobject "kobj") is overheating.  You might do
> > 
> > 	send_kevent(KEVENT_POWER, NULL, kobj, "overheating");
> > 
> > We could get rid of signal and just require passing a specific attribute
> > file in sysfs, which would presumably explain the reason for the event,
> > but I think having a single signal value is acceptable.  The rest of the
> > payload has been ditched.
> > 
> > The basic idea here is to represent to user-space events as changes to
> > sysfs.  Media was changed?  Then that block device in sysfs emits a
> > "media_change" event.
> > 
> > This patch includes two example events: file system mount and unmount.
> > 
> > Kay has some utilities and examples at
> > 	http://vrfy.org/projects/kevents/
> > and
> > 	http://vrfy.org/projects/kdbusd/
> > 
> > The intention of this work is to hook the kernel into D-BUS, although
> > the implementation is agnostic and should work with any user-space
> > setup.
> > 
> > Best,
> > 
> > 	Robert Love
> 
> 
> Hi Robert,
> 
> Are you limiting the kernel event mechanism a little too much by getting
> rid of the payload? Wouldn't it be useful to sometimes have data at
> event time? 

The motivation for doing this, is the ambitioned idea, that _data_ should
only be exposed through sysfs values to userspace. This would make it
possible for userspace to scan any state at any time, regardless of a
received event. Which should make the whole setup more reliable, as
applications can just read in the state at startup. We do a similar job
with udevstart, as all lost hotplug events during the early boot are
recovered just by reading sysfs and synthesize these events for creating
device nodes.

The same applies to the way back to the kernel. We don't want to send
data over the netlink back to the kernel, we can write to sysfs.

Very "simple" data still can be specified by the signal string, just
like a "verb" that describes, what actually happened with the kobject.
In the mount case, we send a "mount/unmount" event for the physical
device, and userspace can read "/proc/mounts" for the data, as
applications do today by polling.
Another version to do this (similar to Robert's CPU overheating example
above), is to create a owner value in the blockdevice's kset and let the
device claiming code fill that value. Then the signal may just be a simple
"add/remove" event for the "owner" file at device claiming and release.

Yes, it may require, that some things in the kernel need to use kobjects
to represent it's state to userspace, but that is a nice side effect and
better than a complicated definition, what the event may carry ot of the
kernel with every specific event, I think.

If you can think of any case we can't expose enough data with this model
or we will not be able to use sysfs, let us know.

Thanks,
Kay

