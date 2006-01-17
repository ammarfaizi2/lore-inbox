Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWAQU3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWAQU3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWAQU3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:29:36 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:23649 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964812AbWAQU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:29:36 -0500
Date: Tue, 17 Jan 2006 15:29:32 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] reiserfs: load bitmap blocks on demand
Message-ID: <20060117202930.GA24829@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all -

The following patchset allows reiserfs to load its bitmap blocks on demand
like other file systems.

There are several reasons for this:
* Bitmap blocks, relative to other metadata blocks, are among the least used
  blocks in the file system. We don't cache the root node block, so why do
  we pin the bitmaps?

* Loading all the bitmaps at file system mount takes a lot of time. On multi-
  TB file systems, I've heard reports of file systems taking 15 minutes to
  mount. There go your 5 9's after one reboot.

* Keeping bitmaps in memory isn't free. The old argument of "large storage
  implies large memory" is no longer true. It's possible to assemble a multi-
  TB RAID array for a desktop for under $1000 these days. Memory prices have
  not fallen at the same rate.

There are 4 patches:

reiserfs-01-fix-is_reusable-bitmap-check.diff
  This fixes up the is_reusable() function up to calculate valid bitmap
  block numbers rather than compare them to the blocks of the pinned buffer
  heads for the bitmap blocks.

reiserfs-02-bitmap-info-bh-cleanup.diff
  Cleans up SB_AP_BITMAP(s)[n].bh accesses to use a temporary variable. It
  also uses proper bh refcounting, which may not make sense at this stage -
  but it's used later.

reiserfs-03-bitmap-loading-move.diff
  Moves the bitmap loading operations out of super.c and into bitmap.c where
  they belong.

reiserfs-04-on-demand-bitmap-loading.diff
  Actually implements the on-demand loading of bitmaps.

I've run some overnight testing on this under heavy load, but I'd still like
to see more testing before acceptance into mainline.

-Jeff

(Sent to reiserfs-list this morning)

--
Jeff Mahoney
SUSE Labs
