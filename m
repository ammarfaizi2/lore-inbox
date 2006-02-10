Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWBJTwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWBJTwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBJTwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:52:36 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:44734 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751331AbWBJTwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:52:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ErGlotEyMZmCbY+eOhFbpmAe8DjDq18rtuhLh+UIOQlSzprOzjyjG6i8XWl/0xq7gIeTjHgnsUJqzqnKmGHysNnsaSxBI3yApy5G9nZgo5D7BCpPz0Q1A65UXUQ1cDbkeDXjUPv4VueLYBY/lmJwHy9R0MtBwfmIFpmlT+WV6MQ=  ;
Message-ID: <43ECEEFF.7050905@yahoo.com.au>
Date: Sat, 11 Feb 2006 06:52:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au> <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au> <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org> <43ECD471.9080203@yahoo.com.au> <Pine.LNX.4.64.0602101011350.19172@g5.osdl.org> <43ECE97F.1080902@yahoo.com.au> <Pine.LNX.4.64.0602101138480.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101138480.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>>Your pattern would actually be
>>>
>>>	.. dirty offset 100-200 ..
>>>	fadvice(fd, 100, 200, FADV_WRITE_START);
>>>
>>>	.. dirty offset 200-300 ..
>>>	fadvice(fd, 200, 300, FADV_WRITE_START);
>>>
>>>	.. dirty offset 300-400 ..
>>>	fadvice(fd, 300, 400, FADV_WRITE_START);
>>>
>>>	.. dirty offset 400-415 .. (for the next transaction)
>>>
>>
>>- IOW if the app or OS crashed here it would be possible to see 400-415 on
>>the disk and none of the previous transactions (assuming we don't know
>>the page size).
> 
> 
> If the app/OS crashed here, nothing would matter. We haven't committed 
> anything at all yet. We've just started the IO. What is at 400-415 simply 
> doesn't matter, because nobody would have any reason to look at it.
> 
> (Besides, it's not at all clear that 400-415 would or would not be on 
> disk. It depends on entirely on timing and buffering of the IO system at 
> that point - the fact that its dirty in memory doesn't mean that it ever 
> made it into the IO buffer that was started).
> 
> 
>>>	fadvice(fd, 100, 400, FADV_JUST_WAIT); (for the previous one)
> 
> 
> This is the one that waits for it to finish, so _now_ we can update the 
> pointers (elsewhere) to that log (and if the app/OS crashes before that, 
> nobody will even know about it).
> 
> See?
> 

Well in that case in your argument your FADV_WRITE_START is of
the "waits for writeout then starts writeout if dirty" type.

In which case you've just made 3 consecutive  write+wait cycles
to the same page, so it is hardly an optimal IO pattern.

> 
>>I'm not convinced. You above example was bogus.
> 
> 
> No, your understanding was incomplete. I'm talking about just parts of a 
> much bigger transaction. 
> 
> A single write on its own is almost never a transaction unless your system 
> is _purely_ log-based (which it could be, of course. Not in my example).
> 

You were saying that your above sequence would be more efficient
if implemented with "always start IO, and just wait for IO", because
"write and wait" would do 2 write+wait cycles.

However "always start IO, and just wait for IO" does 3 write+wait cycles.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
