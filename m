Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWBJDgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWBJDgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWBJDgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:36:47 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:15765 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751030AbWBJDgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:36:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YEjbmRvjl5qYJmekXBaaDYjmy/gbW5lUPfKKTy9D/BWcSmLqkbTrDHgwwH8mRwPBXdOOFOG+0eEk5UqiB6vvSf9dbQOuOI0Gsd9GqWv9VLkEt9pWHM3i1WdUXMGdJdiWTxDj9YZJz0nrjZU2i7lM8gQLbddXskp6gL6sPNr1zvc=  ;
Message-ID: <43EC0A44.1020302@yahoo.com.au>
Date: Fri, 10 Feb 2006 14:36:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org>
In-Reply-To: <20060209094815.75041932.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>>>
>>>Well, for example you might want to msync a number of disjoint parts of the
>>>mapping, then write them all out in one hit.
>>>
>>
>>That should still be pretty efficient with 2.4 like behaviour?
> 
> 
> It's a bit of a disaster if you happen to msync(MS_ASYNC) the same page at
> any sort of frequency - we have to wait for the previous I/O to complete
> before new I/O can be started.  That was the main problem which caused this
> change to be made.  You can see that it'd make 100x or 1000x speed improvements
> with some sane access patterns.
> 

I'm not sure you'd have to do that, would you? Just move the dirty bit
from the pte and skip the page if it is found locked or writeback.

> 
>>pdflush
>>does write them out in file offset order doesn't it?
> 
> 
> pdflush does, but an msync(MS_ASYNC) which starts I/O puts the IO order
> into the application's control.
> 

I don't see a problem with that. There are plenty of ways to shoot oneself
in the foot.

> 
>>>Or you may not actually _want_ to start the I/O now - you just want pdflush
>>>to write things back in a reasonable time period, so you don't have unsynced
>>>data floating about in memory for eight hours.  That's a quite reasonable
>>>application of msync(MS_ASYNC).
>>>
>>
>>I think data integrity requirements should be handled by MS_SYNC.
> 
> 
> Well that's always been the case.  MS_ASYNC doesn't write metadata.
> 
> 

So I don't understand your argument for using MS_ASYNC in that case.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
