Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUI1BvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUI1BvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 21:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUI1BvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 21:51:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:22721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267452AbUI1BvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 21:51:08 -0400
Date: Mon, 27 Sep 2004 21:41:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040927214141.688b2b2c.akpm@osdl.org>
In-Reply-To: <1096318369.30503.136.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> wrote:
>
> > > +	memset(dev->bitmask, 0,
> > > +	  sizeof(unsigned long) * MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG);
> > 
> > What purpose does this bitmask serve, anyway??
> 
> Bitmask of allocated/unallocated watcher descriptors.

Can you expand on that?  Why do we need such a bitmap?

Would an idr tree be more appropriate?

> We _could_ take a fixed minor...
> 
> > > +struct inotify_event {
> > > +	int wd;
> > > +	int mask;
> > > +	int cookie;
> > > +	char filename[INOTIFY_FILENAME_MAX];
> > > +};
> > 
> > yeah, that's not very nice.  Better to kmalloc the pathname.
> 
> That is the structure that we communicate with to user-space.

In that case it looks rather 64-bit-unfriendly.  A 32-bit compiler will lay
that structure out differently from a 64-bit compiler.  Or not.  Hard to
say.  Perhaps something more defensive is needed here.


One other thing: the patch adds 16 bytes to struct inode, for a feature
which many users and most inodes will not use.  Unfortunate.

Is it possible to redesign things so that those four new fields are in a
standalone struct which points at the managed inode?  Joined at the hip
like journal_head and buffer_head?

Bonus marks for not having a backpointer from the inode to the new struct ;)

(Still wondering what those timers are doing in there, btw)
