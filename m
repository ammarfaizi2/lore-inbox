Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293208AbSCAImP>; Fri, 1 Mar 2002 03:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310411AbSCAIic>; Fri, 1 Mar 2002 03:38:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310408AbSCAIhR>;
	Fri, 1 Mar 2002 03:37:17 -0500
Message-ID: <3C7F3D67.2A8E6055@zip.com.au>
Date: Fri, 01 Mar 2002 00:35:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] multipage pagecache writeout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches:

	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/mpio-10-biobits.patch
	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/mpio-20-core.patch
	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/mpio-30-ext2.patch

implement multipage writeout from the pagecache.  These patches require
the allocate-on-flush patches.  The dalloc-30-ratcache patch is not a
requirement for the mpio series.  But is recommended for
balls-to-the-wall how-fast-can-it-go testing.

Pages from the pagecache are given a disk mapping, are assembled into
large BIOs (up to half a megabyte) and these BIOs are injected direct
into the request layer.

These pages never have attached buffer_heads.  The buffer layer is
completely bypassed for all write(2) data.  As is, to some extent, the
request merging layer.

This patch should bypass the lru_list_lock contention problem, and the
ZONE_NORMAL-full-of-buffer_heads bug.  (Well, this may require
multipage reads, too).



Future work includes:

- Implement buffer_head-less block_truncate_page().

- multipage reads.

  A bit of a no-brainer, but first the current readahead code needs a
  big shakeout.


Two additional patches are available:

	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/tuning-10-request.patch

        - The get_request starvation fix for 2.5.

          This patch also increases the request queue by a
          lot.  Which implies that we can have as much as 512 megabytes
          of I/O underway per device.  This may sound excessive, but
          the locked- and dirty-page accounting in the delalloc patch
          only permits this to happen if the machine is large enough to
          cope with it.

	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/tuning-20-ext2-preread-inode.patch
        - Pull the backing block for a new ext2 inode into
          the buffercache when the inode is created.  This fixes a
          significant throughput problem with many-file writeout, where
          the writer is continually interrupted by having to perform
          reads.
