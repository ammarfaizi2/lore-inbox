Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWC3Gto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWC3Gto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWC3Gto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:49:44 -0500
Received: from ns2.suse.de ([195.135.220.15]:56484 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751182AbWC3Gtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:49:43 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 17:48:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17451.32547.622388.387407@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 3] md: Don't clear bits in bitmap when writing to
 one device fails during recovery.
In-Reply-To: message from Andrew Morton on Wednesday March 29
References: <20060330164933.25210.patches@notabene>
	<1060330055237.25270@suse.de>
	<20060329221209.20e7fd00.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 29, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> > +	if (!uptodate) {
> >  +		int sync_blocks = 0;
> >  +		sector_t s = r1_bio->sector;
> >  +		long sectors_to_go = r1_bio->sectors;
> >  +		/* make sure these bits doesn't get cleared. */
> >  +		do {
> >  +			bitmap_end_sync(mddev->bitmap, r1_bio->sector,
> >  +					&sync_blocks, 1);
> >  +			s += sync_blocks;
> >  +			sectors_to_go -= sync_blocks;
> >  +		} while (sectors_to_go > 0);
> >   		md_error(mddev, conf->mirrors[mirror].rdev);
> >  +	}
> 
> Can mddev->bitmap be NULL?

Yes, normally it is.

> 
> If so, will the above loop do the right thing when this:
> 
> void bitmap_end_sync(struct bitmap *bitmap, sector_t offset, int *blocks, int aborted)
> {
> 	bitmap_counter_t *bmc;
> 	unsigned long flags;
> /*
> 	if (offset == 0) printk("bitmap_end_sync 0 (%d)\n", aborted);
> */	if (bitmap == NULL) {
> 		*blocks = 1024;
> 		return;
> 	}
> 
> triggers?

Yes.  sync_blocks will be 1024 (a nice big number) and the loop will
exit quite quickly having done nothing (which is what it needs to do
in that case).
Ofcourse, if someone submits a bio for multiple thousands of sectors
it will loop needlessly a few times, but do we ever generate bios that
are even close to a megabyte?
If so, that 1024 can be safely increased to 1<<20, and possibly higher
but I would need to check.

Thanks for asking
NeilBrown
