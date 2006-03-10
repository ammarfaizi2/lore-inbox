Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWCJFOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWCJFOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWCJFOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:14:36 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:39007 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750707AbWCJFOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:14:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kvHZvE059J+gvv5HzBKfa7WSh4r2GgniQ+7sUTimOoFMNs2dCwJrIgbRodrJHMkXrjmcUDftkj3Wenk+DBfr9kziMyJNxXbkM8MpeZ3yxhmx08LXptgSKLKu1tHVxXH9TUxjvUjEf2pd3EgH492iVxsYbiWB4z7XV17KsxxV+LU=  ;
Message-ID: <44110B35.8040903@yahoo.com.au>
Date: Fri, 10 Mar 2006 16:14:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Daniel Phillips <phillips@google.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com> <440FCA81.7090608@google.com> <440FDC8E.9060907@yahoo.com.au> <200603090519.37801.ak@suse.de> <44101FE8.9050105@yahoo.com.au>
In-Reply-To: <44101FE8.9050105@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andi Kleen wrote:
> 
>> On Thursday 09 March 2006 08:43, Nick Piggin wrote:
>>  
>>
>>> Just interested: do the locks have any sort of locality of lookup?
>>> If so, then have you tried moving hot (ie. the one you've just found,
>>> or newly inserted) hash entries to the head of the hash list?
>>>
>>> In applications with really good locality you can sometimes get away
>>> with small hash tables (10s even 100s of collisions on average) without
>>> taking too big a hit this way, because your entries basically get sorted
>>> LRU for you.
>>
>>
>>
>> LRU hashes have really bad cache behaviour though if that is not the case
>> because you possibily need to bounce around the hash heads as DIRTY 
>> cache lines instead of keeping them in SHARED state.
>> My feeling would be that scalability is more important for this, which 
>> would
>> discourage this.
>>
> 
> That's true, it would have to have very good locality of reference to
> be of use. In that case it is not always going to dirty the cachelines
> because you now only have to make your hash table size appropriate for
> your _working set_ rather than the entire set - if the working set is
> small enough and you make your hash say 4 times bigger than it, then
> you might expect to often hit the right lock at the head of the list.
> 

OTOH, I suspect it actually isn't all that bad. There is already a
shared lock there, which will definitely have its cacheline invalidated.

So adding an extra cacheline bounce is not like the bad problem of going
from perfect scalability (no shared cachelines) to a single shared cacheline.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
