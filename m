Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWJWQoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWJWQoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWJWQoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:44:19 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:43677 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932161AbWJWQoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:44:18 -0400
Date: Mon, 23 Oct 2006 10:44:16 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andre Noll <maan@systemlinux.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061023164416.GM3509@schatzie.adilger.int>
Mail-Followup-To: Andre Noll <maan@systemlinux.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
References: <20061023144556.GY22487@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023144556.GY22487@skl-net.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 23, 2006  16:45 +0200, Andre Noll wrote:
> stress tests on a 6.3T ext3 filesystem which runs on top of software
> raid 6 revealed the following:
> 
> [663594.224641] init_special_inode: bogus i_mode (4412)
> [663596.355652] init_special_inode: bogus i_mode (5123)
> [663596.355832] init_special_inode: bogus i_mode (71562)

This would appear to be inode table corruption.

> [663763.319514] EXT3-fs error (device md0): ext3_new_block: Allocating block in system zone - blocks from 517570560, length 1

This is bitmap corruption.

> [663763.339423] EXT3-fs error (device md0): ext3_free_blocks: Freeing blocks in system zones - Block = 517570560, count = 1

Hmm, this would appear to be a buglet in error handling.  If the block just
allocated above is in the system zone it should be marked in-use in the
bitmap but otherwise ignored.  We definitely should NOT be freeing it on
error.

Yikes!  It seems a patch I submitted to 2.4 that fixed the behaviour
of ext3_new_block() so that if we detect this block shouldn't be
allocated it is skipped instead of corrupting the filesystem if it
is running with errors=continue...

It looks like ext3_free_blocks() needs a similar fix - i.e. report an
error and don't actually free those blocks.

> This system is currently not in production use, so I can use it for tests ATM.

I would suggest that you give this a try on RAID5, just for starters.
I'm not aware of any problems in the existing ext3 code for anything
below 8TB.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

