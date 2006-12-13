Return-Path: <linux-kernel-owner+w=401wt.eu-S932625AbWLMJBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWLMJBK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWLMJBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:01:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37742 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932625AbWLMJBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:01:09 -0500
Date: Wed, 13 Dec 2006 00:59:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, balbir@in.ibm.com, csturtiv@sgi.com,
       daw@sgi.com, guillaume.thouvenin@bull.net, jlan@sgi.com,
       nagar@watson.ibm.com, tee@sgi.com
Subject: Re: [patch 03/13] io-accounting: write accounting
Message-Id: <20061213005954.e2d32446.akpm@osdl.org>
In-Reply-To: <457FBDBE.10102@FreeBSD.org>
References: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
	<457FBDBE.10102@FreeBSD.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 00:45:50 -0800
Suleiman Souhlal <ssouhlal@FreeBSD.org> wrote:

> akpm@osdl.org wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Accounting writes is fairly simple: whenever a process flips a page from clean
> > to dirty, we accuse it of having caused a write to underlying storage of
> > PAGE_CACHE_SIZE bytes.
> 
> On architectures where dirtying a page doesn't cause a page fault (like i386), couldn't you end up billing the wrong process (in fact, I think that even on other archituctures set_page_dirty() doesn't get called immediately in the page fault handler)? 

Yes, that would be a problem in 2.6.18 and earlier.

In 2.6.19 and later, we do take a fault when transitioning a page from
pte-clean to pte-dirty.  That was done to get the dirty-page accounting
right - to avoid the all-of-memory-is-dirty-but-the-kernel-doesn't-know-it
problem.


> AFAICS, set_page_dirty() is mostly called when trying to unmap a page when trying to shrink LRU lists, and there is no guarantee that this happens under the process that dirtied it (in fact, the set_page_dirty() is often done by kswapd).

hm, that code is still there in zap_pte_range().  If all is well, that
set_page_dirty() call should never return true.  Peter did, you ever test
for that?

(Well, it might return true in rare races, because zap_pte_range() doesn't
lock the pages)
