Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVLPNlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVLPNlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLPNlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:41:37 -0500
Received: from smtp101.plus.mail.mud.yahoo.com ([68.142.206.234]:4514 "HELO
	smtp101.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932267AbVLPNlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:41:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZXVuSc3XBK5bDlbGBCBBKcB0UYBY1oqPCzx9E4SYhHDucRgWYcgIIhiwJZgp+H/gQ7QCzHZu2YJfSHoyx92js7jWOYsZ6kp3EFDCSR9yL2PnnuBb8EnrutBejvcm9SsqiaQ96N0/Jt127DIiAEpQsOpOZyqgXHjK+3MBEkLxwVs=  ;
Message-ID: <43A2C40B.1020102@yahoo.com.au>
Date: Sat, 17 Dec 2005 00:41:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au> <20051216132123.GB1222@flint.arm.linux.org.uk>
In-Reply-To: <20051216132123.GB1222@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, Dec 17, 2005 at 12:01:27AM +1100, Nick Piggin wrote:
> 
>>You were proposing a worse default, which is the reason I suggested it.
> 
> 
> I'd like to qualify that.  "for architectures with native cmpxchg".
> 
> For general consumption (not specifically related to mutex stuff)...
> 
> For architectures with llsc, sequences stuch as:
> 
> 	load
> 	modify
> 	cmpxchg
> 
> are inefficient because they have to be implemented as:
> 
> 	load
> 	modify
> 	load
> 	compare
> 	store conditional
> 
> Now, if we consider using llsc as the basis of atomic operations:
> 
> 	load
> 	modify
> 	store conditional
> 
> and for cmpxchg-based architectures:
> 
> 	load
> 	modify
> 	cmpxchg
> 
> Notice that the cmpxchg-based case does _not_ get any worse - in fact
> it's exactly identical.  Note, however, that the llsc case becomes
> more efficient.
> 

True in many cases. However in a lock fastpath one could do the
atomic_cmpxchg without an initial load, assuming the lock is
unlocked.

atomic_cmpxchg(&lock, UNLOCKED, LOCKED)

which should basically wind up to the most optimal code on both the
cmpxchg and ll/sc platforms (aside from other quirks David pointed
out like cmpxchg being worse than lock inc on x86).

Ah - I see you pointed out "for general consumption", I missed that.
Indeed for general consumption one should still be careful using
atomic_cmpxchg.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
