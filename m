Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWESUzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWESUzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWESUzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:55:54 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:26062 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964840AbWESUzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:55:53 -0400
Date: Fri, 19 May 2006 14:55:51 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, torvalds@osdl.org, aia21@cam.ac.uk,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
Message-ID: <20060519205550.GI5964@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	"Stephen C. Tweedie" <sct@redhat.com>, torvalds@osdl.org,
	aia21@cam.ac.uk, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int> <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk> <20060518185955.GK5964@schatzie.adilger.int> <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org> <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.64.0605181526240.10823@g5.osdl.org> <20060518232324.GW5964@schatzie.adilger.int> <1148067412.5156.65.camel@sisko.sctweedie.blueyonder.co.uk> <20060519131130.71c390d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519131130.71c390d9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 19, 2006  13:11 -0700, Andrew Morton wrote:
> btw, it seems odd to me that we're trying to handle the
> device-too-large-for-sector_t problem at the submit_bh() level.  What
> happens if someone uses submit_bio()?  Isn't it something we can check at
> mount time, or partition parsing, or...?

Doing so at mount time will be added to ext3 shortly.  That said, I'd still
like a check in the block layer to avoid the silent corruption possible if
the filesystem makes a mistake, or for those filesystems that haven't added
such a check yet, or new filesystems that don't in the future.

I saw that xfs and ocfs2 have some checks at fill_super time related
to sector_t and CONFIG_LBD, which I found AFTER I saw that ext3 already
had a problem and was searching for where CONFIG_LBD was used. Looking
at that code, however, it isn't even clear there that this is checking
for sector_t overflow, only what the maximum file size is, so they may
also be susceptible to the same corruption.

As for submit_bio() I don't think it is even POSSIBLE to check for overflow
at that stage because the bi_sector has already been truncated to sector_t.
It would have to be done in the caller of submit_bio(), as in submit_bh().

As for the kernel completely disallowing access to a block device larger
than 2TB when CONFIG_LBD isn't set is a separate question entirely.
Stephen suggested (and I can believe this happening, just did it myself
last week during testing on an 8TB+delta device) that a filesystem may be
formatted to only use the accessible part of the device.  Having the block
layer fail IO beyond the limit is good, not being able to use the device
because it is just a bit bigger than the safe limit is not.

One extra suggestion that might be safe and acceptible all around is if
a device is larger than 2TB w/o a 64-bit sector_t that the block device
size itself be truncated in the kernel to 2TB-512.  This at least prevents
userspace tools from trying to e.g. format a 3TB filesystem on a device
that will just corrupt the filesystem.

I don't think partitions on a larger device make any difference, since
the kernel will remap them to the final sector offset internally in the
end, and still overflow sector_t later (which could itself be checked
also).  I don't think this is sufficient to avoid the submit_bh() check
though, since it doesn't address wrapping when calculating the sector.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

