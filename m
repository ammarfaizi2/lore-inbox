Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWJJJEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWJJJEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWJJJEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:04:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965109AbWJJJEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:04:33 -0400
Date: Tue, 10 Oct 2006 02:04:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Chen@ozlabs.org, Kenneth W <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepage regression
Message-Id: <20061010020426.4d597be2.akpm@osdl.org>
In-Reply-To: <20061010084748.GE18681@localhost.localdomain>
References: <20061010084748.GE18681@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 18:47:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> It seems commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes a
> hugepage regression.  A git bisect points the finger at that commit
> for causing an oops in the 'alloc-instantiate-race' test from the
> libhugetlbfs testsuite.
> 
> Still looking to determine the reason it breaks things.
> 

It's assuming that unmap_hugepage_range() is always freeing these pages. 
If the page is shared by another mapping, bad things will happen: the
threads fight over page->lru.

Doing

+	if (page_count(page) == 1)
		list_add(&page->lru, &page_list);

might help.  But then we miss the tlb flush in rare racy conditions.
