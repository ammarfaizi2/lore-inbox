Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVH0PFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVH0PFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 11:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVH0PFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 11:05:25 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:18101 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751618AbVH0PFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 11:05:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pw0GDP7Z5pbbU0lRom9966cOQ5Bx+2lVsRXKtl4XPNpS4B+htJSef/lBbbnZzyd+e/LhnMVkJFdWFVG0Y6YTjcTAvjYp1iXQYoHUbFkk20jua5NufpJt/mII0JROKK2lONCVKiIKOJ2EwfFtlMC26283+5tf4rN9bkI7JFwM/nk=  ;
Message-ID: <43108136.1000102@yahoo.com.au>
Date: Sun, 28 Aug 2005 01:05:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org> <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org> <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com> <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com> <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 26 Aug 2005, Rik van Riel wrote:
> 
>>On Fri, 26 Aug 2005, Hugh Dickins wrote:
>>
>>
>>>Well, I still don't think we need to test vm_file.  We can add an
>>>anon_vma test if you like, if we really want to minimize the fork
>>>overhead, in favour of later faults.  Do we?
>>
>>When you consider NUMA placement (the child process may
>>end up running elsewhere), allocating things like page
>>tables lazily may well end up being a performance win.
> 
> 
> It should be easy enough to benchmark something like kernel compiles etc, 
> which are reasonably fork-rich and should show a good mix for something 
> like this. Or even just something like "time to restart a X session" after 
> you've brought it into memory once.
> 

2.6.13-rc7-git2
kbuild (make -j4) on  dual G5.

plain
228.85user 19.90system 2:06.50elapsed 196%CPU (3725666minor)
228.91user 19.90system 2:06.07elapsed 197%CPU (3721353minor)
229.00user 19.78system 2:06.20elapsed 197%CPU (3721345minor)
228.81user 19.94system 2:06.05elapsed 197%CPU (3723791minor)

nocopy shared
229.28user 19.76system 2:06.24elapsed 197%CPU (3725661minor)
229.04user 19.91system 2:06.92elapsed 196%CPU (3718904minor)
228.97user 20.06system 2:06.46elapsed 196%CPU (3723807minor)
229.24user 19.84system 2:06.13elapsed 197%CPU (3723793minor)

nocopy all
228.74user 19.87system 2:06.27elapsed 196%CPU (3819927minor)
228.89user 19.81system 2:05.89elapsed 197%CPU (3822943minor)
228.77user 19.73system 2:06.23elapsed 196%CPU (3820517minor)
228.93user 19.70system 2:05.84elapsed 197%CPU (3822935minor)

I'd say the full test (including anon_vma) is maybe slightly
faster on this test though maybe it isn't significant.

It is doing around 2.5% more minor faults, thought the profiles
say copy_page_range time is reduced as one would expect.

I think that if all else (ie. final performance) is equal, then
faulting is better than copying because the work is being
deferred until it is needed, and we dodge some pathological
cases like Ray's database taking 100s of ms to fork (we hope!)

However it will always depend on workload.

This is the condition I ended up with. Any good?

   if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
     if (vma->vm_flags & VM_MAYSHARE)
       return 0;
     if (vma->vm_file && !vma->anon_vma)
       return 0;
   }

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
