Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWEFJVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWEFJVb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 05:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWEFJVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 05:21:31 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:44733 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751229AbWEFJVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 05:21:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=E5ltvNG0ddAxjchqWV55ZmYse8dVjU1VdxVe5EElQxaySIFbnMpJKDEzVbR76t46UMtOGQJjO0APzUxFqSdLoOqGqcslLOyB4QmioaDe6Aoy1J9YFW5PLBE3CZi7lbgK9eSlTSyllUV2ubUE4UyEdMu4bkFuEI3OqGtEa0H7ac8=  ;
Message-ID: <445C6717.1000402@yahoo.com.au>
Date: Sat, 06 May 2006 19:06:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Ulrich Drepper <drepper@redhat.com>, Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030245.01457.blaisorblade@yahoo.it>
In-Reply-To: <200605030245.01457.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Tuesday 02 May 2006 05:45, Nick Piggin wrote:
> 
>>blaisorblade@yahoo.it wrote:
>>
>>>The first idea is to use this for UML - it must create a lot of single
>>>page mappings, and managing them through separate VMAs is slow.
> 
> 
>>I think I would rather this all just folded under VM_NONLINEAR rather than
>>having this extra MANYPROTS thing, no? (you're already doing that in one
>>direction).
> 
> 
> That step is _temporary_ if the extra usages are accepted.

Can we try to get the whole design right from the start?

> 
> Also, I reported (changelog of patch 03/14) a definite API bug you get if you 
> don't distinguish VM_MANYPROTS from VM_NONLINEAR. I'm pasting it here because 
> that changelog is rather long:
> 
> "In fact, without this flag, we'd have indeed a regression with
> remap_file_pages VS mprotect, on uniform nonlinear VMAs.
> 
> mprotect alters the VMA prots and walks each present PTE, ignoring installed
> ones, even when pte_file() is on; their saved prots will be restored on 
> faults,
> ignoring VMA ones and losing the mprotect() on them. So, in do_file_page(), we
> must restore anyway VMA prots when the VMA is uniform, as we used to do before
> this trail of patches."

It is only a bug because you hadn't plugged the hole -- make it fix up pte_file
ones as well.

> Ulrich wanted to have code+data(+guard on 64-bit) into the same VMA, but I 
> left the code+data VMA joining away, to think more with it, since currently 
> it's too slow on swapout.

Yes, and it would be ridiculous to do this with non linear protections anyway.
If the vma code is so slow that glibc wants to merge code and data vmas together,
then we obviously need to fix the data structure (which will help everyone)
rather than hacking around it.

> 
> The other part is avoiding guard VMAs for thread stacks, and that could be 
> accomplished too by your proposal. Iff this work is held out, however.

I see no reason why they couldn't both go in. In fact, having an mmap flag for
adding guard regions around vmas (and perhaps eg. a system-wide / per-process
option for stack) could almost go in tomorrow.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
