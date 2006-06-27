Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWF0JxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWF0JxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWF0JxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:53:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43796 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932531AbWF0JxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:53:10 -0400
Date: Tue, 27 Jun 2006 11:54:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627095443.GQ22071@suse.de>
References: <20060625093534.1700e8b6@localhost> <20060625102837.GC20702@suse.de> <20060625152325.605faf1f@localhost> <20060625174358.GA21513@suse.de> <20060627112105.0b15bfa1@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627112105.0b15bfa1@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Paolo Ornati wrote:
> On Sun, 25 Jun 2006 19:43:59 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > > Hmm, and you are sure that the fs is properly umounted on reboot? Or is
> > > > it just remounted ro? It looks like fcache_close_dev() isn't being
> > > > called, so the cache serial doesn't match what we expect from the fs,
> > > > hence fcache bails out since it could indicate that the fs has been
> > > > changed without fcache being attached.
> > > 
> > > Ahh... it is the root fs and it's just remounted read-only by the
> > > standard Gentoo scripts ;)
> > > 
> > > I don't think that unmounting it is trivial (you need to chroot to a
> > > virtual FS or something...). Does any distro do it?
> > 
> > ro should be enough, something odd must be going on. I'll add it to the
> > list of things to test tomorrow.
> 
> Since "fcache_close_dev()" is called by "ext3_put_super()" I have added
> this stupid printk:
> 
> --- fs/ext3/super.c.orig        2006-06-27 10:47:15.000000000 +0200
> +++ fs/ext3/super.c     2006-06-27 10:50:36.000000000 +0200
> @@ -422,6 +422,8 @@ static void ext3_put_super (struct super
> 
>         has_fcache = test_opt(sb, FCACHE);
> 
> +       printk("!!! ext3_put_super !!!   has_fcache=%d\n", has_fcache);
> +
>         ext3_xattr_put_super(sb);
>         journal_destroy(sbi->s_journal);
>         if (!(sb->s_flags & MS_RDONLY)) {
> 
> 
> It triggers on unmount but it doesn't on remount "ro".
> 
> So the problem is that "fcache_close_dev()" have zero chances to run ;)

Hmm, you seem to be using an older fcache version. I'll test this and
post an updated patch if it doesn't work with the newer version.

-- 
Jens Axboe

