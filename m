Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318232AbSHKHnE>; Sun, 11 Aug 2002 03:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318228AbSHKH0p>; Sun, 11 Aug 2002 03:26:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30982 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317911AbSHKHY7>;
	Sun, 11 Aug 2002 03:24:59 -0400
Message-ID: <3D56147E.15E7A98@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/21] fix ARCH_HAS_PREFETCH
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



include/linux/prefetch.h does a strange thing: if the arch doesn't have
the prefectch functions, this header defines no-op version of them and
then defines ARCH_HAS_PREFETCH.  So there's no way for mainline code to
know if the architecture *really* has prefetch instructions.

This information loss is unfortunate.  Examples:

	for (i = 0; i < N; i++)
		prefetch(foo[i]);

   Problem is, if `prefetch' is a no-op, the compiler will still
   generate an empty busy-wait loop.  Which it must do.  We need to
   know the truth about ARCH_HAS_PREFETCH to correctly elide that loop.


#ifdef ARCH_HAS_PREFETCH
#define prefetch_prev_lru_page(_page, _base, _field)                    \
        do {                                                            \
                if ((_page)->lru.prev != _base) {                       \
                        struct page *prev;                              \
                                                                        \
                        prev = list_entry(_page->lru.prev,              \
                                        struct page, lru);              \
                        prefetch(&prev->_field);                        \
                }                                                       \
        } while (0)
#else
#define prefetch_prev_lru_page(_page, _base, _field) do { } while (0)
#endif

Which needs a working ARCH_HAS_PREFETCH to avoid probable extra code
generation on CPUs which don't have prefetch.




 prefetch.h |    3 ---
 1 files changed, 3 deletions(-)

--- 2.5.31/include/linux/prefetch.h~arch_has_prefetchw	Sun Aug 11 00:20:08 2002
+++ 2.5.31-akpm/include/linux/prefetch.h	Sun Aug 11 00:20:08 2002
@@ -39,17 +39,14 @@
  */
  
 #ifndef ARCH_HAS_PREFETCH
-#define ARCH_HAS_PREFETCH
 static inline void prefetch(const void *x) {;}
 #endif
 
 #ifndef ARCH_HAS_PREFETCHW
-#define ARCH_HAS_PREFETCHW
 static inline void prefetchw(const void *x) {;}
 #endif
 
 #ifndef ARCH_HAS_SPINLOCK_PREFETCH
-#define ARCH_HAS_SPINLOCK_PREFETCH
 #define spin_lock_prefetch(x) prefetchw(x)
 #endif
 

.
