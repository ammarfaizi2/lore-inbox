Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269662AbUJABXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269662AbUJABXB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269660AbUJABXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:23:01 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:20693 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S269662AbUJABWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:22:38 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Paul Jackson <pj@sgi.com>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040930104808.291d9ddc.pj@sgi.com>
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
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Thu, 30 Sep 2004 18:22:35 -0700
Message-Id: <1096593755.26742.168.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, now I'm sure I'm not communicating well. Please let me try again,
and I'll see if I can do better this time.

On Thu, 2004-09-30 at 10:48 -0700, Paul Jackson wrote:
> Ray wrote:
> > However, dnotify has shown that forcing userspace to cache the
> > entire contents of all the directories it wishes to watch doesn't scale
> > well.
> 
> The dnotify cache isn't just an optional performance tweak, caching
> inode to name.  It's an essential tracking of much of the stat
> information of any file of interest, in order to have _any_ way of
> detecting which file changed.

Agreed.

> The inotify cache could just have the last few most recently used
> entries or some such - it's just a space vs time performance tradeoff.

Not the case.

> So passing back an inode number doesn't come close to reintroducing
> the forced tracking of all the interesting stat data of every file.

It certainly forces userspace to track all file names and inodes, at
least. Userspace wishes to know about deletes and renames. Unless it
caches everything, it won't know what was deleted, or what got renamed.
For that matter, passing back the inode number might also cause
confusion for hardlinked files in the same directory, though I'd have to
think about that for a bit to be sure.

Perhaps I'm missing something. I haven't missed anything yet today,
which means I'm overdue.

> > dnotify already forces an O(N) workload per directory onto
> > userspace, and that has shown itself to not work well.
> 
> Just because there exists an O(N) solution that has been shown to fail
> doesn't mean all O(N) solutions fail.

<shrug> Okay, I'll agree with you in theory. This is in fact true for
several classes of multiplication algorithms, for example. (Who's gonna
do an FFT multiply of two two-digit numbers, I ask; no one.) So, yeah, I
get your point. Honest.

> If the constants change enough,
> then the actual numbers (how many changes per minute, how many compute
> cycles and memory bytes, what's the likely cache hit rate for a given
> size cache, ...) need to be re-examined.  I see no evidence of that
> re-examination -- am I missing something?

This is one of the parts I'm not communicating well. For any 'event'
that inotify wants to relay, the kernel knows the inode and the name.
You're saying pass the inode number, as it's smaller and makes for an
easier and higher speed interface to get changes to userspace (if I
understand you correctly).

I'm saying, sure, if you look at that corner of the problem, you're
right. That's ignoring how this gets used, however, where userspace
ultimately wants to know the name of the file that's changed. So, by
your method, we scan the entire directory, looking for the inode that
matches via the getdents call.

So, the kernel ended up sending the name of the changed file *anyway*,
but userspace had to ask for it. And, oh, the kernel sent the name of
every other file in that directory too. (Okay, maybe half, but then
again maybe not if you want to catch hardlinked files.)

> > the kernel *has* that information already, ...
> 
> Frustrating, isn't it.  The information is right there, and we're trying
> to keep you from getting to it.
> 
> Whatever ...

No, that's not my point at all. I'm not saying Big Bad Kernel Developers
won't let me have my candy. I'm saying that if the kernel has the
information already, and we're not passing it to userspace, and
userspace *needs* that information, then all we've done is guarantee
another long set of syscalls while it tries to pull the directory
contents to match up item for item against its cache of previously known
file states.

Or, in other words, I don't see how tossing away needed information is
going to make anything more efficient in this case. Userspace, like a
bulldog, will be coming back knocking on the kernel's door to get that
information one way or another.

 ~ ~

I've been avoiding saying this, as this really will be a bit more
complex than even my suggestions, but perhaps everyone would be happier
if we crammed all this through a netlink socket instead. Got me.

Ray

