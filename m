Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUAFW7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUAFW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:59:18 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:31412 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265427AbUAFW7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:59:16 -0500
Date: Tue, 6 Jan 2004 14:58:55 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Hans Reiser <reiser@namesys.com>,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040106225855.GH1882@matchmail.com>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Hans Reiser <reiser@namesys.com>,
	"Tigran A. Aivazian" <tigran@veritas.com>,
	Hans Reiser <reiserfs-dev@namesys.com>,
	Daniel Pirkl <daniel.pirkl@email.cz>,
	Russell King <rmk@arm.linux.org.uk>,
	Will Dyson <will_dyson@pobox.com>, linux-kernel@vger.kernel.org,
	nikita@namesys.com
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <Pine.LNX.4.56.0401062251290.8384@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401062251290.8384@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 11:43:40PM +0100, Jesper Juhl wrote:
> reiserfs_write_unlock(inode->i_sb); is called at the beginning of the
> function, and as far as I can tell it's matched by a call to
> reiserfs_write_unlock(inode->i_sb); at every potential return point in the
> function, and I see no other locks being taken.

OK, good.

> Besides, since  if (block < 0)  will never be true and
> 	reiserfs_write_unlock(inode->i_sb);
> 	return -EIO;
> will never execute in any case, locking should behave identical to what it
> did before removing the code.
> Locking /seems/ OK to me in this function.
> 
> Also, I did a build of fs/reiserfs/ both with and without the above patch,
> and then did a disassemble of inode.o (objdump -d) and compared the
> generated code for reiserfs_get_block , and the generated code is
> byte-for-byte identical in both cases, which means that gcc realizes that
> the if() statement will never execute and optimizes it away in any case.

I'm not talking about before and afte your patch, I'm talking about before
and after the sector_t patch (presumably for the large block device (gt 2TB)
support).

> I'm not familliar with those "sector_t merges" you are refering to, but I
> found some mention of a 64bit sector_t merge in the 2.5.x kernel
> Changelogs, so I downloaded the 2.5.10 kernel source (first reference to
> sector_t I found was in the 2.5.11 changelog) and took a look at how
> sector_t used to be defined. It seems that it was an unsigned value even
> back then.
> Has sector_t ever been signed?

Really?  Interesting.  Then maybe this is from ported 2.2 code?
