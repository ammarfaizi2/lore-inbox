Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWD3M1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWD3M1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWD3M1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:27:47 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:20196 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750930AbWD3M1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:27:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Sun, 30 Apr 2006 14:27:21 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <200604260043.03481.rjw@sisk.pl> <200604261049.39592.nigel@suspend2.net>
In-Reply-To: <200604261049.39592.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301427.22687.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 26 April 2006 02:49, Nigel Cunningham wrote:
> On Wednesday 26 April 2006 08:43, Rafael J. Wysocki wrote:
> > On Wednesday 26 April 2006 00:25, Pavel Machek wrote:
> > > > > It does apply to all of the LRU pages. This is what I've been doing
> > > > > for years now. The only corner case I've come across is XFS. It still
> > > > > wants to write data even when there's nothing to do and it's threads
> > > > > are frozen (IIRC - haven't looked at it for a while). I got around
> > > > > that by freezing bdevs when freezing processes.
> > > >
> > > > This means if we freeze bdevs, we'll be able to save all of the LRU
> > > > pages, except for the pages mapped by the current task, without
> > > > copying.  I think we can try to do this, but we'll need a patch to
> > > > freeze bdevs for this purpose. ;-)
> > >
> > > ...adding more dependencies to how vm/blockdevs work. I'd say current
> > > code is complex enough...
> >
> > Well, why don't we see the patch?  If it's too complex, we can just decide
> > not to use it. :-)
> 
> In Suspend2, I'm still using a different version of process.c to what you guys 
> have. In my version, I thaw kernelspace, then thaw bdevs, then thaw userspace. 
> The version below just thaws bdevs after thawing all processes. I think that 
> might need modification, but thought I'd post this now so you can see how 
> complicated or otherwise it is.

IMHO it doesn't look so scary. :-)

> diff -ruN linux-2.6.17-rc2/kernel/power/process.c bdev-freeze/kernel/power/process.c
> --- linux-2.6.17-rc2/kernel/power/process.c	2006-04-19 14:27:36.000000000 +1000
> +++ bdev-freeze/kernel/power/process.c	2006-04-26 10:44:56.000000000 +1000
> @@ -19,6 +19,56 @@
>   */
>  #define TIMEOUT	(20 * HZ)
>  
> +struct frozen_fs
> +{
> +	struct list_head fsb_list;
> +	struct super_block *sb;
> +};
> +
> +LIST_HEAD(frozen_fs_list);
> +
> +void freezer_make_fses_rw(void)
> +{
> +	struct frozen_fs *fs, *next_fs;
> +
> +	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
> +		thaw_bdev(fs->sb->s_bdev, fs->sb);
> +
> +		list_del(&fs->fsb_list);
> +		kfree(fs);
> +	}
> +}
> +
> +/* 
> + * Done after userspace is frozen, so there should be no danger of
> + * fses being unmounted while we're in here.
> + */
> +int freezer_make_fses_ro(void)
> +{
> +	struct frozen_fs *fs;
> +	struct super_block *sb;
> +
> +	/* Generate the list */
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		if (!sb->s_root || !sb->s_bdev ||
> +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> +		    (sb->s_flags & MS_RDONLY))
> +			continue;
> +
> +		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);

Shouldn't we check for kmalloc() failures here?

> +		fs->sb = sb;
> +		list_add_tail(&fs->fsb_list, &frozen_fs_list);
> +	};
> +
> +	/* Do the freezing in reverse order so filesystems dependant
> +	 * upon others are frozen in the right order. (Eg loopback
> +	 * on ext3). */
> +	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
> +		freeze_bdev(fs->sb->s_bdev);
> +
> +	return 0;
> +}
> +
>  
>  static inline int freezeable(struct task_struct * p)
>  {
> @@ -77,6 +127,7 @@
>  	printk( "Stopping tasks: " );
>  	start_time = jiffies;
>  	user_frozen = 0;
> +	bdevs_frozen = 0;
>  	do {
>  		nr_user = todo = 0;
>  		read_lock(&tasklist_lock);
> @@ -107,6 +158,10 @@
>  			start_time = jiffies;
>  		}
>  		user_frozen = !nr_user;
> +
> +		if (user_frozen && !bdevs_frozen)
> +			freezer_make_fses_ro();
> +
>  		yield();			/* Yield is okay here */
>  		if (todo && time_after(jiffies, start_time + TIMEOUT))
>  			break;
> @@ -156,6 +211,8 @@
>  			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
>  	} while_each_thread(g, p);
>  
> +	freezer_make_fses_rw();
> +
>  	read_unlock(&tasklist_lock);
>  	schedule();
>  	printk( " done\n" );

Greetings,
Rafael
