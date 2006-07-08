Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWGHJU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWGHJU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGHJU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:20:26 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:33797 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751264AbWGHJUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:20:25 -0400
Message-ID: <44AF78CE.7060904@argo.co.il>
Date: Sat, 08 Jul 2006 12:20:14 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <1152348696.3120.9.camel@laptopd505.fenrus.org>
In-Reply-To: <1152348696.3120.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jul 2006 09:20:21.0010 (UTC) FILETIME=[BC413F20:01C6A26F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> >
> > It could be argued that gcc's implementation of volatile is wrong, and
> > that gcc should add the appropriate serializing instructions before and
> > after volatile accesses.
> >
> > Of course, that would make volatile even more suboptimal, but at least
> > correct.
>
> with PCI, and the PCI posting rules, there is no "one" serializing
> instruction, you need to know the specifics of the device in question to
> cause the flush. So at least there is no universal possible
> implementation of volatile as you suggest ;-)
>

A serializing volatile makes it possible to write portable code to 
access pci mmio.  You'd just follow a write with a read or whatever the 
rules say.

Of course, it would still generate horrible code, and would still be 
unable to express notions like atomic accesses, so there is not much 
point in it.

One point which was raised, is that optimization barriers also somewhat 
pessimize the code. I wonder how useful a partial memory clobber could be:

  #define spin_lock_data(lock, lock_protected_data...) \
      do { __spin_lock(lock); asm volatile ( "" : : : 
"memory"(lock_protected_data) ); } while(0)

Where __spin_lock has a partial memory clobber only on the lock variable 
itself.

It would take a lot of work, but it can eliminate the instructions to 
save and reload registers.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

