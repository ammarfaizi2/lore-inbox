Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKLPAy>; Tue, 12 Nov 2002 10:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSKLPAy>; Tue, 12 Nov 2002 10:00:54 -0500
Received: from pc-62-31-74-27-ed.blueyonder.co.uk ([62.31.74.27]:44419 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261582AbSKLPAh>; Tue, 12 Nov 2002 10:00:37 -0500
Date: Tue, 12 Nov 2002 15:07:11 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mark Hazell <nutts@penguinmail.com>
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [patch/2.4] ll_rw_blk stomping on bh state [Re: kernel BUG at journal.c:1732! (2.4.19)]
Message-ID: <20021112150711.F2837@redhat.com>
References: <20021028111357.78197071.nutts@penguinmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028111357.78197071.nutts@penguinmail.com>; from nutts@penguinmail.com on Mon, Oct 28, 2002 at 11:13:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Oct 28, 2002 at 11:13:57AM +0000, Mark Hazell wrote:
 
> I got your addresses from the MAINTAINERS file in the kernel source
> tree, so apologies if i should have sent this somewhere else first.
> 
> Summary: I was copying 700mb of data to my ext3 RAID-1 39gig filesystem
> (2.4gig free according to 'df') yesterday, when the kernel spewed out
> the lines at the bottom of this email.

The start of this is just anonymous disk corruption -- there's no way
I can tell how it happened, but this:

> Oct 28 02:44:14 recondo kernel: attempt to access beyond end of device
> Oct 28 02:44:14 recondo kernel: 09:00: rw=1, want=38708548,
> limit=38708544

looks like you've got a corrupt indirect block on disk somewhere which
is pointing to illegal data blocks off the end of the disk.

That said, ext3 should survive such corruption.  It fails to do so
because of the core block IO code, which in generic_make_request(),
does:

		if (maxsector < count || maxsector - count < sector) {
			/* Yecch */
			bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);

and this has the unfortunate side effect of zapping key ext3 metadata
in the buffer state bits, leading up to

> Oct 28 02:44:15 recondo kernel: Assertion failure in
> __journal_remove_journal_he ad() at journal.c:1732: "buffer_jbd(bh)"
> Oct 28 02:44:15 recondo kernel: kernel BUG at journal.c:1732!

when ext3 next comes across the buffer that it knows it owns, but
which has been cleared of ext3 metadata.

The patch below fixes it for me (it's easy to reproduce --- just set
up an ext3 filesystem on an LVM device and then lvreduce it while live
to force half of the filesystem off the end of the device.)

Folks, just which buffer flags do we want to preserve in this case?

--Stephen

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="000-buffer_clearbits.patch"

--- linux-uml-jbddebug/drivers/block/ll_rw_blk.c.=K0001=.orig	Tue Nov 12 14:35:45 2002
+++ linux-uml-jbddebug/drivers/block/ll_rw_blk.c	Tue Nov 12 14:35:45 2002
@@ -1129,7 +1129,9 @@
 
 		if (maxsector < count || maxsector - count < sector) {
 			/* Yecch */
-			bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
+			bh->b_state &= ~((1 << BH_Uptodate) | (1 << BH_Dirty) |
+					 (1 << BH_New) | (1 << BH_Wait_IO) |
+					 (1 << BH_Launder));
 
 			/* This may well happen - the kernel calls bread()
 			   without checking the size of the device, e.g.,

--O5XBE6gyVG5Rl6Rj--
