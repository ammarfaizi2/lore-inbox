Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280789AbRKGNhV>; Wed, 7 Nov 2001 08:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280787AbRKGNhO>; Wed, 7 Nov 2001 08:37:14 -0500
Received: from [212.147.82.109] ([212.147.82.109]:62595 "HELO
	coruscant.solstice.ch") by vger.kernel.org with SMTP
	id <S280789AbRKGNhB>; Wed, 7 Nov 2001 08:37:01 -0500
From: Nicson <nicson@unforgettable.com>
Date: Wed, 7 Nov 2001 13:35:27 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Problem to compile 2.4.14 on x86 (cause: mm/swap.c) : patch included in body
MIME-Version: 1.0
Message-Id: <0111071254290C.00326@padawah>
Content-Transfer-Encoding: 7BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This is my first post on lkml, I tried to do it "by the book" (I read the 
"Unofficial Linus HOWTO" from Jeff Garzik) but may have missed something. My 
apologies if this is the case - and feel free to correct me, could be useful 
next time ;-)

[Disclaimer: I'm not a kernel hacker]

I wanted to compile 2.4.14 on a Dell PowerEdge 2500 with 2x PIII 1GHz, and 
encountered a small problem with the loopback dev. (either included or as a 
module) : the function deactivate_page() was not found.
The exact error message is:
----------------[ start 'make bzImage' output ]-----------------
[...]
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x87af): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0x87f9): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1                                                   
----------------[ end 'make bzImage' output ]-----------------

I tried it also on another x86 box (PIII-UP), same problem.

I traced it back to mm/swap.c and include/linux/swap.h
On 2.4.13 the function deactivate_page() is present in mm/swap.c, but not in 
2.4.14

I just added it (and the relevant declaration in include/linux/swap.h), and 
tried compiling 2.4.14 with this modification ---> problem fixed on both 
systems.

I couldn't find exactly who's the maintainer for this section of the kernel 
(and didn't want to bother Linus with something that trivial), so I post this 
on lkml in hope the person-in-charge will see it. I do not read lkml (just 
Kernel-Traffic, thanx Zack Brown for the great job!) so maybe someone else 
already submitted a patch for this bug.

Anyway, here is the small patch (made with diff -urN). It's basically only 
cut&paste stuff :
------------------------------[ cut here ]-------------------------------
diff -urN linux/include/linux/swap.h linux-2.4.14-patched/include/linux/swap.h
--- linux/include/linux/swap.h  Mon Nov  5 21:42:13 2001
+++ linux-2.4.14-patched/include/linux/swap.h   Wed Nov  7 13:17:48 2001
@@ -105,6 +105,7 @@
 extern void FASTCALL(__lru_cache_del(struct page *));
 extern void FASTCALL(lru_cache_del(struct page *));
 
+extern void FASTCALL(deactivate_page(struct page *));
 extern void FASTCALL(activate_page(struct page *));
 
 extern void swap_setup(void);
diff -urN linux/mm/swap.c linux-2.4.14-patched/mm/swap.c
--- linux/mm/swap.c     Sun Nov  4 19:29:49 2001
+++ linux-2.4.14-patched/mm/swap.c      Wed Nov  7 13:17:26 2001
@@ -33,6 +33,32 @@
        8,      /* do swap I/O in clusters of this size */
 };
 
+/**
+ * (de)activate_page - move pages from/to active and inactive lists
+ * @page: the page we want to move
+ * @nolock - are we already holding the pagemap_lru_lock?
+ *
+ * Deactivate_page will move an active page to the right
+ * inactive list, while activate_page will move a page back
+ * from one of the inactive lists to the active list. If
+ * called on a page which is not on any of the lists, the
+ * page is left alone.
+ */
+static inline void deactivate_page_nolock(struct page * page)
+{
+       if (PageActive(page)) {
+               del_page_from_active_list(page);
+               add_page_to_inactive_list(page);
+       }
+}
+
+void deactivate_page(struct page * page)
+{
+       spin_lock(&pagemap_lru_lock);
+       deactivate_page_nolock(page);
+       spin_unlock(&pagemap_lru_lock);                                       
+}
+
 /*
  * Move an inactive page to the active list.
  */                                                                          
-------------------------------[ cut here ]-------------------------


Hope this helps...

Cheers!
--
Nicolas Ouedraogo
email: nicson@unforgettable.com

