Return-Path: <linux-kernel-owner+w=401wt.eu-S932577AbWLMEEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWLMEEO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 23:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLMEEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 23:04:14 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:44638 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932577AbWLMEEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 23:04:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nZxV9V0eG+3gzG7fgF2Cg1NYhoyA3eOXXT8xhiY0Ev3lOnZCtwMdvJ3ZZ8dSTrArZbxlhXdgCSxX0CgejV6mcSezy1njU1KluCPO9+efTr/9khnLB3UfxxcDxRb9Fhk92kkNMMXpSYlDYo0GO4q/Jsjxr03PRb3xmKzUsu88CGM=  ;
X-YMail-OSG: LLDrVLQVM1m5Q0oU4z8inV2y1pLmIQlBePInHvi04pvNZF.ySjcDmYNZrJ6m0IYNPWDPU_fATwXCFwMKG8DeKNDru0UwNh2dhPnaDCmv6zgNJQoNd7bNJ3ueQfjiu2InGJQnPLT5jca6g30-
Message-ID: <457F7B90.5000900@yahoo.com.au>
Date: Wed, 13 Dec 2006 15:03:28 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
References: <45751712.80301@yahoo.com.au>	 <20061207195518.GG4497@ca-server1.us.oracle.com>	 <4578DBCA.30604@yahoo.com.au>	 <20061208234852.GI4497@ca-server1.us.oracle.com>	 <457D20AE.6040107@yahoo.com.au> <457D7EBA.7070005@yahoo.com.au>	 <20061212223109.GG6831@ca-server1.us.oracle.com>	 <457F4EEE.9000601@yahoo.com.au>	 <1165974458.5695.17.camel@lade.trondhjem.org>	 <457F5DD8.3090909@yahoo.com.au> <1165977064.5695.38.camel@lade.trondhjem.org>
In-Reply-To: <1165977064.5695.38.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-12-13 at 12:56 +1100, Nick Piggin wrote:
> 
>>Note that these pages should be *really* rare. Definitely even for normal
>>filesystems I think RMW would use too much bandwidth if it were required
>>for any significant number of writes.
> 
> 
> If file "foo" exists on the server, and contains data, then something
> like
> 
> fd = open("foo", O_WRONLY);
> write(fd, "1", 1);
> 
> should never need to trigger a read. That's a fairly common workload
> when you think about it (happens all the time in apps that do random
> write).

Right. What I'm currently looking at doing in that case is two copies,
first into a temporary buffer. Unfortunate, but we'll see what the
performance looks like.

>>I don't want to mandate anything just yet, so I'm just going through our
>>options. The first two options (remove, and RMW) are probably trickier
>>than they need to be, given the 3rd option available (temp buffer). Given
>>your input, I'm increasingly thinking that the best course of action would
>>be to fix this with the temp buffer and look at improving that later if it
>>causes a noticable slowdown.
> 
> 
> What is the generic problem you are trying to resolve? I saw something
> fly by about a reader filling the !uptodate page while the writer is
> updating it: how is that going to happen if the writer has the page
> locked?

The problem is that you can't take a pagefault while holding the page
lock. You can deadlock against another page, the same page, or the
mmap_sem.

> AFAIK the only thing that can modify the page if it is locked (aside
> from the process that has locked it) is a process that has the page
> mmapped(). However mmapped pages are always uptodate, right?

That's right (modulo the pagefault vs invalidate race bug).

But we need to unlock the destination page in order to be able to take
a pagefault to bring the source user memory uptodate. If the page is
not uptodate, then a read might see uninitialised data.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
