Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbSKUXrR>; Thu, 21 Nov 2002 18:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbSKUXrR>; Thu, 21 Nov 2002 18:47:17 -0500
Received: from holomorphy.com ([66.224.33.161]:33923 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267219AbSKUXrQ>;
	Thu, 21 Nov 2002 18:47:16 -0500
Date: Thu, 21 Nov 2002 15:51:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rohit Seth <rseth@unix-os.sc.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       torvalds@transmeta.com, rohit.seth@intel.com
Subject: Re: hugetlb page patch for 2.5.48-bug fixes
Message-ID: <20021121235127.GS23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rohit Seth <rseth@unix-os.sc.intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@digeo.com,
	torvalds@transmeta.com, rohit.seth@intel.com
References: <3DDD58C1.9020503@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD58C1.9020503@unix-os.sc.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 02:05:53PM -0800, Rohit Seth wrote:
> Linus, Andrew,
> Attached is the hugetlbpage patch for 2.5.48 containing following main 
> changes:
> 1) Bug fixes (mainly in the unsuccessful attempts of hugepages).
> 2) Removal of Radix Tree field in key structure (as it is not needed).
> 3) Include the IPC_LOCK for permission to use hugepages.
> 4) Increment the key_counts during forks.

Okay, first off why are you using a list linked through page->private?
page->list is fully available for such tasks.

Second, the if (key == NULL) check in hugetlb_release_key() is bogus;
someone is forgetting to check for NULL, probably in
alloc_shared_hugetlb_pages().

Third, the hugetlb_release_key() in unmap_hugepage_range() is the one
that should be removed [along with its corresponding mark_key_busy()],
not the one in sys_free_hugepages(). unmap_hugepage_range() is doing
neither setup nor teardown of the key itself, only the pages and PTE's.
I would say key-level refcounting belongs to sys_free_hugepages().

Bill
