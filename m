Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136788AbRA1EiL>; Sat, 27 Jan 2001 23:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136821AbRA1EiB>; Sat, 27 Jan 2001 23:38:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1808 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136819AbRA1Ehz>; Sat, 27 Jan 2001 23:37:55 -0500
Date: Sat, 27 Jan 2001 20:37:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <Pine.LNX.4.21.0101280010320.12703-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101272030590.1897-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Marcelo Tosatti wrote:
> > 
> > This is the smoking gun here, I bet, but I'd like to make sure I see the
> > whole thing. I don't see _why_ we'd have deadlocked on __wait_on_page(),
> > but I think this is the thread that hangs on to the mm semaphore.
> 
> I was able to reproduce it here with dbench. 
> 
> Nothing is locked except this dbench thread (the only dbench thread):
> 
> dbench    D C1C9FE64  5200  1013      1        (L-TLB)    1370   785 
> Call Trace: [___wait_on_page+130/160] [truncate_list_pages+100/404] [truncate_inode_pages+93/128] [iput+162/360] [dput+262/356] [fput+121/232] [exit_mmap+218/292]  
> [mmput+56/80] [do_exit+208/680] [do_signal+566/656] [dput+25/356] [path_release+13/60] [sys_newstat+100/112] [sys_read+188/196] [signal_return+20/24]  

Ok, this definitely seems to be the pattern.

I don't see _what_ is going on, though.

I know of one "known bug" in pre10: if you run out of swap-space with
shared memory segments, it will do the wrong thing (return 1 without
unlocking the page). xmms might trigger this, but I didn't think that
dbench used shared memory?

There's also an ugliness in the truncate ordering. I don't think it should
matter, but I do believe it's conceptually wrong as-is.

Does this patch make any difference at all?

		Linus

-----
diff -u --recursive --new-file pre10/linux/mm/memory.c linux/mm/memory.c
--- pre10/linux/mm/memory.c	Sat Jan 27 10:53:39 2001
+++ linux/mm/memory.c	Sat Jan 27 19:12:35 2001
@@ -945,7 +945,6 @@
 	if (inode->i_size < offset)
 		goto do_expand;
 	inode->i_size = offset;
-	truncate_inode_pages(mapping, offset);
 	spin_lock(&mapping->i_shared_lock);
 	if (!mapping->i_mmap && !mapping->i_mmap_shared)
 		goto out_unlock;
@@ -960,8 +959,7 @@
 
 out_unlock:
 	spin_unlock(&mapping->i_shared_lock);
-	/* this should go into ->truncate */
-	inode->i_size = offset;
+	truncate_inode_pages(mapping, offset);
 	if (inode->i_op && inode->i_op->truncate)
 		inode->i_op->truncate(inode);
 	return;
diff -u --recursive --new-file pre10/linux/mm/shmem.c linux/mm/shmem.c
--- pre10/linux/mm/shmem.c	Sat Jan 27 10:53:39 2001
+++ linux/mm/shmem.c	Sat Jan 27 19:50:08 2001
@@ -217,8 +217,11 @@
 
 	info = &page->mapping->host->u.shmem_i;
 	swap = __get_swap_page(2);
-	if (!swap.val)
-		return 1;
+	if (!swap.val) {
+		set_page_dirty(page);
+		UnlockPage(page);
+		return -ENOMEM;
+	}
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(page->mapping->host);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
