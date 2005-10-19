Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVJSDNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVJSDNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVJSDNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:13:34 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18643 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751481AbVJSDNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:13:33 -0400
From: Takao Indoh <indou.takao@soft.fujitsu.com>
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Cc: akpm@osdl.org, hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Date: Wed, 19 Oct 2005 12:17:02 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 4.51
In-Reply-To: <20051018.224823.03979969.noboru.obata.ar@hitachi.com>
References: <C0C5D30C9A813Cindou.takao@soft.fujitsu.com> 
	<20051018.224823.03979969.noboru.obata.ar@hitachi.com>
Message-Id: <C5C5D45B9312EFindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Oct 2005 22:48:23 +0900 (JST), OBATA Noboru wrote:

>> The 2nd issue (memory size problem) may be solved by exporting
>> diskdump's functions to kdump.
>
>Could you briefly explain the implementation of partial dump in
>diskdump for those who are not familiar with it?
>
>- Levels of partial dump (supported page categories)
>- How to indentify the category (kernel data structure used)

Ok.
Partial dump of diskdump defines 5 filters.

#define DUMP_EXCLUDE_CACHE 0x00000001 /* Exclude LRU & SwapCache pages*/
#define DUMP_EXCLUDE_CLEAN 0x00000002 /* Exclude all-zero pages */
#define DUMP_EXCLUDE_FREE  0x00000004 /* Exclude free pages */
#define DUMP_EXCLUDE_ANON  0x00000008 /* Exclude Anon pages */
#define DUMP_SAVE_PRIVATE  0x00000010 /* Save private pages */

You can select each filters for partialdump. (Therefore, there are 32
levels of partial dump.)

1) DUMP_EXCLUDE_CACHE

This filter uses only page flags of struct page.
If the following condition is true, the page is not dumped.

	!PageAnon(page) && (PageLRU(page) || PageSwapCache(page))

2) DUMP_EXCLUDE_CLEAN

If this filter is enabled, a page which is filled with zero is not
dumped.

3) DUMP_EXCLUDE_FREE

If this filter is enabled, free pages are not dumped. Diskdump find free
pages from free_list of zone->free_area.

4) DUMP_EXCLUDE_ANON

This filter uses only page flags of struct page.
If the following condition is true,  the page is not dumped.

	PageAnon(page)

5) DUMP_SAVE_PRIVATE

This filter is different from others. Even if you specified
DUMP_EXCLUDE_CACHE, a page which has PG_private flag is dumped if this
filter is enabled.



DUMP_EXCLUDE_FREE has some risks. If this filter is enable, diskdump
scans free page linked lists. If the list is corrupt, diskdump may hang.
Therefore, I always use level-19 (EXCLUDE_CACHE & EXCLUDE_CLEAN &
SAVE_PRIVATE).

DUMP_EXCLUDE_CACHE reduces dump size effectively when file caches on
memory are big. I don't use DUMP_EXCLUDE_ANON because user data(user
stack, thread stack, mutex, etc.) is sometimes needed to investigate
dump.
DUMP_SAVE_PRIVATE is needed for filesystem. Filesystem (journal) uses
PG_private pages, so these pages is necessary to investigate
trouble of filesystem. 

If there are other useful filters, please let me know.


These filters may be able to be used for kdump, but I don't know how I
can find the kernel structure (for example, page flag of struct page)
when kdump dumps memory.


Takao Indoh
