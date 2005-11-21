Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVKUXHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVKUXHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVKUXHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:07:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:54243 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751248AbVKUXHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:07:48 -0500
From: Neil Brown <neilb@suse.de>
To: sander@humilis.net
Date: Tue, 22 Nov 2005 10:07:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.21309.229128.930997@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Please help me understand ->writepage. Was Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
In-Reply-To: message from Sander on Thursday November 17
References: <431B9558.1070900@baanhofman.nl>
	<17179.40731.907114.194935@cse.unsw.edu.au>
	<20051116133639.GA18274@favonius>
	<20051116142000.5c63449f.akpm@osdl.org>
	<17275.48113.533555.948181@cse.unsw.edu.au>
	<20051117075041.GA5563@favonius>
	<20051117101251.GA2883@favonius>
	<20051117101511.GB2883@favonius>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 17, sander@humilis.net wrote:
> Sander wrote (ao):
> # Sander wrote (ao):
> # # Neil Brown wrote (ao):
> # # > On Wednesday November 16, akpm@osdl.org wrote:
> # # > > Sander <sander@humilis.net> wrote:
> # # > > > With 2.6.14-mm2 (x86) and mdadm 2.1 I get a Segmentation fault when I
> # # > > > try this:
> # # > > 
> # # > > It oopsed in reiser4.  reiserfs-dev added to Cc...
> # # > > 
> # # > 
> # # > Hmm... It appears that md/bitmap is calling prepare_write and
> # # > commit_write with 'file' as NULL - this works for some filesystems,
> # # > but not for reiser4.
> # # > 
> # # > Does this patch help.
> # # 
> # # Something changed, but it didn't fix it it seems:
> # # 
> # # # mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
> # # mdadm: RUN_ARRAY failed: No such file or directory
> # 
> # FWIW, the following happens when I point --bitmap to /tmp/raid1.bitmap
> # which is tmpfs, and also happens when I attach both loop0 and loop1 to
> # files on tmpfs.
> # 
> # This would suggest that reiser4 is not solely at fault?
> # 

No, there is something very wrong in md/bitmap.c's handling of writing
to a file.  It was developed for, and tested on, ext3 and doesn't seem
to work anywhere else.... and I don't understand enough to fix it.

Help ???

What md/bitmap wants to do is effectively memory map the file, make
updates to pages occasionally, flush those pages out to storage, and
wait for the flush to complete.  It doesn't exactly memory map.  It
just reads all the pages and keeps them in an array (holding a
reference to each).

To write the pages out it effectively does ->prepare_write,
->commit_write, and then ->writepage.
I'm not sure that prepare/commit is needed, but they don't seem to be
the problem.  writepage is.

For tmpfs at least, writepage disconnects the page from the pagecache
(via move_to_swap_cache), so the page that we are holding is no longer
part of the file and, significantly, page->mapping become NULL.
This suggests that the ->writepage usage is broken.
However I tried to see what 'msync' does for real memory mapped files,
and it eventually calls ->writepage too.  So how does that work??

Any advice would be most welcome!

Thanks,
NeilBrown

