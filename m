Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTDITDe (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTDITDe (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:03:34 -0400
Received: from [12.47.58.221] ([12.47.58.221]:54104 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263691AbTDITDd (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:03:33 -0400
Date: Wed, 9 Apr 2003 12:15:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: Joel.Becker@oracle.com, robn@verdi.et.tudelft.nl,
       linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ?
Message-Id: <20030409121537.36ba3fce.akpm@digeo.com>
In-Reply-To: <200304091653.h39GrHR05341@verdi.et.tudelft.nl>
References: <20030409154836.GA31739@ca-server1.us.oracle.com>
	<200304091653.h39GrHR05341@verdi.et.tudelft.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 19:15:08.0327 (UTC) FILETIME=[55A22B70:01C2FECC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> wrote:
>
> 
> Joel Becker wrote:
> > On Wed, Apr 09, 2003 at 02:16:08PM +0200, Rob van Nieuwkerk wrote:
> > > I plan to use O_DIRECT in my application (on a partition, no fs).
> > > It is hard to find info on the exact requirements on the mandatory
> > > alignments of buffer, offset, transfer size: it's easy to find many
> > > contradicting documents.  And checking the kernel source itself isn't
> > > trivial.
> > 
> > 	In 2.4, your buffer, offset, and transfer size must be soft
> > blocksize aligned.  That's the output of BLKBSZGET against the block
> > device.  For unmounted partitions that is 512b, for most people's ext3
> > filesystems that is 4K.  It is, FYI, the number set by set_blocksize().
> 
> Hi Joel,
> 
> Thank you for your reaction.
> 
> I get 4096 with BLKBSZGET on several unmounted partitions on my system
> (RH 2.4.18-27.7.x kernel).  Some give 1024 ..  Maybe it is because I
> had them mounted first and unmounted them for the test ?
> 

Yes, the blockdev initially comes up with a 1024 softblocksize.  When you
mount a filesystem on the device, the soft blocksize gets rewritten to
(typically) 4096.

Unfortunately it remains at 4096 after the fs is unmounted, which is rather
silly.

In 2.5 you should use BLKSSZGET (sector-size, not block-size) to work out the
supported alignment.

I'm not sure what a good and general solution is really.  You might have to
resort to probing the size at runtime, by trying increasing blocksizes until
it works.

