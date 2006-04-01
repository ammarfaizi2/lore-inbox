Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWDAXBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWDAXBC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 18:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWDAXBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 18:01:02 -0500
Received: from linuxhacker.ru ([217.76.32.60]:9140 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1751637AbWDAXBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 18:01:00 -0500
Date: Sun, 2 Apr 2006 02:00:13 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Robert Mueller <robm@fastmail.fm>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Chris Mason <mason@suse.com>, Bron Gondwana <brong@fastmail.fm>,
       Jeremy Howard <jhoward@fastmail.fm>
Subject: Re: System lockup with processes in D state in 2.6.16.1
Message-ID: <20060401230013.GB26989@linuxhacker.ru>
References: <13d501c6544b$23e023d0$c100a8c0@robm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d501c6544b$23e023d0$c100a8c0@robm>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 31, 2006 at 08:41:38AM +1000, Robert Mueller wrote:

> >There was a patch for the problem referenced by this link. (By Cris Mason,
> >I think). This patch is long included into vanilla kernel
> >(2.6.15 certainly contains it). If you still see deadlocks, I guess you 
> >need
> >to gather some more info again (sysrq-t and friends).
> So we recently built 2.6.16.1, without the patch. However after just 1 hour 
> of stress testing with cyrus again, we were able to lock up the system with 
> lots of processes stuck in D state and a load running to 500+. The machine 
> had about 1500 processes running on it, and the dmesg buffer was only 1M, 
> so it seems we weren't able to capture all the traces with a sysrq-t, but 
> there's still a lot of info. I've put the sysrq-t and kernel config output 
> at the links below:
> http://kernel.robm.fastmail.fm/sysrq-t-2006-03-30-1.txt
> http://kernel.robm.fastmail.fm/kernel-config-2006-03-30-1.txt
> Any idea if this is related to the previous problem or is something 
> different?

Hm. This is in fact the same problem as I now see it.
I looked at the code another time and it is in fact unfixed. (Though I
remember seeing a patch committed, or may be this was my imagination?)
Looking at reiserfs_copy_from_user_to_file_region and seeing it does not need
transaction handle, I uncorrectly assumed, the transaction was not opened yet,
but it was in fact opened in reiserfs_allocate_blocks_for_region() earlier.
Sorry for misinforming you.
I now looked at the code again, and I cannot think of any reason why we
have not implemented a solution like one present in the patch at the end
of this message (don't tell me it's just because it is too late now.)
The patch compiles and passes some simple tests like racer and fsx.
Perhaps you can give it a try (on non-production fs first, of course).
And if we get lucky, Chris will comment on it before getting to busy with
personal stuff next week.

imapd         D 0098A9C9     0 11217   1784         11232 11216 (NOTLB)
e1c65c18 cd267550 c56134e0 0098a9c9 f760ca24 c024024e c03034df f760ca0c 
       ccac5cd4 65b68200 0098a9c9 00000000 00000000 cd267550 c56134a0 00000000 
       65b68200 0098a9c9 d84f1550 d84f1678 c56134a0 e1c65c7c c560df8c e1c65c24 
Call Trace:
 [<c024024e>] kobject_release+0x0/0xa
 [<c03034df>] scsi_request_fn+0x55/0x2e2
 [<c03cca3a>] io_schedule+0x26/0x30
 [<c013e2fd>] sync_page+0x37/0x4c
 [<c03cccab>] __wait_on_bit_lock+0x53/0x61
 [<c013e2c6>] sync_page+0x0/0x4c
 [<c013eb9d>] __lock_page+0x91/0x99
 [<c0131af9>] wake_bit_function+0x0/0x55
 [<c0131af9>] wake_bit_function+0x0/0x55
 [<c013fe1f>] filemap_nopage+0x25e/0x3bb
 [<c014d45a>] do_no_page+0x9d/0x2fd
 [<c015f9c0>] sync_buffer+0x0/0x4a
 [<c03ccc50>] out_of_line_wait_on_bit+0x91/0x99
 [<c014d921>] __handle_mm_fault+0x174/0x326
 [<c0115277>] do_page_fault+0x1b1/0x64f
 [<c01150c6>] do_page_fault+0x0/0x64f
 [<c010380f>] error_code+0x4f/0x54
 [<c01a8e8e>] reiserfs_copy_from_user_to_file_region+0x6d/0x100
 [<c01aa38b>] reiserfs_file_write+0x558/0x75f
 [<c03cd1da>] __mutex_unlock_slowpath+0x54/0x1ed
 [<c014e83f>] unlink_file_vma+0x38/0x4c
 [<c01542e0>] free_pages_and_swap_cache+0x5d/0x80
 [<c015e108>] default_llseek+0x62/0xc5
 [<c01a9e33>] reiserfs_file_write+0x0/0x75f
 [<c015e838>] vfs_write+0xa6/0x171
 [<c015e9d4>] sys_write+0x51/0x80
 [<c0102ce9>] syscall_call+0x7/0xb


--- linux-2.6.16/fs/reiserfs/file.c.orig	2006-04-02 01:15:23.000000000 +0300
+++ linux-2.6.16/fs/reiserfs/file.c	2006-04-02 01:41:10.000000000 +0300
@@ -1486,6 +1486,19 @@
 						  s_blocksize_bits)) -
 						blocks_to_allocate);
 
+		/* Copy data from user-supplied buffer to file's pages, we
+		   need to do it here, because we may need to fault-in some
+		   data in process and this is not allowed with transaction
+		   running */
+		res =
+		    reiserfs_copy_from_user_to_file_region(pos, num_pages,
+							   write_bytes,
+							   prepared_pages, buf);
+		if (res) {
+			reiserfs_unprepare_pages(prepared_pages, num_pages);
+			break;
+		}
+
 		if (blocks_to_allocate > 0) {	/*We only allocate blocks if we need to */
 			/* Fill in all the possible holes and append the file if needed */
 			res =
@@ -1509,16 +1522,6 @@
    and probably we would do that just to get rid of garbage in files after a
    crash */
 
-		/* Copy data from user-supplied buffer to file's pages */
-		res =
-		    reiserfs_copy_from_user_to_file_region(pos, num_pages,
-							   write_bytes,
-							   prepared_pages, buf);
-		if (res) {
-			reiserfs_unprepare_pages(prepared_pages, num_pages);
-			break;
-		}
-
 		/* Send the pages to disk and unlock them. */
 		res =
 		    reiserfs_submit_file_region_for_write(&th, inode, pos,


Bye,
    Oleg
