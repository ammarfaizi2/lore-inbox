Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVCHJ2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVCHJ2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVCHJ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:28:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261926AbVCHJ2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:28:40 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050307155001.099352b5.akpm@osdl.org>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
	 <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307131113.0fd7477e.akpm@osdl.org>
	 <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307155001.099352b5.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110274110.1941.5.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 08 Mar 2005 09:28:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-03-07 at 23:50, Andrew Morton wrote:

> truncate_inode_pages_range() seems to dtrt here.  Can we do it in the same
> manner in invalidate_inode_pages2_range()?
> 
> 
> Something like:

> -			if (page->mapping != mapping || page->index > end) {
> +			page_index = page->index;
> +			if (page_index > end) {
> +				next = page_index;
> +				unlock_page(page);
> +				break;
> +			}
> +			if (page->mapping != mapping) {
>  				unlock_page(page);
>  				continue;
>  			}

Yes, breaking early seems fine for this.  But don't we need to test
page->mapping == mapping again with the page lock held before we can
reliably break on page_index?

I think it should be OK just to move the page->mapping != mapping test
above the page>index > end test.  Sure, if all the pages have been
stolen by the time we see them, then we'll repeat without advancing
"next"; but we're still making progress in that case because pages that
were previously in this mapping *have* been removed, just by a different
process.  If we're really concerned about that case we can play the
trick that invalidate_mapping_pages() tries and do a "next++" in that
case.

--Stephen

