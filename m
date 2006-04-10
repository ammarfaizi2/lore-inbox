Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWDJSg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWDJSg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWDJSg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:36:28 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:9810 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932096AbWDJSg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:36:28 -0400
Message-ID: <BAYC1-PASMTP100D4C6A96440C47EA2F93B9CC0@CEZ.ICE>
X-Originating-IP: [70.49.209.204]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [RFC][PATCH] inotify kernel api
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Amy Griffis <amy.griffis@hp.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>
In-Reply-To: <20060406170601.GA22698@zk3.dec.com>
References: <20060406170601.GA22698@zk3.dec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Apr 2006 14:36:28 -0400
Message-Id: <1144694188.29846.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-OriginalArrivalTime: 10 Apr 2006 18:38:02.0765 (UTC) FILETIME=[E6401BD0:01C65CCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 13:06 -0400, Amy Griffis wrote:
> The following patch against 2.6.17-rc1-mm1 introduces a kernel API for inotify.
>
> Event processing is unchanged except for the indirection added for the
> callback.  In inotify_user.c, an additional per-device mutex is held
> while adding watches to prevent adding the same watch twice.  The
> design retains the original assumption that there will be more watches
> per inotify_handle than watches on any given inode, and performs the
> search for existing watches accordingly.
> 

Why do we need the 'up_mutex' mutex? Was this a bug in the old code? 

> This patch makes the inotify_watch public so it can be embedded in callers' own
> watch structures, which avoids the use of a void ptr to caller data.
> Even though inotify_watch is public, callers must use the established
> interfaces to access inotify_watch contents.  Was this the best
> choice?
> 

I suppose this is an alright change. As long as it is understood that
there is no guarantee about the layout of the inotify_watch structure. A
comment in inotify.h should do.

> I think the locking may be less than ideal, as the
> inode->inotify_mutex must be held to traverse the inode's watchlist,
> and thus must be held during the callback.  The result is that the
> caller can't hold any locks taken during callback processing while
> calling any of the published inotify interfaces, making
> synchronization a little more difficult.
> 

Well, I think it's up for the kernel consumers to decide whether or not
this is acceptable. It's probably a good idea to come up with some use
cases for the kernel API and see if this _is_ a problem. Since the
callbacks will be run inside the VFS ops, they need to be small and
fast, so they probably should just be putting the event on a list and
handling it later.

Looking over the patch, nothing jumps out at me as being wrong. But some
stress testing would convince me faster than my eyes can.

-- 
John McCutchan <john@johnmccutchan.com>
