Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUHBWQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUHBWQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUHBWQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:16:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39421 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264246AbUHBWQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:16:23 -0400
Date: Tue, 3 Aug 2004 00:16:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.8-rc2-mm2: compile error with SWAP=n
Message-ID: <20040802221612.GO2746@fs.tum.de>
References: <20040802015527.49088944.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 01:55:27AM -0700, Andrew Morton wrote:
>...
> - Added Rik's token-based load control patch.  The VM currently has pretty
>   bad performance problems under heavy swapping loads and this patch speeds up
>   simple tests most impressively.  People who care about these things: please
>   test and measure.
>...
> Changes since 2.6.8-rc2-mm1:
>...
> +token-based-thrashing-control.patch
>...
>  VM load control.
>...

This breaks compilation with CONFIG_SWAP=n:

<--  snip  -->

...
  CC      kernel/fork.o
kernel/fork.c: In function `mmput':
kernel/fork.c:471: warning: implicit declaration of function `put_swap_token'
...
  CC      mm/filemap.o
mm/filemap.c: In function `filemap_nopage':
mm/filemap.c:1250: warning: implicit declaration of function `grab_swap_token'
...
  CC      mm/memory.o
mm/memory.c: In function `do_swap_page':
mm/memory.c:1375: warning: implicit declaration of function `grab_swap_token'
...
  CC      mm/rmap.o
mm/rmap.c: In function `page_referenced_one':
mm/rmap.c:233: warning: implicit declaration of function `has_swap_token'
...
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x1ccf): In function `mmput':
: undefined reference to `put_swap_token'
mm/built-in.o(.text+0x1542): In function `filemap_nopage':
: undefined reference to `grab_swap_token'
mm/built-in.o(.text+0x131c9): In function `page_referenced_one':
: undefined reference to `has_swap_token'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The bug is obvious:


#ifdef CONFIG_SWAP
...
#ifdef CONFIG_SWAP
...
#else
...
#endif
...
#else
...
#endif


Additional, the dummy grab_swap_token and has_swap_token weren't 
correct.


diffstat output:
 include/linux/swap.h |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-mm2-full/include/linux/swap.h.old	2004-08-02 23:16:52.000000000 +0200
+++ linux-2.6.8-rc2-mm2-full/include/linux/swap.h	2004-08-02 23:21:32.000000000 +0200
@@ -204,28 +204,6 @@
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
-/* linux/mm/thrash.c */
-#ifdef CONFIG_SWAP
-extern struct mm_struct * swap_token_mm;
-extern void grab_swap_token(void);
-extern void __put_swap_token(struct mm_struct *);
-
-static inline int has_swap_token(struct mm_struct *mm)
-{
-	return (mm == swap_token_mm);
-}
-
-static inline void put_swap_token(struct mm_struct *mm)
-{
-	if (has_swap_token(mm))
-		__put_swap_token(mm);
-}
-#else /* CONFIG_SWAP */
-#define put_swap_token(x) do { } while(0)
-#define grab_swap_token  do { } while(0)
-#define has_swap_token 0
-#endif /* CONFIG_SWAP */
-
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
@@ -250,6 +228,22 @@
 #define swap_device_lock(p)	spin_lock(&p->sdev_lock)
 #define swap_device_unlock(p)	spin_unlock(&p->sdev_lock)
 
+/* linux/mm/thrash.c */
+extern struct mm_struct * swap_token_mm;
+extern void grab_swap_token(void);
+extern void __put_swap_token(struct mm_struct *);
+
+static inline int has_swap_token(struct mm_struct *mm)
+{
+	return (mm == swap_token_mm);
+}
+
+static inline void put_swap_token(struct mm_struct *mm)
+{
+	if (has_swap_token(mm))
+		__put_swap_token(mm);
+}
+
 #else /* CONFIG_SWAP */
 
 #define total_swap_pages			0
@@ -287,6 +281,11 @@
 	return entry;
 }
 
+/* linux/mm/thrash.c */
+#define put_swap_token(x) do { } while(0)
+#define grab_swap_token()  do { } while(0)
+#define has_swap_token(x) 0
+
 #endif /* CONFIG_SWAP */
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */

