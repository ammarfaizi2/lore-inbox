Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUJDU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUJDU6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268487AbUJDU6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:58:41 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:32737 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268464AbUJDU6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:58:36 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Paul Jackson <pj@sgi.com>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040930210920.707a5421.pj@sgi.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
	 <1096392771.26742.96.camel@orca.madrabbit.org>
	 <1096403685.30123.14.camel@vertex> <20040929211533.5e62988a.akpm@osdl.org>
	 <1096508073.16832.17.camel@localhost> <20040929200525.4e7bb489.pj@sgi.com>
	 <1096558180.26742.133.camel@orca.madrabbit.org>
	 <20040930092744.5eb5ea10.pj@sgi.com>
	 <1096563193.26742.152.camel@orca.madrabbit.org>
	 <20040930104808.291d9ddc.pj@sgi.com>
	 <1096593755.26742.168.camel@orca.madrabbit.org>
	 <20040930210920.707a5421.pj@sgi.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Mon, 04 Oct 2004 13:58:33 -0700
Message-Id: <1096923513.14886.8.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 21:09 -0700, Paul Jackson wrote: 
> If file "foo" goes away, and if the kernel only reports that inode
> 314159 was unlinked from a given directory, unless some user code
> previously remembered that inode 314159 was accessible from the
> directory entry named "foo", you can't tell the user that "foo"
> disappeared.

Right. Follow the same argument for renames, as well. ("Well, what did
it *used* be to named?") Short of caching the entire contents, there's
no way to know if all that's returned is an inode.

> Do you have the same problem with directories, if some cookie, not the
> full pathname, is passed back after an 'rmdir(2)' event?  Or is it just
> that it's less onerous to track all the directories, because there's
> fewer of them?

In the case of a directory that's being monitored going away, userspace
has already asked for tracking events for that directory explicitly, and
has to keep track of the cookie ("watch descriptor") to directory name
mapping (or some context, at least) already. That's the only way it
knows the correct context for the events.

For example, I ask for monitoring of two different directories on my
system, both with a final path component of "etc". Since the kernel
can't pass back the full path (cf. mount --bind, or consider an
watch/chdir/watch sequence, if you believe the kernel should cache the
full path passed to it from userspace), it instead needs to pass back
something unique for that directory. The name isn't, and the full
pathname isn't available to the kernel. So, the watch descriptor, being
an arbitrary but unique cookie, steps in.

> > You're saying pass the inode number, as it's smaller and makes for an
> > easier and higher speed interface to get changes to userspace (if I
> > understand you correctly).
> 
> That was the idea, yes.  Most of it anyway.  That and striving to keep
> the API the kernel presents to the user minimal and orthogonal.

<Nod> That's actually a stronger argument with me than the micro-
optimization. Orthogonal interfaces allow for more uses. However, I can
find no way to clean up the interface any more than what's been
suggested so far.

> If there is a way, any way, for user code to get something from the
> kernel, then I don't mind dragging my feet on providing other ways,
> until I see a good reason.

Fair enough.

> It's always worth a bit of effort to keep
> kernel API's minimal and orthogonal.

Agreed.

> Your "delete and rename" point above seems now like a good reason.

It would bring inotify almost down to the level of usefulness of
dnotify, which would be painful.

Ray

