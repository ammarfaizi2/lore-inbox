Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269740AbUJAKSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269740AbUJAKSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269742AbUJAKSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:18:47 -0400
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:32640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269740AbUJAKSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:18:45 -0400
Date: Fri, 1 Oct 2004 12:18:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Patch 7/10]: ext3 online resize: SMP locking for group metadata
Message-ID: <20041001101822.GA18786@elf.ucw.cz>
References: <200409301323.i8UDNo99004796@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409301323.i8UDNo99004796@sisko.scot.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix the SMP locking for group metadata in online resize.
> 
> Most of the resize is simply not dangerous from an SMP point of view, as
> we're adding new data beyond the end of the device and so we're
> guaranteed that no existing CPUs can already be using that data.  But we
> need to be extremely careful about the ordering when enabling that new
> data.
> 
> The key to this is sb->s_groups_count; when that is raised, it enables
> new space on a filesystem, and the kernel will suddenly start accessing
> all of the newly-created tables for that space.
> 
> The precise rules we use are:
> 
> * Writers of s_groups_count *must* hold lock_super
> AND
> * Writers must perform a smp_wmb() after updating all dependent
>   data and before modifying the groups count
> 
> * Readers must hold lock_super() over the access
> OR
> * Readers must perform an smp_rmb() after reading the groups count
>   and before reading any dependent data.
> 
> This leaves the hot path, where s_groups_count is referenced, requiring
> an smp_rmb(); but no other locking on that hot path is required.

Should not s_groups_count be atomic_t, then? Is it possible that
normal read sees only half-updated value?

[I know this is non-issue at least on i386, and probably on most
architectures as long as s_groups_count is aligned...

							Pavel


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
