Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S160427AbPJUEiS>; Thu, 21 Oct 1999 00:38:18 -0400
Received: by vger.rutgers.edu id <S157594AbPJUEiB>; Thu, 21 Oct 1999 00:38:01 -0400
Received: from linuxcare.canberra.net.au ([203.29.91.49]:3940 "EHLO front.linuxcare.com.au") by vger.rutgers.edu with ESMTP id <S157042AbPJUEhu>; Thu, 21 Oct 1999 00:37:50 -0400
From: Paul Mackerras <paulus@linuxcare.com>
Organization: Linuxcare, Inc.
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: architecture bootup changes..
Date: Thu, 21 Oct 1999 14:25:51 +1000
X-Mailer: KMail [version 1.0.21]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.9910202032260.982-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <99102114373200.00468@argo.linuxcare.com.au>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 21 Oct 1999, Linus Torvalds wrote:

> Ho humm.. I would almost prefer the "struct page" because in theory you
> might want to do it without mapping the page at all. But this is
> definitely a case where most of the time it's only needed with virtual
> caches, so at the same time a virtual address is not necessarily wrong
> either.
> 
> So my preference would be a "struct page", but if you have a stronger
> opinion you can override me with a little argumentation for show, ok?

I don't have a strong opinion about it, I'm quite happy with the struct
page option.  Here is a patch which fixes the places where pre-2.3.23-5
calls flush_page_to_ram with a virtual address (in the generic code; I
haven't tried to fix the places under arch/), plus a thinko in
mm/memory.c.

I have pre-2.3.23-5 running on my PPC (an Apple G3 powerbook) but it
crashes as soon as it starts to use swap, with a kernel bug at
include/linux/pagemap.h:105, in kswapd.  The stack trace is:

add_page_to_inode_queue (inline in add_to_page_cache)
add_to_page_cache
add_to_swap_cache
try_to_swap_out
swap_out_vma
swap_out_mm
swap_out
do_try_to_free_pages
kswapd

Have others seen this problem, or is it a PPC-specific stuff-up of mine? 
:-)

Paul.

diff -urN official/fs/exec.c linux/fs/exec.c
--- official/fs/exec.c	Thu Oct 21 11:57:36 1999
+++ linux/fs/exec.c	Thu Oct 21 13:46:02 1999
@@ -246,7 +246,7 @@
 					memset(kaddr+offset+len, 0, PAGE_SIZE-offset-len);
 			}
 			err = copy_from_user(kaddr + offset, str, bytes_to_copy);
-			flush_page_to_ram(kaddr);
+			flush_page_to_ram(page);
 			kunmap((unsigned long)kaddr, KM_WRITE);
 
 			if (err)
diff -urN official/include/linux/highmem.h linux/include/linux/highmem.h
--- official/include/linux/highmem.h	Thu Oct 21 11:57:38 1999
+++ linux/include/linux/highmem.h	Thu Oct 21 14:01:23 1999
@@ -59,7 +59,7 @@
 		BUG();
 	kaddr = kmap(page, KM_WRITE);
 	memset((void *)(kaddr + offset), 0, size);
-	flush_page_to_ram(kaddr);
+	flush_page_to_ram(page);
 	kunmap(kaddr, KM_WRITE);
 }
 
diff -urN official/kernel/ptrace.c linux/kernel/ptrace.c
--- official/kernel/ptrace.c	Thu Oct 21 11:57:38 1999
+++ linux/kernel/ptrace.c	Thu Oct 21 14:01:22 1999
@@ -52,12 +52,12 @@
 	if (write) {
 		maddr = kmap(page, KM_WRITE);
 		memcpy((char *)maddr + (addr & ~PAGE_MASK), buf, len);
-		flush_page_to_ram(maddr);
+		flush_page_to_ram(page);
 		kunmap(maddr, KM_WRITE);
 	} else {
 		maddr = kmap(page, KM_READ);
 		memcpy(buf, (char *)maddr + (addr & ~PAGE_MASK), len);
-		flush_page_to_ram(maddr);
+		flush_page_to_ram(page);
 		kunmap(maddr, KM_READ);
 	}
 	return len;
diff -urN official/mm/memory.c linux/mm/memory.c
--- official/mm/memory.c	Thu Oct 21 11:57:38 1999
+++ linux/mm/memory.c	Thu Oct 21 14:01:21 1999
@@ -742,7 +742,7 @@
 		__free_page(page);
 		return 0;
 	}
-	flush_page_to_ram(pte_page(page));
+	flush_page_to_ram(page);
 	set_pte(pte, pte_mkwrite(page_pte_prot(page, PAGE_COPY)));
 /* no need for flush_tlb */
 	return page;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
