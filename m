Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWBJD54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWBJD54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWBJD54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:57:56 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:34687 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751042AbWBJD5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:57:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wokj5yBZ7ZYmUpvthAxvxv+PzvYPI33ewn6ye6hTRbDL1JHDI/d5FV3R1t/Y23/4qgOKSBeDW8KngOSGR0OmNtqcbN5Gt7wj6Of8GtfblMZuSiUL3yRT9g/ykpFVJW1+larBDdvZsTHWKc2i+fPcW7g3YMwAJlbPTndGHLQPxGI=  ;
Message-ID: <43EC0F3F.1000805@yahoo.com.au>
Date: Fri, 10 Feb 2006 14:57:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org>
In-Reply-To: <20060209195035.5403ce95.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> > It's a bit of a disaster if you happen to msync(MS_ASYNC) the same page at
>> > any sort of frequency - we have to wait for the previous I/O to complete
>> > before new I/O can be started.  That was the main problem which caused this
>> > change to be made.  You can see that it'd make 100x or 1000x speed improvements
>> > with some sane access patterns.
>> > 
>>
>> I'm not sure you'd have to do that, would you? Just move the dirty bit
>> from the pte and skip the page if it is found locked or writeback.
> 
> 
> That would make MS_ASYNC mean "start I/O now, unless there's I/O in
> progress, in whch case start I/O in 30 seconds.  That's not good.
> 

Yes, that change would make MS_ASYNC asynchronously start as much
IO as possible, as soon as possible. Which is good for the problem
reporter, who uses it to pipeline IOs and seems to have fairly good
control of when IO starts and finishes.

I don't think anyone would use MS_ASYNC for anything other than
performance improvement, so it is not like we need super well
defined behaviour... the earlier it will start IO AFAIKS the better.

> If we're going to change the kernel, better off using fadvise()
> enhancements, whic are also useful for post-write() operations.
> 

I don't think there is any downside to changing MS_ASYNC either,
though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
