Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbVITFRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVITFRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbVITFRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:17:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15247 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932729AbVITFRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:17:31 -0400
Date: Tue, 20 Sep 2005 06:17:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920051729.GF7992@ftp.linux.org.uk>
References: <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org> <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org> <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex> <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127192784.19093.7.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 01:06:23AM -0400, John McCutchan wrote:
> On Tue, 2005-09-20 at 05:58 +0100, Al Viro wrote:
> > On Tue, Sep 20, 2005 at 12:53:12AM -0400, John McCutchan wrote:
> > > DELETE_SELF WD=X
> > > 
> > > The path you requested a watch on (inotify_add_watch(path,mask) returned
> > > X) has been deleted.
> > 
> > Then why the devil do we have IN_DELETE and IN_DELETE_SELF generated
> > in different places?  The only difference is in who receives the
> > event - you send IN_DELETE to watchers on parent and IN_DELETE_SELF
> > on watchers on victim.  Event itself is the same, judging by your
> > description...
> 
> No, because in the case of IN_DELETE, the path represented by the WD
> hasn't been deleted, it is "PATH(WD)/event->name" that has been.

That's OK - same thing described for different recepients, thus two
events with different contents and type being sent.

> Also,
> IN_DELETE_SELF marks the death of the WD, no further events will be sent
> with the same WD [Except for the IN_IGNORE]. 

Uh-oh...  Now, _that_ is rather interesting - you are giving self-contradictory
descriptions of the semantics.

fd = open("foo", 0);
unlink("foo");
sleep for a day
fchmod(fd, 0400);
sleep for a day
close(fd);

Which events do we have here?  Removal of path happens at unlink(); change
of attributes - a day later.
