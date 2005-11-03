Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKCHce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKCHce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 02:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKCHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 02:32:34 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:13970 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750802AbVKCHcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 02:32:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fQwJBQzgJXtoVWa/i9IClnBApMQGqjcKPraKqf/L23k1FwM4qZRJ5lf9JY3Qxz/iLM3S7oONNHd0vdu0f8bVKlLpHYdv9iTiN6q6eWduu4cqb1VFl3SmQlI+eP4bxeYJcxLg97IBz8mwSTAYfGEGSSYP/23TdfmXJGaz+Xc+0bc=  ;
Message-ID: <4369BD7D.6050507@yahoo.com.au>
Date: Thu, 03 Nov 2005 18:34:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au> <200511030007.34285.rob@landley.net>
In-Reply-To: <200511030007.34285.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 02 November 2005 22:43, Nick Piggin wrote:
> 

>>I'd just be happy with UML handing back page sized chunks of memory that
>>it isn't currently using. How does contiguous memory (in either the host
>>or the guest) help this?
> 
> 
> Smaller chunks of memory are likely to be reclaimed really soon, and adding in 
> the syscall overhead working with individual pages of memory is almost 
> guaranteed to slow us down.

Because UML doesn't already make a syscall per individual page of
memory freed? (If I read correctly)

>  Plus with punch, we'd be fragmenting the heck 
> out of the underlying file.
> 

Why? No you wouldn't.

> 
>>>What does this have to do with specifying hard limits of anything? 
>>>What's to specify?  Workloads vary.  Deal with it.
>>
>>Umm, if you hadn't bothered to read the thread then I won't go through
>>it all again. The short of it is that if you want guaranteed unfragmented
>>memory you have to specify a limit.
> 
> 
> I read it.  It just didn't contain an answer the the question.  I want UML to 
> be able to hand back however much memory it's not using, but handing back 
> individual pages as we free them and inserting a syscall overhead for every 
> page freed and allocated is just nuts.  (Plus, at page size, the OS isn't 
> likely to zero them much faster than we can ourselves even without the 
> syscall overhead.)  Defragmentation means we can batch this into a 
> granularity that makes it worth it.
> 

Oh you have measured it and found out that "defragmentation" makes
it worthwhile?

> This has nothing to do with hard limits on anything.
> 

You said:

   "What does this have to do with specifying hard limits of
    anything? What's to specify?  Workloads vary.  Deal with it."

And I was answering your very polite questions.

> 
>>Have you looked at the frag patches?
> 
> 
> I've read Mel's various descriptions, and tried to stay more or less up to 
> date ever since LWN brought it to my attention.  But I can't say I'm a linux 
> VM system expert.  (The last time I felt I had a really firm grasp on it was 
> before Andrea and Rik started arguing circa 2.4 and Andrea spent six months 
> just assuming everybody already knew what a classzone was.  I've had other 
> things to do since then...)
> 

Maybe you have better things to do now as well?

>>Duplicating the 
>>same or similar infrastructure (in this case, a memory zoning facility)
>>is a bad thing in general.
> 
> 
> Even when they keep track of very different things?  The memory zoning thing 
> is about where stuff is in physical memory, and it exists because various 
> hardware that wants to access memory (24 bit DMA, 32 bit DMA, and PAE) is 
> evil and crippled and we have to humor it by not asking it to do stuff it 
> can't.
> 

No, the buddy allocator is and always has been what tracks the "long
contiguous runs of free memory". Both zones and Mels patches classify
blocks of memory according to some criteria. They're not exactly the
same obviously, but they're equivalent in terms of capability to
guarantee contiguous freeable regions.

> 
> I was under the impression it was orthogonal to figuring out whether or not a 
> given bank of physical memory is accessable to your sound blaster without an 
> IOMMU.
> 

Huh?

>>Err, the point is so we don't now have 2 layers doing very similar things,
>>at least one of which has "particularly silly" bugs in it.
> 
> 
> Similar is not identical.  You seem to be implying that the IO elevator and 
> the network stack queueing should be merged because they do similar things.
> 

No I don't.

> 
> If you'd like to write a counter-patch to Mel's to prove it...
> 

It has already been written as you have been told numerous times.

Now if you'd like to actually learn about what you're commenting on,
that would be really good too.

>>So you didn't look at Yasunori Goto's patch from last year that implements
>>exactly what I described, then?
> 
> 
> I saw the patch he just posted, if that's what you mean.  By his own 
> admission, it doesn't address fragmentation at all.
> 

It seems to be that it provides exactly the same (actually stronger)
guarantees than the current frag patches do. Or were you going to point
out a bug in the implementation?

> 
>>>Yes, zones are a way of categorizing memory.
>>
>>Yes, have you read Mel's patches? Guess what they do?
> 
> 
> The swap file is a way of storing data on disk.  So is ext3.  Obviously, one 
> is a trivial extension of the other and there's no reason to have both.
> 

Don't try to bullshit your way around with stupid analogies please, it
is an utter waste of time.

> 
>>>They're not a way of defragmenting it.
>>
>>Guess what they don't?
> 
> 
> I have no idea what you intended to mean by that.  Mel posted a set of patches 

What I mean is that Mel's patches aren't a way of defragmenting memory either.
They fit exactly the description you gave for zones (ie. a way of categorizing,
not defragmenting).

> in a thread titled "fragmentation avoidance", and you've been arguing about 
> hotplug, and pointing to a set of patches from Goto that do not address 
> fragmentation at all.  This confuses me.
> 

Yeah it does seem like you are confused.

Now let's finish up this subthread and try to keep the SN ratio up, please?
I'm sure Jeff or someone knowledgeable in the area can chime in if there are
concerns about UML.

Send instant messages to your online friends http://au.messenger.yahoo.com 
