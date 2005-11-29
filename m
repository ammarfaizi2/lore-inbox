Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVK2FSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVK2FSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 00:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVK2FSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 00:18:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbVK2FSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 00:18:20 -0500
Date: Mon, 28 Nov 2005 21:18:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: torvalds@osdl.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Fix crash when ptrace poking hugepage areas
Message-Id: <20051128211807.66817481.akpm@osdl.org>
In-Reply-To: <20051129050628.GB12498@localhost.localdomain>
References: <20051129050628.GB12498@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> Bill, does this look like the correct fix for the problem to you?  If
> so, please apply Andrew.
> 
> set_page_dirty() will not cope with being handed a page * which is
> part of a compound page, but not the master page in that compound
> page.  This case can occur via access_process_vm() if you attempt to
> write to another process's hugepage memory area using ptrace()
> (causing an oops or hang).
> 
> This patch fixes the bug by first resolving the page * to the compound
> page's master page.

We already have to handle this situation for direct-io read()s into
hugepages.  bio_set_pages_dirty() does

		if (page && !PageCompound(page))
			set_page_dirty_lock(page);

It's such a rare case that it's probably best to continue to do this in the
caller rather than in the callee.  That's access_process_vm().

Unless there's a reason why we actually want the compound page to be marked
dirty?  If there is, then direct-io has a problem.  
