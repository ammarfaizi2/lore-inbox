Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUGXSNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUGXSNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUGXSNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:13:15 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19607 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261875AbUGXSNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:13:12 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: dsaxena@plexity.net
Cc: Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040724175442.GA26222@plexity.net>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
	 <20040724175442.GA26222@plexity.net>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 14:13:10 -0400
Message-Id: <1090692790.12088.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 10:54 -0700, Deepak Saxena wrote:

> Oh ok, that makes much more sense now. "arch/kerne/cpu" is the
> name of the file, from which that message came.

Yah.  It is pretty simple and it gives us a unique name without imposing
any naming policy.

I have, however, been thinking about using kobject paths. ;-)  I
actually like the idea now, but I do not think we can get a kobject for
most of the stuff we need, unfortunately.  Also, we need the kobject
name to be unique.  This is an interesting concept to keep in mind,
though.

> I think we agree.  So are there some existing docs that you/Ximian has 
> on reccomended usage and object naming? I didn't see anything on 
> freedesktop.org.  That's where a lot of my questions are coming from. We 
> have this really simple events system, but how do we expect it to be used
> in the kernel.

No, we don't have any usage recommendations.  Going forward, this is
something we all need to work on and agree with.

All I want is a way to get events to user-space asynchronously without
any hacks.  This fits the bill nicely.  ;-)

That said, I do have some basic ideas about usage.  I see two main uses,
asynchronous events (such as, filesystem mounted) and the more specific
case of errors (such as device failure).

Criteria for adding the event would be that user-space needs to know
about it, and would normally have to poll to get the information.  If
the event is so non-important that right now no one even knows about it
or cares about it, it may not be worth adding.

But let's look at filesystem mounted, since many user-space applications
are interested in this.  Right now, they poll /proc/mtab every few
seconds, parse it, and look for changes.  Gross, right?

So we can create an event in fs/mount.c, say "/org/kernel/fs/mount" with
the signal "change".  The payload could be a simple "mounted" and
"unmounted" or the exact details on what was mounted or unmounted or
even nothing.  I'd prefer to give no information and just have the event
cause a re-read of /proc/mtab.  But whatever.

So we want up with, in do_mount,

	send_kevent (KEVENT_FS, "/org/kernel/fs/mount",
		     "change", "mounted");

Or similar.

	Robert Love


