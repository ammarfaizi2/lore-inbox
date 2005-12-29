Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVL2JBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVL2JBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVL2JBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:01:42 -0500
Received: from smtp109.plus.mail.mud.yahoo.com ([68.142.206.242]:20577 "HELO
	smtp109.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965080AbVL2JBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:01:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=he0KztxDKDhrDLgm1VVd5NvwO9u2JYpiVUqAqjpP+qrUqSRcKrc80NadJAveC+9icVtzrYgpQJHWB5/637h7YSLBL8yIajke4dolqlVkiAPIZSM50P0j2a9JDAt3YA1vrAJPi4MPuwhSwmfXuTylEX9fMENyQLJtvmc6tX4ruTo=  ;
Message-ID: <43B3A5F2.5060903@yahoo.com.au>
Date: Thu, 29 Dec 2005 20:01:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nicolas Pitre <nico@cam.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain> <1135685158.2926.22.camel@laptopd505.fenrus.org> <20051227131501.GA29134@elte.hu> <Pine.LNX.4.64.0512282222400.3309@localhost.localdomain> <20051229083333.GA31003@elte.hu>
In-Reply-To: <20051229083333.GA31003@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nicolas Pitre <nico@cam.org> wrote:

>>+		"1: ldrex	%0, [%3]	\n"
>>+		"subs		%1, %0, #1	\n"
>>+		"strexeq	%2, %1, [%3]	\n"
>>+		"movlt		%0, #0		\n"
>>+		"cmpeq		%2, #0		\n"
>>+		"bgt		1b		\n"
> 
> 
> so we are back to what is in essence a cmpxchg implementation?
> 

FWIW, I still think we should go for an open-coded "cmpxchg" variant
for UP that disables preempt, and an atomic_cmpxchg variant for SMP.

- good generic implementations
- the UP version is faster than atomic_xchg for non preempt on ARM
- if you really are counting cycles, you'd probably have preempt off
- if you've got preempt on then the preempt_ operations in semaphores
   would be the least of your worries (how about spinlocks?)

Rather than straight out introducing lots of ugliness and complexity
for something that actually slows down the speed critical !preempt
case (but is unlikely to be measurable either way).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
