Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVAUAgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVAUAgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVAUAgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:36:19 -0500
Received: from news.suse.de ([195.135.220.2]:12432 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262213AbVAUAgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:36:10 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [patch 5/5] Disallow in-inode attributes for reserved inodes
Date: Fri, 21 Jan 2005 01:36:03 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
References: <20050120020124.110155000@suse.de> <200501201429.15681.agruen@suse.de> <20050120230518.GL22715@schnapps.adilger.int>
In-Reply-To: <20050120230518.GL22715@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501210136.04024.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 00:05, Andreas Dilger wrote:
> [...]
> But as your patch stands it doesn't ever check if i_extra_isize is valid
> for the root or lost+found inode.  It just always sets i_extra_isize = 0
	(that's the in-memory i_extra_isize)
> and never uses it.  Given that the root inode is fairly high-traffic it
> makes sense to use the faster EA space if it is available.

It's only a single block we're talking about, not all the overhead you run 
into with huge amounts of attributes in many xattr disk blocks. It sure would 
be much cleaner to use the root inode's in-inode space like with all other 
inodes, but performance wise I don't think it matters.

> If these inodes have a BAD i_extra_isize it is OK to skip it, but I'm
> not so keen to have an ext3_error() there.  If the user doesn't have an
> e2fsck with ea-in-inode support there isn't anything they can do to fix
> it and they will get a full e2fsck on each boot.

Agreed, that would be really bad. We should get e2fsck fixed ASAP.

> Even so, for the effort of setting i_extra_isize = 4 (or larger if we
> initialize the fixed fields) we can do the equivalent of what e2fsck will
> do when it finds a bogus value.

We cannot ask the user, and we don't have the kind of global view that e2fsck 
has. Something different may be messed up, and may have lead to the 
corruption. It's unlikely, but not impossible.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
