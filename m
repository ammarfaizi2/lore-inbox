Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUEHK23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUEHK23 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbUEHK23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:28:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62616 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264238AbUEHK21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:28:27 -0400
Date: Sat, 8 May 2004 11:28:23 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, davej@redhat.com, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040508102823.GY17014@parcelfarce.linux.theplanet.co.uk>
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org> <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040508031159.782d6a46.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 03:11:59AM -0700, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Here be another patch.
> 
> 
> Can't help myself!
> 
> 
> - d_vfs_flags can be removed - just use d_flags.  It looks like someone
>   added d_vfs_flags with the intent of doing bitops on it, but all
>   modifications are under dcache_lock.  4 bytes saved.

Bzzert.  ->d_vfs_flags modifications are under dcache_lock; ->d_flags ones
are *not* - they are up to whatever filesystem code happens to use them.
 
> - Pack things so that dentry.d_name.len and dentry.d_flags occupy the same
>   word.  4 bytes saved.

d_name.len is accessed on very hot paths.  In particular, we are looking
at it while traversing hash chains and we do that without dcache_lock
(see callers of ->d_compare()).

If we are going to hold dcache_lock in __d_lookup(), we can get rid of
a _lot_ more than 2 bytes.  32 bytes that came from RCU are there pretty
much for a single reason - to avoid dcache_lock on that path.
