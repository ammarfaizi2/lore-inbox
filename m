Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424372AbWKJGgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424372AbWKJGgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424373AbWKJGgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:36:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28552 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424372AbWKJGgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:36:03 -0500
Date: Fri, 10 Nov 2006 17:35:46 +1100
From: David Chinner <dgc@sgi.com>
To: Chris Mason <chris.mason@oracle.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid too many boundaries in DIO
Message-ID: <20061110063546.GF11034@melbourne.sgi.com>
References: <20061110014854.GS10889@think.oraclecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110014854.GS10889@think.oraclecorp.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 08:48:54PM -0500, Chris Mason wrote:
> Dave Chinner found a 10% performance regression with ext3 when using DIO
> to fill holes instead of buffered IO.  On large IOs, the ext3 get_block
> routine will send more than a page worth of blocks back to DIO via a
> single buffer_head with a large b_size value.
> 
> The DIO code iterates through this massive block and tests for a
> boundary buffer over and over again.  For every block size unit spanned
> by the big map_bh, the boundary bit is tested and a bio may be forced
> down to the block layer.
> 
> There are two potential fixes, one is to ignore the boundary bit on
> large regions returned by the FS.  DIO can't tell which part of the big
> region was a boundary, and so it may not be a good idea to trust the
> hint.
> 
> This patch just clears the boundary bit after using it once.  It is 10%
> faster for a streaming DIO write w/blocksize of 512k on my sata drive.

8p altix, 8GB RAM, 64 FC disks, >2.5GiB/s sustainable raw throughput.
dm stripe, outer 1GB of each disk for 64GB volume. Chunk size 128k.
Single thread Direct I/O, I/O size of 512MiB, sequential file extend.

# mkfs.ext3 -E stride-size=32 /dev/mapper/testvol
# mkfs.xfs -f -d sunit=256,swidth=16384 /dev/mapper/testvol

ext3 mounted data=ordered; data=writeback results are the same
for direct I/O.

2.6.19-rc3-pl is 2.6.19-rc3 + the direct I/o placeholder patches.
2.6.19-rc3-pl-bd is 2.6.19-rc3-pl plus the boundary patch.

Kernel            fs    throughput      I/Os/s          sys+intr
-----------       ----  ----------      -------         ------
2.6.19-rc3        ext3   660MiB/s       ~36,000         70+60
2.6.19-rc3-pl     ext3   600MiB/s       ~36,000         70+60
2.6.19-rc3-pl-bd  ext3   715MiB/s       ~16,000         45+35
2.6.19-rc3        xfs   2.28GiB/s       ~18,000         65+65
2.6.19-rc3-pl     xfs   2.24GiB/s       ~18,000         65+65
2.6.19-rc3-pl-bd  xfs   2.26GiB/s       ~18,000         65+65

Hole filling with direct I/O shows equivalent results.

The boundary patch doubles the average I/O size of ext3 and
substantially reduces CPU usage for direct I/O. Nice one, Chris.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
