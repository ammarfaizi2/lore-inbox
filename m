Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbVITQjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbVITQjD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVITQjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:39:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44168 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932661AbVITQjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:39:00 -0400
Date: Tue, 20 Sep 2005 17:38:48 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920163848.GO7992@ftp.linux.org.uk>
References: <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org> <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex> <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk> <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 08:34:20AM -0400, John McCutchan wrote:
> Where is the contradiction?
> 
> >fd = open("foo", 0);
> >unlink("foo");
> >sleep for a day
> >fchmod(fd, 0400);
> >sleep for a day
> >close(fd);
> >
> >Which events do we have here?  Removal of path happens at unlink();  
> >change
> >of attributes - a day later.
> >
> 
> [I'm assuming that fchmod continues to work even if the path has been  
> deleted.]

Of course it does.

> With Linus's latest patch:
> 
> IN_ATTRIB
> IN_DELETE_SELF
> IN_IGNORE

And IN_DELETE_SELF comes days after the path removal; moreover, it
comes after event that happened after the path removal.  To make it
even funnier, have your code do fchmod() only if stat("foo", ...)
returns -ENOENT.
 
> If we were able to get inoderemove called when the path removal happens,
>
> IN_DELETE_SELF
> IN_IGNORE
> 
> At this point, inotify would stop monitoring the inode, and we would  
> never see the fchmod.

So if you have
ln a b
start watching b
rm a
chmod 400 b
you'll get no event on that chmod?  Both with the current version and
one with your "if we were able" above...

I don't get it.  Could you please describe what your code is _supposed_
to do?  I'm not even talking about implementation - it's on the level
of "what do we want the watchers to see after the following operations".
Especially since you have fixed ABI - if you have userland clients
relying on the representation of individual events, surely they also
have to assume something about the sequence of events generated when
we do this and that to files and directories?
