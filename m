Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSDJWMQ>; Wed, 10 Apr 2002 18:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDJWMP>; Wed, 10 Apr 2002 18:12:15 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:62850 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S313907AbSDJWMO>; Wed, 10 Apr 2002 18:12:14 -0400
Date: Wed, 10 Apr 2002 18:12:11 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020410221211.GA6076@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <Pine.GSO.4.21.0204100725410.15110-100000@weyl.math.psu.edu> <3CB48F8A.DF534834@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 12:16:26PM -0700, Andrew Morton wrote:
> I believe that the object relationship you're describing is
> that the inode->i_mapping points to the main address_space,
> and the `host' field of both the main and private address_spaces
> both point at the same inode?  That the inode owns two
> address_spaces?

Actually with Coda we've got 2 inodes that have an identical i_mapping.
The Coda inode's i_mapping is set to point to the hosting inode's
i_data. Hmm, I should probably set it to the i_mapping of the host
inode that way I can run Coda over a Coda(-like) filesystem.

> That's OK.  When a page is dirtied, the kernel will attach
> that page to the private address_space's dirty pages list and
> will attach the common inode to its superblock's dirty inodes list.

But Coda has 2 inodes, which one are you connecting to whose superblock.
My guess is that it would be correct to add inode->i_mapping->host to
inode->i_mapping->host->i_sb, which will be the underlying inode in
Coda's case, but host isn't guaranteed to be an inode, it just happens
to be an inode in all existing situations.

> > What's more, I wonder how well does your scheme work with ->i_mapping
> > to a different inode's ->i_data (CODA et.al., file access to block devices).
> 
> Presumably, those different inodes have a superblock?  In that
> case set_page_dirty will mark that inode dirty wrt its own
> superblock.  set_page_dirty() is currently an optional a_op,
> but it's not obvious that there will be a need for that.

Coda's inodes don't have to get dirtied because we never write them out,
although the associated dirty pages do need to hit the disk eventually :)

Jan

