Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVLVJAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVLVJAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVLVJAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:00:12 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:59475 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965140AbVLVJAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:00:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cg6M3XVzerf4Wc8W0Z18c2dkDxjngF3MFYb0Ob0JTNdVMzjSvRjHK5cNe01TA9UVThl/edeoMl5FZaHGfFaJetQdwc7VjMmyCoeW1HYWV1klffFcXpO2ZrX1Sj4brCfsI1U62euL+6Cz3I0vnWMEwq5NfGbn3oLjRycPWik8syc=  ;
Message-ID: <43AA6B17.4060504@yahoo.com.au>
Date: Thu, 22 Dec 2005 20:00:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Seigh <jseigh_02@xemaps.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: rcuref optimization
References: <doc72s$g43$1@sea.gmane.org>
In-Reply-To: <doc72s$g43$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Seigh wrote:
> You can get rid of the requirement for atomic_inc_not_zero logic
> if you use the logic I first proposed here in c.l.c++.m.
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=3E7C83DD.B126DE24%40xemaps.com 
> 
> for weakptrs where the same kind of logic was required for the strong 
> count.
> This will allow you to use fetch_inc (e.g. LOCK INC on x86) instead of 
> compare
> and swap logic which might be more efficient on some processors.  You might
> even be able to get rid of the the "unincrement" if you are pretty sure the
> maximum number of increments won't put the refcount to zero.
> 
> Summary for those who can't follow the link.  Basically, if you 
> decrement the
> refcount to zero, you attempt to set the refcount to the minimum signed 
> value
> (e.g. 0x80000000 for 32 bits).  If successful you can schedule the object
> for deallocation using RCU.  If unsuccessful, some other thread has 
> incremented
> the refcount and object is still in use and even deallocated by some 
> other thread.
> Incrementing of the refcount is only considered successful if the result 
> is greater
> than zero.  If less than zero, object is being scheduled for deallocation.
> 

Clever idea.

I don't know... atomic_inc_not_zero is implemented very easily on the
many architectures without SMP, and I think it *could* be implemented
very nicely on ll/sc based architectures without using cmpxchg.

Lastly, your InterlockedIncrement and InterlockedDecrement are not
actually atomic_inc (LOCK INC), but atomic_inc_return (XADD). Another
primitive like atomic_inc_return_negative or something could be added
to take advantages of status flags and use LOCK INC, but this will
probably not be worthwhile for any architecture other than i386/x86-64
(ie. it will be plain worse on most ll/sc and UP-only architectures
once they get around to implementing atomic_inc_not_zero properly)

Also, the extra logic and atomic op in the decrement-to-zero case
takes a bit of shine off it even for i386. I'd say we should stick
to what we have unless we see some really compelling numbers.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
