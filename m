Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUI1UfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUI1UfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUI1UfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:35:10 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:23722 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S267798AbUI1Ue7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:34:59 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Robert Love <rml@novell.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096392771.26742.96.camel@orca.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
	 <1096392771.26742.96.camel@orca.madrabbit.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096403685.30123.14.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:34:45 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.28.2
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 13:32, Ray Lee wrote:
> On Tue, 2004-09-28 at 12:53 -0400, Robert Love wrote:
> > On Tue, 2004-09-28 at 10:41 -0600, Chris Friesen wrote:
> > > Andrew Morton wrote:
> > > 
> > > > Why don't you pass a file descriptor into the syscall instead of a pathname?
> > > > You can then take a ref on the inode and userspace can close the file.
> > > > That gets you permission checking for free.
> > > 
> > > For passing in the data, that would work.  Wouldn't you still need a name or 
> > > path when getting data back though?
> > 
> > Does Andrew mean an fd on the thing being watched?
> > 
> > That is what we are trying to fix with dnotify: the open fd's are pin
> > the device and prevent unmount, making notification on removable devices
> > impossible.
> 
> That's why he said to close the fd right after the syscall. But yeah,
> for a case of someone wanting to watch their 1700 directories underneath
> ~/, thems a lot of open calls.
> 
> > Such a 1:1 relationship also opens way too many fd's.
> 
> ...I'm not sure I follow. If you're talking about the IN_CREATE and
> IN_DELETE events available when watching a parent directory, then I
> don't think anything would change. IOW, why not do an open(2) on the
> directory in question, and pass that fd in?
> 
> Regardless, Andrew's point still stands. What do we want the permission
> semantics to be? One would think that a normal user account should not
> be able to watch the contents of some other user's 0600 directories, for
> example. open(2) already does all the correct checks. We should inherit
> that work if at all possible.

Yes we should, but I think the inotify interface would be cleaner if we
just factored out this permission code and called it from open() and
from the inotify code.

> 
> Another benefit of passing in an fd, by the way, would be to make it
> easier to make a write(2) interface to inotify, and get rid of the ioctl
> one.
> 

I don't see how passing directories/files to inotify by fd not filename,
makes providing a write(2) interface to inotify any easier. To me they
are mutually exclusive. When you open up /dev/inotify, you get an fd,
you read events from it. We could provide write on that fd instead of
the ioctl() interface. 

>  ~ ~
> 
> As Chris points out, we still need a way to pass the name or path back
> to userspace when an event occurs, which is the interface I was harping
> on a few messages back.
> 
> It seems we're trying to recreate a variant struct dirent for
> communicating changes to userspace. Perhaps we can learn something from
> already trodden ground? Just sayin'.

Yes the current method of passing the name back to user space is
definitely sub par. But I don't think passing a full path to user space
is reasonable, as that would require walking the dirent tree for every
event. Really the best we can provide user space is the filename/dirname
(relative to the directory you are currently watching).

John
