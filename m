Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUGAF3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUGAF3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 01:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUGAF3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 01:29:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10880 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263980AbUGAF3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 01:29:09 -0400
Subject: Re: [Lhms-devel] new memory hotremoval patch
From: Dave Hansen <haveblue@us.ibm.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040701030543.8CE8F70A92@sv1.valinux.co.jp>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
	 <1088640671.5265.1017.camel@nighthawk>
	 <20040701030543.8CE8F70A92@sv1.valinux.co.jp>
Content-Type: text/plain
Message-Id: <1088659723.10720.3.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 22:28:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 20:05, IWAMOTO Toshihiro wrote:
> At Wed, 30 Jun 2004 17:11:11 -0700,
> Dave Hansen wrote:
> > 
> > On Wed, 2004-06-30 at 04:17, IWAMOTO Toshihiro wrote:
> > > Due to struct page changes, page->mapping == NULL predicate can no
> > > longer be used for detecting cancellation of an anonymous page
> > > remapping operation.  So the PG_again bit is being used again.
> > > It may be still possible to kill the PG_again bit, but the priority is
> > > rather low.
> > 
> > But, you reintroduced it everywhere, including file-backed pages, not
> > just for anonymous pages?  Why was this necessary?
> 
> Which PG_again check are you talking about?
> I think BUG_ON()s in file backed page codes should be kept for now.

I'm referring to all of the code segments like this:
        
        +       if (PageAgain(page)) {
        +               unlock_page(page);
        +               page_cache_release(page);
        +               goto again;
        +       }
        +       BUG_ON(PageAgain(page));
        
For any page that's in the page cache that you want to remove, simply
take the page lock, overwrite page->mapping, and the page cache code
will take care of the rest, no PG_again needed.  

> For swap pages, one possibility to reserve a special swap entry
> constant (SWAP_AGAIN) and check page->private instead of PageAgain
> check, but I'm not sure if this is a good idea.
> 
> #define	SWAP_AGAIN	~0UL

Do you mean pages in the swap cache?

-- Dave

