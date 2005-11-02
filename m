Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965327AbVKBWjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbVKBWjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbVKBWjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:39:31 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:25549 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S965327AbVKBWja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:39:30 -0500
Message-ID: <43694020.8080208@vc.cvut.cz>
Date: Wed, 02 Nov 2005 23:39:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>  <4368139A.30701@vc.cvut.cz>  <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>  <1130965454.20136.50.camel@gaston>  <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com> <1130967936.20136.65.camel@gaston> <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 3 Nov 2005, Benjamin Herrenschmidt wrote:
> 
>>>Take a look at Andrew's educational comment on set_page_dirty_lock
>>>in mm/page-writeback.c.  You do have the list of pages you need to
>>>page_cache_release, don't you?  So it should be easy to dirty them.
>>
>>Ok, so just passing 'write' to get_user_pages() is good enough; right ?
> 
> 
> Not quite, I think: you need to pass 'write' to get_user_pages()
> initially; but at the end, if it was indeed writing into user space,
> you need to do the set_page_dirty_lock thing on each of the pages
> before page_cache_release, just in case a race cleaned them before
> the DMA completed.  I think (I've never used it myself).

Unfortunately at least for our use set_page_dirty{_lock} has an
unfortunate feature that it schedules writeback immediately.

get_user_pages() through __follow_page() calls set_page_dirty() only
if pte_dirty() bit is not set (I have no idea why it just does not
set pte dirty bit instead of doing set_page_dirty(), but there must
be some reason, yes?), so under normal condition page is marked
dirty in the page's structure only if it was not marked dirty
on pte level before.  This way page itself is marked dirty only after
somebody copies dirty bit from page tables to the page structure, which
can take a lot of time.

On other side when you do set_page_dirty(), page is in few seconds
written back to the disk - causing quite visible I/O load if you
perform get_user_pages()/set_page_dirty() when compared with
situation where you just mark PTE dirty after you are done with
page.

(for those interested, in the situation described above we are
doing get_user_pages() on the file mapped by MAP_SHARED to the
user's address space to get physical address of these pages,
then virtual machine monitor uses this physical address to fill
guest's pagetables, and later (once guest is done with page) we
mark page dirty and release page; performance difference between
set_page_dirty() and home grown ptep_set_dirty() is more than
visible...  but AGP memory in question is probably not
backed up by some writeable file, so it does not make difference
here)

					Petr

