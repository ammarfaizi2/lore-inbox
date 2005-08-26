Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVHZPO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVHZPO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVHZPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:14:57 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:19133 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965067AbVHZPO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:14:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IEJIAia9AOjI2cSuJ7l2dSrc/Ayn8BOVz/dfuLERoVodm9lZ++9BySXPNE8LqpKWzw6Mr09JbwnY1nqpltIdZIag6CEZwaHGwrEmUQr2yyumtGsdsVUUIa7FvGBU511RHMQJPUh3VVJ3Rrnw3zSBqHLgoR3TDOKHB9AfZJWIWvc=  ;
Message-ID: <430F26AA.80901@yahoo.com.au>
Date: Sat, 27 Aug 2005 00:26:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org> <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 25 Aug 2005, Linus Torvalds wrote:

>>That said, I think it's a valid optimization. Especially as the child 
>>_probably_ doesn't need it (ie there's at least some likelihood of an 
>>execve() or similar).
> 
> 
> I agree, seems a great idea to me (sulking because I was too dumb
> to get it, even when Nick and Andi first posted their patches).
> 
> It won't just save on the copying at fork time, it'll save on
> undoing it all again when the child mm is torn down for exec.
> 
> The refaulting will hurt the performance of something: let's
> just hope that something doesn't turn out to be a show-stopper.
> 

OK let's see how Ray goes, and try it when 2.6.14 opens...

> I see some flaws in the various patches posted, including Rik's.
> Here's another version - doing it inside copy_page_range, so this
> kind of vma special-casing is over in mm/ rather than kernel/.
> 

Yeah I guess that's a good idea. Patch looks pretty good.
Just a minor issue with the comment, it is not strictly
just assuming the child will exec... IMO it is worthwhile
in Ray's case even if his forked process _eventually_ ends
up touching all the shared memory pages, it is better to
avoid many ms of fork overhead.

Also, on NUMA systems this will help get page tables allocated
on the right nodes, which is not an insignificant problem for
big HPC jobs.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
