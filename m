Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbUCXQbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUCXQbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:31:11 -0500
Received: from vlan400-082-019.maconline.McMaster.CA ([130.113.82.19]:56547
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263758AbUCXQbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:31:04 -0500
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
From: John McCutchan <ttb@tentacle.dhs.org>
To: Alexander Larsson <alexl@redhat.com>
Cc: rudi@lambda-computing.de, linux-kernel@vger.kernel.org,
       jamie@shareable.org, tridge@samba.org,
       viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org
In-Reply-To: <1080142815.8108.90.camel@localhost.localdomain>
References: <4061986E.6020208@gamemakers.de>
	 <1080142815.8108.90.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1080146269.23224.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 11:37:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-24 at 10:40, Alexander Larsson wrote:
> 
> I think everyone agrees that dnotify is a POS that needs replacement,
> however coming up with a good new API and implementation seems to be
> hard (or at least uninteresting to kernel developers). 
> 
> I for sure would welcome a sane file change notification API, i.e. one
> that doesn't require the use of signals. However, I don't really care
> about recursive monitors, and I'm actually unsure if you really want the
> DN_EXTENDED functionallity in the kernel. It seems like a great way to
> make the kernel use a lot of unswappable memory, unless you limit the
> event queues, and if you do that you need to stat all files in userspace
> anyway so you can correctly handle queue overflows.
> 
> I think the most important properties for a good dnotify replacement is:
> 
> * Don't use signals or any other global resource that makes it
> impossible to use the API in a library thats supposed to be used by all
> sorts of applications.
> 
> * Get sane semantics. i.e. if a hardlink changes notify a file change in
> all directories the file is in. (This is hard though, it needs backlinks
> from the inodes to the directories, at least for the directories with a
> monitor, something i guess we don't have today.)
> 
> * Some way to get an event when the last open fd to the file is closed
> after a file change. This means you won't get hundreds of write events
> for a single file change. (Of course, you won't catch writes to e.g.
> logs which aren't closed, so this has to be optional. But for a desktop,
> this is often what you want.)

Maybe adding a rate limiter on these write events would be a better
idea, live updates are usefull for the desktop. Also with a netlink
socket I think the overhead of many events would drop siginificantly.

Also a couple other items I think need to be on the list of features,

* Some way to not have an open file descriptor for each directory you
are monitoring. This causes so many problems when unmounting, and this
is really the most noticable problem for the user.

* Better event vocabulary, we should fire events for all VFS ops. I
think right now it is limited to delete,create,written to. It would be
good to tell the listener exactly what happened, moved,renamed, etc.

John

