Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWBJTG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWBJTG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWBJTG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:06:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750953AbWBJTGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:06:25 -0500
Date: Fri, 10 Feb 2006 11:05:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECDD9B.7090709@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au>
 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org> <43ECC13F.5080109@yahoo.com.au>
 <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org> <43ECCF68.3010605@yahoo.com.au>
 <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org> <43ECDD9B.7090709@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>     When MS_ASYNC is specified, msync() shall return immediately once all
>     the write operations are initiated or queued for servicing;
> 
> It is talking about write operations, not dirtying. Actually the only
> difference with MS_SYNC is that it waits for said write operations (of the
> type queued up by MS_ASYNC) to complete.

Right. And it's what we do. We queue them by moving the pages to the dirty 
lists (yeah, it's just a tag on the page index thing, whatever).

And yes, you argue that we should move the queue closer to the actual 
disk, but I have used at least one app that really hated the "start IO 
now" approach. I can't talk about that app in any detail, but I can say 
that it was an in-memory checkpoint thing with the checkpoints easily 
being in the hundred-meg range.

And moving a hundred megs to the IO layer is insane. It also makes the 
system pretty unusable.

So we may have different expectations, because we've seen different 
patterns. Me, I've seen the "events are huge, and you stagger them", so 
that the previous event has time to flow out to disk while you generate 
the next one. There, MS_ASYNC starting IO is _wrong_, because the scale of 
the event is just huge, so trying to push it through the IO subsystem asap 
just makes everything suck.

In contrast, you seem to be coming at it from a standpoint of "only one 
event ever outstanding at any particular time, and it's either small or 
it's the only thing the whole system is doing". In which case pushing it 
out to IO buffers is probably the right thing to do.

The reason I like the current MS_ASYNC is that it _allows_ both. Once you 
push it to the page cache, you can choose to push it closer to the IO path 
if you want to. In contrast, if MS_ASYNC pushes it directly into the IO 
queues, you're screwed. You can't take it back. You don't have any choice.

				Linus
