Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWF0JVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWF0JVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWF0JVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:21:15 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:19677 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750949AbWF0JVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:21:14 -0400
Date: Tue, 27 Jun 2006 11:21:05 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627112105.0b15bfa1@localhost>
In-Reply-To: <20060625174358.GA21513@suse.de>
References: <20060625093534.1700e8b6@localhost>
	<20060625102837.GC20702@suse.de>
	<20060625152325.605faf1f@localhost>
	<20060625174358.GA21513@suse.de>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 19:43:59 +0200
Jens Axboe <axboe@suse.de> wrote:

> > > Hmm, and you are sure that the fs is properly umounted on reboot? Or is
> > > it just remounted ro? It looks like fcache_close_dev() isn't being
> > > called, so the cache serial doesn't match what we expect from the fs,
> > > hence fcache bails out since it could indicate that the fs has been
> > > changed without fcache being attached.
> > 
> > Ahh... it is the root fs and it's just remounted read-only by the
> > standard Gentoo scripts ;)
> > 
> > I don't think that unmounting it is trivial (you need to chroot to a
> > virtual FS or something...). Does any distro do it?
> 
> ro should be enough, something odd must be going on. I'll add it to the
> list of things to test tomorrow.

Since "fcache_close_dev()" is called by "ext3_put_super()" I have added
this stupid printk:

--- fs/ext3/super.c.orig        2006-06-27 10:47:15.000000000 +0200
+++ fs/ext3/super.c     2006-06-27 10:50:36.000000000 +0200
@@ -422,6 +422,8 @@ static void ext3_put_super (struct super

        has_fcache = test_opt(sb, FCACHE);

+       printk("!!! ext3_put_super !!!   has_fcache=%d\n", has_fcache);
+
        ext3_xattr_put_super(sb);
        journal_destroy(sbi->s_journal);
        if (!(sb->s_flags & MS_RDONLY)) {


It triggers on unmount but it doesn't on remount "ro".

So the problem is that "fcache_close_dev()" have zero chances to run ;)

-- 
	Paolo Ornati
	Linux 2.6.17-ck1 on x86_64
