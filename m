Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVCVXcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVCVXcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVCVXcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:32:50 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:62564 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262403AbVCVXcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:32:18 -0500
Message-ID: <4240AAFA.1040206@yahoo.com.au>
Date: Wed, 23 Mar 2005 10:32:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>     <20050322034053.311b10e6.akpm@osdl.org>     <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>     <20050322110144.3a3002d9.davem@davemloft.net>     <20050322112125.0330c4ee.davem@davemloft.net>     <20050322112329.70bde057.davem@davemloft.net>     <Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>     <20050322123301.090cbfa6.davem@davemloft.net> <Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 22 Mar 2005, David S. Miller wrote:
> 
>>On Tue, 22 Mar 2005 19:36:46 +0000 (GMT)
>>Hugh Dickins <hugh@veritas.com> wrote:
>>
>>
>>>I notice that although both i386 and sparc64 use pgtable-nopud.h, the
>>>i386 pud_clear does nothing at all and the sparc64 pud_clear resets to 0.
>>
>>This was a dead end.  I386 doesn't do anything with pud_clear() in
>>order to work around a chip erratum.
>>
>>IA64 does clear in pud_clear() just like sparc64.
> 
> 
> My mind kept flipping back and forth on whether it was pud_clear().
> I agree, I can't see that it's the issue now.
> 

It shouldn't be.

In the case that pud is folded, free_pud_range will only call into
free_pmd_range once, and that function will loop over the required
range of the pud (ie. the pmd). If it then also falls through to
pud_clear in that function, it will also fall through to pgd_clear
in free_pud_range. So it doesn't _really_ matter which one does the
actual clearing in that case.

I think David's on the right track - I think there's something a
bit wrong at the top. In my reply to Andrew in this thread I
posted a patch which may at least get things working...

