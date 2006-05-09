Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWEIDqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWEIDqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWEIDqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:46:22 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:11934 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750942AbWEIDqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:46:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mMHC8lgG7b9x2mFO81pptizbbNYc0nbFOwdyHok2TK+38+OCg+fzlccpPxEjK5VZ9TbmXWCLkbeyc9EGPPC+xuGAk9KRgdrgYT6im21o2MCHFlvQ7rwAJge3hrBACyuuTIKx4qR/F8c8ecp3DciSn2G9UmL6/qfFC/JwZJtM5mM=  ;
Message-ID: <44600F9B.1060207@yahoo.com.au>
Date: Tue, 09 May 2006 13:42:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Twichell <tbrian@us.ibm.com>
CC: Hugh Dickins <hugh@veritas.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
References: <1146671004.24422.20.camel@wildcat.int.mccr.org> <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com> <57DF992082E5BD7D36C9D441@[10.1.1.4]> <Pine.LNX.4.64.0605061620560.5462@blonde.wat.veritas.com> <445FA0CA.4010008@us.ibm.com>
In-Reply-To: <445FA0CA.4010008@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Twichell wrote:

> Hugh Dickins wrote:
>
>> Let me say (while perhaps others are still reading) that I'm seriously
>> wondering whether you should actually restrict your shared pagetable 
>> work
>> to the hugetlb case.  I realize that would be a disappointing limitation
>> to you, and would remove the 25%/50% improvement cases, leaving only the
>> 3%/4% last-ounce-of-performance cases.
>>
>> But it's worrying me a lot that these complications to core mm code will
>> _almost_ never apply to the majority of users, will get little testing
>> outside of specialist setups.  I'd feel safer to remove that "almost",
>> and consign shared pagetables to the hugetlb ghetto, if that would
>> indeed remove their handling from the common code paths.  (Whereas,
>> if we didn't have hugetlb, I would be arguing strongly for shared pts.)
>>
> Hi,
>
> In the case of x86-64, if pagetable sharing for small pages was 
> eliminated, we'd lose more than the 27-33% throughput improvement 
> observed when the bufferpools are in small pages.  We'd also lose a 
> significant chunk of the 3% improvement observed when the bufferpools 
> are in hugepages.  This occurs because there is still small page 
> pagetable sharing being achieved, minimally for database text, when 
> the bufferpools are in hugepages.  The performance counters indicated 
> that ITLB and DTLB page walks were reduced by 28% and 10%, 
> respectively, in the x86-64/hugepage case.


Aside, can you just enlighten me as to how TLB misses are improved on 
x86-64? As far as
I knew, it doesn't have ASIDs so I wouldn't have thought it could share 
TLBs anyway...
But I'm not up to scratch with modern implementations.

>
> To be clear, all measurements discussed in my post were performed with 
> kernels config'ed to share pagetables for both small pages and hugepages.
>
> If we had to choose between pagetable sharing for small pages and 
> hugepages, we would be in favor of retaining pagetable sharing for 
> small pages.  That is where the discernable benefit is for customers 
> that run with "out-of-the-box" settings.  Also, there is still some 
> benefit there on x86-64 for customers that use hugepages for the 
> bufferpools.


Of course if it was free performance then we'd want it. The downsides 
are that it
is a significant complexity for a pretty small (3%) performance gain for 
your apparent
target workload, which is pretty uncommon among all Linux users.

Ignoring the complexity, it is still not free. Sharing data across 
processes adds to
synchronisation overhead and hurts scalability. Some of these page fault 
scalability
scenarios have shown to be important enough that we have introduced 
complexity _there_.

And it seems customers running "out-of-the-box" settings really want to 
start using
hugepages if they're interested in getting the most performance 
possible, no?

---

Send instant messages to your online friends http://au.messenger.yahoo.com 
