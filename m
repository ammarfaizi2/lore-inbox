Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWBJR7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWBJR7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBJR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:59:18 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:36968 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751358AbWBJR7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:59:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Bmp5CtOFph0GD4eqc0tvRuGPuEvEClXU3WvTUKdzmI48sHdmUS7B6rbQ2iNCzuyTGcPRX63LkeFsouOsA5SCbaFosXpNQ6pGX0EKAZEcyhlmfr/jlALHZQZAQ7wt7hDqQaLyBq6g6IO0C8VnNuzjGprp1Rf2X42P33uycTRUKCk=  ;
Message-ID: <43ECD471.9080203@yahoo.com.au>
Date: Sat, 11 Feb 2006 04:59:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au> <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au> <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>No, you are thinking about what the kernel does. Subtle difference. A
>>smart user wants to:
>>
>>- start writing this
>>- start writing that
>>- start writing that-other-thing
>>- make sure this that and the other have reached backing store
>>
>>OK so in effect it is the same thing, but it is better to export the
>>interface that reflects how the user interacts with pagecache.
>>
>>WRITE_SYNC obviously does the "wait for them all" (aka ensure they
>>hit backing store) thing too, right? It performs exactly the same
>>role that WRITE_WAIT would do in the above example.
> 
> 
> NOOOOOO!
> 
> Think about it for a second. Think about the usage case you yourself were 
> quoting.
> 
> The "magic" in IO is "overlapping IO". If you don't get overlapping IO, 
> your interfaces are broken. End of story.
> 
> And WRITE_SYNC _cannot_ do overlapping IO.
> 

What do you mean by overlapping?

fadvise(fd, 100, 200, FADV_WRITE_ASYNC);
fadvise(fd, 300, 400, FADV_WRITE_ASYNC);
fadvise(fd, 100, 200, FADV_WRITE_SYNC);
fadvise(fd, 300, 400, FADV_WRITE_SYNC);

Will do exactly the same as Andrew's

fadvise(fd, 100, 200, FADV_ASYNC_WRITE);
fadvise(fd, 300, 400, FADV_ASYNC_WRITE);
fadvise(fd, 100, 200, FADV_WRITE_WAIT);
fadvise(fd, 300, 400, FADV_WRITE_WAIT);


> It's entirely possible that somebody else (or that very same program) has 
> dirtied the same pages that you started write-out on earlier. And that is 
> when "wait for writes to finish" and "WRITE_SYNC" _differ_. 
> 

Yeah they do differ but if you are using sync writes then you obviously
have some data integrity requirements and you _know_ who is writing to
your file and when. That's my point. You're thinking kernel mode. The
userspace requirement for sync writes is "this has reached backing store".

> If you want synchronous writes, use synchronous writes. But if you want 
> asynchronous writes, you do _not_ implement them as "start writes now" and 
> "write synchronously". You implement them as "start writes now" and "wait 
> for the writes to have finished".
> 

_You_ do, yes. You are a kernel hacker. You implement synchonous writes.
Implementing synchronous writes is what you do.

Userspace does not care. They use synchronous writes to guarantee it has
hit backing store. They've managed quite nicely up until now without having
your implementation details exposed to them (when is a page dirty? when is
it "under writeout"? who cares? I just want to know if it is on backing
store or not).

> There's another very specific and important difference: "wait for the 
> writes" is fundamentally an interruptible and pollable operation, which 
> means that it's a lot easier to integrate into any system that has to do 
> other things too. In contrast, WRITE_SYNC is _neither_ easily 
> interruptible nor pollable.
> 

It is just as easy as WRITE_WAIT to do both. In the pollable case you
just need another flag to say you don't want to block, same as would
be required for WRITE_WAIT.

Seems like you're clutching for straws here.

> So WRITE_SYNC has clearly different behaviour. There's a good reason the 
> kernel internally has "start write" + "wait for write", and I'll repeat: 
> none of those reasons go away just because you move to user space.
> 
> 
>>My proposal isn't really different to Andrew's in terms of functionality
>>(unless I've missed something), but it is more consistent because it
>>does not introduce this completely new concept to our userspace API but
>>rather uses the SYNC/ASYNC distinction like everything else.
> 
> 
> Your proposal has two _huge_ downsides:
> 

I was still talking about new additions to fadvise here, not the msync stuff.

>  - it changes semantics, and you have absolutely _no_ idea of who depends 
>    on the performance semantics of the old behaviour. In contrast, I can 
>    tell you that we did it once before, and we reverted it.
> 
>  - it's not at all consistent. The _current_ behaviour is consistent, and 
>    matches 100% the current behaviour of sync vs async write().

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
