Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWE3CzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWE3CzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWE3CzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:55:03 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:32351 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932068AbWE3CzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:55:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4bvC2TZ5jbPR3OQIacxRhMgKbj0kcupffel0maT5MvZdqphE6d0Zaj66fM03QpmGmWQvzK5CFRiUsfVMTThKmxYlm70/Ng/QcEyak2zbX6/UzAoMj7W0deLQi9shzxv+V561qxNo8DGN8/B2ypuSyjJc3z3mGuHNFbnIQzhauMo=  ;
Message-ID: <447BB3FD.1070707@yahoo.com.au>
Date: Tue, 30 May 2006 12:54:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au>	<20060529121556.349863b8.akpm@osdl.org>	<447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
In-Reply-To: <20060529183201.0e8173bc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Tue, 30 May 2006 10:08:06 +1000
>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>
>>Which is what I want to know. I don't exactly have an interesting
>>disk setup.
>>
>
>You don't need one - just a single disk should show up such problems.  I
>forget which workloads though.  Perhaps just a linear read (readahead
>queues the I/O but doesn't unplug, subsequent lock_page() sulks).
>

I guess so. Is plugging still needed now that the IO layer should
get larger requests? Disabling it might result in a small initial
request (although even that may be good for pipelining)...

Otherwise, we could make set_page_dirty_lock use a weird non-unplugging
variant (although maybe that will upset Ken), but I'd rather look
at simplification first ;)

>
>>Yes. So set_page_dirty_lock is broken, right?
>>
>
>yup.
>
>
>>And the wait_on_page_stuff needs an inode ref.
>>Also splice seems to have broken sync_page.
>>
>
>Please describe the splice() problem which you've observed.
>

sync_page wants to get either the current mapping, or a NULL one.
The sync_page methods must then be able to handle running into a
NULL mapping.

With splice, the mapping can change, so you can have the wrong
sync_page callback run against the page.

>
>>Well yes, writing to a page would be the main reason to set it dirty.
>>Is splice broken as well? I'm not sure that it always has a ref on the
>>inode when stealing a page.
>>
>
>Whereabouts?
>

The ->pin() calls in pipe_to_file and pipe_to_sendpage?

>
>>It sounds like you think fixing the set_page_dirty_lock callers wouldn't
>>be too difficult? I wouldn't know (although the ptrace one should be
>>able to be turned into a set_page_dirty, because we're holding mmap_sem).
>>
>
>No, I think it's damn impossible ;)
>
>get_user_pages() has gotten us a random pagecache page.  How do we
>non-racily get at the address_space prior to locking that page?
>
>I don't think we can.
>

But the vma isn't going to disappear because mmap_sem is held; and the
vma should hold a ref on the inode I think?

>
>>You're sure about all other lock_page()rs? I'm not, given that
>>set_page_dirty_lock got it so wrong. But you'd have a better idea than
>>me.
>>
>
>No, I'm not sure.
>
>However it is rare for the kernel to play with pagecache pages against
>which the caller doesn't have an inode ref.  Think: how did the caller look
>up that page in the first place if not from the address_space in the first
>place?
>
>- get_user_pages(): the current problem
>
>- page LRU: OK, uses trylock first.
>
>- pagetable walk??
>

Am I wrong about mmap_sem?

Anyway, it is possible that most of the problems could be solved by locking
the page at the time of lookup, and unlocking it on completion/dirtying...
it's just that that would be a bit of a task. Can we somehow add BUG_ONs to
lock_page to ensure we've got an inode ref?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
