Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTDCRiV 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261440AbTDCRiU 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:38:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40975 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261380AbTDCRiP 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:38:15 -0500
Date: Thu, 3 Apr 2003 09:48:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function needs mb() - oopsable
In-Reply-To: <Pine.LNX.4.50.0304030119270.29397-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0304030937360.27631-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Apr 2003, Zwane Mwaikambo wrote:
>
> I have a 3 Processor Pentium 133 system w/ 512k external cache which is 
> oopsing reliably in the exact same location.

Whee. What a piece of "interesting hardware".

>					 The problem is that the 
> current memory barrier in smp_call_function is a simple gcc optimisation 
> barrier, we really need a memory barrier there so that the other cpu's 
> get the updated value when they get IPI'd immediately afterwards. 

I really think that your patch is a bit questionable. The wmb() on the 
sender side looks correct as-is, and to me it looks like it is the 
_receiver_ side that might need a read-barrier before it reads 
call_data(). 

I really thought that the interrupt should be a serializing event, but I 
can't find that in the intel databooks (they make "iret" a serializing 
instruction, but not _taking_ an interrupt, unless I missed something).

Can you check if you get the right behaviour if you have a read barrier in 
the receive path? I actually think we need a full mb() on _both_ paths, 
since the current wmb() only guarantees that writes will be seen "in 
order wrt other writes", and while the IPI generation really _is_ a write 
in itself, I wonder if the Intel CPU's might not consider it something 
special..

I'm not opposed to your patch per se, but I really do believe that it is 
potentially wrong. If we have no serialization on the read side, your 
patch might not actually fully plug the real bug, only hide it. I'd like 
to know if a read barrier on the read side (without the full barrier on 
the write side) is sufficient. It _should_ be (but see my worry about the 
APIC write maybe being considered "outside the scope" of the normal cache 
coherency protocols).

			Linus

