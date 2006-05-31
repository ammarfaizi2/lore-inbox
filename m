Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWEaPW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWEaPW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWEaPW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:22:28 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:8287 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965067AbWEaPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:22:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bRpt7+4syUV2bg7xYjPz0awStiRkUmUgRtZp/fy8I+e+4SDbqicLiWj8OpOx+FbRo7aZCAXcKrUKw7ZkN83DJ/6W2aelWESnEozI29Z+zYzVK0bSbKkf6dE4lTLKIZ8Zyt+9H4uZLG6tN20s7v1pn2Ls/X2kDeDBzw4wT1Qmu1g=  ;
Message-ID: <447DB4AB.9090008@yahoo.com.au>
Date: Thu, 01 Jun 2006 01:22:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org> <20060530090549.GF4199@suse.de> <447D9D9C.1030602@yahoo.com.au> <Pine.LNX.4.64.0605311602020.26969@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605311602020.26969@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 31 May 2006, Nick Piggin wrote:
> 
>>Jens Axboe wrote:
>>
>>>Maybe I'm being dense, but I don't see a problem there. You _should_
>>>call the new mapping sync page if it has been migrated.
>>
>>But can some other thread calling lock_page first find the old mapping,
>>and then run its ->sync_page which finds the new mapping? While it may
>>not matter for anyone in-tree, it does break the API so it would be
>>better to either fix it or rip it out than be silently buggy.
> 
> 
> Splicing a page from one mapping to another is rather worrying/exciting,
> but it does look safely done to me.  remove_mapping checks page_count
> while page lock and old mapping->tree_lock are held, and gives up if
> anyone else has an interest in the page.  And we already know it's
> unsafe to lock_page without holding a reference to the page, don't we?

Oh, that's true. I had thought that splice allows stealing pages with
an elevated refcount, which Jens was thinking about at one stage. But
I see that code isn't in mainline. AFAIKS it would allow other
->pin()ers to attempt to lock the page while it was being stolen.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
