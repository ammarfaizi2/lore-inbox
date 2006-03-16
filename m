Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWCPNxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWCPNxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWCPNxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:53:50 -0500
Received: from thunk.org ([69.25.196.29]:6114 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751122AbWCPNxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:53:49 -0500
Date: Thu, 16 Mar 2006 08:53:41 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060316135341.GB24013@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:11:17PM +0900, Takashi Sato wrote:
> >You changed most of the affected variables from "int" to "unsigned int",
> >that seems allow block number to address 2^32. It probably a good thing
> >to consider change the variables to sector_t type, so when the time we
> >want to support for 64 bit block number, we don't have to re-do the
> >similar work again.  Laurent did very similar work on this before.
> 
> sector_t is 8bytes on normal configuration and there are many
> variables for blocks on ext2/3.  I thought extending variables may
> influence on performance, so I didn't change.

It would be interesting to do a CPU overhead benchmark to see how much
of the overhead is actually measurable on an x86 system.  If it's only
a small percent, it might be acceptable given that x86_64 machines are
going to be gradually taking over, and sector_t only exists if
CONFIG_LBD is enabled.  So for smaller systems where LBD isn't
enabled, we won't see performance overhead since sector_t won't exist
and so the code is going to have to use a typedef for ext2_blk_t which
is either __u32 or sector_t as necessary.

> >- The superblock format currently stores the number of block groups as a
> >16-bit integer, and because (on a 4 KB blocksize filesystem) the maximum
> >number of blocks in a block group is 32,768 , a combination of these
> >constraints limits the maximum size of the filesystem to 8 TB
> 
> Is it s_block_group_nr in ext3_super_block?
> mke2fs sets 65535 to the field if the number of block groups is greater
> than 65535.  Current kernel ignores the field and re-calculate from
> other fields.  findsuper command is the only user of it and it simply prints
> the value.  So, it does not limit the maximum size of the filesystem to 8 
> TB.

s_block_group_nr is *not* the number of block groups in the
filesystem.  As Takashi-san properly pointed out, the kernel
calculates the number of block groups by dividing the number of blocks
by the blocks_per_group fields.  s_block_group_nr is used to identify
the block group of a particular backup supeblock.  

So for the backup superblock located at block group #3,
s_block_group_nr 3, and for the backup superblock located at block
group #5, s_block_group_nr 5, and so on.  It is used only as a hint so
that prorams like findsuper and gpart can be more intelligent about
finding the start of filesystem, when trying to recover from a smashed
partition table.

						- Ted
