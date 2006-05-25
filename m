Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWEYLNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWEYLNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 07:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWEYLNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 07:13:18 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:20430 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965083AbWEYLNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 07:13:18 -0400
Message-ID: <348555594.15435@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 19:13:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/33] readahead: support functions
Message-ID: <20060525111318.GH4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469540.21464@ustc.edu.cn> <44753CEC.6090308@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44753CEC.6090308@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:13:16PM +1000, Nick Piggin wrote:
> Wu Fengguang wrote:
> 
> >+#ifdef CONFIG_ADAPTIVE_READAHEAD
> >+
> >+/*
> >+ * The nature of read-ahead allows false tests to occur occasionally.
> >+ * Here we just do not bother to call get_page(), it's meaningless anyway.
> >+ */
> >+static inline struct page *__find_page(struct address_space *mapping,
> >+							pgoff_t offset)
> >+{
> >+	return radix_tree_lookup(&mapping->page_tree, offset);
> >+}
> >+
> >+static inline struct page *find_page(struct address_space *mapping,
> >+							pgoff_t offset)
> >+{
> >+	struct page *page;
> >+
> >+	read_lock_irq(&mapping->tree_lock);
> >+	page = __find_page(mapping, offset);
> >+	read_unlock_irq(&mapping->tree_lock);
> >+	return page;
> >+}
> > 
> >
> 
> Meh, this is just open-coded elsewhere in readahead.c; I'd either
> open code it, or do a new patch to replace the existing callers.
> find_page should be in mm/filemap.c, btw (or include/linux/pagemap.h).

Maybe it should stay in readahead.c.

I got this early warning from Andrew:
        find_page() is not meant to be a general API, for it can
        easily be abused.

> >+
> >+/*
> >+ * Move pages in danger (of thrashing) to the head of inactive_list.
> >+ * Not expected to happen frequently.
> >+ */
> >+static unsigned long rescue_pages(struct page *page, unsigned long 
> >nr_pages)
> > 
> >
> 
> Should probably be in mm/vmscan.c

Maybe. It's a highly specialized function. It protects a continuous
range of sequential readahead pages in a file. Do you mean to move it
for the zone->lru_lock protected statements?

Regards,
Wu
