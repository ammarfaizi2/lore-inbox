Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132009AbRCVVEj>; Thu, 22 Mar 2001 16:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbRCVVEb>; Thu, 22 Mar 2001 16:04:31 -0500
Received: from netel-gw.online.no ([193.215.46.129]:9741 "EHLO
	InterJet.networkgroup.no") by vger.kernel.org with ESMTP
	id <S132009AbRCVVDd>; Thu, 22 Mar 2001 16:03:33 -0500
Message-ID: <3ABA6848.B56CB12B@powertech.no>
Date: Thu, 22 Mar 2001 22:02:00 +0100
From: Geir Thomassen <geirt@powertech.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Penny <jpenny@universal-fasteners.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no> <20010322141937.C22479@universal-fasteners.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Penny wrote:
> 
> On Thu, Mar 22, 2001 at 07:21:28PM +0100, Geir Thomassen wrote:
> > My program controls a device (a programmer for microcontrollers) via the
> > serial port. The program sits in a tight loop, writing a few (typical 6)
> > bytes to the port, and waits for a few (typ. two) bytes to be returned from
> > the programmer.
> >
> > The program works, but it is very slow. I use an oscilloscope to monitor the
> > serial lines, and notices that there is a large delay between the returned
> > data, and the next new command. I really don't know if the delay is on the
> > sending or the receiving side (or both).
> >


> 
> 500ms seems a bit too long, but the quick answer is scheduler latency.
> You will certainly be scheduled out by the read, after all, it is not
> your program that is doing the read, but the kernel.  I think you are
> scheduled out after the write, as well.

I do believe the write will make the kernel write the first byte
into the UART transmit buffer directly. If this is the case, then the
data should appear on the serial lines almost immediately. There might be a
delay before the bottom half handler process the byte (or is the bottom half
only used on receive ?), but I do believe that this happens before the next
process is scheduled (BH handlers are all finished before any syscalls returns).
If this is the case, then scheduling out on write should not do any harm.

> 
> Your task is then sitting idle until the scheduler's next pass, if nothing
> else is happening, an interrupt is scheduled on the RTC, the CPU is set to
> idle power, and your system sleeps until the RTC wakes it back up, and
> the schedule queue is re-examined.
> 
> This normally implies a wait of at least a jiffy after every read.
>


Isn't a jiffy 10ms on i386 ? Scheduling delays should not be any
more than say 50 ms, but I am measuring 500ms. I could live with
50ms, which would make my program finish in 3 min. Now it is using
30 min !!

> 
> (But your time seems really excessive.)

Yep  :-(

> The usual cure is to write a custom driver which does a single
> read/write command.  If, as I recall, you are scheduled out on reads
> as well as writes, this lets you get rid of half the jiffies.

That could be the solution to my problem, but I won't start on that
before I understand what the problem is ...


Geir, geirt@powertech.no
