Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSI2OJE>; Sun, 29 Sep 2002 10:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSI2OJE>; Sun, 29 Sep 2002 10:09:04 -0400
Received: from thunk.org ([140.239.227.29]:21156 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262483AbSI2OJD>;
	Sun, 29 Sep 2002 10:09:03 -0400
Date: Sun, 29 Sep 2002 10:13:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: chrisl@gnuchina.org
Cc: Ryan Cumming <ryan@completely.kicks-ass.org>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix htree dir corrupt after fsck -fD
Message-ID: <20020929141325.GD653@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, chrisl@gnuchina.org,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <E17uINs-0003bG-00@think.thunk.org> <20020926235741.GC10551@think.thunk.org> <20020927041234.GS22795@clusterfs.com> <200209271820.41906.ryan@completely.kicks-ass.org> <20020928141330.GA653@think.thunk.org> <20020929070315.GA6876@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929070315.GA6876@vmware.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 12:03:15AM -0700, chrisl@gnuchina.org wrote:
> When e2fsck rehash the directory index. it will left one empty
> dir entry at the end of block if next dir entry can not fit in.
> I think it is OK to do so but I also make a patch to make the empty
> space merge with previous entry to consistent with the kernel.

Nice catch!  Yup, e2fsck will create an empty directory entry, instead
of letting the previous entry absorb the extra space.  Both are legal
ways of doing things, but yes, the kernel does the latter in all cases
except when deleting the last directory entry in a block.  (But that's
OK, because the split code would never need to be invoked on an empty
directory block.)

> dx_make_map need to skip the empty entry. So here is the patch for
> review before I push it back to htree BK repository.

That patch looks fine.  Push away!

> Ted, is e2fsck endian free now? I notice some code in
> copy_dir_entries() do not have cpu_to_le32 for rec_len etc.

Yes, e2fsprogs is endian-free.  The byte swapping happens in the
library routine ext2fs_read_dir_block() and ext2fs_write_dir_block().
Note that you have to tell these routines whether you're planning on
using the v2 version of dirent struct or not, because that affects
whether or not the name_len field needs to be byte-swapped or not.

					- Ted
