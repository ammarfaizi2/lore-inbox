Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWJFGoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWJFGoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWJFGoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:44:10 -0400
Received: from brick.kernel.dk ([62.242.22.158]:13134 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932643AbWJFGoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:44:03 -0400
Date: Fri, 6 Oct 2006 08:43:45 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_splice crashes in 2.6.19rc1 during autotest
Message-ID: <20061006064345.GG5170@kernel.dk>
References: <200610051725.53183.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610051725.53183.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05 2006, Andi Kleen wrote:
> 
> I was running autotest on 2.6.19rc1+x86_64 patchkit and I ended up with a BUG()
> below sys_splice while running some IO test there.
> 
> This was a debugging kernel with PREEMPTION and various other
> debugging options enabled.
> 
> The system ran out of disk space during the test so that
> might have been related and I ended up with a "fio" process
> in D. Also the system was confused afterwards with rm
> oopsing etc.
> 
> File system was reiserfs.
> 
> -Andi
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at /abuild/autoboot/lsrc/x86_64/linux/mm/filemap.c:547
> invalid opcode: 0000 [1] SMP 
> CPU 0 
> Modules linked in:
> Pid: 13789, comm: fio Not tainted 2.6.19-rc1 #5
> RIP: 0010:[<ffffffff80255134>]  [<ffffffff80255134>] unlock_page+0xf/0x2f
> RSP: 0018:ffff81000a5e1e18  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff810000cfa9e0 RCX: 0000000000000036
> RDX: ffff81000a5e1e98 RSI: ffff810000cfa9e0 RDI: ffff810000cfa9e0
> RBP: ffff810000cfa9e0 R08: ffff81003ec46c00 R09: ffffc20000265908
> R10: ffff8100157a3e40 R11: 0000000000000000 R12: ffff81003e0a09a0
> R13: 0000000000001000 R14: 0000000006400000 R15: ffff810037baac10
> FS:  00002af7c37d7b70(0000) GS:ffffffff8077d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00002af7c365e0b0 CR3: 0000000002c07000 CR4: 00000000000006e0
> Process fio (pid: 13789, threadinfo ffff81000a5e0000, task ffff81003f4b6e60)
> Stack:  00000000ffffffe4 ffffffff80293652 ffff81000a5e1e98 ffff81003e0a0800
>  ffff8100367745c0 00000000000200d2 000000000000452c ffff81003e0a09a0
>  ffff81003e0a0800 0000000000000000 0000000000000000 ffffffff80694f00
> Call Trace:
>  [<ffffffff80293652>] pipe_to_file+0x2df/0x2f0
>  [<ffffffff80292b4e>] splice_from_pipe+0x86/0x213
>  [<ffffffff80292f0d>] generic_file_splice_write+0x21/0x8a
>  [<ffffffff80293baa>] sys_splice+0x105/0x210
>  [<ffffffff8020953e>] system_call+0x7e/0x83
> DWARF2 unwinder stuck at system_call+0x7e/0x83

So I'm guessing you hit a ->prepare_write() failure and that path exit
seems to be buggy. Can you see if this fixes it? It should, but if you
can reproduce it would be nice to get verification.

[PATCH] splice: fix pipe_to_file() ->prepare_write() error path

Don't jump to the unlock+release path, we already did that.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

diff --git a/fs/splice.c b/fs/splice.c
index 13e92dd..a567010 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -607,7 +607,7 @@ find_page:
 			ret = -ENOMEM;
 			page = page_cache_alloc_cold(mapping);
 			if (unlikely(!page))
-				goto out_nomem;
+				goto out_ret;
 
 			/*
 			 * This will also lock the page
@@ -666,7 +666,7 @@ find_page:
 		if (sd->pos + this_len > isize)
 			vmtruncate(mapping->host, isize);
 
-		goto out;
+		goto out_ret;
 	}
 
 	if (buf->page != page) {
@@ -698,7 +698,7 @@ find_page:
 out:
 	page_cache_release(page);
 	unlock_page(page);
-out_nomem:
+out_ret:
 	return ret;
 }
 

-- 
Jens Axboe

