Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030608AbVKXFlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbVKXFlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbVKXFlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:41:50 -0500
Received: from ns.suse.de ([195.135.220.2]:49606 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030608AbVKXFlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:41:49 -0500
From: Neil Brown <neilb@suse.de>
To: sander@humilis.net
Date: Thu, 24 Nov 2005 16:41:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17285.21142.558651.239828@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: Please help me understand reiser4_writepage. Was Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
In-Reply-To: message from Sander on Tuesday November 22
References: <17179.40731.907114.194935@cse.unsw.edu.au>
	<20051116133639.GA18274@favonius>
	<20051116142000.5c63449f.akpm@osdl.org>
	<17275.48113.533555.948181@cse.unsw.edu.au>
	<20051117075041.GA5563@favonius>
	<20051117101251.GA2883@favonius>
	<20051117101511.GB2883@favonius>
	<17282.21309.229128.930997@cse.unsw.edu.au>
	<20051121155144.62bedaab.akpm@osdl.org>
	<17282.35980.613583.592130@cse.unsw.edu.au>
	<20051122103428.GA12072@favonius>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 22, sander@humilis.net wrote:
> 
> It doesn't crash or segfault anymore. It works with the bitmap file on
> tmpfs, but not yet on reiser4.
> 
> This is kernel 2.6.15-rc1-mm2 with your (Neil Brown's) patch.
> 
...
> [42949655.680000] md1: bitmap initialized from disk: read 0/4 pages, set 0 bits, status: 1
....

Ok, this is interesting... 'status: 1'.
That should be either 0 or a negative errno.

That is printed in bitmap_init_from_disk in drivers/md/bitmap.c

'ret' can only be '1' if that value is returned from 'write_page'
write_page (same file) can only return '1' if that is returned by
write_one_page (mm/page-writeback.c).
write_one_page can only return '1' from a_ops->writepage, which is
presumably
  reiser4_writepage in fs/reiser4/page_cache.c

This will only return an unchecked value from write_page_by_ent (if
REISER4_USE_ENTD is defined) or emergency_flush.
emergency_flush is in fs/reiser4/emergency_flush.c and it does indeed
return 1 in some circumstances, though I don't really know what
circumstances.

So there may well be something that md/bitmap is doing wrongly, but
reiser4_writepage should not be returning 1 in any case.

Could someone on reiserfs-dev help me understand when
reiser4_writepage returns '1' and what I might be doing to trigger
that?

Thanks,
NeilBrown

