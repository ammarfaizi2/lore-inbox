Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWEaAdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWEaAdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWEaAdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:33:06 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:34452 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964832AbWEaAdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:33:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=M3i0wBk0RmRrSEclX5xYRPIbociSjAiCkKDv54XMenb8FWB64oqTK9bDYOkTZN4OMfZ/C54AvdYXahQZs9Ket+b23Rlt1BOEd6qQDytx5FjyNPoHAUrTRt0q6UsPsxEr1Vlv7K0LkhDHQSIiV8g+fvRzyJ0sQleYEhZs8pfk8QQ=  ;
Message-ID: <447CE43A.6030700@yahoo.com.au>
Date: Wed, 31 May 2006 10:32:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 30 May 2006, Nick Piggin wrote:
> 
>>For workloads where plugging helps (ie. lots of smaller, contiguous
>>requests going into the IO layer), the request pattern should be
>>pretty good without plugging these days, due to multiple page
>>readahead and writeback.
> 
> 
> No.
> 
> That's fundamentally wrong.
> 
> The fact is, plugging is not about read-ahead and writeback. It's very 
> fundamentally about the _boundaries_ between multiple requests, and in 
> particular the time when the queue starts out empty so that we can build 
> up things for devices that wand big requests, but even more so for devices 
> where _seeking_ is very expensive.
> 
> Those boundaries haven't gone anywhere. The fact that we do read-ahead and 
> write-back in chunks doesn't change anything: yes, we often have the "big 
> requests" thing handled, but (a) not always and (b) upper layers 
> fundamentally don't fix the seek issues.

The requests can only get merged if contiguous requests from the upper
layers come down, right?

So in a random IO workload, plugging is unlikely to help at all. In a
contiguous IO workload, mpage should take *some* of the burden off
plugging. But OK, it turns out not always, I accept that.



> 
> I want to know that the block layer could - if we wanted to - do things 
> like read-ahead for many distinct files, and for metadata. We don't 
> currently do much of that yet, but the point is, plugging _allows_ us to. 
> Exactly because it doesn't depend on upper layers feeding everything in 
> one go.
> 
> Look at "sys_readahead()", and realize that it can be used to start IO for 
> read ahead _across_many_small_files_. Last I tried it, it was hugely 
> faster at populating the page cache than reading individual files (I used 
> to do it with BK to bring everything into cache so that the regular ops 
> would be fster - now git doesn't much need it).
> 
> And maybe it was just my imagination, but the disk seemed quieter too. It 
> should be able to do better seek patterns at the beginning due to plugging 
> (ie we won't start IO after the first file, but after the request queue 
> fills up or something else needs to wait and we do an unplug event).
> 
> THAT is what plugging is good for. Our read-ahead does well for large 
> requests, and that's important for some disk controllers in particular. 
> But plugging is about avoiding startign the IO too early.

Why would plugging help if the requests can't get merged, though?

> 
> Think about the TCP plugging (which is actually newer, but perhaps easier 
> to explain): it's useful not for the big file case (just use large reads 
> and writes), but for the "different sources" case - for handling the gap 
> between a header and the actual file contents. Exactly because it plugs in 
> _between_ events. 

TCP plugging is a bit different because there is no page cache between
the application and the device; and it is stream based so everything can
be merged (within a single socket).

The same high level concept I agree, but I never said the concept was
wrong; just hoped that as a heuristic, the block plugging was no longer
useful. I've been set straight about that though ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
