Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWFTQCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWFTQCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFTQCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:02:35 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:62834 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751364AbWFTQCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:02:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2EX5xxnzm9OOMRQeGlhE88P6V5DRzjHXX2+soc0x0aFID2Rg86x6ws4THqtoKLFAiKrTG2ov8yf83FIcq908alJWQpWYZBa2oYsTnC7Stbr4HmjJxZPVqpgVNBnYKF8hEEl3d+9SSPrzziw/lFC4Xv/7lYH4zSqHH0Vh+ivy50w=  ;
Message-ID: <44981164.3000406@yahoo.com.au>
Date: Wed, 21 Jun 2006 01:16:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Dave Olson <olson@unixfolk.com>, ccb@acm.org,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>	 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>	 <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>	 <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au>	 <20060620083305.GB7899@elte.hu> <4497C1BC.9090601@yahoo.com.au>	 <20060620095135.GC11037@elte.hu>  <4497D4FF.6000706@yahoo.com.au>	 <1150808692.2891.194.camel@laptopd505.fenrus.org>	 <4497F9F1.8060708@yahoo.com.au> <1150815237.2891.205.camel@laptopd505.fenrus.org>
In-Reply-To: <1150815237.2891.205.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Taking the lock is going to transiation the cacheline to exclusive. If
>>the next locker tries to take the lock, they transfer the cacheline and
>>exclusive access and fail. If they have already tried to take the lock
>>earlier, they might only request a readonly state, but it still requires
>>a cacheline transfer (which is the expensive part).
> 
> 
> the "which is the expensive part" isn't entirely true on modern hardware
> (and for sure not on multicore systems); due to various bus snooping
> tricks and other "pass-the-cacheline" tricks this is relatively cheap;
> not free obviously but not nearly as expensive as the exclusive part.

Yes, I meant the entire process of getting the cacheline. The cache
coherency is the larger part of the cost (except maybe with shared
cache multi cores), however you make it sound like getting exclusive
access is fundamentally more expensive than getting shared access.
(ok, once you *have* shared access, no problems, but *getting* it is
still expensive).

With broadcast snooping cache coherency with MESI, the "getting
exclusive" shouldn't be hugely more expensive than "getting shared".
Either way the owner has to write out the line and cause the requester
to retry iff it was dirty. Then, in the former case, the owner should
probably mark their line invalid, in the latter, just shared.

With MOESI, both cases will still have to do the broadcast snoop
AFAIK.

Not sure about fancier snoop filters or directory protocols. I can't
see why getting E would be that much more expensive than getting S in
this situation (sure, in situations where lots of entities are also in
S, getting an E might require more invalidates to be sent out...).

And either way, spinlocks are still much more costly than rwlocks,
because they still have that first exclusive request, who's
effectiveness deteriorates under load. That you *also* have these
follow on shared accesses (which will need to be invalidated somehow
later anyway), doesn't make them better than read locks.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
