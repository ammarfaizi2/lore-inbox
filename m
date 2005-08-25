Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVHYOv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVHYOv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVHYOv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:51:58 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:133 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750979AbVHYOv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:51:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IO22j0tRZzzhTjRvuhAdWYIdB/wHkAvcdGCHkvIse5NLOvDYy+6tCzE9PGiW2AornKlE7mgBMjRqhUUm4YZbj6Cc4E9vgOu7qOTWUr+CwTSMoWxxNq63sMRv1mbKjUwjKxUYJ6h9+FWEYm7DfKXIqHg22t7edh3xxC55unQrLgQ=  ;
Message-ID: <430DDAF2.6030601@yahoo.com.au>
Date: Fri, 26 Aug 2005 00:51:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain>	 <1124956563.3222.8.camel@laptopd505.fenrus.org>	 <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org>	 <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org>	 <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site> <430DB8FA.4080009@cosmosbay.com>
In-Reply-To: <430DB8FA.4080009@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Nick Piggin a écrit :
> 

>> Would you just be able to add the atomic sysctl handler that
>> Christoph suggested?
>>
> 
> Quite a lot of work indeed, and it would force to convert 3 int 
> (nr_files, nr_free_files, max_files) to 3 atomic_t. I feel bad 
> introducing a lot of sysctl rework for a tiny change (removing 
> filp_count_lock)
> 

True, I didn't notice that.

>> This introduces lost update problems. 2 CPUs may store to nr_files
>> in the opposite order that they incremented atomic_nr_files.
>>
> 
> That's true, and the difference can be relatively important in case of 
> preemption.
> 
> Each time the true and correct value  (atomic_nr_files) is updated, a 
> copy is done on nr_files : as nr_files is only used to be a guard value 
> against too many file allocations, a somewhat 'lazy' value has no impact 
> at all.
> 

OK, well I would prefer you do the proper atomic operations throughout
where it "really matters" in file_table.c, and do your lazy synchronize
with just the sysctl exported value.

Unless the fs people had a problem with that.

And you may as well get rid of the atomic_inc_return which can be more
expensive on some platforms and doesn't buy you much.
   atomic_inc;
   atomic_read;
Should be enough if you don't care about lost updates here, yeah?

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
