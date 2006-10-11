Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWJKFjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWJKFjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWJKFja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:39:30 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:34947 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932442AbWJKFj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:39:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KAGbqGgbRb0OETmZ/Ct0OMYuLanL3LJzfsNc7uAyJrDNX34M7O00CUaJLw3Q5KrsV+j/9HLl4UgP6Heh1AXd+JaqwRJm9/A7ZOOJPt5xXbzbMyDYClCa1y4KnteY10bn2ODpb5O/9RhgmYCj/is8Fw2kDOPUC1F0eC4W8A4AzXk=  ;
Message-ID: <452C838A.70806@yahoo.com.au>
Date: Wed, 11 Oct 2006 15:39:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
References: <20061010121314.19693.75503.sendpatchset@linux.site>	<20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org>
In-Reply-To: <20061010213843.4478ddfc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Tue, 10 Oct 2006 16:21:49 +0200 (CEST)
>Nick Piggin <npiggin@suse.de> wrote:
>
>
>>Fix the race between invalidate_inode_pages and do_no_page.
>>
>>Andrea Arcangeli identified a subtle race between invalidation of
>>pages from pagecache with userspace mappings, and do_no_page.
>>
>>The issue is that invalidation has to shoot down all mappings to the
>>page, before it can be discarded from the pagecache. Between shooting
>>down ptes to a particular page, and actually dropping the struct page
>>from the pagecache, do_no_page from any process might fault on that
>>page and establish a new mapping to the page just before it gets
>>discarded from the pagecache.
>>
>>The most common case where such invalidation is used is in file
>>truncation. This case was catered for by doing a sort of open-coded
>>seqlock between the file's i_size, and its truncate_count.
>>
>>Truncation will decrease i_size, then increment truncate_count before
>>unmapping userspace pages; do_no_page will read truncate_count, then
>>find the page if it is within i_size, and then check truncate_count
>>under the page table lock and back out and retry if it had
>>subsequently been changed (ptl will serialise against unmapping, and
>>ensure a potentially updated truncate_count is actually visible).
>>
>>Complexity and documentation issues aside, the locking protocol fails
>>in the case where we would like to invalidate pagecache inside i_size.
>>do_no_page can come in anytime and filemap_nopage is not aware of the
>>invalidation in progress (as it is when it is outside i_size). The
>>end result is that dangling (->mapping == NULL) pages that appear to
>>be from a particular file may be mapped into userspace with nonsense
>>data. Valid mappings to the same place will see a different page.
>>
>>Andrea implemented two working fixes, one using a real seqlock,
>>another using a page->flags bit. He also proposed using the page lock
>>in do_no_page, but that was initially considered too heavyweight.
>>However, it is not a global or per-file lock, and the page cacheline
>>is modified in do_no_page to increment _count and _mapcount anyway, so
>>a further modification should not be a large performance hit.
>>Scalability is not an issue.
>>
>>This patch implements this latter approach. ->nopage implementations
>>return with the page locked if it is possible for their underlying
>>file to be invalidated (in that case, they must set a special vm_flags
>>bit to indicate so). do_no_page only unlocks the page after setting
>>up the mapping completely. invalidation is excluded because it holds
>>the page lock during invalidation of each page (and ensures that the
>>page is not mapped while holding the lock).
>>
>>This allows significant simplifications in do_no_page.
>>
>>
>
>The (unchangelogged) changes to filemap_nopage() appear to have switched
>the try-the-read-twice logic into try-it-forever logic.  I think it'll hang
>if there's a bad sector?
>

It should fall out if there is an error. I think. I'll go through it again.

Some of the changes simply come about due to find_lock_page meaning that we
never see an !uptodate page unless it is an error, so some of that stuff can
come out.

But I see that it does read twice. Do you want that behaviour retained? It
seems like at this level it would be logical to read it once and let lower
layers take care of any retries?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
