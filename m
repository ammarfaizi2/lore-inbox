Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUDMKWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 06:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbUDMKWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 06:22:43 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:48913 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263159AbUDMKWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 06:22:36 -0400
Date: Tue, 13 Apr 2004 11:20:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
cc: kenneth.w.chen@intel.com, raybry@sgi.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: HUGETLB commit handling.
Message-ID: <6480000.1081851647@[192.168.100.2]>
In-Reply-To: <20040408154742.3faf7141.akpm@osdl.org>
References: <15037082.1081445730@42.150.104.212.access.eclipse.net.uk> <20040408154742.3faf7141.akpm@osdl.org>
X-Mailer: Mulberry/3.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 08, 2004 15:47:42 -0700 Andrew Morton <akpm@osdl.org> wrote:

> Andy Whitcroft <apw@shadowen.org> wrote:
>>
>> We have been looking at the HUGETLB page commit issue (offlist) and are
>> close a final merged patch.
>
> Be aware that I've merged a patch from Bill which does all the hugetlb code
> unduplication.  A thousand lines gone:
>
>  25-akpm/arch/i386/mm/hugetlbpage.c    |  264 ----------------------------------
>  25-akpm/arch/ia64/mm/hugetlbpage.c    |  251 --------------------------------
>  25-akpm/arch/ppc64/mm/hugetlbpage.c   |  257 ---------------------------------
>  25-akpm/arch/sh/mm/hugetlbpage.c      |  258 ---------------------------------
>  25-akpm/arch/sparc64/mm/hugetlbpage.c |  259 ---------------------------------
>  25-akpm/fs/hugetlbfs/inode.c          |    2
>  25-akpm/include/linux/hugetlb.h       |    7
>  25-akpm/kernel/sysctl.c               |    6
>  25-akpm/mm/Makefile                   |    1
>  25-akpm/mm/hugetlb.c                  |  245 +++++++++++++++++++++++++++++++
>  10 files changed, 263 insertions(+), 1287 deletions(-)
>
> Of course, this buggers up everyone else's patches, but I do think this
> work has to come first.
>
> I still need to test this on ppc64 and ia64.  I've dropped a rollup against
> 2.6.5 at http://www.zip.com.au/~akpm/linux/patches/stuff/mc3.bz2 which you
> should work against until I get -mc3 out for real.

After bashing my poor bruised head against the screen for a
considerable period I've discovered that memset'ing your IO space
to zero is a very good way to stop your machine dead, silently.
Anyhow, here is a patch against -mc4 to make HUGETLB support actually
work in the presence of memory in ZONE_HIGHMEM.

-apw

=== 8< ===
When clearing a large page allocation ensure we use a page clear function
which will correctly clear a ZONE_HIGHMEM page.

---
 hugetlb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c	2004-04-13 12:10:56.000000000 +0100
+++ current/mm/hugetlb.c	2004-04-13 12:12:20.000000000 +0100
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/sysctl.h>
+#include <linux/highmem.h>

 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
 static unsigned long nr_huge_pages, free_huge_pages;
@@ -66,6 +67,7 @@ void free_huge_page(struct page *page)
 struct page *alloc_huge_page(void)
 {
 	struct page *page;
+	int i;

 	spin_lock(&hugetlb_lock);
 	page = dequeue_huge_page();
@@ -77,7 +79,8 @@ struct page *alloc_huge_page(void)
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	page->lru.prev = (void *)free_huge_page;
-	memset(page_address(page), 0, HPAGE_SIZE);
+	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
+		clear_highpage(&page[i]);
 	return page;
 }





