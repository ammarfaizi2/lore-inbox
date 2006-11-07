Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753925AbWKGXoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbWKGXoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbWKGXoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:44:17 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58511 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1753925AbWKGXoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:44:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Wed, 8 Nov 2006 00:42:02 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611080005.50070.rjw@sisk.pl> <45511430.8030703@redhat.com>
In-Reply-To: <45511430.8030703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611080042.03563.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 November 2006 00:18, Eric Sandeen wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday, 7 November 2006 23:45, Eric Sandeen wrote:
> >> Andrew Morton wrote:
> >>
> >>>> --- linux-2.6.19-rc4.orig/fs/buffer.c	2006-11-07 17:06:20.000000000 +0000
> >>>> +++ linux-2.6.19-rc4/fs/buffer.c	2006-11-07 17:26:04.000000000 +0000
> >>>> @@ -188,7 +188,9 @@ struct super_block *freeze_bdev(struct b
> >>>>  {
> >>>>  	struct super_block *sb;
> >>>>  
> >>>> -	mutex_lock(&bdev->bd_mount_mutex);
> >>>> +	if (down_trylock(&bdev->bd_mount_sem))
> >>>> +		return -EBUSY;
> >>>> +
> >>> This is a functional change which isn't described in the changelog.  What's
> >>> happening here?
> >> Only allow one bdev-freezer in at a time, rather than queueing them up?
> > 
> > But freeze_bdev() is supposed to return the result of get_super(bdev)
> > _unconditionally_.  Moreover, in its current form freeze_bdev() _cannot_
> > _fail_, so I don't see how this change doesn't break any existing code.
> 
> Well, it could return NULL.  Is that a failure?

It will only fail if get_super(bdev) returns NULL, but if you call
freeze_bdev(sb->s_bdev), then it can't do that.

> But, nobody is checking for an outright error, certainly.  Especially
> when the error hasn't been ERR_PTR'd.  :)  So I agree, that's not so good.
> 
> But, how is a stampede of fs-freezers -supposed- to work?  I could
> imagine something like a freezer count, and the filesystem is only
> unfrozen after everyone has thawed?  Or should only one freezer be
> active at a time... which is what we have now I guess.

I think it shouldn't be possible to freeze an fs more than once.
