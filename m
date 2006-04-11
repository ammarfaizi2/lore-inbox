Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWDKDNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWDKDNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 23:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWDKDNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 23:13:34 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:35243 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932260AbWDKDNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 23:13:33 -0400
X-IMAP-Sender: amg
Date: Mon, 10 Apr 2006 23:13:30 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: John McCutchan <john@johnmccutchan.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>
Subject: Re: [RFC][PATCH] inotify kernel api
Message-ID: <20060411031329.GC656@sage.flatmonk>
Mail-Followup-To: Amy Griffis <amy.griffis@hp.com>,
	John McCutchan <john@johnmccutchan.com>,
	linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>
References: <20060406170601.GA22698@zk3.dec.com> <1144694188.29846.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1144694188.29846.9.camel@localhost.localdomain>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:  [Mon Apr 10 2006, 02:36:28PM EDT]
> On Thu, 2006-04-06 at 13:06 -0400, Amy Griffis wrote:
> > The following patch against 2.6.17-rc1-mm1 introduces a kernel API for inotify.
> >
> > Event processing is unchanged except for the indirection added for the
> > callback.  In inotify_user.c, an additional per-device mutex is held
> > while adding watches to prevent adding the same watch twice.  The
> > design retains the original assumption that there will be more watches
> > per inotify_handle than watches on any given inode, and performs the
> > search for existing watches accordingly.
> > 
> 
> Why do we need the 'up_mutex' mutex? Was this a bug in the old code? 

The up_mutex is needed to ensure that a watch that does not exist when
calling inotify_find_update_watch() still does not exist when calling
inotify_add_watch().  It seemed to me that the find/update and add
functions needed to be separated for the kernel api.

Unfortunately we can't use dev->ev_mutex here as it's taken during the
callback.

> > This patch makes the inotify_watch public so it can be embedded in callers' own
> > watch structures, which avoids the use of a void ptr to caller data.
> > Even though inotify_watch is public, callers must use the established
> > interfaces to access inotify_watch contents.  Was this the best
> > choice?
> > 
> 
> I suppose this is an alright change. As long as it is understood that
> there is no guarantee about the layout of the inotify_watch structure. A
> comment in inotify.h should do.

Done.

 * Callers must use the established inotify interfaces to access inotify_watch
 * contents.  The content of this structure is private to the inotify
 * implementation.

> > I think the locking may be less than ideal, as the
> > inode->inotify_mutex must be held to traverse the inode's watchlist,
> > and thus must be held during the callback.  The result is that the
> > caller can't hold any locks taken during callback processing while
> > calling any of the published inotify interfaces, making
> > synchronization a little more difficult.
> > 
> 
> Well, I think it's up for the kernel consumers to decide whether or not
> this is acceptable. It's probably a good idea to come up with some use
> cases for the kernel API and see if this _is_ a problem. Since the
> callbacks will be run inside the VFS ops, they need to be small and
> fast, so they probably should just be putting the event on a list and
> handling it later.
> 
> Looking over the patch, nothing jumps out at me as being wrong. But some
> stress testing would convince me faster than my eyes can.

I'll follow up with some stress test results.

Thanks,
Amy
