Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWCGUxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWCGUxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWCGUxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:53:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751526AbWCGUxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:53:14 -0500
Date: Tue, 7 Mar 2006 12:51:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.16-rc5-mm3
Message-Id: <20060307125122.5f7d3462.akpm@osdl.org>
In-Reply-To: <440DEF75.9060802@mbligh.org>
References: <20060307021929.754329c9.akpm@osdl.org>
	<440DEF0A.3030701@mbligh.org>
	<440DEF75.9060802@mbligh.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@mbligh.org> wrote:
>
> Martin Bligh wrote:
> > Andrew Morton wrote:
> > 
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/ 
> >>
> >>
> >> - A relatively small number of changes, although we're up to 9MB of diff
> >>   in the various git trees.
> > 
> > 
> > E_NOT_COMPILING ;-) i386+NUMA at least
> > 
> > NUMA-Q + 
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
> > =
> > http://test.kernel.org/24793/debug/test.log.0
> > mm/built-in.o(.text+0x178dc): In function `check_huge_range':
> > mm/mempolicy.c:1832: undefined reference to `huge_pte_offset'
> > make: *** [.tmp_vmlinux1] Error 1
> > 03/07/06-12:25:56 Build the kernel. Failed rc = 2
> > 03/07/06-12:25:56 build: kernel build Failed rc = 1
> > 03/07/06-12:25:56 command complete: (2) rc=126
> > 
> > Much the same error on x440 +
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
> > =
> > http://test.kernel.org/24791/debug/test.log.0
> 
> Oh, BTW ... I see that's also broken in -git9, but not -git8.
> 
> Presumably something didn't go via -mm for testing?
> 

No, it's just that we suck.  The numa-maps update got squeezed in at the
last minute.

I guess we do it this way - there's still code in there which will call
check_huge_range(), but it's inside if (0) {}.



--- devel/mm/mempolicy.c~numa_maps-update-fix	2006-03-07 12:48:38.000000000 -0800
+++ devel-akpm/mm/mempolicy.c	2006-03-07 12:49:22.000000000 -0800
@@ -1789,6 +1789,7 @@ static void gather_stats(struct page *pa
 	cond_resched();
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
 static void check_huge_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end,
 		struct numa_maps *md)
@@ -1814,6 +1815,7 @@ static void check_huge_range(struct vm_a
 		gather_stats(page, md, pte_dirty(*ptep));
 	}
 }
+#endif
 
 int show_numa_map(struct seq_file *m, void *v)
 {
_

