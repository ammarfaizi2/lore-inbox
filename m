Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWJWMJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWJWMJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWJWMJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:09:48 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:24715 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932152AbWJWMJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:09:47 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200610231236.54317.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610231236.54317.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 22:09:39 +1000
Message-Id: <1161605379.3315.23.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 12:36 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > XFS can continue to submit I/O from a timer routine, even after
> > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > be an issue for current swsusp code,
> 
> So it doesn't look like we need the patch _now_.

I'm trying to prepare the patches to make swsusp into suspend2. Please
assume it's part of a stream of patches that belong together, rather
than an isolated modification. Yes, I'd really rather just rm -f swap.c
user.c swsusp.c, but I'm trying to do the incremental modification thing
for you.

> > but is definitely an issue for Suspend2, where the pages being written could
> > be overwritten by Suspend2's atomic copy.
> 
> And IMO that's a good reason why we shouldn't use RCU pages for storing the
> image.  XFS is one known example that breaks things if we do so and
> there may be more such things that we don't know of.  The fact that they
> haven't appeared in testing so far doesn't mean they don't exist and
> moreover some things like that may appear in the future.

Ok. We can modify the selection of pages to be overwritten. I agree that
absence of proof isn't proof of absence, but on the later part, we can't
rule some modification out now because something in the future might
break it.

> > We can address this issue by freezing bdevs after stopping userspace
> > threads, and thawing them prior to thawing userspace.
> 
> This will only address the issues related to filesystems, but the RCU pages
> can also be modified from interrupt context by other code, AFAICT.

Agreed. We can find some other way to address that.

> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > 
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index 4a001fe..ddeeb50 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -13,6 +13,7 @@ #include <linux/interrupt.h>
> >  #include <linux/suspend.h>
> >  #include <linux/module.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/buffer_head.h>
> >  #include <linux/freezer.h>
> >  
> >  /* 
> > @@ -20,6 +21,58 @@ #include <linux/freezer.h>
> >   */
> >  #define TIMEOUT	(20 * HZ)
> >  
> > +struct frozen_fs
> > +{
> > +	struct list_head fsb_list;
> > +	struct super_block *sb;
> > +};
> > +
> > +LIST_HEAD(frozen_fs_list);
> > +
> > +void freezer_make_fses_rw(void)
> > +{
> > +	struct frozen_fs *fs, *next_fs;
> > +
> > +	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
> > +		thaw_bdev(fs->sb->s_bdev, fs->sb);
> > +
> > +		list_del(&fs->fsb_list);
> > +		kfree(fs);
> > +	}
> > +}
> > +
> > +/* 
> > + * Done after userspace is frozen, so there should be no danger of
> > + * fses being unmounted while we're in here.
> > + */
> > +int freezer_make_fses_ro(void)
> > +{
> > +	struct frozen_fs *fs;
> > +	struct super_block *sb;
> > +
> > +	/* Generate the list */
> > +	list_for_each_entry(sb, &super_blocks, s_list) {
> > +		if (!sb->s_root || !sb->s_bdev ||
> > +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> > +		    (sb->s_flags & MS_RDONLY))
> > +			continue;
> > +
> > +		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
> > +		if (!fs)
> > +			return 1;
> 
> You're still leaking memory here.

Ah. Good point.

> I have a simpler version of this patch without this leak, but we have decided
> we won't apply it anyway.

We?

You do realise that XFS can still be writing data while you're writing
your snapshot, so (depending on what it does), you might end up with a
messed up filesystem without something similar? (XFS may do
$UNDEFINED_WRITING_TO_DISK while writing the snapshot and potentially
different/inconsistent $UNDEFINED_WRITING_TO_DISK after the atomic
restore).

Nigel

