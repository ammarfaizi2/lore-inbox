Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVLPNRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVLPNRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVLPNRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:17:04 -0500
Received: from smtp101.plus.mail.mud.yahoo.com ([68.142.206.234]:60831 "HELO
	smtp101.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932150AbVLPNRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:17:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wRvyOZEj28kaupnfSzkwHVUUq1POjXezX1qEuC8WipZrDVP4hxGdeSGELAR173AtI/M9vh7eNJfS3xMVvRx2VlUnGuiaZzDf54wqFLicmz9Tt8vqmW5y8AJJ9RcSVEv+P14jVlyD3Kxn80p/wf1anhiintE5PF2fnCxtrTErYZA=  ;
Message-ID: <43A2BE49.4000102@yahoo.com.au>
Date: Sat, 17 Dec 2005 00:16:57 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <43A08D50.30707@yahoo.com.au>  <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> <12832.1134734438@warthog.cambridge.redhat.com>
In-Reply-To: <12832.1134734438@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

> See how many cmpxchgs you may end up doing? Now imagine that cmpxchg() is
> implemented as:
> 

Yes, 2 architectures do this and they would probably want to optimise it.

> 	spin_lock_irqsave(&common_lock[N], flags);
> 	actual = *state;
> 	if (actual == old)
> 		*state = new;
> 	spin_unlock_irqrestore(&common_lock[N], flags);
> 
> Now my point about using LL/SC is that:
> 
> 	1,C,A	cmpxchg(0,1) [failed]
> 	1,C,A	cmpxchg(1,3) [success]
> 	3,C,A	...
> 
> Can be turned into:
> 
> 	1,C,A	x = LL()
> 	1,C,A	x |= 2;
> 	1,C,A	SC(3) [success]
> 	3,C,A	...
> 
> On x86 you could use:
> 
> 	1,C,A	LOCK OR (2)
> 	3,C,A	...
> 
> instead.
> 
> Now, contention isn't very likely, so using CMPXCHG _may_ be good enough _if_
> you have it. But if you have to emulate it by using spinlocks, you're far
> better off just wrapping the entire thing in spinlocks and not pretending use
> atomic ops to access the counter; unless, of course, you have somthing that

Yes, the architecture code knows whether or not it implements atomic ops
with spinlocks, so that architecture is in the position to decide to override
the mutex implementation. *generic* code shouldn't worry about that, it should
use the interfaces available, and if that isn't optimal on some architecture
then that architecture can override it.

It is not even clear that any ll/sc based architectures would need to override
an atomic_cmpxchg variant at all because you can assume an unlocked fastpath
and not do the additional initial load to prime the cmpxchg.

So I don't know why you're so worried about sparc32 and parisc while preferring
to introduce a worse default implementation that even your frv architecture wants
to override...?

However: considering everyone and their dog has already implemented their own
semaphore, the best mutex default I guess is to probably use that as you say.
So: disregard my suggestion :P

Send instant messages to your online friends http://au.messenger.yahoo.com 
