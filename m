Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWBXJ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWBXJ0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWBXJ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:26:05 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:12455 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932140AbWBXJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:26:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mDw3th75KRsOldUU3ys0NGmmyuXEZ9/+zXgsnQCJGOGvIsltjAKaAeAt6huJw9TniFqSk1QlPrdMC9oZZ2STk4iA5QHgICyXUNRCqYbKWytI+GNcOVEPUpv7/T42bXS46p9Cfv0e6MV1mWw1gMXXfQ38CohtsoTPCLvZqqfaQ48=  ;
Message-ID: <43FED128.1030500@yahoo.com.au>
Date: Fri, 24 Feb 2006 20:26:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>	 <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu>	 <200602231406.43899.ak@suse.de> <43FDB55E.7090607@yahoo.com.au>	 <20060223132954.GA16074@elte.hu>  <43FEA97D.2000609@yahoo.com.au> <1140772543.2874.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1140772543.2874.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Arjan, just to get an idea of your workload: obviously it is a mix of
>>read and write on the mmap_sem (read only will not really benefit from
>>reducing lock width because cacheline transfers will still be there).
> 
> 
> yeah it's threads that each allocate, use and then free memory with
> mmap()
> 
> 
>>Is it coming from brk() from the allocator? Someone told me a while ago
>>that glibc doesn't have a decent amount of hysteresis in its allocator
>>and tends to enter the kernel quite a lot... that might be something
>>to look into.
> 
> 
> we already are working on that angle; I just posted the kernel stuff as
> a side effect basically 
> 

OK.

[aside]
Actually I have a scalability improvement for rwsems, that moves the
actual task wakeups out from underneath the rwsem spinlock in the up()
paths. This was useful exactly on a mixed read+write workload on mmap_sem.

The difference was quite large for the "generic rwsem" algorithm because
it uses the spinlock in fastpaths a lot more than the xadd algorithm. I
think x86-64 uses the former, which is what I presume you're testing with?

Obviously this is a slightly different issue from the one you're trying to
address here, but I'll dig out patch when I get some time and you can see
if it helps.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
