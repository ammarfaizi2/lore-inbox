Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSCIAT5>; Fri, 8 Mar 2002 19:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSCIATr>; Fri, 8 Mar 2002 19:19:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291547AbSCIATl>;
	Fri, 8 Mar 2002 19:19:41 -0500
Message-ID: <3C8954B3.2543A503@zip.com.au>
Date: Fri, 08 Mar 2002 16:17:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Dave Hansen <haveblue@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C8932CC.761C8829@zip.com.au>,
		<3C880EFF.A0789715@zip.com.au>,	<3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au> <17920000.1015622098@flay> <3C8932CC.761C8829@zip.com.au> <67550000.1015632244@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> ..
> > If the page_cache_release() in truncate_complete_page() is calling
> > __free_pages_ok() then something really horrid has happened.
> 
> That's exactly what's happening.
> 
> > Yes, it could be that the page has had its refcount incorrectly
> > decremented somewhere.
> 
> I don't see you need that to make this bug happen.
> Say count is 0 when we enter truncate_list_pages.

It mustn't be zero!  The page is *known* to be in the pagecache,
so its count must be at least 1.

> We increment it.
> It's now 1 when we call page_cache_release.
> put_page_testzero dec's it back to 0, and returns true.
> We do a __free_pages_ok. Page is still locked. BUG.
> 
> No other process, nothing funky happening, no races, no other
> refcount decrements. Or that's the way I read it.
> 
> > Or the page wasn't in the pagecache at all.
> 
> The only thing I can think of was the pagecount shouldn't have been 0
> to start with (or the code path we're reading is wrong ;-) )

yup.  You can stick an

	if (page_count(page) == 0)
		BUG();

at the top of truncate_list_pages...

Actually it might help to add some extra checks to
page_cache_release():

1: If the page is in the pagecache, that's one.
2: If the page has buffers, that's another.

so 

  void page_cache_release(struct page *page)  
  {
+	int expected = 0;
+
+	if (page->buffers)
+		expected++;
+	if (page->mapping) {
+		if (!list_empty(page->list))
+			BUG();
+		expected++;
+	}
+
+	expected++;	/* The caller has a ref too */
+
+	if (page_count(page) < expected)
+		BUG();
+
        if (!PageReserved(page) && put_page_testzero(page)) {
                if (PageLRU(page))
                        lru_cache_del(page);
                __free_pages_ok(page, 0);
        }
  }

The list_empty() check will require that remove_page_from_inode_queue()
use list_del_init() instead of list_del().

The above code (untested, and racy as hell on SMP and preempt) may
catch whoever is droppng the refcount at the wrong time.

-
