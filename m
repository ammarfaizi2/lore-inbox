Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbRF2T12>; Fri, 29 Jun 2001 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266162AbRF2T1S>; Fri, 29 Jun 2001 15:27:18 -0400
Received: from mnh-1-20.mv.com ([207.22.10.52]:50952 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266161AbRF2T1H>;
	Fri, 29 Jun 2001 15:27:07 -0400
Message-Id: <200106292040.PAA03583@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
cc: mistral@stev.org, linux-mm@kvack.org, rcastro@ime.usp.br, abali@us.ibm.com,
        riel@conectiva.com.br, phillips@bonn-fries.net, viro@math.psu.edu
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state 
In-Reply-To: Your message of "Mon, 25 Jun 2001 20:33:17 GMT."
             <Pine.LNX.4.30.0106252031240.25982-100000@cyrix.stev.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jun 2001 15:40:16 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To recap the story so far, a number of people have reported seeing processes 
hang indefinitely in TASK_UNINTERRUPTIBLE in __wait_on_buffer or __lock_page, 
both on physical boxes and under UML.  It was found to be reproducable under 
UML, but not on a native kernel as far as I know.

I've fixed this problem in UML.

The short story :

The bug was UML-specific and specific in such a way that I don't think it's 
possible to find the bug in the native kernel by making analogies from the UML 
bug.

The long story :

First, two pieces of background information
	- UML's ubd block driver performs asynchronous I/O by using a separate thread 
to perform the I/O.  The driver's request routine writes the request to the 
I/O thread over a file descriptor.  The thread performs the request by calling 
either read() or write() on the host.  When that call returns, it writes the 
results back to UML, causing a SIGIO.  That goes through the normal IRQ system 
and ends up in the ubd interrupt handler, which finishes the request, and, if 
the device request queue isn't empty, starts the next request.
	- A couple of weeks ago, I made a change to reduce the number of clock ticks 
that UML loses under load.  The clock is implemented with SIGALRM and 
SIGVTALRM.  The change involved leaving those signals enabled all the time, 
and having the handler decide whether it was safe to invoke the timer irq.  If 
not, it bumped a missing_ticks counter and returned.  The missing ticks are 
fully accounted for the next time the handler finds that it can call into the 
irq system.

The ubd request routine runs with interrupts off, but now, the alarms could at 
least fire, even if they didn't do anything but increment a counter.  This 
occasionally caused the write of the I/O request from the request routine to 
the I/O thread to return -EINTR.  The return value wasn't checked, so the I/O 
thread didn't get the request and the request routine had no idea that 
anything was wrong.  This caused disk I/O to permanently shut down, so pending 
requests stayed pending, and processes waiting on them waited forever.

The key piece of this bug was a signal causing a crucial communication between 
two UML threads to be lost.  I don't see any analogies between this and 
anything that happens on a physical system, so it looks to me like the problem 
that people are seeing there is completely different.

Thanks to James Stevenson for figuring out how to reproduce the bug under UML, 
and to Daniel Phillips and Al Viro for help in tracking this problem from the 
fs and mm systems into the block and driver layers.

				Jeff


