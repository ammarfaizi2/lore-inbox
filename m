Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSAYXL2>; Fri, 25 Jan 2002 18:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290826AbSAYXJl>; Fri, 25 Jan 2002 18:09:41 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:32776 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288742AbSAYXJT>;
	Fri, 25 Jan 2002 18:09:19 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15441.58698.88184.111366@argo.ozlabs.ibm.com>
Date: Sat, 26 Jan 2002 10:07:54 +1100 (EST)
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com>
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> The attached patch does the following to 2.5.3-pre5:
> 
>  * consolidates various status items that are found in the lower reaches of
>    task_struct into one 32-bit word, thus allowing them to be tested
>    atomically without the need to disable interrupts in entry.S.

I'm no expert on the x86 arch-specific code, but it looks to me like
you have misunderstood what is going on there.  It seems to me that
you have opened up a race by testing the need_resched and sigpending
flags with interrupts enabled.  The race is that you can test those
flags and find them false, and then get an interrupt that sets one or
other of those flags.  You will then return to the usermode process
and not act on the need_resched or sigpending until the next
interrupt.  So in fact you will reschedule / deliver the signal
eventually, but with extra latency.

In other words, the "atomic" in the comment is not about testing
need_resched and sigpending at the same time, but about making the
process of testing those flags and returning to usermode atomic.

Paul.
