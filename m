Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWE3ENM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWE3ENM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 00:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWE3ENM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 00:13:12 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:12939 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751474AbWE3ENK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 00:13:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VB3bLMlyeSguyFhqftPwZKP+gO96RUyAC4eV3drlGt5uch3Xtxsou/GTAbThK111Zgg88cZdLypKxX0TP8dK8ymWtRDt5TfeWiTbvZrn49PXCsCsnmNsQZ0ob9boh99W4cBCB3GpauTbetKHxb8Bb6RTf5LMTY3ptM0KocmMd4s=  ;
Message-ID: <447BC64D.3060706@yahoo.com.au>
Date: Tue, 30 May 2006 14:13:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au>	<20060529121556.349863b8.akpm@osdl.org>	<447B8CE6.5000208@yahoo.com.au>	<20060529183201.0e8173bc.akpm@osdl.org>	<447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org>
In-Reply-To: <20060529201444.cd89e0d8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Tue, 30 May 2006 12:54:53 +1000
>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>
>>I guess so. Is plugging still needed now that the IO layer should
>>get larger requests? Disabling it might result in a small initial
>>request (although even that may be good for pipelining)...
>>
>
>Mysterious question, that.  A few years ago I think Jens tried pulling unplugging
>out, but some devices still want it (magneto-optical storage iirc).  And I
>think we did try removing it, and it caused hurt.
>

Would be nice to get rid of it. I guess that's out of the question
for several releases, even if there was no performance problems.

>
>>Otherwise, we could make set_page_dirty_lock use a weird non-unplugging
>>variant
>>
>
>Yes, that would work.  In fact the number of times when direct-io actually
>calls set_page_dirty_lock() is infinitesimal - I had to jump through hoops
>to even test that code.  The speculative
>set-the-page-dirty-before-we-do-the-IO thing is very effective.  So the
>performace impact of making such a change would be nil.
>

OK, that'll probably be the way to go for upcoming releases. I'll post
a patch soon.

>
>That's for the direct-io case.  Other cases might be hurt more.
>
>Also, perhaps we could poke kblockd to do it for us.
>

Hard, I think, to get back to ->mapping. Well not hard if we just use
a non-syncing lock_page, but in that case we don't need kblockd.

>
>>sync_page wants to get either the current mapping, or a NULL one.
>>The sync_page methods must then be able to handle running into a
>>NULL mapping.
>>
>>With splice, the mapping can change, so you can have the wrong
>>sync_page callback run against the page.
>>
>
>Oh.
>

Don't know what we can do about that off the top of my head. Within
block_sync_page there shouldn't be any problems (at worst, we'd unplug
the wrong dev). Maybe the whole sync_page callback scheme can be removed
so nobody tries to do anything funny with it? Call blk_run_backing_dev
directly.

>
>>>>Well yes, writing to a page would be the main reason to set it dirty.
>>>>Is splice broken as well? I'm not sure that it always has a ref on the
>>>>inode when stealing a page.
>>>>
>>>>
>>>Whereabouts?
>>>
>>>
>>The ->pin() calls in pipe_to_file and pipe_to_sendpage?
>>
>
>One for Jens...
>
>
>>>>It sounds like you think fixing the set_page_dirty_lock callers wouldn't
>>>>be too difficult? I wouldn't know (although the ptrace one should be
>>>>able to be turned into a set_page_dirty, because we're holding mmap_sem).
>>>>
>>>>
>>>No, I think it's damn impossible ;)
>>>
>>>get_user_pages() has gotten us a random pagecache page.  How do we
>>>non-racily get at the address_space prior to locking that page?
>>>
>>>I don't think we can.
>>>
>>>
>>But the vma isn't going to disappear because mmap_sem is held; and the
>>vma should hold a ref on the inode I think?
>>
>
>That's true during the get_user_pages() call.  Be we run
>set_page_dirty_lock() much later, after IO completion.
>

Oh, I thought you specifically meant the ptrace case. Yes, in
general it is much harder.

>>Anyway, it is possible that most of the problems could be solved by locking
>>the page at the time of lookup, and unlocking it on completion/dirtying...
>>it's just that that would be a bit of a task.
>>
>
>But lock_page() requires access to the address_space.  To kick the IO so we
>don't wait for ever.
>

It shouldn't wait for ever, because the unplug timer will go off
and kblockd will do it eventually. And I was imagining that it would
have a pin on the address space at the point it is looked up... But
reworking all callers is just a pipe dream anyway, so nevermind ;)

Where we have synchronous IO, we do want the queue to be unplugged,
however in most set_page_dirty_lock case this is normally not the
case and a locked page should be rare. So hmm yes that would make
sense to have it use a special lock_page...

>
>>Can we somehow add BUG_ONs to
>>lock_page to ensure we've got an inode ref?
>>
>
>WARN_ONs.
>

But is it practical? Or I suspect the warning would only ever trigger
in the really rare racy cases anyway, when dentry, inode, etc have
been reclaimed.

Anyway, I'll come up with a less intrusive patch shortly...

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
