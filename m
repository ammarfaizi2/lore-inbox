Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263602AbUEHKmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUEHKmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbUEHKmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:42:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263602AbUEHKmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:42:03 -0400
Date: Sat, 8 May 2004 03:41:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: manfred@colorfullife.com, davej@redhat.com, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508034129.08056637.akpm@osdl.org>
In-Reply-To: <20040508102823.GY17014@parcelfarce.linux.theplanet.co.uk>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<20040508102823.GY17014@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Sat, May 08, 2004 at 03:11:59AM -0700, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Here be another patch.
> > 
> > 
> > Can't help myself!
> > 
> > 
> > - d_vfs_flags can be removed - just use d_flags.  It looks like someone
> >   added d_vfs_flags with the intent of doing bitops on it, but all
> >   modifications are under dcache_lock.  4 bytes saved.
> 
> Bzzert.  ->d_vfs_flags modifications are under dcache_lock; ->d_flags ones
> are *not* - they are up to whatever filesystem code happens to use them.

yup, I hunted down the rest.

> > - Pack things so that dentry.d_name.len and dentry.d_flags occupy the same
> >   word.  4 bytes saved.
> 
> d_name.len is accessed on very hot paths.  In particular, we are looking
> at it while traversing hash chains and we do that without dcache_lock
> (see callers of ->d_compare()).

That's OK.  The d_move() d_movecount and locking logic takes care of that. 
But the ushorts are a bit dopey - I'll give those 4 bytes back.

