Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280983AbRKOSb6>; Thu, 15 Nov 2001 13:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280982AbRKOSbr>; Thu, 15 Nov 2001 13:31:47 -0500
Received: from ppp-RAS1-1-210.dialup.eol.ca ([64.56.224.210]:17924 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S280981AbRKOSbf>; Thu, 15 Nov 2001 13:31:35 -0500
Date: Thu, 15 Nov 2001 13:31:33 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Andreas Dilger <adilger@turbolabs.com>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011115133133.A732@node0.opengeometry.ca>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>,
	"Peter T. Breuer" <ptb@it.uc3m.es>,
	Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <20011115003434.A25883@node0.opengeometry.ca> <200111151235.fAFCZQY31248@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111151235.fAFCZQY31248@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Nov 15, 2001 at 01:35:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 01:35:26PM +0100, Peter T. Breuer wrote:
> What is the forward strategy? I see no alternative but moving to 64bit
> sector counts. 

Me too.

I looked around, and 1KB block size is hard-coded in too many places.
For example, function 'generic_make_request()' in
'drivers/block/ll_rw_blk.c' assumes 512 sector and 1024 block size:

    if (blk_size[major])
	minorsize = blk_size[major][MINOR(bh->b_rdev)];
    if (minorsize) {
	unsigned long maxsector = (minorsize << 1) + 1;		<--
	unsigned long sector = bh->b_rsector;
	unsigned int count = bh->b_size >> 9;

So, using 'u64 *blk_size[][]' seems to be the most straightforward
solution, leaving BLOCK_SIZE alone.

I thought 'drivers/block/nbd.c' was already using 64-bit count,
according to its comment at the top.  But, curiously, it reverts back to
'int' count of BLOCK_SIZE.  I tried searching list archives for 64-bit
patch, but no luck.

Any URL would be helpful.

Is changing 'int' to 'u64' (and all the dependent code) enough to get
64-bit block devices?  I'm willing to do the work.  I don't care about
filesystem; that's the job for maintainer of particular filesystem.  I
understand XFS is 64-bit, so I can use that.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
