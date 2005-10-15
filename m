Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVJOI6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJOI6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 04:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJOI6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 04:58:24 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:7015 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750986AbVJOI6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 04:58:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SFRsKmQWejbHodkxIv3xYCmjAgQ7UUS2mYpzezitg3OPgikdSMCdSk2R4wHxDN1nuyQHrwCMGsrWTOTnccUIUEJM0iPccUtZR1QDS8PbK5rWhBSIw8a1Siberj4Mze6KsAGP/haZd+Q04+ZnuFKTmPpOnAgEtehjvxCYz/J2nY4=  ;
Message-ID: <4350C4F6.4030807@yahoo.com.au>
Date: Sat, 15 Oct 2005 18:59:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible memory ordering bug in page reclaim?
References: <4350776D.1060304@yahoo.com.au>	 <Pine.LNX.4.61.0510150705240.22534@goblin.wat.veritas.com> <1129362196.7620.8.camel@gaston>
In-Reply-To: <1129362196.7620.8.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Sat, 2005-10-15 at 07:17 +0100, Hugh Dickins wrote:
> 
>>On Sat, 15 Oct 2005, Nick Piggin wrote:
>>

>>>1                                2
>>>find_get_page();
>>>write to page                    write_lock(tree_lock);
>>>SetPageDirty();                  if (page_count != 2
>>>put_page();                          || PageDirty())
>>>
>>>Now I'm worried that 2 might see PageDirty *before* SetPageDirty in
>>
>>                                  page->flags
>>
>>>1, and page_count *after* put_page in 1.
>>
>>I think you're right.  But I'm the last person to ask
>>barrier/ordering questions of.  CC'ed Ben and Andrea.
> 
> 
> yup, now the question is wether PG_Dirty will be visible to CPU 2 before
> the page count is decremented right ? That depends on put_page, I
> suppose. If it's doing a simple atomic, there is an issue. But atomics
> with return has been so often abused as locks that they may have been
> implemented with a barrier... (On ppc64, it will do an eieio, thus I
> think it should be ok).
> 

Well yes, that's on the store side (1, above). However can't a CPU
still speculatively (eg. guess the branch) load the page->flags
cacheline which might be satisfied from memory before the page->count
cacheline loads? Ie. you can still have the correct write ordering
but have incorrect read ordering?

Because neither PageDirty nor page_count is a barrier, and there is
no read barrier between them.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
