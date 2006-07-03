Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWGCXbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWGCXbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGCXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:31:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39876 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932095AbWGCXbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:31:46 -0400
From: Neil Brown <neilb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 4 Jul 2006 09:31:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17577.43190.724583.146845@cse.unsw.edu.au>
Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
In-Reply-To: message from Alan Cox on Monday July 3
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl>
	<20060703202219.GA9707@aitel.hist.no>
	<20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<1151964720.16528.22.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 3, alan@lxorguk.ukuu.org.uk wrote:
> Ar Llu, 2006-07-03 am 23:01 +0200, ysgrifennodd Arjan van de Ven:
> > raid is great for protecting against individual disks or sectors going
> > bad. But raid, especially high performance implementations, do not
> > checksum data or detect corruptions. 
> > 
> > They're different purpose with almost zero overlap in purpose or even
> > goal...
> 
> Same layer though - checksums are really a device mapper type problem
> rather than an fs type problem.

Can't say I agree with this layering distinction.
It's been some years that I've felt that most 'logical volume
management' really belongs in the filesystem.
Why have a dm that chops devices up in to segments and assembles them to
look like a big device, only to have that big device chopped up and
presented as files.  Seems like double handling to me.

With checksums - the filesystem is in a better position to:
 - be selective about what is checksummed - no point checksumming
   blocks that aren't part of any file.  Some blocks (highlevel
   metadata) might always be checksummed, while other blocks
   (regular data) might not if a 'fast' option was chosen.
 - record the checksum somewhere easily accessible.  The dm layer
   could do little better than store a block of checksums for every 10
   blocks of data.  A filesystem can store checksums with indexing
   information, or ensure that checksums for consecutive blocks in a
   file are stored together, even if the blocks cannot be.

I think that for a filesystem that makes heavy use of trees to find
things, it makes a lot of sense to checksum and replicate the upper
levels of the tree, while checksumming and replicating lower levels
has a very different cost/benefit tradeoff.   These distinctions are
easy to make in a filesystem, and hard to make in a block device.

To my mind, the only thing you should put between the filesystem and
the raw devices is RAID (real-raid - not raid0 or linear).

NeilBrown
