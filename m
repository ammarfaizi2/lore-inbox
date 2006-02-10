Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWBJQh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWBJQh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWBJQh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:37:27 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:33620 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750911AbWBJQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:37:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=l6hCVLndfyQlcy43JQMb+jEA59EmmqVvB66ELsxoxLolBkbYYNNCdVvRMvbUwd7M6elBaZFK6rc9IGxCXPe4+jgkvwWQSiLYePDoZJP+w4pY8uOA+FkplSy0bV4bRokFA/rZosQt460f/1xrFoDcTzt6mfSXNcF3HBD6Js1zowg=  ;
Message-ID: <43ECC13F.5080109@yahoo.com.au>
Date: Sat, 11 Feb 2006 03:37:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 Feb 2006, Nick Piggin wrote:
> 
>>This is a Linux implementation detail. As such it would make sense to
>>introduce a new Linux specific MS_ flag for this.
>>..
>>Definitely. And when the app gives us a hint that it really wants the
>>data on the disk, starting it as early as possible is also a good
>>optimisation.
> 
> 
> But that's what MS_SYNC is. MS_SYNC says "I need this data written now".
> 

Yes but it is synchronous.

> MS_ASYNC moves it into the page cache. That makes 100% sense. Then it will 
> be written by the regular dirty page writeout. That makes 100% sense. 
> 

MS_INVALIDATE does that (in Linux), the spec is poorly worded but the
intention seems to be that it would push dirty state back into pagecache for
implementations such as ours.

> 
>>I don't think there's anything wrong with your fadvise additions.
>>I'd rather see MS_ASYNC start IO immediately and add another MS_
>>flag for Linux to propogate bits.
> 
> 
> Why? I miss the _reason_ you want to do this.
> 

linux@horizon.com has an application (database or logging I think), which
uses MS_SYNC to provide integrity guarantees, however it is possible to do
useful work between the last write to memory and the commit point. MS_ASYNC
is used to start the IO and pipeline work.

> The current MS_ASYNC behaviour is the sane one. It's the one that doesn't 
> cause the harddisk to start ticking senselessly. It's the one that allows 
> a person on a laptop to say "don't write dirty data every 5 seconds - do 
> it just every hour".
> 

MS_INVALIDATE

> In contrast, _your_ proposal is just inflexible and inconvenient.
> 

Currently MS_ASYNC does the same as MS_INVALIDATE. But it used to start
IO (before 2.5.something), and apparently it does in Solaris as well.

> If somebody really really wants to "start flushing data now", then he can 
> do so, but that actually has absolutely zero to do with "msync()" any 
> more. A person who wants the flushing to start "now" might want to flush 
> any random dirty buffers.
> 

I didn't quite understand what you're saying here.

> Your suggestion is no different from saying "we should make every 
> 'write()' call start the IO". Which is obviously crap.
> 

I think it is quite a bit different. Obviously what you're saying is crap,
but I think there are good arguments for changing MS_ASYNC so it is not
quite so obvious.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
