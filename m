Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTDPC3J (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 22:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbTDPC3J 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 22:29:09 -0400
Received: from holomorphy.com ([66.224.33.161]:31880 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264210AbTDPC3I 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 22:29:08 -0400
Date: Tue, 15 Apr 2003 19:40:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-ID: <20030416024036.GK706@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030416022154.GF12487@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416022154.GF12487@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 07:21:54PM -0700, William Lee Irwin III wrote:
> follow_hugetlb_page() behaved improperly if its starting address was
> not hugepage-aligned. It looked a bit unclean too, so I rewrote it.
> This fixes a bug, and more importantly, makes the thing readable by
> something other than a compiler (e.g. programmers).

And this one fixes an overflow when there is more than 4GB of hugetlb:


diff -urpN htlb-2.5.67-bk6-1/arch/i386/mm/hugetlbpage.c htlb-2.5.67-bk6-2/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.67-bk6-1/arch/i386/mm/hugetlbpage.c	2003-04-15 18:58:07.000000000 -0700
+++ htlb-2.5.67-bk6-2/arch/i386/mm/hugetlbpage.c	2003-04-15 19:25:30.000000000 -0700
@@ -482,9 +482,7 @@ int hugetlb_report_meminfo(char *buf)
 
 int is_hugepage_mem_enough(size_t size)
 {
-	if (size > (htlbpagemem << HPAGE_SHIFT))
-		return 0;
-	return 1;
+	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem;
 }
 
 /*
