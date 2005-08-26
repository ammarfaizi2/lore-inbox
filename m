Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVHZBQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVHZBQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVHZBQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:16:55 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:64372 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965038AbVHZBQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:16:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xg2UIPMQFgp/4fE9RKTDE4fRf5JqhMgyFzaDJV3T6ngfl3ZkKqE23sobqongMvVvW6NwGI0UPOjDjf+zdUMJiXnqY2ObZl+QawIfVFiPlVYPjHxYwNPS0HGrwJaA6pxE+6xn+rxkVjn+vnRvM5prVJx+j4B8kevvOgj4+ibD6a4=  ;
Message-ID: <430E6D86.5080202@yahoo.com.au>
Date: Fri, 26 Aug 2005 11:16:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain>	 <1124956563.3222.8.camel@laptopd505.fenrus.org>	 <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org>	 <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org>	 <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site> <430DB8FA.4080009@cosmosbay.com> <430DDAF2.6030601@yahoo.com.au> <430DE001.8060604@cosmosbay.com>
In-Reply-To: <430DE001.8060604@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

> Furthermore, a lazy sync would mean to change sysctl proc_handler for 
> "file-nr" to perform a synchronize before calling proc_dointvec, this 
> would be really obscure.
>  

I was only using your terminology (ie. the 'lazy' synch after the
atomic is updated).

Actually, a better idea would be to make a specific sysctl handler
like Christoph said.

Unless you can show some improvement, it would better not to introduce
the racy hack (even if it is mostly harmless).

>> Unless the fs people had a problem with that.
>>
>> And you may as well get rid of the atomic_inc_return which can be more
>> expensive on some platforms and doesn't buy you much.
>>   atomic_inc;
>>   atomic_read;
>> Should be enough if you don't care about lost updates here, yeah?
>>
> 
> You mean :
> 
> atomic_inc(&counter);
> lazeyvalue = atomic_read(&counter);
> 
> instead of
> 
> lazeyvalue = atomic_inc_return(&counter);
> 

Yes.

> In fact I couldnt find one architecture where the later would be more 
> expensive.
> 

atomic_inc_return guarantees a memory barrier, while the former
statements do not. I'm fairly sure it will be more expensive on
a POWER5.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
