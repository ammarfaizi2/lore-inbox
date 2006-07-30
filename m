Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWG3VVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWG3VVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWG3VVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:21:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932322AbWG3VVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:21:49 -0400
Date: Sun, 30 Jul 2006 14:21:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: linux-kernel@vger.kernel.org, neilb@suse.de
Subject: Re: let md auto-detect 128+ raid members, fix potential race
 condition
Message-Id: <20060730142137.b1789aff.akpm@osdl.org>
In-Reply-To: <orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 17:56:31 -0300
Alexandre Oliva <aoliva@redhat.com> wrote:

> On Jul 30, 2006, Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Sun, 30 Jul 2006 03:56:21 -0300
> > Alexandre Oliva <aoliva@redhat.com> wrote:
> 
> >> -void md_autodetect_dev(dev_t dev);
> >> +int md_register_autodetect_dev(dev_t dev);
> 
> > Put it in a header file, please.
>  
> AFAICT it really isn't supposed to be used elsewhere.  I suppose I
> could add it to either blkdev.h, fs.h or raid/md.h, since it's more of
> glue code between two modules than something that belongs to one
> specific module.  E.g., if it goes in raid/md.h, where it feels the
> most appropriate, then fs/parititions/check.c has to include it, which
> doesn't sound right.  OTOH, if it goes in blkdev.h or fs.h, then a lot
> of code ends up seeing the declaration that shouldn't be available.
> Thoughts?

If the function is exported by md then md.h would be an appropriate place
for the declaration.

> Maybe we could replace this with some register/unregister notifier
> interface, such that add_partitions() could then notify multiple
> watchers when a new partition is configured.  This would remove the
> backwards dependency here, but I feel it should be done in a separate
> patch.  I don't mind if they're integrated at once, but I don't feel
> that changing two unrelated issues at once is a good approach.

If we went that way then patch #1 would be "add a notifier" and patch #2
would be "use it in md".

Do we anticipate that there would ever be other users of this notifier
callback API?

> >> #ifdef CONFIG_BLK_DEV_MD
> >> -		if (state->parts[p].flags)
> >> -			md_autodetect_dev(bdev->bd_dev+p);
> >> +		if (state->parts[p].flags
> >> +		    && md_register_autodetect_dev(bdev->bd_dev+p))
> >> +			printk(KERN_ERR "md: out of memory registering %s%d\n",
> >> +			       disk->disk_name, p);
> >> #endif
> 
> > What happens if CONFIG_BLK_DEV_MD=m?
> 
> AFAIK then you'd get a link failure.  One more reason to go with the
> notifier approach, I guess.  It wouldn't quite enable md to
> auto-detect from partitions set up before the module was loaded, but
> it would at least remove this presumed link error.
> 
> Another approach would be to split the autodetect stuff out of md.c
> into a separate file that goes in the main kernel image (if
> CONFIG_MD=y, it's never m) even if CONFIG_BLK_DEV_MD=m.  Would this be
> a desirable arrangement?

I guess it sounds logical, but I'm not sure what the end result would look
like.  Which amounts to noncommittal Sunday afternoon waffling ;)

The notifier certainly makes sense if we anticipate other users of it.  If
we think it'll always be an md-special thing then yeah, I guess we can code
it that way.
