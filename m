Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUI1DpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUI1DpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 23:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUI1DpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 23:45:25 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:25576 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S267518AbUI1DpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 23:45:18 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
In-Reply-To: <1096337698.5103.145.camel@localhost>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <20040927214141.688b2b2c.akpm@osdl.org>
	 <1096337698.5103.145.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096343091.11477.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 23:44:51 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.27.6
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 22:14, Robert Love wrote:
> On Mon, 2004-09-27 at 21:41 -0700, Andrew Morton wrote:
> 
> > Can you expand on that?  Why do we need such a bitmap?
> 
> It is a unique cookie that identifies the exact object being watched
> (e.g. /home/rml or /etc/fstab).  I suspect John introduced it in lieu of
> the (device,inode) tuple when Al bitched, which makes sense.  Because we
> have only a single fd (this is one of the problems with dnotify, the 1:1
> relation between objects and file descriptors consumed) we need some
> other object to identify each watched object.
> 
> So John introduced watcher descriptors.  This bitmask keeps track of
> which descriptors are used versus unused.
> 
> > Would an idr tree be more appropriate?
> 
> Quite possibly.  I was originally thinking that idr's were too heavy,
> but if we can make the wd <-> inotify_watcher relation then they make
> perfect sense.
> 
> I'll look at making the conversion.

I only first heard about idr in last weeks LWN, I thought they might be
useful.

> 
> > In that case it looks rather 64-bit-unfriendly.  A 32-bit compiler will lay
> > that structure out differently from a 64-bit compiler.  Or not.  Hard to
> > say.  Perhaps something more defensive is needed here.
> 
> Well, no, since all known architectures are everything-is-32bit or LP64,
> as far as I know.  And padding would be the same.
> 
> And even if not, the only problem would be with 64-bit architectures and
> a 32-bit user-space.
> 
> Nonetheless, we should probably make the three int types be s32 or
> u32's, eh?  I will submit a patch.
> 
> > One other thing: the patch adds 16 bytes to struct inode, for a feature
> > which many users and most inodes will not use.  Unfortunate.
> > 
> > Is it possible to redesign things so that those four new fields are in a
> > standalone struct which points at the managed inode?  Joined at the hip
> > like journal_head and buffer_head?
> 
> We could probably get away with a single word-sized variable in the
> inode structure.
> 

Yep, we could toss everything in to a structure and only have a pointer
to it from the inode.

> > Bonus marks for not having a backpointer from the inode to the new struct ;)
> 
> Don't push your luck. ;-)
> 
> In school, I always felt the bonus was just showing off, what with the
> perfect score on the normal assignment.  But I will investigate.
> 
> > (Still wondering what those timers are doing in there, btw)
> 
> John?  I see what the timer does, but I am wondering why a timer _has_
> to do it?

We need a timer to wake up any processes blocking on a read() call. The
reason it has to be a timer is because the code paths that get run when
an event is queued are not safe places to wake up blocked processes (But
I a kernel amateur so I am probably wrong).

John
