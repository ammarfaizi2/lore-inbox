Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVITSWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVITSWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVITSWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:22:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12241 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964949AbVITSWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:22:53 -0400
Date: Tue, 20 Sep 2005 19:22:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ray Lee <ray@madrabbit.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920182249.GP7992@ftp.linux.org.uk>
References: <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex> <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk> <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org> <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost> <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 11:12:02AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Sep 2005, Ray Lee wrote:
> > 
> > I can't even talk to that level, but perhaps it'd help to know that some
> > (I think) are pinning their hopes on inotify as the foundation of a
> > userspace negative dentry cache (i.e., samba trying to prove a set of
> > filenames (case-insensitively) doesn't exist).
> 
> Note that than you should use the _name_ caching part, ie the 
> fsnotify_nameremove() part of the equation. That part is unambiguous.
> 
> It's literally only the "inode" things (IN_DELETE_SELF) that are
> questionable. And that's fundamentally because the "self" can live on for
> _longer_ than the name that points to it.
> 
> I really think that the patch I sent out yesterday is as good as it gets.  
> If you want immediate notification, you should ask for notification about
> name changes in a particular directory. IN_DELETE_SELF notification on a
> file simple is _not_ going to be immediate.

But then it's too early.  Note that with your patch we still get removal
of _any_ link to our inode (even though it's alive and well and we'd never
heard about the sodding link in the first place) terminating all events
on it.  See example upthread - we have two links to the same inode;
the_only_name_we_know and ~luser/foo/bar/baz.   We watch the_only_name_we_know.
Luser goes spring-cleaning and does rm ~luser/foo/bar/baz.  Now we suddenly
get IN_DELETE_SELF on our watch *and* stop getting anything coming on that
sucker.

This is obviously broken - even if we reinstate the watch (after figuring out
that there had been no events on parent), we are already too late - we've
lost an unknown number of events _and_ had to do non-trivial cleanup in
the client (including redoing stat() and friends if we are going to compensate
for the lost events).
