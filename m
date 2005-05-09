Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVEIKgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEIKgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 06:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEIKgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 06:36:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32734 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261213AbVEIKga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 06:36:30 -0400
Date: Mon, 9 May 2005 12:36:27 +0200
From: Jan Kara <jack@suse.cz>
To: George Ronkin <gronkin@nerdvana.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mason@suse.com
Subject: Re: PROBLEM: Reiserfs stall 2.6.10-bk7 up through 2.6.12-rc3
Message-ID: <20050509103623.GF10739@atrey.karlin.mff.cuni.cz>
References: <1115428405.2233.65.camel@fir.nerdvana.com> <1115536148.9660.17.camel@fir.nerdvana.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115536148.9660.17.camel@fir.nerdvana.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  thanks for your report. It was quite complete so it was not a big
problem to find the bug ;)

> On Fri, 2005-05-06 at 18:13 -0700, George Ronkin wrote:
> > ... one of my machines now stalls
> > attempting to access the reiserfs file system used as that server's
> > spool...  This problem did not occur before 2.6.10-bk7.  That and all subsequent
> > kernels I've tried (Debian 2.6.11, stock 2.6.12-rc3, and 2.6.12-rc3-mm3)
> > cause the problem, consistently and repeatably.
> 	As does 2.6.12-rc4.  The unusual 1K block size I used for this reiserfs
> seems to have exposed the problem; all my other reiserfs use 4K and have
> no problem.  I copied its contents to a new reiserfs I created with 4K
> blocks and the later kernels work fine with the copy.  I also tried
> turning off CONFIG_QUOTA on 2.6.12-rc4 - that worked with the 1K block
> reiserfs as well.  I'm keeping the 4K block copy, since that works with
> QUOTA, and turning QUOTA off affects non-reiserfs fs as well.
> 	Note also:
> 
> - The 1K block fs caused the problem even though no quota mount options
> were set.
> 
> - All my reiserfs are devmapped, so I don't know if the problem occurs
> without it on a physical partition, or whether the symptoms would
> differ.
  Hmm, I think the following is happening: with 1KB blocksize we call
journal_begin() with nblocks larger than the biggest possible size of the
transaction (actually your trace in the previous mail was truncated and
I did not see any such process. It would be nice if you could increase
the size of kernel logging buffer - it's in the kernel config - and acquire
the trace again to confirm my suspicion).
  Quota is quite hungry regarding the number of blocks it requires in
a transaction - in setattr we require 558 blocks - and from your boot
messages I can see that your filesystem has maximum transaction size 256
blocks.
  Chris, I don't quite understand these computations in journal_init() -
why do we divide by the 'ratio' when the block size is smaller than
1024? We always count in the number of blocks regardless the block size,
don't we? Also we should add an assertion into journal_start() to BUG()
if we call it with too big nblocks. I guess I should also revise the
quota code and somehow achieve a less pesimistic estimates on the number
of dirtied blocks.
  I'm sorry but I won't be reading emails for the next two days.
Afterwards I'll work on the fix.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
