Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWJWOIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWJWOIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWJWOIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:08:11 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23740 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964870AbWJWOIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:08:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Mon, 23 Oct 2006 16:07:16 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net>
In-Reply-To: <1161605379.3315.23.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231607.17525.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 14:09, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-10-23 at 12:36 +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > > XFS can continue to submit I/O from a timer routine, even after
> > > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > > be an issue for current swsusp code,
> > 
> > So it doesn't look like we need the patch _now_.
> 
> I'm trying to prepare the patches to make swsusp into suspend2.

Oh, I see.  Please don't do that.

> Please assume it's part of a stream of patches that belong together, rather
> than an isolated modification. Yes, I'd really rather just rm -f swap.c
> user.c swsusp.c,

And I'm against that, sorry.  Also I don't think you can remove user.c just
like that.

> but I'm trying to do the incremental modification thing for you.
>
> > > but is definitely an issue for Suspend2, where the pages being written could
> > > be overwritten by Suspend2's atomic copy.
> > 
> > And IMO that's a good reason why we shouldn't use RCU pages for storing the
> > image.  XFS is one known example that breaks things if we do so and
> > there may be more such things that we don't know of.  The fact that they
> > haven't appeared in testing so far doesn't mean they don't exist and
> > moreover some things like that may appear in the future.
> 
> Ok. We can modify the selection of pages to be overwritten. I agree that
> absence of proof isn't proof of absence, but on the later part, we can't
> rule some modification out now because something in the future might
> break it.

This case is a bit special.  I don't think it would be right to require every
device driver writer to avoid modifying RCU pages from the interrupt
context, because that would break the suspend to disk ...

Besides, if there is an RCU page that we _know_ we can use to store the image
in it, we can just include this page in the image without copying.  This
already gives us one extra free page for the rest of the image and we can
_avoid_ creating two images which suspend2 does and which adds a _lot_ of
complexity to the code.

> > > We can address this issue by freezing bdevs after stopping userspace
> > > threads, and thawing them prior to thawing userspace.
> > 
> > This will only address the issues related to filesystems, but the RCU pages
> > can also be modified from interrupt context by other code, AFAICT.
> 
> Agreed. We can find some other way to address that.

I think, to stat with, we should look for pages that we're deadly sure will
_not_ be overwritten from the interrupt context (for example, the pages that
are mapped read-only by the user space look promising).  Then, we should
estimate the number of these pages and consider if dealing with them in
a special way is worth the effort.

> > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > > 
> > > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > > index 4a001fe..ddeeb50 100644
> > > --- a/kernel/power/process.c
> > > +++ b/kernel/power/process.c
> > > @@ -13,6 +13,7 @@ #include <linux/interrupt.h>
> > >  #include <linux/suspend.h>
> > >  #include <linux/module.h>
> > >  #include <linux/syscalls.h>
> > > +#include <linux/buffer_head.h>
> > >  #include <linux/freezer.h>
> > >  
> > >  /* 
> > > @@ -20,6 +21,58 @@ #include <linux/freezer.h>
> > >   */
> > >  #define TIMEOUT	(20 * HZ)
> > >  
> > > +struct frozen_fs
> > > +{
> > > +	struct list_head fsb_list;
> > > +	struct super_block *sb;
> > > +};
> > > +
> > > +LIST_HEAD(frozen_fs_list);
> > > +
> > > +void freezer_make_fses_rw(void)
> > > +{
> > > +	struct frozen_fs *fs, *next_fs;
> > > +
> > > +	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
> > > +		thaw_bdev(fs->sb->s_bdev, fs->sb);
> > > +
> > > +		list_del(&fs->fsb_list);
> > > +		kfree(fs);
> > > +	}
> > > +}
> > > +
> > > +/* 
> > > + * Done after userspace is frozen, so there should be no danger of
> > > + * fses being unmounted while we're in here.
> > > + */
> > > +int freezer_make_fses_ro(void)
> > > +{
> > > +	struct frozen_fs *fs;
> > > +	struct super_block *sb;
> > > +
> > > +	/* Generate the list */
> > > +	list_for_each_entry(sb, &super_blocks, s_list) {
> > > +		if (!sb->s_root || !sb->s_bdev ||
> > > +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> > > +		    (sb->s_flags & MS_RDONLY))
> > > +			continue;
> > > +
> > > +		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
> > > +		if (!fs)
> > > +			return 1;
> > 
> > You're still leaking memory here.
> 
> Ah. Good point.
> 
> > I have a simpler version of this patch without this leak, but we have decided
> > we won't apply it anyway.
> 
> We?

Well, Pavel and I have discussed that with the XFS people.

> You do realise that XFS can still be writing data while you're writing 
> your snapshot, 

According to the XFS people, this can't happen.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
