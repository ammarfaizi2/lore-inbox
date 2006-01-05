Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWAEQm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWAEQm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAEQm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:42:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:57529 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932081AbWAEQm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:42:27 -0500
Message-ID: <43BD4C66.60001@austin.ibm.com>
Date: Thu, 05 Jan 2006 10:42:14 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu>
In-Reply-To: <20060105143502.GA16816@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Anyway, here is some disassembly of some of the code generated with my 
>>comments:
>>
>>c00000000049bf9c <.mutex_lock>:
>>c00000000049bf9c:       7c 00 06 ac     eieio
>>c00000000049bfa0:       7d 20 18 28     lwarx   r9,r0,r3
>>c00000000049bfa4:       31 29 ff ff     addic   r9,r9,-1
> 
> 
>>The eieio is completly unnecessary, it got picked up from 
>>atomic_dec_return (Anton, why is there an eieio at the start of 
>>atomic_dec_return in the first place?).
> 
> 
> a mutex is like a spinlock, it must prevent loads and stores within the 
> critical section from 'leaking outside the critical section' [they must 
> not be reordered to before the mutex_lock(), nor to after the 
> mutex_unlock()] - hence the barriers added by atomic_dec_return() are 
> very much needed.

The bne- and isync together form a sufficient import barrier.  See PowerPC Book2 
Appendix B.2.1.1

And if the eieio was necessary it should come after not before twidling the lock 
bits.
