Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRCLL6r>; Mon, 12 Mar 2001 06:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCLL6h>; Mon, 12 Mar 2001 06:58:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:40135 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129725AbRCLL6Z>;
	Mon, 12 Mar 2001 06:58:25 -0500
Date: Mon, 12 Mar 2001 11:55:29 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Tweedie <sct@redhat.com>
Subject: Re: BUG? race between kswapd and ptrace (access_process_vm )
Message-ID: <20010312115529.D20724@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103071356140.1409-100000@duckman.distro.conectiva> <3AA7E7C4.4D89E280@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AA7E7C4.4D89E280@colorfullife.com>; from manfred@colorfullife.com on Thu, Mar 08, 2001 at 09:12:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Mar 08, 2001 at 09:12:52PM +0100, Manfred Spraul wrote:
> > 
> Fixing the bug is more difficult than I thought:
> 
> Initially I assumed it would be a two-liner (lock, unlock) but kmap()
> can sleep.
> 
> Can I reuse a kmap_atomic() type or should I add a new type?

I've just tried with the patch below and it seems fine.  You don't
need to hold the spinlock over the kmap() call: you only need to hold
a reference to the page.

Cheers,
 Stephen

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ptrace-fix.diff"

--- linux-2.4.2-ac18/kernel/ptrace.c.~1~	Thu Nov  9 03:01:34 2000
+++ linux-2.4.2-ac18/kernel/ptrace.c	Mon Mar 12 11:32:30 2001
@@ -28,6 +28,7 @@
 	struct page *page;
 
 repeat:
+	spin_lock(&mm->page_table_lock);
 	pgdir = pgd_offset(vma->vm_mm, addr);
 	if (pgd_none(*pgdir))
 		goto fault_in_page;
@@ -47,9 +48,13 @@
 
 	/* ZERO_PAGE is special: reads from it are ok even though it's marked reserved */
 	if (page != ZERO_PAGE(addr) || write) {
-		if ((!VALID_PAGE(page)) || PageReserved(page))
+		if ((!VALID_PAGE(page)) || PageReserved(page)) {
+			spin_unlock(&mm->page_table_lock);
 			return 0;
+		}
 	}
+	get_page(page);
+	spin_unlock(&mm->page_table_lock);
 	flush_cache_page(vma, addr);
 
 	if (write) {
@@ -64,19 +69,23 @@
 		flush_page_to_ram(page);
 		kunmap(page);
 	}
+	put_page(page);
 	return len;
 
 fault_in_page:
+	spin_unlock(&mm->page_table_lock);
 	/* -1: out of memory. 0 - unmapped page */
 	if (handle_mm_fault(mm, vma, addr, write) > 0)
 		goto repeat;
 	return 0;
 
 bad_pgd:
+	spin_unlock(&mm->page_table_lock);
 	pgd_ERROR(*pgdir);
 	return 0;
 
 bad_pmd:
+	spin_unlock(&mm->page_table_lock);
 	pmd_ERROR(*pgmiddle);
 	return 0;
 }

--sm4nu43k4a2Rpi4c--
