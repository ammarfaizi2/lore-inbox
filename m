Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268110AbTGIKaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbTGIK3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:29:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:45484 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S268110AbTGIK1E
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:27:04 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.61796.951198.414088@laputa.namesys.com>
Date: Wed, 9 Jul 2003 14:41:40 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5 VM changes: skip-writepage.patch
In-Reply-To: <20030709031242.14e89af6.akpm@osdl.org>
References: <16139.54921.640901.797268@laputa.namesys.com>
	<20030709031242.14e89af6.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > > Don't call ->writepage from VM scanner when page is met for the first time
 > >  during scan.
 > 
 > 
 > I don't think we need all the code reorganisation.  Something like this:

I separated call to ->writepage into special function because of some
other patch that I didn't send yet.

 > 
 > 
 >  include/linux/page-flags.h |    7 +++++++
 >  mm/page_alloc.c            |    1 +
 >  mm/truncate.c              |    2 ++

[...]

 > @@ -328,6 +328,8 @@ shrink_list(struct list_head *page_list,
 >  		 * See swapfile.c:page_queue_congested().
 >  		 */
 >  		if (PageDirty(page)) {
 > +			if (!TestSetPageSkipped(page))
 > +				goto keep_locked;
 >  			if (!is_page_cache_freeable(page))
 >  				goto keep_locked;
 >  			if (!mapping)
 > @@ -351,6 +353,7 @@ shrink_list(struct list_head *page_list,
 >  				list_move(&page->list, &mapping->locked_pages);
 >  				spin_unlock(&mapping->page_lock);
 >  
 > +				ClearPageSkipped(page);

Good idea.

By the way, have you noted that patch changes wbc.nonblocking to be 0,
if called from kswapd or pdflush, what do you think?

 >  				SetPageReclaim(page);
 >  				res = mapping->a_ops->writepage(page, &wbc);
 >  

Nikita.
