Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263728AbUEWXM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUEWXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUEWXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:12:26 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:40592 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263728AbUEWXMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:12:25 -0400
Subject: Re: [PATCH] export swapper_space
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040523160439.0aad94a2.akpm@osdl.org>
References: <1085352637.10930.42.camel@mulgrave> 
	<20040523160439.0aad94a2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 May 2004 18:12:17 -0500
Message-Id: <1085353939.10930.47.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-23 at 18:04, Andrew Morton wrote:
> I'd be a bit reluctant to do this.  filesystems actually have no need for
> page_mapping() - page->mapping is always correct in that context and
> page_mapping() has additional overhead.  So if poss we should avoid this
> export so as to force filesystems to avoid page_mapping().
> 
> parisc broke because its flush_dcache_page() is inlined, and it uses
> page_mapping().  I'd suggest that parisc and arm uninline that function -
> it's quite large anyway.

You mean our fast path for flush_dcache_page

static inline void flush_dcache_page(struct page *page)
{
        struct address_space *mapping = page_mapping(page);

        if (mapping && !mapping_mapped(mapping)) {
                set_bit(PG_dcache_dirty, &page->flags);
        } else {
                __flush_dcache_page(page);
        }
}

Yes, that's the culprit...I suppose we could uninline it.

James


