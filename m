Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVLBWxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVLBWxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVLBWxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:53:40 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:24482 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751034AbVLBWxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:53:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Date: Fri, 2 Dec 2005 23:54:43 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20051202183748.GA12584@hexapodia.org> <200512022302.48734.rjw@sisk.pl>
In-Reply-To: <200512022302.48734.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512022354.43750.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

On Friday, 2 of December 2005 23:02, Rafael J. Wysocki wrote:
> On Friday, 2 of December 2005 19:37, Andy Isaacson wrote:
> > On Thu, Dec 01, 2005 at 10:42:44PM +0100, Rafael J. Wysocki wrote:
> > > On Thursday, 1 of December 2005 18:36, Andy Isaacson wrote:
> > > > My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> > > > 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> > > > successful suspend/resume cycles.  But now that I'm running
> > > > 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:
> > > 
> > > Thanks a lot for the report.
> > > 
> > > The problem is apparently caused by my recent patch intended to speed up
> > > suspend.  Could you please apply the appended debug patch, try to reproduce
> > > the problem and send full dmesg output back to me?
> > 
> > Here you go.  This is two suspends; the first one completed
> > successfully, then I triggered a failure by starting a bunch of
> > processes until highmem looked full.  (Just firefox wasn't enough, so I
> > started a bunch of vim -R sessions on a 50MB file until HighFree went
> > under 1MB.)
> 
}-- snip --{
> I'm working on a patch.

Could you please apply the appended one and see if it fixes the issue?
It's on top of the previous one.

It's been compile-tested, but I have no machine with highmem to really
test it.

Greetings,
Rafael


Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-02 22:02:50.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-02 23:45:13.000000000 +0100
@@ -37,6 +37,12 @@
 unsigned int nr_copy_pages;
 
 #ifdef CONFIG_HIGHMEM
+struct highmem_page {
+	char *data;
+	struct page *page;
+	struct highmem_page *next;
+};
+
 unsigned int count_highmem_pages(void)
 {
 	struct zone *zone;
@@ -52,22 +58,27 @@
 				if (!pfn_valid(pfn))
 					continue;
 				page = pfn_to_page(pfn);
-				if (PageReserved(page))
-					continue;
-				if (PageNosaveFree(page))
-					continue;
-				n++;
+				if (!PageNosaveFree(page) && !PageReserved(page))
+					n++;
 			}
 		}
+	if (n > 0) {
+		unsigned int size = sizeof(struct highmem_page);
+
+#define CACHE(x) \
+		if (sizeof(struct highmem_page) <= x) { \
+			size = x; \
+			goto found; \
+		}
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
+found:
+		printk("count_highmem_pages(): size = %u\n", size);
+		n += (n * size + PAGE_SIZE - 1) / PAGE_SIZE + 1;
+	}
 	return n;
 }
 
-struct highmem_page {
-	char *data;
-	struct page *page;
-	struct highmem_page *next;
-};
-
 static struct highmem_page *highmem_copy;
 
 static int save_highmem_zone(struct zone *zone)
Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-01 22:24:56.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-02 23:34:48.000000000 +0100
@@ -637,7 +637,7 @@
 #ifdef FAST_FREE
 		tmp = count_data_pages();
 		printk("Data pages: %ld\n", tmp);
-		tmp += count_highmem_pages();
+		tmp += 2 * count_highmem_pages();
 		printk("Data and highmem pages: %ld\n", tmp);
 		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
