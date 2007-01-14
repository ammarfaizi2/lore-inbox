Return-Path: <linux-kernel-owner+w=401wt.eu-S1751089AbXANEAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbXANEAK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 23:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbXANEAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 23:00:10 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:41816 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751089AbXANEAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 23:00:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uXAErWQY4OOBYZwI/5jegdmZvv3A8Xp1VRFAdA8/YzTGt9o/a0fMCna2cgYcNOb89ZtbSmPofksUMK1BzfUKbhW4KDpOAvCDbxwxlKHafyc7CtCez9j1u/5mAipIAjfY3saE3cWJrg6p5CmhD34hMEurw0xq0WR7e+kSH6K3+Cw=  ;
X-YMail-OSG: 61FUd9MVM1nzoKUlNXt69aroH7R4IqZ1qTn3OHnaOm2owbgc6n4GWtJ0C_1PRIUYkDz2zjFgWefAA7sUHXAoUP2ZJKz44njJtQpv4eso7W6QEq60HXudrdUG_ap4mCtO.2i3TyJIW955ln4-
Message-ID: <45A9AAAB.2090008@yahoo.com.au>
Date: Sun, 14 Jan 2007 14:59:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 10/10] mm: fix pagecache write deadlocks
References: <20070113011159.9449.4327.sendpatchset@linux.site> <20070113011334.9449.61323.sendpatchset@linux.site>
In-Reply-To: <20070113011334.9449.61323.sendpatchset@linux.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> @@ -1878,31 +1889,88 @@ generic_file_buffered_write(struct kiocb
>  			break;
>  		}
>  
> +		/*
> +		 * non-uptodate pages cannot cope with short copies, and we
> +		 * cannot take a pagefault with the destination page locked.
> +		 * So pin the source page to copy it.
> +		 */
> +		if (!PageUptodate(page)) {
> +			unlock_page(page);
> +
> +			bytes = min(bytes, PAGE_CACHE_SIZE -
> +				     ((unsigned long)buf & ~PAGE_CACHE_MASK));
> +
> +			/*
> +			 * Cannot get_user_pages with a page locked for the
> +			 * same reason as we can't take a page fault with a
> +			 * page locked (as explained below).
> +			 */
> +			status = get_user_pages(current, current->mm,
> +					(unsigned long)buf & PAGE_CACHE_MASK, 1,
> +					0, 0, &src_page, NULL);

Thinko... get_user_pages needs to be called with mmap_sem held, obviously.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
