Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWF1Si4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWF1Si4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWF1Si4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:38:56 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:37077 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750897AbWF1Siu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:38:50 -0400
Date: Wed, 28 Jun 2006 20:38:25 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vs@namesys.com,
       Neil Brown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <stable@kernel.org>
Subject: Re: Unkillable process in last git -- Bisected
Message-ID: <20060628203825.47790a10@localhost>
In-Reply-To: <20060628151955.0acdb39a@localhost>
References: <20060628142918.1b2c25c3@localhost>
	<20060628145349.53873ccc@localhost>
	<20060628150943.78e91871@localhost>
	<20060628151955.0acdb39a@localhost>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 15:19:55 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> > > > [  430.083347] localedef     R  running task       0  8577   8558  8578               (NOTLB)
> > > > [  430.083352] gzip          X ffff81001e612ee0     0  8578   8577                     (L-TLB)
> > > > [  430.083358] ffff81001395bef8 ffff81001fd1a310 0000000000000246 ffff81001e612ee0 
> > > > [  430.083362]        ffff81001e4c0080 ffff81001e612ee0 ffff81001e4c0258 0000000000000001 
> > > > [  430.083366]        0000000000000046 0000000000000046 ffff81001395bf18 0000000000000010 
> > > > [  430.083370] Call Trace: <ffffffff80227f6f>{do_exit+2378} <ffffffff802628e9>{vfs_write+288}
> > > > [  430.083379]        <ffffffff80228065>{sys_exit_group+0} <ffffffff80209806>{system_call+126}
> > > 
> > > do_exit() -- kernel/exit.c
> > > 
> > > 0xffffffff80227f66 <do_exit+2369>:      mov    %rax,0x18(%rbp)
> > > 0xffffffff80227f6a <do_exit+2373>:      callq  0xffffffff8048b850 <schedule>
> > > 0xffffffff80227f6f <do_exit+2378>:      ud2a
> > > 0xffffffff80227f71 <do_exit+2380>:      pushq  $0xffffffff804b7821
> > > 0xffffffff80227f76 <do_exit+2385>:      retq   $0x3ba
> > > 0xffffffff80227f79 <do_exit+2388>:      jmp    0xffffffff80227f79 <do_exit+2388>
> > 
> > 
> > that is the end of the function:
> > 
> > ...
> >         schedule();
> >         BUG();
> >         /* Avoid "noreturn function does return".  */
> >         for (;;) ;
> > }
> > 
> > 
> > So the questions are two:
> > 
> > 1) why schedule() didn't work?
> > 
> > 2) why the process is looping around "ud2a" (placed by BUG()) and
> > presumibly throwing a lot of "invalid opcode" exceptions?
> 
> It seems that the first mail didn't hit LKML (maybe it was too big),
> here it is (stripped):
> 
> ------------------------------------------------------------------------
> Running "localedef" triggers an infinite loop in kernel mode (or
> something) --> localdef becomes unkillable.
> 
> This is dmesg after pressing ALT+SysRQ+T three times:
> 
> [CUT]
> 
> KERNEL:
> 
> --
> 	Paolo Ornati
> 	Linux 2.6.17-ga39727f2-dirty on x86_64
> 	                      ^^^^^^^
> 
> The -dirty is because of a fix to PS2 Keyboard auto-repeat, nothing else.
> ------------------------------------------------------------------------


Hi everybody,

as you can see from the subject the problem is an unkillable process
(localedef) that eats 100% CPU (the system is usable however).


After a git-bisect session I've found that reverting the following
commit fixes the problem.

Any idea?


commit 6527c2bdf1f833cc18e8f42bd97973d583e4aa83
Author: Vladimir V. Saveliev <vs@namesys.com>
Date:   Tue Jun 27 02:53:57 2006 -0700

    [PATCH] generic_file_buffered_write(): deadlock on vectored write
    
    generic_file_buffered_write() prefaults in user pages in order to avoid
    deadlock on copying from the same page as write goes to.
    
    However, it looks like there is a problem when write is vectored:
    fault_in_pages_readable brings in current segment or its part (maxlen).
    OTOH, filemap_copy_from_user_iovec is called to copy number of bytes
    (bytes) which may exceed current segment, so filemap_copy_from_user_iovec
    switches to the next segment which is not brought in yet.  Pagefault is
    generated.  That causes the deadlock if pagefault is for the same page
    write goes to: page being written is locked and not uptodate, pagefault
    will deadlock trying to lock locked page.
    
    [akpm@osdl.org: somewhat rewritten]
    Cc: Neil Brown <neilb@suse.de>
    Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
    Cc: <stable@kernel.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/mm/filemap.c b/mm/filemap.c
index 9c7334b..d504d6e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2095,14 +2095,21 @@ generic_file_buffered_write(struct kiocb
 	do {
 		unsigned long index;
 		unsigned long offset;
-		unsigned long maxlen;
 		size_t copied;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
-			bytes = count;
+
+		/* Limit the size of the copy to the caller's write size */
+		bytes = min(bytes, count);
+
+		/*
+		 * Limit the size of the copy to that of the current segment,
+		 * because fault_in_pages_readable() doesn't know how to walk
+		 * segments.
+		 */
+		bytes = min(bytes, cur_iov->iov_len - iov_base);
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2110,10 +2117,7 @@ generic_file_buffered_write(struct kiocb
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		maxlen = cur_iov->iov_len - iov_base;
-		if (maxlen > bytes)
-			maxlen = bytes;
-		fault_in_pages_readable(buf, maxlen);
+		fault_in_pages_readable(buf, bytes);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {



-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
