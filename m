Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUDFMv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUDFMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:50:18 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:18091 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263800AbUDFMt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:49:57 -0400
Date: Tue, 06 Apr 2004 21:50:08 +0900 (JST)
Message-Id: <20040406.215008.83497719.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [patch 6/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406.214123.129013798.taka@valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	<20040406.214123.129013798.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 6 of memory hotplug patches for hugetlbpages.

$Id: va-hugepageproc.patch,v 1.7 2004/04/05 06:46:16 iwamoto Exp $

--- linux-2.6.4.ORG/mm/page_alloc.c	Thu Apr  1 18:32:34 2032
+++ linux-2.6.4/mm/page_alloc.c	Thu Apr  1 18:32:44 2032
@@ -1989,6 +1989,8 @@ int min_free_kbytes_sysctl_handler(ctl_t
 }
 
 #ifdef CONFIG_MEMHOTPLUG
+extern int mhtest_hpage_read(char *p, int, int);
+
 static int mhtest_read(char *page, char **start, off_t off, int count,
     int *eof, void *data)
 {
@@ -2012,9 +2014,15 @@ static int mhtest_read(char *page, char 
 				/* skip empty zone */
 				continue;
 			len = sprintf(p,
-			    "\t%s[%d]: free %ld, active %ld, present %ld\n",
+			    "\t%s[%d]: free %ld, active %ld, present %ld",
 			    z->name, NODEZONE(i, j),
 			    z->free_pages, z->nr_active, z->present_pages);
+			p += len;
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_MEMHOTPLUG)
+			len = mhtest_hpage_read(p, i, j);
+			p += len;
+#endif
+			len = sprintf(p, "\n");
 			p += len;
 		}
 	}
--- linux-2.6.4.ORG/arch/i386/mm/hugetlbpage.c	Thu Apr  1 18:30:33 2032
+++ linux-2.6.4/arch/i386/mm/hugetlbpage.c	Thu Apr  1 18:32:44 2032
@@ -846,6 +846,24 @@ int remap_hugetlb_pages(struct zone *zon
 }
 #endif /* CONFIG_MEMHOTPLUG */
 
+#ifdef CONFIG_MEMHOTPLUG
+int mhtest_hpage_read(char *p, int nodenum, int zonenum)
+{
+	struct page *page;
+	int total = 0;
+	int free = 0;
+	spin_lock(&htlbpage_lock);
+	list_for_each_entry(page, &hugepage_alllists[nodenum], list) {
+		if (page_zonenum(page) == zonenum) total++;
+	}
+	list_for_each_entry(page, &hugepage_freelists[nodenum], list) {
+		if (page_zonenum(page) == zonenum) free++;
+	}
+	spin_unlock(&htlbpage_lock);
+	return sprintf(p, " / HugePage free %d, total %d\n", free, total);
+}
+#endif
+
 int hugetlb_sysctl_handler(ctl_table *table, int write,
 		struct file *file, void *buffer, size_t *length)
 {
