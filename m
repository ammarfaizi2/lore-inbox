Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWIYQsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWIYQsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWIYQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:48:13 -0400
Received: from mga06.intel.com ([134.134.136.21]:65098 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750955AbWIYQsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:48:12 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,215,1157353200"; 
   d="scan'208"; a="135369179:sNHT7891510760"
Date: Mon, 25 Sep 2006 09:46:39 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] EXT2: Remove superblock lock contention in ext2_statfs
Message-ID: <20060925164637.GA30477@goober>
References: <1158611794.11940.40.camel@kleikamp.austin.ibm.com> <1158622685.11940.52.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158622685.11940.52.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 06:38:05PM -0500, Dave Kleikamp wrote:
> On Mon, 2006-09-18 at 15:36 -0500, Dave Kleikamp wrote:
> > EXT2: Remove superblock lock contention in ext2_statfs
> > 
> > Fix a performance degradation introduced in 2.6.17.  (30% degradation running
> > dbench with 16 threads)
> > 
> > Patch 21730eed11de42f22afcbd43f450a1872a0b5ea1, which claims to make
> > EXT2_DEBUG work again, moves the taking of the kernel lock out of debug-only
> > code in ext2_count_free_inodes and ext2_count_free_blocks and into
> > ext2_statfs.  This patch reverses that part of the patch.
> > 
> > Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
> 
> Eric Sandeen pointed out to me that taking the superblock lock in
> ext2_count_free_* will cause a deadlock when EXT2FS_DEBUG is enabled,
> since the superblock is locked in write_super().
> 
> We found that the same problem was fixed in ext3 with this patch
> (forgive the long link):
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5b11687924e40790deb0d5f959247ade82196665;hp=2384f55f8aa520172c995965bd2f8a9740d53095
> 
> The patch below just removes the use of the superblock lock in the debug
> code.

(Sorry for the delay; been on vacation.)

Heh, I ran into the same lock nesting issues as you when I first tried
to fix this; the lock debugging code found it for me.  I asked for
feedback on the locking issue when I submitted the patch, but no one
had any opinions then, so I chose consistency over possible
contention.  Al Viro snorted at the idea of consistency in the results
of statfs (I paraphrase his IRC remarks), and thinking about it
further, I realized the debug code should not be doing these checks in
statfs anyway; only on mount and unmount.  This is because it appears
that the block group accounting and the overall fs accounting are done
non-atomically - see group_reserve_blocks() for example - and part of
what the code does is reconcile these two numbers.  It is legal for a
valid fs to have the block group summaries and the fs-wide summaries
out of sync, so the debug code could erroneously report an error,
leading some poor soul on a wild goose chase.  Removing this code from
statfs also happens to fix the locking issues nicely.

Rewriting this has been on my todo list for about 6 months now -
anyone interested in grabbing it?  I'm on #linuxfs on irc.oftc.net if
anyone wants to chat about it.

-VAL
