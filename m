Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266421AbSKGGNq>; Thu, 7 Nov 2002 01:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266452AbSKGGNq>; Thu, 7 Nov 2002 01:13:46 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:44042
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266421AbSKGGNp>; Thu, 7 Nov 2002 01:13:45 -0500
Date: Thu, 7 Nov 2002 01:20:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Corey Minyard <cminyard@mvista.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: Re: NMI handling rework
In-Reply-To: <3DCA0BCC.3080203@mvista.com>
Message-ID: <Pine.LNX.4.44.0211070103540.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Corey Minyard wrote:

> Ingo et al...
> 
> Since a lot of things have started tying into the NMI handler (oprofile, 
> nmi watchdog, memory errors, bus error, now the IPMI watchdog), I think 
> it better to use a request/release mechanism for the NMI handlers. 
>  Plus, I think the current NMI code is actually not correct, it's 
> theoretically possible to miss NMIs if two occur at the same time.  So 

How? The NMI interrupt should be internally masked till IRET. I think your 
code is ok, but i don't see how it takes care of concurrent users such as 
oprofile and the nmi watchdog, the nmi watchdog already programs its own 
interrupt interval if its shared, what is the intended base NMI interval? 
How about handlers requiring a different interrupt interval? I have code 
which does the following;

base NMI poll function with time interval T;
master queue with slots per timeout;
slots with task queues which are flushed whenever we hit the timeout;

you can therefore add tasks in with specific time intervals which will get 
triggered. This code currently is only running the nmi watchdog, but i'll 
be experimenting with various other handlers. I'll post a URL soon.

To support external devices which trigger NMI we can simply check wether 
we have hit an nmi interval period, if not we run through the NMI handler 
lists.

	Zwane
-- 
function.linuxpower.ca

