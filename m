Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSHLPSJ>; Mon, 12 Aug 2002 11:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSHLPSJ>; Mon, 12 Aug 2002 11:18:09 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18421 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318128AbSHLPSI>; Mon, 12 Aug 2002 11:18:08 -0400
Date: Mon, 12 Aug 2002 11:21:55 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-D5
Message-ID: <20020812112155.S1596@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0208121809340.20532-100000@localhost.localdomain> <Pine.LNX.4.44.0208121858280.21637-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208121858280.21637-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Aug 12, 2002 at 07:06:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 07:06:50PM +0200, Ingo Molnar wrote:
> 
> okay, the attached patch does some more things:
> 
>  - moves the first two TLS entries and the user CS/DS entries on the same
>    cacheline.
> 
>  - excludes CS/DS from the TLS space - Luca is right in that it only slows
>    things down unnecesserily, and there is nothing that cannot be done by
>    changing the %ds %cs selectors - and every cycle counts in the 
>    context-switch path.
> 
> the only open issues are the number of TLSs supported. I'd vote for making
> them 4 and then we can inline the copy and make it unconditional, it will
> be 12 cycles to copy them all which alone is better than a branch miss. In
> this patch it's 2, thus the copying cost is 6 cycles.
> 
> with 4 entries the 0x40 entry would be taken and APM has to move further
> up, and has to save/restore the 0x40 entry across BIOS calls.

As each supported TLS entry has its context-switch time cost, I think we
should stay at 2 supported TLS entries.
My understanding was that the GDT patches were written to optimize the
common case (all threaded apps using LDT and with the advent of __thread
support causing every single application to use LDT), with 2 TLS entries
where one is for libc/libpthread and the other one is for application
usage I think it is enough for 99.9% of apps. In the rare
case someone needs more, there is still LDT which offers 8192 entries.

	Jakub
