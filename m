Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUI1CO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUI1CO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUI1CO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:14:58 -0400
Received: from peabody.ximian.com ([130.57.169.10]:32425 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267474AbUI1COy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:14:54 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040927214141.688b2b2c.akpm@osdl.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <20040927214141.688b2b2c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 27 Sep 2004 22:14:58 -0400
Message-Id: <1096337698.5103.145.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 21:41 -0700, Andrew Morton wrote:

> Can you expand on that?  Why do we need such a bitmap?

It is a unique cookie that identifies the exact object being watched
(e.g. /home/rml or /etc/fstab).  I suspect John introduced it in lieu of
the (device,inode) tuple when Al bitched, which makes sense.  Because we
have only a single fd (this is one of the problems with dnotify, the 1:1
relation between objects and file descriptors consumed) we need some
other object to identify each watched object.

So John introduced watcher descriptors.  This bitmask keeps track of
which descriptors are used versus unused.

> Would an idr tree be more appropriate?

Quite possibly.  I was originally thinking that idr's were too heavy,
but if we can make the wd <-> inotify_watcher relation then they make
perfect sense.

I'll look at making the conversion.

> In that case it looks rather 64-bit-unfriendly.  A 32-bit compiler will lay
> that structure out differently from a 64-bit compiler.  Or not.  Hard to
> say.  Perhaps something more defensive is needed here.

Well, no, since all known architectures are everything-is-32bit or LP64,
as far as I know.  And padding would be the same.

And even if not, the only problem would be with 64-bit architectures and
a 32-bit user-space.

Nonetheless, we should probably make the three int types be s32 or
u32's, eh?  I will submit a patch.

> One other thing: the patch adds 16 bytes to struct inode, for a feature
> which many users and most inodes will not use.  Unfortunate.
> 
> Is it possible to redesign things so that those four new fields are in a
> standalone struct which points at the managed inode?  Joined at the hip
> like journal_head and buffer_head?

We could probably get away with a single word-sized variable in the
inode structure.

> Bonus marks for not having a backpointer from the inode to the new struct ;)

Don't push your luck. ;-)

In school, I always felt the bonus was just showing off, what with the
perfect score on the normal assignment.  But I will investigate.

> (Still wondering what those timers are doing in there, btw)

John?  I see what the timer does, but I am wondering why a timer _has_
to do it?

Thanks for the review, Andrew.

	Robert Love


