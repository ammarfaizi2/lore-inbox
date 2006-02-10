Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWBJUDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWBJUDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWBJUDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:03:19 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:17998 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751050AbWBJUDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:03:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JEMhsiu7JL54kpPDXIGWm2W3DlRHItfGWjqeiZbZtpMYi9rowlXFLIbqoLw2t/zdwFVEQrfkiSreYiXE2ebSDVRO7YfG5tWV6Qx227hLTjPkEDRp1qAYKIkecfwAMCiu1TMSfOcj6NuEg9INrEy2nFeItXT1q9IkR6WT6ZDxXb0=  ;
Message-ID: <43ECF182.9020505@yahoo.com.au>
Date: Sat, 11 Feb 2006 07:03:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org> <43ECC13F.5080109@yahoo.com.au> <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org> <43ECCF68.3010605@yahoo.com.au> <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org> <43ECDD9B.7090709@yahoo.com.au> <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>    When MS_ASYNC is specified, msync() shall return immediately once all
>>    the write operations are initiated or queued for servicing;
>>
>>It is talking about write operations, not dirtying. Actually the only
>>difference with MS_SYNC is that it waits for said write operations (of the
>>type queued up by MS_ASYNC) to complete.
> 
> 
> Right. And it's what we do. We queue them by moving the pages to the dirty 
> lists (yeah, it's just a tag on the page index thing, whatever).
> 
> And yes, you argue that we should move the queue closer to the actual 
> disk, but I have used at least one app that really hated the "start IO 
> now" approach. I can't talk about that app in any detail, but I can say 
> that it was an in-memory checkpoint thing with the checkpoints easily 
> being in the hundred-meg range.
> 

Hey fix your damn broken proprietary app (nah just kidding)

> And moving a hundred megs to the IO layer is insane. It also makes the 
> system pretty unusable.
> 
> So we may have different expectations, because we've seen different 
> patterns. Me, I've seen the "events are huge, and you stagger them", so 
> that the previous event has time to flow out to disk while you generate 
> the next one. There, MS_ASYNC starting IO is _wrong_, because the scale of 
> the event is just huge, so trying to push it through the IO subsystem asap 
> just makes everything suck.
> 
> In contrast, you seem to be coming at it from a standpoint of "only one 
> event ever outstanding at any particular time, and it's either small or 
> it's the only thing the whole system is doing". In which case pushing it 
> out to IO buffers is probably the right thing to do.
> 

The way I see it, it stems from simply a different expectation of
MS_ASYNC semantics, rather than exactly what the app is doing.

If there are no data integrity requirements, then the writing should
be left up to the VM. If there are, then there will be a MS_SYNC,
which *will* move those hundred megs to the IO layer so there is no
reason for MS_ASYNC *not* to get it started earlier (and it will
be more efficient if it does).

The semantics your app wants, in my interpretation, are provided
by MS_INVALIDATE. Which kind of says "bring mmap data into coherence
with system cache", which would presumably transfer dirty bits if
modified (though as an implementation detail, we are never actually
incoherent as far as the data goes, only dirty bits).

At this point the best I can do is agree to disagree if you are
still not convinced and I'll leave it to Linux to keep debating it.
We reached something of an agreement on the fadvise thing at least.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
