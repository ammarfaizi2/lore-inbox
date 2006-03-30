Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWC3Ww3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWC3Ww3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 17:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWC3Ww3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 17:52:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750842AbWC3Ww2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 17:52:28 -0500
Date: Thu, 30 Mar 2006 14:54:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Just Marc <marc@corky.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash soon after an alloc_skb failure in 2.6.16 and previous,
 swap disabled
Message-Id: <20060330145422.6c7e2517.akpm@osdl.org>
In-Reply-To: <442C0BA3.1050603@corky.net>
References: <442C0BA3.1050603@corky.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just Marc <marc@corky.net> wrote:
>
> I'm running a few machines with swap turned off and am experiencing 
> crashes when the system is extremely low on kernel memory.   So far the 
> crashes observed are always inside the recv function of the Ethernet 
> module, below is the trace for the tg3 module but a similar result is 
> also seen with the e1000 module.   Th crash is not necessarily related 
> to the Ethernet modules but may happen at a later stage deeper in the 
> networking code.
> 
> I don't have console access to the machine so I can't know what the 
> final oops/crash message is (if any) but this can be reproduced on any 
> machine quite easily by consuming all of the available memory,  I guess 
> that if done at userspace the OOM killer will prevent this from 
> happening but a simple LKM can allocate all this memory and this issue 
> should surface quickly.

We'd really need to see that final oops trace, please.

It's not unusual for a hard-working gigabit NIC to exhaust the page
allocator reserves and perhaps we're a bit too noisy in the logs when it
happens.  But it's sufficiently rare and sufficiently associated with other
problems (like this one) that nobody has yet gone and stuck the
__GFP_NOWARN into the relevant drivers to suppress the messages.

If we really have broken something in there then someone else will hit this
soon enough.  But nobody has, as far as I know.

A digital photo of the screen would suit.

Or perhaps netconsole.  If the crash is really associated with the NIC
running out of txbufs then netconsole might not be useful.  But perhaps the
crash is something else altogether.

Netconsole is pretty easy to get going.  See
Documentation/networking/netconsole.txt.  To the target machine's kernel
boot command line you add

netconsole=4444@a.b.c.d/eth0,5140@A.B.C.D/nn:nn:nn:nn:nn:nn

where a.b.c.d is the target machine's IP address and A.B.C.D is your
workstation's IP address and nn:nn:nn:nn:nn:nn is your workstation's MAC
address.

On the workstation, do

	netcat -u -l -p 5140


