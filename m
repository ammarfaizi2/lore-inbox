Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268978AbUIBUit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268978AbUIBUit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUIBUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:38:27 -0400
Received: from soundwarez.org ([217.160.171.123]:45031 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S269021AbUIBU3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:29:35 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Kay Sievers <kay.sievers@vrfy.org>
To: Robert Love <rml@ximian.com>
Cc: Daniel Stekloff <dsteklof@us.ibm.com>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1094142469.2284.15.camel@betsy.boston.ximian.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094126565.1761.25.camel@localhost.localdomain>
	 <20040902132609.GB26413@vrfy.org>
	 <1094142469.2284.15.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 02 Sep 2004 22:29:27 +0200
Message-Id: <1094156968.26430.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 12:27 -0400, Robert Love wrote:
> On Thu, 2004-09-02 at 15:26 +0200, Kay Sievers wrote:
> 
> > o What kind of signal do we need? A lazy string, a well defined set like
> >   ADD/REMOVE/CHANGE?
> >   Or can we get rid of the whole signal? But how can we distinguish between
> >   add and remove? Watching if the sysfs file comes or goes is not a option,
> >   I think.
> 
> I think (from our off-list discussions) that we really need the signal.
> Agreed?
> 
> I do think that defining the signal to specific values makes sense, e.g.
> KEVENT_ADD, KEVENT_REMOVE, KEVENT_MOUNTED, etc.  We could also send the
> attribute as a string.
> 
> To get around the hotplug issue that would occur without 'enum kevent',
> as we discussed, we could have a "hotplug_added" signal or whatever.
> Nothing wrong with that.

Hmm, the threads are a bit mixed up now, I will only reply to this one:

I think we can get rid of the kset at all, but let's see what Greg says
about it. Until that, I assume, we don't need it.

We don't depend on the multicast groups, they are only used cause the
concept was so nice, I think. I don't expect a lot of listeners on the
netlink socket, so we can live without it, if it makes something
easier. 

Yes, in our current incarnation of kevent, we need the signal as a
string value to describe what actually happens with this kobject. It is
nice as it would be easy to implement a event, without touching to much
code in the subsystems.
I like that model, if we all agree to go this way. It would look like
Robert's example in the other mail:

  int send_kevent(struct kobject *kobj,
                  const char *signal);


But Greg and Dan have valid points, that this won't work well for the
single attribute case, we possibly should cover, without encoding it in
the signal string.
If we may agree to export data only by creating an attribute in the
kobject instead of the signal "verb", it would look like this:

   int send_kevent(struct kobject *kobj,
                   struct attribute *attr,
                   const char *signal)

The signal may be well defined as "add|remove|change"(like
the /sbin/hotplug ACTION= value today), which will mandate that we
create any data as attributes (no exception). We may allow NULL as the
attribute and send the event for the whole kobject this way. 

For the mount example it would look like this:
  send_kevent(bdev->kobj, &attr_owner, "change");

For cpu overheating:
  send_kevent(cpu->kobj, &attr_temperature_state, "change");

For hotplug:
  send_kevent(cpu->kobj, NULL, "add");
  send_kevent(cpu->kobj, NULL, "remove");

This model may be a bit over-ambitious, but in the long run, it may be
the better one, as it doesn't require a signal dictionary and _any_
state is readable at any time from userspace.

It is more similar to our current /sbin/hotplug-notification, we use
e.g. for udev. There we get only the sysfs-path and the action for a
device that gets connected or disconnected.
The second model would conceptually only be a strong sysfs-state-change
notification for kobjects(sysfs-directory) or single kobject-attributes
(sysfs-attribute).

Any thoughts?

Thanks,
Kay


