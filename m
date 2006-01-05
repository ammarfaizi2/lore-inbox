Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWAEDV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWAEDV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWAEDV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:21:56 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:23701 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751898AbWAEDVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:21:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=H7CVe9F9H4b3H31gKxn1kz92jrtW7B4R0cASdQ9PfWyZRCL5O0HRhgr8e+InNQ9GKJMIFYxffrhyllARdBkxBYGJX8oWDOgJSOpBqJZIXSAkyjkSiZe28igpQhJOr2osdBi7fUf3+2QXcN17IOBaK4ip9t41D1FjvEZWQ/+nT2s=  ;
Message-ID: <43BC90CE.4040201@yahoo.com.au>
Date: Thu, 05 Jan 2006 14:21:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Nicolas Pitre <nico@cam.org>, Joel Schopp <jschopp@austin.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain> <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 4 Jan 2006, Nicolas Pitre wrote:
> 
> 
>>On Wed, 4 Jan 2006, Joel Schopp wrote:
>>
>>
>>>>this is version 14 of the generic mutex subsystem, against v2.6.15.
>>>>
>>>>The patch-queue consists of 21 patches, which can also be downloaded from:
>>>>
>>>>  http://redhat.com/~mingo/generic-mutex-subsystem/
>>>>
>>>
>>>Took a glance at this on ppc64.  Would it be useful if I contributed an arch
>>>specific version like arm has?  We'll either need an arch specific version or
>>>have the generic changed.
>>
>>Don't change the generic version.  You should provide a ppc specific 
>>version if the generic ones don't look so good.
> 
> 
> Well, if the generic one generates _buggy_ code on ppc64, that means that 
> either the generic version is buggy, or one of the atomics that it uses is 
> buggily implemented on ppc64.
> 
> And I think it's the generic mutex stuff that is buggy. It seems to assume 
> memory barriers that aren't valid to assume.
> 
> A mutex is more than just updating the mutex count properly. You also have 
> to have the proper memory barriers there to make sure that the things that 
> the mutex _protects_ actually stay inside the mutex.
> 
> So while a ppc64-optimized mutex is probably a good idea per se, I think 
> the generic mutex code had better be fixed first and regardless of any 
> optimized version.
> 
> On x86/x86-64, the locked instructions automatically imply the proper 
> memory barriers, but that was just lucky, I think.
> 

I think the generic code is correct according to Documentation/atomic_ops.txt
which basically defines any atomic_xxx operation which both modifies its
operand and returns something to have a full memory barrier before and after
its load/store operations.

Side note, why can't powerpc use lwsync for smp_wmb? The only problem seems to
be that it allows loads to be reordered before stores, but that's OK with
smp_wmb, right?

And why is smp_wmb() (ie. the non I/O barrier) doing eieio, while wmb() does
not? And rmb() does lwsync, which apparently does not order IO at all...

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
