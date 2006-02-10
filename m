Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWBJSiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWBJSiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWBJSiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:38:24 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:53355 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750774AbWBJSiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:38:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=V/F7SVOKGZk+vo5d8AlwHJt8VvA6IIrDKwCYfJemBJlFMd5unSdisG54S7IPLL0tCBi0hwWvFS4bDn2vc2iYP9KIY9gdcUeKdVIAtn0pgRb3qf/olYvaGdo8YvEAeVZE5IIiTzlvJQYtG1wr+sbT2KEPABCAteIkaQB4Pp0BA30=  ;
Message-ID: <43ECDD9B.7090709@yahoo.com.au>
Date: Sat, 11 Feb 2006 05:38:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org> <43ECC13F.5080109@yahoo.com.au> <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org> <43ECCF68.3010605@yahoo.com.au> <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>It seems very obvious to me that it is a hint. If you wer expecting
>>to call msync(MS_SYNC) at some point, then you could hope that hinting
>>with msync(MS_ASYNC) at some point earlier might improve its efficiency.
> 
> 
> And it will. MS_ASYNC tells the system about dirty pages. It _should_ 
> actually initiate writeback if the system decides that it has lots of 
> dirty pages. Of course, if the system doesn't have a lot of dirty pages, 
> the kernel will decide that no writeback is necessary.
> 
> If you (as an application) know that you will wait for the IO later (which 
> is _not_ what MS_ASYNC talks about), why don't you just start it?
> 

It depends how you interpret the standards and what you think sensible
behaviour would be, I guess (obviously our current MS_ASYNC is not
technically buggy, we're arguing about whether or not it is suboptimal).

But given that there is an MS_INVALIDATE (I interpret mmap + MS_INVALIDATE
should work as write()), and that one would _expect_ MS_ASYNC to closely
match MS_SYNC, I think MS_ASYNC should start writeout straight away.

The fact that we've historically had a buggy MS_INVALIDATE implementation
is a non argument when it comes to the interpretation of the standards.

> ie what's wrong with Andrew's patch which is what I also encourage?
> 
> I contend that "mmap + MS_ASYNC" should work as "write()". That's just 
> _sensible_.
> 
> Btw, you can equally well make the argument that "write()" is a hint that 
> we should start IO, so that if we do fdatasync() later, it will finish 
> more quickly. It's _true_. It just isn't the whole truth. It makes things 
> _slowe_ if you don't do fdatasync(), the same way you can do MS_ASYNC 
> without doing MS_SYNC afterwards.
> 

I wouldn't argue that because I don't agree with your contention. I
argue that MS_ASYNC should do as much of the work of MS_SYNC as possible,
without blocking.

 From the standard (msync):

   Description
     The msync() function shall write all modified data to permanent storage
     locations...

     When MS_ASYNC is specified, msync() shall return immediately once all
     the write operations are initiated or queued for servicing;

It is talking about write operations, not dirtying. Actually the only
difference with MS_SYNC is that it waits for said write operations (of the
type queued up by MS_ASYNC) to complete.

So our current MS_ASYNC behaviour might technically not violate a standard
(depending on what you consider initiating / queueing writes), but it would
be akin to having MS_SYNC waiting for pages to become clean without actually
starting the writeout either (which is likewise inefficient but technically
correct).

[snip smooth writeback]

That would be a nice thing yes, but again I don't agree that MS_ASYNC
is semantically equivalent to write()

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
