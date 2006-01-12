Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWALAlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWALAlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWALAlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:41:16 -0500
Received: from fmr23.intel.com ([143.183.121.15]:55177 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964869AbWALAlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:41:15 -0500
Message-Id: <200601120040.k0C0ebg02818@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
Date: Wed, 11 Jan 2006 16:40:37 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYW/itjjO67zSDSTmaloBqyhdrYxAAEX1pQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1137018263.9672.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Wednesday, January 11, 2006 2:24 PM
> > here).  The patch doesn't completely close the race (there is a much
> > smaller window without the zeroing though).  The next patch should close
> > the race window completely.
> 
> My only concern is if I am using the correct lock for the job here.

I don't think so.


> @@ -454,26 +455,31 @@ int hugetlb_no_page(struct mm_struct *mm
>  	 * Use page lock to guard against racing truncation
>  	 * before we get page_table_lock.
>  	 */
> -retry:
>  	page = find_lock_page(mapping, idx);
>  	if (!page) {
>  		if (hugetlb_get_quota(mapping))
>  			goto out;
> +
> +		if (shared)
> +			spin_lock(&mapping->host->i_lock);
> +		
>  		page = alloc_unzeroed_huge_page(vma, address);
>  		if (!page) {
>  			hugetlb_put_quota(mapping);
> +			if (shared)
> +				spin_unlock(&mapping->host->i_lock);
>  			goto out;
>  		}

What if two processes fault on the same page and races with find_lock_page(),
both find page not in the page cache.  The process won the race proceed to
allocate last hugetlb page.  While the other will exit with SIGBUS.  In theory,
both processes should be OK.

- Ken

