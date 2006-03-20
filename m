Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWCTTfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWCTTfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWCTTfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:35:00 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:4549 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964835AbWCTTe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:34:58 -0500
Date: Mon, 20 Mar 2006 12:34:49 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 1/4] ext2/3: Extends the max file size(ext2 in kernel)
Message-ID: <20060320193449.GD6199@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <20060318220130sho@rifu.tnes.nec.co.jp> <20060320072037.GD30801@schatzie.adilger.int> <07fa01c64c18$d3ac7a60$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07fa01c64c18$d3ac7a60$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 20, 2006  21:21 +0900, Takashi Sato wrote:
> >Instead of breaking all filesystems that need to create large files,
> >the patch should instead set "i_flags | EXT2_LARGEBLK_FL" only on inodes
> >that are larger than 2TB and use "blocksize" i_blocks on those files.
> 
> Do you have any idea when the flag is set and cleared?

You would set this flag when the file grows over 2^32 sectors in size.
You might optionally clear it if the file shrinks below 2^32 sectors.
At that time you would take the old i_blocks value and (>> (blockbits - 9)).

> >This preserves compatibility with existing filesystems and doesn't
> >impose any breakage opon an existing filesystem for anyone who wants
> >to use this feature.
> 
> I'm afraid that i_blocks of >2TB file would be corrupted if old kernel
> or old e2fsprogs touches the file.

I don't mean that we would remove the COMPAT flag (Ted and I arE just
having a discussion in another thread whether i_blocks inaccuracy
should be an ROCOMPAT or INCOMPAT feature)).  If a kernel understands
the {RO,IN}COMPAT_LARGE_BLOCK flag, then they would also understand
EXT2_LARGEBLK_FL on the inode to mean "i_blocks is in fs-blocksize units",
so no corruption would take place.  If the kernel can't understand the
COMPAT flag, it would not mount (INCOMPAT, which is inconvenient for the
users) or mount read-only (ROCOMPAT, wouldn't allow file to be modified).
The same is true for e2fsprogs.

The real goal is that setting ?COMPAT_LARGE_BLOCK doesn't immediately
make all OTHER files in the filesystem have incorrect i_blocks values,
which would be MUCH more of a problem than files > 2TB having inaccurate
i_blocks counts.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

