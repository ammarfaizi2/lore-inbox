Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTA0UZM>; Mon, 27 Jan 2003 15:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTA0UZM>; Mon, 27 Jan 2003 15:25:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:4019 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262796AbTA0UZK>;
	Mon, 27 Jan 2003 15:25:10 -0500
Date: Mon, 27 Jan 2003 12:51:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: dementiev@mpi-sb.mpg.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: buffer leakage in kernel?
Message-Id: <20030127125138.5dc35b1d.akpm@digeo.com>
In-Reply-To: <3E3564EB.8E675E@mpi-sb.mpg.de>
References: <3E31364E.F3AFDCF0@mpi-sb.mpg.de>
	<20030124130208.52583b24.akpm@digeo.com>
	<3E3564EB.8E675E@mpi-sb.mpg.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2003 20:34:23.0083 (UTC) FILETIME=[79F25BB0:01C2C643]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Dementiev <dementiev@mpi-sb.mpg.de> wrote:
>
> Application allocates 512 MB and never uses more.
> 2MB buffers are used for each read() and write() calls.
> Each file has only one read or write request going any time. There is no othr
> memory-
> hungry applications running.

OK.

> > Please perform this test:
> >
> > 1: Wait until you have 500M "Buffers"
> > 2: cat 64_gig_file > /dev/null
> > 3: Now see how large "Buffers" is.  It should have reduced a lot.
> 
> Yes, it worked, they had reduced.
> Does this mean, that cached indirect buffers can't be kicked out of memory
> automatically
> and ONLY non-O_DIRECT access can do it? I suppose, they should be displaced by
> newly allocated indirect buffers and user memory allocation.

I suspect what is happening is that you've managed to find a code path in
which the kernel is allocating lots of memory in a mode in which it cannot
run effective page reclaim.  This would be more likely to be true if you only
see the failures when writing.

It would help if you could change mm/vmscan.c:try_to_free_pages_zone()
thusly:

        /*
         * Hmm.. Cache shrink failed - time to kill something?
         * Mhwahahhaha! This is the part I really like. Giggle.
         */
+	show_stack(0);
        out_of_memory();
        return 0;
 }

and pass the resulting log output through ksyoops.

And here's a protopatch to teach the kernel to make sure that there's a
decent amount of free memory before it goes and performs GFP_NOFS pagecache
allocations:

diff -puN fs/buffer.c~a fs/buffer.c
--- 24/fs/buffer.c~a	2003-01-27 12:28:02.000000000 -0800
+++ 24-akpm/fs/buffer.c	2003-01-27 12:28:23.000000000 -0800
@@ -2112,6 +2112,8 @@ int generic_direct_IO(int rw, struct ino
 	for (i = 0; i < nr_blocks; i++, blocknr++) {
 		struct buffer_head bh;
 
+		try_to_free_pages(GFP_KERNEL);
+
 		bh.b_state = 0;
 		bh.b_dev = inode->i_dev;
 		bh.b_size = blocksize;


If that sheds no light, please send me the app and I'll see if I can
reproduce it.  Thanks.


