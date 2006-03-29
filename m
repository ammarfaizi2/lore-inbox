Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWC2G60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWC2G60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWC2G6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:58:25 -0500
Received: from fmr19.intel.com ([134.134.136.18]:57741 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751109AbWC2G6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:58:25 -0500
Date: Tue, 28 Mar 2006 22:57:25 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Cc: Zach Brown <zach.brown@oracle.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Arjan van de Ven <arjan@linux.intel.com>, Mingming Cao <cmm@us.ibm.com>
Subject: [BENCHMARK] fswide dirty bit for ext2
Message-ID: <20060329065724.GD16173@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a file system wide dirty bit for ext2.  This allows
you to skip a full fsck if you crash while the file system is not
being actively modified.

Zach Brown was kind enough to run a few benchmarks comparing various
versions of ext2 and ext3.  Results:

           ext2   ext2r *ext2fw*   ext3  ext3wb
kuntar    17.86   19.59   17.58   21.10   30.60
postmark   6.41    6.57    8.48   30.87   15.47
tiobench  34.11   34.96   34.26   34.00   34.06

ext2: ext2: 4k blocks, noatime
ext2r: ext2: 4k blocks, noatime, reservations
ext2fw: ext2: 4k blocks, noatime, reservations, fswide
ext3: ext3: 4k blocks, 256m journal, noatime
ext3wb: ext3: 4k blocks, 256m journal, noatime, data=writeback
kuntar: expanding a cached uncompressed kernel tarball and syncing
postmark: postmark: numbers = 10000, transactions = 10000
tiobench: tiobench: 16 threads, 256m size

The summary is that ext2+fswide bit is the same as plain ext2 except
30% slower on postmark.  Slower postmark is expected given the orphan
inode list requires at least two writes to either the superblock or
another inode per file removal.  An obvious improvement would be
per-block group orphan inode lists, which would require a non-trivial
but not frightening patch to fsck. (This might also be ported to
ext3.) Other ideas?

I split out the ext2 reservations port into its own patch.
ext2+reservations alone is strangely slower than ext2+fswide on one
benchmark; I did some preliminary debugging but didn't find anything
obvious wrong as yet.  The patches are available for anyone who wants
to track this down themselves before I get around to it.

Patches against 2.6.16-rc5-mm3 here:

Fswide bit (includes reservations):

http://infohost.nmt.edu/~val/patches/fswide_shorter_patch

Reservations only:

http://infohost.nmt.edu/~val/patches/resv_only_patch

-VAL
