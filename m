Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWBJG5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWBJG5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBJG5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:57:41 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:63826 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751164AbWBJG5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:57:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aO1FO6DgUwL4CTbyA5IqdKQMJYjSzMce2Kxa/8Jj5NiBnGxY0z0V5ogpF/nNi6quGukhzpMbAFYdtXaJYLRlGvSAWTWwq4fogs0kYUeuO/zbEVrv/+1wCpy4TDDB/1DyJ9D2ryski49UuuxX4/BCDZyCS4jLU5rEfrnkyV5WR6Q=  ;
Message-ID: <43EC3961.3030904@yahoo.com.au>
Date: Fri, 10 Feb 2006 17:57:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au>	<20060209201333.62db0e24.akpm@osdl.org>	<43EC16D8.8030300@yahoo.com.au>	<20060209204314.2dae2814.akpm@osdl.org>	<43EC1BFF.1080808@yahoo.com.au>	<20060209211356.6c3a641a.akpm@osdl.org>	<43EC24B1.9010104@yahoo.com.au>	<20060209215040.0dcb36b1.akpm@osdl.org>	<43EC2C9A.7000507@yahoo.com.au>	<20060209221324.53089938.akpm@osdl.org>	<43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org>
In-Reply-To: <20060209224656.7533ce2b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>If there is no actual need for the application to start a write (eg
>>for data integrity) then why would it ever do that?
> 
> 
> To get the data sent to disk in a reasonable amount of time - don't leave it
> floating about in memory for hours or days.
> 

This is a Linux implementation detail. As such it would make sense to
introduce a new Linux specific MS_ flag for this.

>>Oh yeah it is easy if you want to define some more APIs and do
>>it in a Linux specific way.
>>
>>But the main function of msync(MS_ASYNC) AFAIK is to *start* IO.
>>Why do we care so much if some application goes stupid with it?
> 
> 
> Because delaying the writeback to permit combining is a good optimisation.
> 

Definitely. And when the app gives us a hint that it really wants the
data on the disk, starting it as early as possible is also a good
optimisation.


> 
>>Why not introduce a linux specific MS_flag to propogate pte dirty
>>bits?
> 
> 
> That's what MS_ASYNC already does.  We're agreed that something needs to
> change and we're just discussing what that is.  I'm proposing something
> which is complete and flexible.
> 

I don't think there's anything wrong with your fadvise additions.
I'd rather see MS_ASYNC start IO immediately and add another MS_
flag for Linux to propogate bits.

MS_ASYNC behaviour would also somewhat match your proposed FADV_ASYNC
behaviour.

> 
> 
> Another point here is that msync(MS_SYNC) starts writeout of _all_ dirty
> pages in the file (as MS_ASYNC used to do) and it waits upon writeback of
> the whole file.  That's quite inefficient for an app which has lots of
> threads writing to and msync()ing the same MAP_SHARED file.
> 
> We could easily enough convert msync() to only operate on the affected
> region of the (non-linearly-mapped) file.  But I don't think we can do that
> now, because people might be relying upon the side-effects.
> 

I think if the interface was always documented correctly then we should
be able to. If the app breaks it was buggy anyway.

> The fadvise() extensions allow us to fix this.  And we've needed them for
> some time for regular write()s anyway.  
> 

Yes they'd be nice.

Instead of
LINUX_FADV_ASYNC_WRITE
LINUX_FADV_WRITE_WAIT

can we have something more consistent? Perhaps
FADV_WRITE_ASYNC
FADV_WRITE_SYNC

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
