Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUI1ReM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUI1ReM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUI1Rd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:33:27 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:59852 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268052AbUI1Rc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:32:56 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Robert Love <rml@novell.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Andrew Morton <akpm@osdl.org>,
       ttb@tentacle.dhs.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
In-Reply-To: <1096390398.4911.30.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Tue, 28 Sep 2004 10:32:51 -0700
Message-Id: <1096392771.26742.96.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 12:53 -0400, Robert Love wrote:
> On Tue, 2004-09-28 at 10:41 -0600, Chris Friesen wrote:
> > Andrew Morton wrote:
> > 
> > > Why don't you pass a file descriptor into the syscall instead of a pathname?
> > > You can then take a ref on the inode and userspace can close the file.
> > > That gets you permission checking for free.
> > 
> > For passing in the data, that would work.  Wouldn't you still need a name or 
> > path when getting data back though?
> 
> Does Andrew mean an fd on the thing being watched?
> 
> That is what we are trying to fix with dnotify: the open fd's are pin
> the device and prevent unmount, making notification on removable devices
> impossible.

That's why he said to close the fd right after the syscall. But yeah,
for a case of someone wanting to watch their 1700 directories underneath
~/, thems a lot of open calls.

> Such a 1:1 relationship also opens way too many fd's.

...I'm not sure I follow. If you're talking about the IN_CREATE and
IN_DELETE events available when watching a parent directory, then I
don't think anything would change. IOW, why not do an open(2) on the
directory in question, and pass that fd in?

Regardless, Andrew's point still stands. What do we want the permission
semantics to be? One would think that a normal user account should not
be able to watch the contents of some other user's 0600 directories, for
example. open(2) already does all the correct checks. We should inherit
that work if at all possible.

Another benefit of passing in an fd, by the way, would be to make it
easier to make a write(2) interface to inotify, and get rid of the ioctl
one.

 ~ ~

As Chris points out, we still need a way to pass the name or path back
to userspace when an event occurs, which is the interface I was harping
on a few messages back.

It seems we're trying to recreate a variant struct dirent for
communicating changes to userspace. Perhaps we can learn something from
already trodden ground? Just sayin'.

Ray

