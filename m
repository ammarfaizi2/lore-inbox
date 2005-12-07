Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVLGLwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVLGLwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVLGLwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:52:43 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:60347 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750903AbVLGLwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:52:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: how much memory to free? [was Re: swsusp performance problems in 2.6.15-rc3-mm1]
Date: Wed, 7 Dec 2005 12:53:53 +0100
User-Agent: KMail/1.9
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20051205081935.GI22168@hexapodia.org> <200512052218.18769.rjw@sisk.pl> <20051205235501.GC1770@elf.ucw.cz>
In-Reply-To: <20051205235501.GC1770@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071253.54055.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 6 December 2005 00:55, Pavel Machek wrote:
}-- snip --{
> > OTOH, we can get similar result by just making the kernel free some
> > more memory _after_ we are sure we have enough memory to suspend.
> > IOW, after the code that's currently in swsusp_shrink_memory() has finished,
> > we can try to free some "extra" memory to improve performance, if
> > needed.  The question is how much "extra" memory should be freed and
> > I'm afraid it will have to be tuned on the per-system, or at least
> > per-RAM-size, basis.
> 
> I'd prefer not to have extra tunables. "Write only 500MB" will work
> okay for common desktop users -- as long as common desktop fits into
> 500MB, that is. "Free not used in last 10 minutes" should work okay
> for everyone, but may be slightly harder to implement.

Still, it can be done with a fairly small patch that has an additional
advantage, as it allows us to get rid of the FAST_FREE constant
which I don't like.  Appended (untested).

Greetings,
Rafael


 kernel/power/power.h  |    8 +++-----
 kernel/power/swsusp.c |   16 ++++++++--------
 2 files changed, 11 insertions(+), 13 deletions(-)

Index: linux-2.6.15-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/power.h	2005-12-05 22:07:12.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/power.h	2005-12-07 12:45:04.000000000 +0100
@@ -53,12 +53,10 @@
 extern struct pbe *pagedir_nosave;
 
 /*
- * This compilation switch determines the way in which memory will be freed
- * during suspend.  If defined, only as much memory will be freed as needed
- * to complete the suspend, which will make it go faster.  Otherwise, the
- * largest possible amount of memory will be freed.
+ * Preferred image size in MB (set it to zero to get the smallest
+ * image possible)
  */
-#define FAST_FREE	1
+#define IMAGE_SIZE	500
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-05 22:07:12.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-07 12:40:27.000000000 +0100
@@ -626,6 +626,7 @@
 
 int swsusp_shrink_memory(void)
 {
+	unsigned long size;
 	long tmp;
 	struct zone *zone;
 	unsigned long pages = 0;
@@ -634,11 +635,11 @@
 
 	printk("Shrinking memory...  ");
 	do {
-#ifdef FAST_FREE
-		tmp = 2 * count_highmem_pages();
-		tmp += tmp / 50 + count_data_pages();
-		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
+		size = 2 * count_highmem_pages();
+		size += size / 50 + count_data_pages();
+		size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
+		tmp = size;
 		for_each_zone (zone)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
@@ -647,11 +648,10 @@
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
+		} else if (size > (IMAGE_SIZE * 1024 * 1024) / PAGE_SIZE) {
+			tmp = shrink_all_memory(SHRINK_BITE);
+			pages += tmp;
 		}
-#else
-		tmp = shrink_all_memory(SHRINK_BITE);
-		pages += tmp;
-#endif
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
 	printk("\bdone (%lu pages freed)\n", pages);


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
