Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUKCBlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUKCBlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbUKCBlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:41:31 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:12507 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261303AbUKCBla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:41:30 -0500
Date: Wed, 3 Nov 2004 02:40:32 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041103014032.GD3571@dualathlon.random>
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <20041102150426.4102e225.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102150426.4102e225.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 03:04:26PM -0800, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > Andrea Arcangeli wrote:
> > > Still I recommend investigating _why_ debug_pagealloc is violating the
> > > API. It might not be necessary to wait for the pageattr universal
> > > feature to make DEBUG_PAGEALLOC work safe.
> > 
> > This makes the DEBUG_PAGEALLOC stuff symmetric enough to boot for me, 
> > and it's pretty damn simple.  Any ideas for doing this without bloating 
> > 'struct page', even in the debugging case?
> 
> You could use a bit from page->flags.  But CONFIG_DEBUG_PAGEALLOC uses so
> much additional memory nobody would notice anyway.
> 
> hm.  Or maybe page->mapcount is available on these pages.

"page < highmem_start_page" would be equivalent to page->mapped == 1.

I'll try to reproduce the problem, frankly I wondered how
DEBUG_PAGEALLOC could ever work with the current pageattr code that is
far from be usable outside a single device driver that owns the physical
region (then I thought DEBUG_PAGEALLOC perhaps was in an unusable state
like dead code). The current change_page_attr is basically only for
symmetric use via ioremap_nocache or AGP explicit code, that _owns_ the
region by registering in resource.c. Attempting to use the current
restrictive API in random page resources not registared and owned by the
caller, may not even be fixable without creating an universal API.
