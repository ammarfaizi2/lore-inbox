Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSJaSMN>; Thu, 31 Oct 2002 13:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSJaSLO>; Thu, 31 Oct 2002 13:11:14 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:23826 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262882AbSJaSJ4>; Thu, 31 Oct 2002 13:09:56 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.29557.756663.288173@laputa.namesys.com>
Date: Thu, 31 Oct 2002 21:16:21 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [8/8] reiser4 code
In-Reply-To: <Pine.GSO.4.21.0210311203300.16688-100000@weyl.math.psu.edu>
References: <15809.25023.211776.529580@laputa.namesys.com>
	<Pine.GSO.4.21.0210311203300.16688-100000@weyl.math.psu.edu>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: Programs so large they have weather.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Reiserfs-List@Namesys.COM is no longer subscribers-only, back into CC]

Alexander Viro writes:
 > 
 > 
 > On Thu, 31 Oct 2002, Nikita Danilov wrote:
 > 
 > > generic_shutdown_super() calls fsync_super(sb) (which will call
 > > ->writepage() on each dirty page) and then invalidate_inodes().
 > > 
 > > Reiser4 has commit out-standing transactions -between- these two points:
 > > after ->writepage() has been called on all dirty pages, but before
 > > inodes were destroyed. Thus, we cannot use
 > > kill_block_super()/generic_shutdown_super().
 > 
 > Why don't you do that from within fsync_super()?  That would be much
 > more natural point for such stuff...
 > 
 > I hadn't looked into akpm's stuff in fs-writeback.c for a while, but
 > if one can't stick such flush point in there I'd argue that this is
 > a bug that needs to be fixed - either there or by providing explicit

->writepages gets (in wbc->sync_mode) enough information to tell
synchronization request like umount or sync from
balance_dirty_pages(). Yes, it looks like better solution,
->writepages(inode, WB_SYNC_ALL) should just synchronously commit all
transactions involving any of inode's pages.

 > callback from fsync_super().

Hmm, I just noted that for now we probably could simply use exported
fsync_bdev(s->s_bdev) in fsync_super(s) stead. How simple. Thank you for
the useful discussion. :-)

Nikita.
