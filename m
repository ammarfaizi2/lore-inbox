Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVLEILW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVLEILW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVLEILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:11:22 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:8080 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751345AbVLEILV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:11:21 -0500
Date: Mon, 5 Dec 2005 01:11:21 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Message-ID: <20051205081121.GU14509@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp> <1133447539.8557.14.camel@kleikamp.austin.ibm.com> <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp> <20051202185805.GS14509@schatzie.adilger.int> <02cd01c5f809$95a94620$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02cd01c5f809$95a94620$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 03, 2005  22:00 +0900, Takashi Sato wrote:
> Andreas Dilger wrote:
> >Actually, it should probably be "sector_t", because it isn't really
> >possible to have a file with more blocks than the size of the block
> >device.  This avoids memory overhead for small systems that have no
> >need for it in a very highly-used struct.  It may be for some network
> >filesystems that support gigantic non-sparse files they would need to
> >enable CONFIG_LBD in order to get support for this.
> 
> I think sector_t is ok for local filesystem as you said.  However,
> on NFS, there may be over 2TB file on server side, and inode.i_blocks
> for over 2TB file will become invalid on client side in case CONFIG_LBD
> is disabled.

I don't know the exact specs of NFS v2 and v3, but I doubt they can have
single files larger than 2TB.  Even if they could then this is not a
very common situation and if someone is running in such an environment
then they can easily enable CONFIG_LBD (or make e.g. CONFIG_NFS_V4 have
a dependency to enable this if it is important enough).  What I'd rather
avoid is needless growth of heavily-used structures for rather uncommon
cases (at the current time at least, this can be re-examined later).

It might also be possible to have a separate CONFIG_LSF (or whatever)
that enables support for large single files, maybe enabled by default
with CONFIG_LBD and also configurable separately for clients of network
filesystems with large single files.  Someone who cares more about the
proliferation of configuration options than I can decide whether it
makes sense to keep these as separate options.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

