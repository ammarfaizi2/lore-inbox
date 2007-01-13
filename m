Return-Path: <linux-kernel-owner+w=401wt.eu-S1422771AbXAMUGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbXAMUGn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbXAMUGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:06:43 -0500
Received: from mail.tmr.com ([64.65.253.246]:43112 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422771AbXAMUGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:06:42 -0500
Message-ID: <45A93BEA.6040601@tmr.com>
Date: Sat, 13 Jan 2007 15:07:06 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 13 Jan 2007, Michael Tokarev wrote:
>> (No, really - this load isn't entirely synthetic.  It's a typical database
>> workload - random I/O all over, on a large file.  If it can, it combines
>> several I/Os into one, by requesting more than a single block at a time,
>> but overall it is random.)
> 
> My point is that you can get basically ALL THE SAME GOOD BEHAVIOUR without 
> having all the BAD behaviour that O_DIRECT adds.
> 
> For example, just the requirement that O_DIRECT can never create a file 
> mapping, and can never interact with ftruncate would actually make 
> O_DIRECT a lot more palatable to me. Together with just the requirement 
> that an O_DIRECT open would literally disallow any non-O_DIRECT accesses, 
> and flush the page cache entirely, would make all the aliases go away.
> 
> At that point, O_DIRECT would be a way of saying "we're going to do 
> uncached accesses to this pre-allocated file". Which is a half-way 
> sensible thing to do.

But it's not necessary, it would break existing programs, would be 
incompatible with other o/s like AIX, BSD, Solaris. And it doesn't 
provide the legitimate use for O_DIRECT in avoiding cache pollution when 
writing a LARGE file.
> 
> But what O_DIRECT does right now is _not_ really sensible, and the 
> O_DIRECT propeller-heads seem to have some problem even admitting that 
> there _is_ a problem, because they don't care. 

You say that as if it were a failing. Currently if you mix access via 
O_DIRECT and non-DIRECT you can get unexpected results. You can screw 
yourself, mangle your data, or have no problems at all if you avoid 
trying to access the same bytes in multiple ways. There are lots of ways 
to get or write stale data, not all involve O_DIRECT in any way, and the 
people actually using O_DIRECT now are managing very well.

I don't regard it as a system failing that I am allowed to shoot myself 
in the foot, it's one of the benefits of Linux over Windows. Using 
O_DIRECT now is like being your own lawyer, room for both creativity and 
serious error. But what's there appears portable, which is important as 
well.

I do have one thought, WRT reading uninitialized disk data. I would hope 
that sparse files are handled right, and that when doing a write with 
O_DIRECT the metadata is not updated until the write is done.
> 
> A lot of DB people seem to simply not care about security or anything 
> else.anything else. I'm trying to tell you that quoting numbers is 
> pointless, when simply the CORRECTNESS of O_DIRECT is very much in doubt.

The guiding POSIX standard appears dead, and major DB programs which 
work on Linux run on AIX, Solaris, and BSD. That sounds like a good 
level of compatibility. I'm not sure what more correctness you would 
want beyond a proposed standard and common practice. It's tricky to use, 
like many other neat features.

I xonfess I have abused O_DIRECT by opening a file with O_DIRECT, 
fdopen()ing it for C, supplying my own large aligned buffer, and using 
that with an otherwise unmodified large program which uses fprintf(). 
That worked on all of the major UNIX variants as well.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
