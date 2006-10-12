Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWJLNVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWJLNVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 09:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJLNVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 09:21:04 -0400
Received: from sandeen.net ([209.173.210.139]:23404 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1751401AbWJLNVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 09:21:01 -0400
Message-ID: <452E413B.10002@sandeen.net>
Date: Thu, 12 Oct 2006 08:20:59 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Eric Sandeen <esandeen@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061009225036.GC26728@redhat.com> <20061010141145.GM23622@atrey.karlin.mff.cuni.cz> <452C18A6.3070607@redhat.com> <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com> <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz> <452CF523.5090708@sandeen.net> <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com> <20061012122820.GK9495@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061012122820.GK9495@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>> Talking with Stephen, it seemed like the page lock should synchronize these 
>> threads, but I've found that we can get to journal_dirty_data acting on the 
>> buffer heads w/o having the page locked...
>   Yes, PageLock should protect us. Where can we call
> journal_dirty_data() without PageLock? I see the following callers:
>   ext3_ordered_commit_write - should have PageLock
>   ext3_ordered_writepage - has PageLock
>   ext3_block_truncate_page - has PageLock
> 
>   And that are all callers from ext3. Am I missing something?
> 
> 								Honza

I put an assert about the page being locked in journal_dirty_data, and hit it 
right away.  I'll look a bit more but I think this is how I got there:


ext3_ordered_writepage <-- assert PageLocked
	...
	block_write_full_page
		__block_write_full_page
			unlock_page()
	...
	walk_page_buffers
		journal_dirty_data_fn
			ext3_journal_dirty_data
				journal_dirty_data <-- find page unlocked

there's a comment in ext3_ordered_writepage:

         /*
          * The page can become unlocked at any point now, and
          * truncate can then come in and change things.  So we
          * can't touch *page from now on.  But *page_bufs is
          * safe due to elevated refcount.
          */

-Eric
