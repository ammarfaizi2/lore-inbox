Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWAEAbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWAEAbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWAEAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:31:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750875AbWAEAbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:31:12 -0500
Date: Wed, 4 Jan 2006 19:31:08 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-ID: <20060105003108.GC30967@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com> <20060104155326.351a9c01.akpm@osdl.org> <20060104235631.GB29634@redhat.com> <20060104161640.08a53c3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104161640.08a53c3f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:16:40PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > +			printk (KERN_EMERG "Eeek! page_mapcount(page) went negative! (%d)\n", page->_mapcount);
 > 
 > page_mapcount(page);
 > 
 > > +			printk (KERN_EMERG "  page->flags = %x\n", page->flags);
 > 
 > %lx
 > 
 > > +			printk (KERN_EMERG "  page->count = %x\n", page->_count);
 > 
 > page_count(page);

Ugh, almost an error per line. I suck.

		Dave

--- linux-2.6.14/mm/rmap.c~	2006-01-03 08:53:32.000000000 -0500
+++ linux-2.6.14/mm/rmap.c	2006-01-03 08:58:19.000000000 -0500
@@ -484,6 +484,13 @@ void page_remove_rmap(struct page *page)
 	BUG_ON(PageReserved(page));
 
 	if (atomic_add_negative(-1, &page->_mapcount)) {
+		if (page_mapcount(page) < 0) {
+			printk (KERN_EMERG "Eeek! page_mapcount(page) went negative! (%d)\n", page_mapcount(page));
+			printk (KERN_EMERG "  page->flags = %lx\n", page->flags);
+			printk (KERN_EMERG "  page->count = %x\n", page_count(page));
+			printk (KERN_EMERG "  page->mapping = %p\n", page->mapping);
+		}
+		
 		BUG_ON(page_mapcount(page) < 0);
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
