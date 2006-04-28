Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWD1Eyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWD1Eyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 00:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWD1Eyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 00:54:45 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:56419 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750912AbWD1Eyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 00:54:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NHP1DsxapK1D7vpTS0NhiqR5NPIVKinvMSRmIKLtfiKscxYmtOP/G8UxpuR7C8oWI68aWmrKdeWPOAdlnMEnuoyuLMlWtuBcvk7mA/TrxUOCK1AdQHNTHtIo9bY5WQfjftvu8fW8XdLGudxthkx7sDRwanKsFwE/ITySL4qaJN4=  ;
Message-ID: <4451A00A.2030606@yahoo.com.au>
Date: Fri, 28 Apr 2006 14:54:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <44505B59.1060308@yahoo.com.au> <Pine.LNX.4.64.0604270804420.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604270804420.3701@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 27 Apr 2006, Nick Piggin wrote:
> 
>>>Of course, with small files, the actual filename lookup is likely to be the
>>>real limiter.
>>
>>Although that's lockless so it scales. find_get_page will overtake it
>>at some point.
> 
> 
> filename lookup is only lockless for independent files. You end up getting 
> the "dentry->d_lock" for a successful lookup in the lookup path, so if you 
> have multiple threads looking up the same files (or - MUCH more commonly - 
> directories), you're not going to be lockless.

Oh that's true, I forgot. So the many small files case will often have
as much d_lock activity as tree_lock.

> 
> I don't know how we could improve it. I've several times thought that we 
> _should_ be able to do the directory lookups under the rcu read lock and 
> never touch their d_count or d_lock at all, but the locking against 
> directory renaming depends very intimately on d_lock.
> 
> It is _possible_ that we should be able to handle it purely with just 
> memory ordering rather than depending on d_lock. That would be wonderful.
> 
> Of course, we do actually scale pretty damn well already. I'm just saying 
> that it's not perfect.
> 
> See __d_lookup() for details.

Yes I see. Perhaps a seqlock could do the trick (hmm, there already is one),
however we still have to increment the refcount, so there'll always be a
shared cacheline.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
