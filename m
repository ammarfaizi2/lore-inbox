Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbXAGCe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbXAGCe3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbXAGCe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:34:29 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:53602 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932342AbXAGCe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:34:28 -0500
X-Greylist: delayed 4169 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 21:34:27 EST
Date: Sun, 7 Jan 2007 03:24:54 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nathan Scott <nathans@sgi.com>,
       David Chinner <dgc@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: BUG: warning at mm/truncate.c:60/cancel_dirty_page()
Message-ID: <20070107012454.GA3869@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Hugh Dickins <hugh@veritas.com>, Nathan Scott <nathans@sgi.com>,
	David Chinner <dgc@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>
References: <20070106023907.GA7766@m.safari.iki.fi> <Pine.LNX.4.64.0701062051570.24997@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062051570.24997@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 21:11:07 +0000, Hugh Dickins wrote:
> On Sat, 6 Jan 2007, Sami Farin wrote:
> 
> > Linux 2.6.19.1 SMP [2] on Pentium D...
> > I was running dt-15.14 [2] and I ran
> > "cinfo datafile" (it does mincore()).
> > Well it went OK but when I ran "strace cinfo datafile"...:
> > 04:18:48.062466 mincore(0x37f1f000, 2147266560, 
> 
> You rightly noted in a followup that there have been changes to
> mincore, but I doubt they have any bearing on this: I think the
> BUG just happened at the same time as your mincore.

BUG does not happen if I do not do "strace cinfo dtfile" with O_DIRECT
test file.  It's easy to reproduce.
Without strace BUG does not happen.

Now I got it again, with also the mincore patch applied:

01:48:42.831060 mincore(0x37ff1000, 2147254272, ^[

2007-01-07 01:48:51.480531500 <4>BUG: warning at mm/truncate.c:60/cancel_dirty_page()
2007-01-07 01:48:51.480532500 <4> [<c0103cff>] dump_trace+0x215/0x21a
2007-01-07 01:48:51.480557500 <4> [<c0103da7>] show_trace_log_lvl+0x1a/0x30
2007-01-07 01:48:51.480559500 <4> [<c0103dcf>] show_trace+0x12/0x14
2007-01-07 01:48:51.480560500 <4> [<c0103ecc>] dump_stack+0x19/0x1b
2007-01-07 01:48:51.480561500 <4> [<c0155616>] cancel_dirty_page+0x7e/0x80
2007-01-07 01:48:51.480562500 <4> [<c0155632>] truncate_complete_page+0x1a/0x47
2007-01-07 01:48:51.480563500 <4> [<c01557c4>] truncate_inode_pages_range+0x114/0x2ae
2007-01-07 01:48:51.480564500 <4> [<c0155978>] truncate_inode_pages+0x1a/0x1c
2007-01-07 01:48:51.480574500 <4> [<c026a558>] fs_flushinval_pages+0x40/0x77
2007-01-07 01:48:51.480575500 <4> [<c026e7a8>] xfs_write+0x8c4/0xb68
2007-01-07 01:48:51.480576500 <4> [<c0269e28>] xfs_file_aio_write+0x7e/0x95
2007-01-07 01:48:51.480577500 <4> [<c016e5d0>] do_sync_write+0xca/0x119
2007-01-07 01:48:51.480578500 <4> [<c016e7a6>] vfs_write+0x187/0x18c
2007-01-07 01:48:51.480579500 <4> [<c016e84c>] sys_write+0x3d/0x64
2007-01-07 01:48:51.480589500 <4> [<c0102e77>] syscall_call+0x7/0xb
2007-01-07 01:48:51.480590500 <4> [<00bed410>] 0xbed410

$ /sbin/sysctl -n vm.dirty_expire_centisecs
999

cancel_dirty_page would be more useful if it executed WARN_ON
at max once per 10s or something instead of five times out of 2^32 or 2^64
errors...  I mean, user might think program/kernel started to work OK when
BUGs stop if he/she doesn't check cancel_dirty_page() function.


--- linux-2.6.19/mm/truncate.c.bak	2007-01-01 19:10:00.627310000 +0200
+++ linux-2.6.19/mm/truncate.c	2007-01-07 02:35:53.786636897 +0200
@@ -55,11 +55,16 @@ void cancel_dirty_page(struct page *page
 {
 	/* If we're cancelling the page, it had better not be mapped any more */
 	if (page_mapped(page)) {
-		static unsigned int warncount;
+		static int first = 1;
+		static unsigned long lastwarn;
 
-		WARN_ON(++warncount < 5);
+		if (unlikely(first) || time_after(jiffies, (lastwarn + 10*HZ))) {
+			first = 0;
+			lastwarn = jiffies;
+			WARN_ON(42);
+		}
 	}
-		
+
 	if (TestClearPageDirty(page)) {
 		struct address_space *mapping = page->mapping;
 		if (mapping && mapping_cap_account_dirty(mapping)) {


> > ...
> > 2007-01-06 04:19:03.788181500 <4>BUG: warning at mm/truncate.c:60/cancel_dirty_page()
> > 2007-01-06 04:19:03.788221500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
> > 2007-01-06 04:19:03.788223500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
> > 2007-01-06 04:19:03.788224500 <4> [<c0103dcb>] show_trace+0x12/0x14
> > 2007-01-06 04:19:03.788225500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
> > 2007-01-06 04:19:03.788227500 <4> [<c01546a6>] cancel_dirty_page+0x7e/0x80
> > 2007-01-06 04:19:03.788228500 <4> [<c01546c2>] truncate_complete_page+0x1a/0x47
> > 2007-01-06 04:19:03.788229500 <4> [<c0154854>] truncate_inode_pages_range+0x114/0x2ae
> > 2007-01-06 04:19:03.788245500 <4> [<c0154a08>] truncate_inode_pages+0x1a/0x1c
> > 2007-01-06 04:19:03.788247500 <4> [<c0269244>] fs_flushinval_pages+0x40/0x77
> > 2007-01-06 04:19:03.788248500 <4> [<c026d48c>] xfs_write+0x8c4/0xb68
> > 2007-01-06 04:19:03.788250500 <4> [<c0268b14>] xfs_file_aio_write+0x7e/0x95
> > 2007-01-06 04:19:03.788251500 <4> [<c016d66c>] do_sync_write+0xca/0x119
> > 2007-01-06 04:19:03.788265500 <4> [<c016d842>] vfs_write+0x187/0x18c
> > 2007-01-06 04:19:03.788267500 <4> [<c016d8e8>] sys_write+0x3d/0x64
> > 2007-01-06 04:19:03.788268500 <4> [<c0102e73>] syscall_call+0x7/0xb
> > 2007-01-06 04:19:03.788269500 <4> [<001cf410>] 0x1cf410
> > 2007-01-06 04:19:03.788289500 <4> =======================
> 
> So... XFS uses truncate_inode_pages when serving the write system call.
> That's very inventive, and now it looks like Linus' cancel_dirty_page
> and new warning have caught it out.  VM people expect it to be called
> either when freeing an inode no longer in use, or when doing a truncate,
> after ensuring that all pages mapped into userspace have been taken out.

Maybe XFS people can tell is their code doing something unwise?

And about my earlier xfs_freeze issue... =)

...
> Gosh.  Might be better to reproduce it on 2.6.20-rc3;

Well those were not all the patches =)
I have spent so many days with 2.6.18 and 2.6.19 after getting
new mobo that I rather use this 2.6.19.x for as long as it works.

But why doesn't somebody want to reproduce with latest kernel...
Just running dt and "strace cinfo dtfile*" needed...

dt pattern=iot incr=variable records=32768 bs=65536 of=dtfile log=dtfile.log.txt passes=1 procs=2 iotype=random flags=direct capacity=2G

Note: I was not able to reproduce with capacity=512M.
I have 1 GB of RAM and 4 GB of swap (HIGHMEM PAE kernel).

> but I think we have to hand this over to some XFS people.
> 
> Hugh

-- 
