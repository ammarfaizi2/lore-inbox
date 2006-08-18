Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWHRIub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWHRIub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHRIub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:50:31 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:52375 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751140AbWHRIua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:50:30 -0400
Date: Fri, 18 Aug 2006 02:50:29 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Eric Sandeen <esandeen@redhat.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
Message-ID: <20060818085029.GI6634@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Eric Sandeen <esandeen@redhat.com>, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <44DD00FA.5060600@redhat.com> <1155335394.3765.20.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155335394.3765.20.camel@dyn9047017069.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 11, 2006  15:29 -0700, Mingming Cao wrote:
> On Fri, 2006-08-11 at 17:13 -0500, Eric Sandeen wrote:
> > I figure before we get too fired up about 48 bits and ext4 let's fix 32 bits on ext3 :)
> > 
> > I need to do some actual IO testing now, but this gets things mounting for a 16T ext3 filesystem.
> > (patched up e2fsprogs is needed too, I'll send that off the kernel list)
> > 
> > This patch fixes these issues in the kernel:
> > 
> > o sbi->s_groups_count overflows in ext3_fill_super()
> > 
> > 	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
> > 			       le32_to_cpu(es->s_first_data_block) +
> > 			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
> > 			      EXT3_BLOCKS_PER_GROUP(sb);
> > 
> > at 16T, s_blocks_count is already maxed out; adding EXT3_BLOCKS_PER_GROUP(sb) overflows it and 
> > groups_count comes out to 0.  Not really what we want, and causes a failed mount.
> > 
> > Feel free to check my math (actually, please do!), but changing it this way should work & 
> > avoid the overflow:
> > 
> > (A + B - 1)/B changed to: ((A - 1)/B) + 1
> > 
> > o ext3_check_descriptors() overflows range checks

This is generally not safe because of underflow, but it also isn't possible
to have a 0-block filesystem so it should be OK.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

