Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbUAFWrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUAFWrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:47:02 -0500
Received: from [193.138.115.2] ([193.138.115.2]:32272 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265408AbUAFWq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:46:57 -0500
Date: Tue, 6 Jan 2004 23:43:40 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Hans Reiser <reiser@namesys.com>,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
In-Reply-To: <20040106174650.GD1882@matchmail.com>
Message-ID: <Pine.LNX.4.56.0401062251290.8384@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
 <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk>
 <20040106174650.GD1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Jan 2004, Mike Fedyk wrote:

> On Tue, Jan 06, 2004 at 12:28:34PM +0100, Jesper Juhl wrote:
> > --- linux-2.6.1-rc1-mm2-orig/fs/reiserfs/inode.c        2004-01-06 01:33:08.000000000 +0100
> > +++ linux-2.6.1-rc1-mm2/fs/reiserfs/inode.c     2004-01-06 12:16:16.000000000 +0100
> > @@ -574,11 +574,6 @@ int reiserfs_get_block (struct inode * i
> >      th.t_trans_id = 0 ;
> >      version = get_inode_item_key_version (inode);
> >
> > -    if (block < 0) {
> > -       reiserfs_write_unlock(inode->i_sb);
> > -       return -EIO;
> > -    }
> > -
>
> Did you check the locking after this is removed?
>

reiserfs_write_unlock(inode->i_sb); is called at the beginning of the
function, and as far as I can tell it's matched by a call to
reiserfs_write_unlock(inode->i_sb); at every potential return point in the
function, and I see no other locks being taken.
Besides, since  if (block < 0)  will never be true and
	reiserfs_write_unlock(inode->i_sb);
	return -EIO;
will never execute in any case, locking should behave identical to what it
did before removing the code.
Locking /seems/ OK to me in this function.

Also, I did a build of fs/reiserfs/ both with and without the above patch,
and then did a disassemble of inode.o (objdump -d) and compared the
generated code for reiserfs_get_block , and the generated code is
byte-for-byte identical in both cases, which means that gcc realizes that
the if() statement will never execute and optimizes it away in any case.

This is a further indication that removing the code should be safe.
And it seems to me that any code that assumes that a sector_t value can be
negative is either broken or obsolete.


> Maybe after the sector_t merges, this code covered a case that is left open
> now...
>

I'm not familliar with those "sector_t merges" you are refering to, but I
found some mention of a 64bit sector_t merge in the 2.5.x kernel
Changelogs, so I downloaded the 2.5.10 kernel source (first reference to
sector_t I found was in the 2.5.11 changelog) and took a look at how
sector_t used to be defined. It seems that it was an unsigned value even
back then.
Has sector_t ever been signed?


/Jesper Juhl

