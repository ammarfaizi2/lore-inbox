Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUJNOul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUJNOul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUJNOul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:50:41 -0400
Received: from [199.84.5.21] ([199.84.5.21]:5899 "EHLO domino1.coradiant.com")
	by vger.kernel.org with ESMTP id S265477AbUJNOuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:50:35 -0400
To: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5 September 26, 2003
From: bgagnon@coradiant.com
Message-ID: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com>
Date: Thu, 14 Oct 2004 10:50:14 -0400
X-MIMETrack: Serialize by Router on Domino1/Coradiant(Release 6.5|September 26, 2003) at
 10/14/2004 10:50:35 AM,
	Serialize complete at 10/14/2004 10:50:35 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc me directly, since I am not a subscriber to this list)

Hi,

I discovered a memory leak in the mmap raw packet socket implementation, 
specifically when the client application core dumps (elf format). More 
specifically, the entire ring buffer memory leaks under such 
circumstances. I have reproduced the problem with our custom app, which 
links with Phil Wood's mmap version of libpcap (
http://plublic.lanl.gov/cpw) as well as with tcpdump binding against the 
same library. I have asserted the problem presence in kernels 2.4.26 and 
2.4.27. It has been resolved in kernel 2.6.8.

In a nutshell, the reference count of the ring buffer page frame is not 
handled properly by the core dump function elf_core_dump() in 
fs/binfmt_elf.c. After exiting this function, all ring buffer page frames 
reference counts have been increased by one, which impedes their release 
when the socket is closed. 

The reference count mishap is related to the fact that the ring buffer 
page frames have their PG_reserved bit set when they are created by the 
raw packet socket. According to the comments in mm.h, this is to ensure 
the pages don't get swapped out to disk. elf_core_dump() calls 
get_user_pages(), which increments the reference count, irrespective of 
the PG_reserved bit, while the subsequent put_page() call only decrements 
it if the PG_reserved bit is clear.

According to a similar kernel mailing list thread (
http://www.ussg.iu.edu/hypermail/linux/kernel/0311.3/0495.html), the page 
reference count field is not significant if the PG_reserved bit is set. 
Applied to our particular case, the raw packet socket implementation 
should unconditionally reset the reference count when the socket is 
closed, so that the memory gets released. However, I fear this would cause 
user space applications to crash: according to the mmap man page, the 
memory mapping should survive the socket closure:

"The  munmap  system call deletes the mappings for the specified address
range, and causes further references to addresses within the  range  to
generate  invalid  memory references.  The region is also automatically
unmapped when the process is terminated.  On the  other  hand,  closing
the file descriptor does not unmap the region."

So, on 2.4 kernels, we are facing the following situation:

1- The reference count information IS important to control the ring buffer 
lifetime
2- The PG_reserved bit causes the reference count not to be handled 
properly by different kernel subsystems, the core dump functions being one 
of them

>From what I could understand, 2.6 developer fixed the get_user_pages() 
code so it does not increment to reference count if the page has the 
PG_reserved bit set. I don't know if this is readily applicable to 2.4 
kernels, since it may break some other subsystem that rely on its current 
behavior.

So, unless a better solution is found, I would propose a localized fix for 
the leak, in function elf_core_dump(), starting at line 1275  (comments 
are my own) :

if (get_user_pages(current, current->mm, addr, 1, 0, 1,   /*BG: this 
ALWAYS will increment the ref count*/
                   &page, &vma) <= 0) {
       DUMP_SEEK (file->f_pos + PAGE_SIZE);
} else {
       if (page == ZERO_PAGE(addr)) {
              DUMP_SEEK (file->f_pos + PAGE_SIZE);
    } else {
            void *kaddr;
            flush_cache_page(vma, addr);
            kaddr = kmap(page);
            DUMP_WRITE(kaddr, PAGE_SIZE);
            flush_page_to_ram(page);
            kunmap(page);
    }
    /*BG: Start of fix*/ 
    if (PageReserved(page))
            /* BG: just undo the ref count increase done in 
get_user_pages*/
            put_page_testzero(page);
    else
            put_page(page);
    /*BG: end of fix */
}



Thanks,

Bernard
