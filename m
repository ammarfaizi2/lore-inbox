Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTFKGDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 02:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTFKGDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 02:03:35 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:14590 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264173AbTFKGDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 02:03:34 -0400
Date: Wed, 11 Jun 2003 00:16:58 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, marcelo@conectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611001658.K12274@schatzie.adilger.int>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Frank Cusack <fcusack@fcusack.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
References: <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0306102226300.17133-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306102226300.17133-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jun 10, 2003 at 10:30:10PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2003  22:30 -0700, Linus Torvalds wrote:
> On Wed, 11 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Two different dentries for the same file is obviously not a problem...
> 
> It _is_ a problem. It does the wrong thing on any subsequent directory
> operation (move or unlink). 
> 
> Multiple aliased dentries have never been ok, unless the filesystem 
> explicitly handles them and invalidates them (ie ntfs/fat kind of things).

Amusingly, we hit _exactly_ this same problem a couple of days ago
in Lustre because we were trying to use RW locks instead of the single
directory i_sem to improve large (10M files) directory lookup performance,
and it is hard to hit and even harder to detect.

We've gone back to using i_sem to protect the actual dentry instantiation
in lookup for now (we have a separate DLM for doing RW locking of the
directory for create/rename/unlink), but will be looking at ways to allow
this in the filesystem again at some time in the future.  Allowing RW
locking for local filesystem lookups would probably also be a win.

My 5-minute theory to fix this is to re-check the inode dentry alias list
when you are doing d_instantiate() (with dcache lock held) for another
dentry with the same hash (and further the same name if the hashes match),
but that would behave poorly when there are large numbers of links to a
single file.  It _might_ be safe to check the first N entries on the
i_dentry list, where N ~= num_cpus, assuming that we could only have N
racy dentry lookups going at one time.  Even so, the boost of allowing
multiple parallel lookups for huge directories probably beats out the
extra searching slowdown for the uncommon many-links-to-inode case.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

