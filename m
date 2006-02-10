Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWBJRAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWBJRAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWBJRAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:00:18 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:37710 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751298AbWBJRAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:00:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cYCWeiim8ipx7qxqqIWkhZgOnn2Vdr1eTk5o2Tu368pxAW2P86GLIyiRu7YiOSo2EyqFKAvMtqVNKjvheAbW78FKcbAhc/Vr6K2AZyxcd4nbN6TagKYhmCgekEN4DBuxWY2mmI4GdPKuE8XINok0KVAkkXTpzwmH1GCYSlFZG3E=  ;
Message-ID: <43ECC69D.1010001@yahoo.com.au>
Date: Sat, 11 Feb 2006 04:00:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au> <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 Feb 2006, Nick Piggin wrote:
> 
>>It may be a very useful operation in kernel, but I think userspace either
>>wants to definitely know the data is on disk (WRITE_SYNC), or give a hint
>>to start writing (WRITE_ASYNC).
> 
> 
> Only from a _stupid_ user standpoint.
> 
> The fact is, "start writing and wait for the result" is fundamentally a 
> totally broken operation.
> 

No. Userspace has (almost) a transparent pagecache to backing store,
the only time they care about it is data integrity points in which
case they want to know that it is flushed; or performance hints which
might tell the kernel to write them sooner, or later (or other hints).

Wait until writeout has finished is like an implementation detail that
I can't see how it would be ever useful on its own.

> Why?
> 
> Because a smart user actually would want to do
> 
>  - start writing this
>  - start writing that
>  - start writing that-other-thing
>  - wait for them all.
> 

No, you are thinking about what the kernel does. Subtle difference. A
smart user wants to:

- start writing this
- start writing that
- start writing that-other-thing
- make sure this that and the other have reached backing store

OK so in effect it is the same thing, but it is better to export the
interface that reflects how the user interacts with pagecache.

WRITE_SYNC obviously does the "wait for them all" (aka ensure they
hit backing store) thing too, right? It performs exactly the same
role that WRITE_WAIT would do in the above example.

> The reason synchronous write performance is absolutely disgusting is 
> exactly that people think "start writing" should be paired up with "wait 
> for it".
> 
> So the kernel internally separates "start writing" and "wait for it" for 
> very good reasons. Reasons that in no way go away just because you use to 
> user space.
> 

They don't go away but they take different forms. "start writing" is
a performance hint. "wait for it" is only ever a part of "send to
backing store" operation.

My proposal isn't really different to Andrew's in terms of functionality
(unless I've missed something), but it is more consistent because it
does not introduce this completely new concept to our userspace API but
rather uses the SYNC/ASYNC distinction like everything else.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
