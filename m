Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWE3R6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWE3R6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWE3R6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:58:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932363AbWE3R6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:58:36 -0400
Date: Tue, 30 May 2006 10:55:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447BD63D.2080900@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 May 2006, Nick Piggin wrote:
> 
> For workloads where plugging helps (ie. lots of smaller, contiguous
> requests going into the IO layer), the request pattern should be
> pretty good without plugging these days, due to multiple page
> readahead and writeback.

No.

That's fundamentally wrong.

The fact is, plugging is not about read-ahead and writeback. It's very 
fundamentally about the _boundaries_ between multiple requests, and in 
particular the time when the queue starts out empty so that we can build 
up things for devices that wand big requests, but even more so for devices 
where _seeking_ is very expensive.

Those boundaries haven't gone anywhere. The fact that we do read-ahead and 
write-back in chunks doesn't change anything: yes, we often have the "big 
requests" thing handled, but (a) not always and (b) upper layers 
fundamentally don't fix the seek issues.

I want to know that the block layer could - if we wanted to - do things 
like read-ahead for many distinct files, and for metadata. We don't 
currently do much of that yet, but the point is, plugging _allows_ us to. 
Exactly because it doesn't depend on upper layers feeding everything in 
one go.

Look at "sys_readahead()", and realize that it can be used to start IO for 
read ahead _across_many_small_files_. Last I tried it, it was hugely 
faster at populating the page cache than reading individual files (I used 
to do it with BK to bring everything into cache so that the regular ops 
would be fster - now git doesn't much need it).

And maybe it was just my imagination, but the disk seemed quieter too. It 
should be able to do better seek patterns at the beginning due to plugging 
(ie we won't start IO after the first file, but after the request queue 
fills up or something else needs to wait and we do an unplug event).

THAT is what plugging is good for. Our read-ahead does well for large 
requests, and that's important for some disk controllers in particular. 
But plugging is about avoiding startign the IO too early.

Think about the TCP plugging (which is actually newer, but perhaps easier 
to explain): it's useful not for the big file case (just use large reads 
and writes), but for the "different sources" case - for handling the gap 
between a header and the actual file contents. Exactly because it plugs in 
_between_ events. 

		Linus
