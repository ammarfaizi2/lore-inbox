Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUDBKYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUDBKYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:24:51 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:41737 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263578AbUDBKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:24:49 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Date: Fri, 2 Apr 2004 12:21:15 +0200
User-Agent: KMail/1.6.1
Cc: Christoph Hellwig <hch@infradead.org>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com, vrajesh@umich.edu,
       linux-mm@kvack.org
References: <20040402001535.GG18585@dualathlon.random> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org>
In-Reply-To: <20040402104334.A871@infradead.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404021221.15197@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 11:43, Christoph Hellwig wrote:

Hi Christoph,

> I got lots of the following OOPSEs with 2.6.5-rc3aa2 on a powerpc running
> the xfs testsuite (with the truncate fix applied):

What truncate fix? Sorry if I missed that.

dunno if the below is causing your trouble, but is that intentional that 
page_cache_release(page) is called twice?

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} 
--exclude .arch-ids 2.6.5-rc3/mm/page_io.c xx/mm/page_io.c
--- 2.6.5-rc3/mm/page_io.c      2002-12-15 04:18:17.000000000 +0100
+++ xx/mm/page_io.c     2004-04-02 05:32:57.381688904 +0200
@@ -161,7 +176,13 @@ int rw_swap_page_sync(int rw, swp_entry_
                ret = swap_writepage(page, &swap_wbc);
                wait_on_page_writeback(page);
        }
-       page->mapping = NULL;
+
+       lock_page(page);
+       remove_from_page_cache(page);
+       unlock_page(page);
+       page_cache_release(page);
+       page_cache_release(page);       /* For add_to_page_cache() */



ciao, Marc
