Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTHFPRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTHFPRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:17:12 -0400
Received: from angband.namesys.com ([212.16.7.85]:16045 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263930AbTHFPRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:17:09 -0400
Date: Wed, 6 Aug 2003 19:17:07 +0400
From: Oleg Drokin <green@namesys.com>
To: Lenar L?hmus <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad scheduling and an BUG between them
Message-ID: <20030806151707.GA13558@namesys.com>
References: <200308061324.13232.lenar@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308061324.13232.lenar@vision.ee>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 06, 2003 at 01:24:05PM +0300, Lenar L?hmus wrote:

> with kernel-2.6.0-test2-mm3+A3-O12.2int i found this in logs:
> bad: scheduling while atomic!
> Call Trace:
>  [<c011c87d>] schedule+0x56d/0x580
>  [<c0144b33>] unmap_page_range+0x43/0x70
>  [<c0144d15>] unmap_vmas+0x1b5/0x210
>  [<c014893b>] exit_mmap+0x7b/0x190
>  [<c011e399>] mmput+0x79/0xf0
>  [<c0122082>] do_exit+0x122/0x3f0
>  [<c010b7c0>] do_invalid_op+0x0/0xd0
>  [<c010b4d9>] die+0xf9/0x100
>  [<c010b889>] do_invalid_op+0xc9/0xd0
>  [<c01436ba>] kunmap_high+0x1a/0xa0
>  [<c02a0f9f>] error_code+0x2f/0x38
>  [<c01436ba>] kunmap_high+0x1a/0xa0
>  [<c01a6040>] reiserfs_unprepare_pages+0x30/0x70
>  [<c01a72b5>] reiserfs_file_write+0x4e5/0x595
>  [<c011aa31>] do_page_fault+0x251/0x454
>  [<c011c941>] __wake_up_common+0x31/0x60
>  [<c01a6dd0>] reiserfs_file_write+0x0/0x595
>  [<c0153e38>] vfs_write+0xb8/0x130
>  [<c0153f62>] sys_write+0x42/0x70
>  [<c02a0593>] syscall_call+0x7/0xb

I am really unsure who is at fault here. At least reiserfs does not hold any locks
at this point. Not even BKL.

> and one one kernel BUG report in the middle of them:
> kernel BUG at mm/highmem.c:178!
> invalid operand: 0000 [#2]
> Call Trace:
>  [<c01a6040>] reiserfs_unprepare_pages+0x30/0x70
>  [<c01a72b5>] reiserfs_file_write+0x4e5/0x595

Hm, this one is real.
Try the patch below.
I wonder how you was able to hit this reiserfs_unprepare_pages() codepath at all.
Were there any messages prior to the bug? Or was there out of space situation?

Thanks for the report.

Bye,
    Oleg

===== fs/reiserfs/file.c 1.20 vs edited =====
--- 1.20/fs/reiserfs/file.c	Wed Jun  4 11:50:34 2003
+++ edited/fs/reiserfs/file.c	Wed Aug  6 19:11:01 2003
@@ -555,7 +555,6 @@
 	struct page *page = prepared_pages[i];
 
 	try_to_free_buffers(page);
-	kunmap(page);
 	unlock_page(page);
 	page_cache_release(page);
     }
