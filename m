Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWISSeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWISSeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWISSeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:34:10 -0400
Received: from 1wt.eu ([62.212.114.60]:1043 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1750850AbWISSeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:34:09 -0400
Date: Tue, 19 Sep 2006 20:17:38 +0200
From: Willy Tarreau <w@1wt.eu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: Linux 2.4.34-pre3
Message-ID: <20060919181738.GA3467@1wt.eu>
References: <20060919173253.GA25470@hera.kernel.org> <45102BEE.9000501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45102BEE.9000501@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Sep 20, 2006 at 03:42:06AM +1000, Nick Piggin wrote:

[cut -pre3 advertisement]

> I wonder if 2.4 doesn't need the memory ordering fix to prevent pagecache
> corruption in reclaim? (http://www.gatago.com/linux/kernel/14682626.html)
> 
> What would need to be done is to test page_count before testing PageDirty,
> and putting an smp_rmb between the two.

I've read the thread, and Linus proposed to add an smp_wmb() in
set_page_dirty() too. I see that an smp_rmb() is already present
in shrink_cache() with the adequate comment. set_page_dirty() begins
with a test_and_set_bit() check. I suspect that transposing the fix
for 2.6 to 2.4 would imply to and an smp_wmb() here :

void fastcall set_page_dirty(struct page *page)
{
        if (!test_and_set_bit(PG_dirty, &page->flags)) {
                struct address_space *mapping = page->mapping;

+		smp_wmb();
                if (mapping) {
                        spin_lock(&pagecache_lock);
                        mapping = page->mapping;

But I'm really reluctant on this change, as my knowledge here is rather
limited. Also, the fact that the first proposed part of the patch is here
makes me think that it has already been considered OK.

Maybe I'm wrong, I've CC'd Marcelo for any comments.

Cheers,
Willy

