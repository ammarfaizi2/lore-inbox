Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWBJRhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWBJRhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWBJRhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:37:52 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:1618 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751357AbWBJRhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:37:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Gy4pb4KJBKKwMHo6QNNaZ5ruWxgVkUZqJ8cRNN8XhSrTkoQclMhvKs0Vl5+EhELXMDWXIo2G+5s+ttMkXYxkDNFfI5HTi2Yd4Q7Jh30AYGdU7l9dOD6D2kcfK6CzvWn6r3VcIKZhMOKa4mkEpHPqirMXr1wNMeuYsehOdJ2Kgi4=  ;
Message-ID: <43ECCF68.3010605@yahoo.com.au>
Date: Sat, 11 Feb 2006 04:37:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org> <43ECC13F.5080109@yahoo.com.au> <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>MS_INVALIDATE does that (in Linux),
> 
> 
> I don't actually think it does.
> 
> In _current_ linux it does. In some other versions, it will have thrown 
> the dirty data away. Also, it will make subsequent accesses much much more 
> expensive - and it doesn't work on locked areas.
> 
> 
>>					 the spec is poorly worded but the
>>intention seems to be that it would push dirty state back into pagecache for
>>implementations such as ours.
> 
> 
> As an application writer, you'd be absolutely crazy to depend on that.
> 

Either the older versions of Linux are totally broken WRT the spec, or
the spec totally broke compatibility. Either way I guess you would be
crazy to depend on that :(

>>linux@horizon.com has an application (database or logging I think), which
>>uses MS_SYNC to provide integrity guarantees, however it is possible to do
>>useful work between the last write to memory and the commit point. MS_ASYNC
>>is used to start the IO and pipeline work.
> 
> 
> So you're saying that there is one application that knows it could use 
> different semantics?
> 
> Now, please enumerate all the applications that use MS_ASYNC and prefer 
> the current semantics.
> 
> When you know that, you have an argument. 
> 

I must have missed the post where you enumerated all said applications
when changing from 2.4 and 2.5.67 behaviour to current.

> In the meantime, you have an example of an application that wants _new_ 
> semantics.
> 

2.4 semantics, actually. I have an example of a _regression_.

> 
>>>The current MS_ASYNC behaviour is the sane one. It's the one that doesn't
>>>cause the harddisk to start ticking senselessly. It's the one that allows a
>>>person on a laptop to say "don't write dirty data every 5 seconds - do it
>>>just every hour".
>>
>>MS_INVALIDATE
> 
> 
> Repeating something doesn't make it so.
> 

But it is so. Why did you change 2.0 semantics so much? Obviously because
it was broken WRT the spec - I can tell you right now there could have been
a whole lot of applications that preferred the semantics of just throwing
out the data because it is faster, so it wasn't that.

If you want to prove me wrong by quoting buggy behaviour from a 7 year old
kernel.... how am I supposed to argue with that?

> 
>>>In contrast, _your_ proposal is just inflexible and inconvenient.
>>
>>Currently MS_ASYNC does the same as MS_INVALIDATE. But it used to start
>>IO (before 2.5.something), and apparently it does in Solaris as well.
> 
> 
> Actually, it did _not_ use to start IO.
> 
> Then, somebody made it do so, and people eventually screamed, and it was 
> reverted again.
> 
> Go check Linux-2.0 or something. You'll also see the "MS_INVALIDATE means 
> throw the dirty bit away" behaviour.
> 

Sounds like someone else must have screamed in 2.0 because it was buggy
and the behaviour was changed to match standards for 2.4 and AFAIKS 2.2 does
the same (although I'm not so good at reading 2.2 source).

So those people who didn't like it must have been screaming for a long long
time until it was finally changed in 2.5.68. Unfortunately we have someone
else screaming now (and two years ago) because of the most recent change.

> The _sane_ semantics are that if you say "MS_INVALIDATE" the dirty bit is 
> just thrown away. If you say "MS_INVALIDATE | MS_ASYNC", the dirty bit is 
> saved in the page cache and then the page is unmapped. And MS_SYNC 
> obviously does the same thing, except it also waits for it.
> 

They may sound sane to you but if you go throwing away the dirty bit
against then standards then it is very broken.

>>>If somebody really really wants to "start flushing data now", then he can do
>>>so, but that actually has absolutely zero to do with "msync()" any more. A
>>>person who wants the flushing to start "now" might want to flush any random
>>>dirty buffers.
>>
>>I didn't quite understand what you're saying here.
> 
> 
> I'm saying that "start flushing now" has _zero_ to do with an mmap.
> 
> It's a perfectly valid operation after a _write_ call too - even if you 
> never mmaped the area at all.
> 
> So if somebody wants to start background IO, what has that got to do with 
> msync()?
> 

It seems very obvious to me that it is a hint. If you wer expecting
to call msync(MS_SYNC) at some point, then you could hope that hinting
with msync(MS_ASYNC) at some point earlier might improve its efficiency.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
