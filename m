Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVIYI1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVIYI1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVIYI1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:27:08 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:4689 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751242AbVIYI1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:27:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EMDHb8/pGeKAg5Wr7x2cdlGpyCBcIuD5J+VV0F6gLsF5QNvoklAVomu+LJkRQZYphb9pcfleT/LBwXUQJq2Wn9+StGxOqi/knCMk2x7aOtqfJzz3N7rC7m72jTzCjmOxg65ktFcX30T/xoVooczcVRG1jwtVEbvbMn2HBGpylgc=  ;
Message-ID: <43365F82.1040801@yahoo.com.au>
Date: Sun, 25 Sep 2005 18:27:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au> <43365BCA.6030904@gmail.com>
In-Reply-To: <43365BCA.6030904@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

> 
>  As I've said in the other reply, I'll first rip off three stage init 
> thing for cpucontrol.  That added pretty much complexity to it.  And 
> with the weird naming scheme, please tell me how to fix it.  I have no 
> problem renaming things.
> 

OK, my criticism of your naming was not constructive so I apologise
for that. I willll help you with some of those minor issues if we
establish that your overall design is a a goer.


>> What would be wrong with an array of NR_CPUS rwsems? The only
>> tiny trick you would have to do AFAIKS is have up_read remember
>> what rwsem down_read took, but that could be returned from
>> down_read as a token.
> 
> 
>  Using array of rwsems means that every reader-side ops performs 
> (unnecessary) real down and up operations on the semaphore which involve 
> atomic memory op and probably memory barrier.  These are pretty 
> expensive operations.
> 
>  What brsem tries to do is implementing rwsem semantics while performing 
> only normal (as opposed to atomic/barrier) intstructions during 
> reader-side operations.  That's why all the call_on_all_cpus stuff is 
> needed while write-locking.  Do you think avoiding atomic/barrier stuff 
> would be an overkill?
> 

Yes I think so. I think the main problem on modern CPUs is
not atomic operations as such, but cacheline bouncing.

Without any numbers, I'd guess that your down_read is more
expensive than mine simply due to touching more cachelines
and having more branches.

The other thing is simply that you really want your
synchronization primitives to be as simple and verifiable
as possible. For example rwsems even recently have had subtle
memory ordering and other implemntation corner cases, and
they're much less complex than this brsem.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
