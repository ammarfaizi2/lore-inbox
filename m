Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278176AbRJRWS6>; Thu, 18 Oct 2001 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278177AbRJRWSi>; Thu, 18 Oct 2001 18:18:38 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:20870 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278176AbRJRWSc>; Thu, 18 Oct 2001 18:18:32 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: <linux-kernel@vger.kernel.org>, Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 00:18:28 +0200
Message-Id: <20011018221828.23673@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org>
In-Reply-To: <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>When the driver gets a save_state request, that is its notification that
>it is going to sleep. It should then stop/finish all I/O requests. It
>should then prevent itself from taking any more - by setting a flag or
>whatever. Then, device save state. 

Ok, that's what I call more or less "blocking IO queues"..

>From that point in, it should know not to take any requests, theoretically
>preserving state. 

But that's my problem :) Imagine another driver next in the loop need
memory and call swap_out to happen. Problem: you just have blocked the
IO queue of your swap device.

>When it gets the restore_state() call, it should first restore device
>state. Once it does that, it knows that it can take I/O requests again. 
>
>That should work, right?
>
>The only thing that that won't work for is the device to which we're
>saving state, like the disk. At some point, though we have to accept that
>the state that we saved was some checkpoint in the past, and it won't
>reflect the state that changed in the process of writing the system state.

That's why I prefer more explicit semantics:

 - Prepare sleep: Allocate enough memory to save state. For most
devices, it will be a fixed quantity. In the case of devices that need
per-request allocation, like USB of firewire, just allocate a limited
pool. That means that you will eventually cause serialisation to
happen when not needed and hurt perfs, but nobody will care at this
point ;)

 - Suspend activity: There you lock your IO queues, set your busy flag
or whatever, and wait for any pending IO to be completed. Interrupts
are enabled, scheduling as well (and other CPUs). Each driver is
responsible to properly block a process issuing a request (which should
not be a problem to implement for most of them, a single semaphore
is enough for simple drivers, drivers with IO queues just need to
leave requests in the queues, etc...)

 - Set power state: Here you shut your device down for real. Interrupt
are disabled. Only one CPU is still active (the others can be put in
whatever state your arch allow, like a sleep loop or whatever...).

The actual state save can be in step 2 or 3, we don't really care,
it depends mostly on what is more convenient for the driver writer.

The resume process only needs 2 state imho:

 - Set power state: You power back on your device, re-configure the
hardware properly, and make sure it won't send spurrious interrupts.
System interrupts are disabled. One CPU is running.

 - Resume activity: System interrupts are back, scheduling too, you
start handling pending requests.


Regards,
Ben.


