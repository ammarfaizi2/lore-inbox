Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271918AbRIMR2v>; Thu, 13 Sep 2001 13:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271913AbRIMR2o>; Thu, 13 Sep 2001 13:28:44 -0400
Received: from zeus.nmt.edu ([129.138.41.24]:20219 "EHLO zeus.lma.net")
	by vger.kernel.org with ESMTP id <S271918AbRIMR2d>;
	Thu, 13 Sep 2001 13:28:33 -0400
Date: Thu, 13 Sep 2001 11:28:52 -0600 (MDT)
From: Timothy Hamlin <thamlin@zeus.nmt.edu>
To: <linux-kernel@vger.kernel.org>
Subject: questions of a kernel-newbie, simple ISA driver
Message-ID: <Pine.LNX.4.30.0109131124420.20602-100000@zeus.lma.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello kernel wizards,

I'm in the process of developing a simple device driver for a board my
research group has been using for some time in our lightning mapping
system.  I've made progress understanding how to get kernel modules
written, but have some questions -- this is my first kernel module of any
real use.  Here's a brief description of the hardware:

This is an ISA board that has a settable base address, usually 0x230.
The board has a 16bit wide FIFO (baseAddr + 4) that is 32k deep.  As data
flows in, the data accumulates in the FIFO.  When the FIFO is 1/2 full a
flag is set in a status register (baseAddr + 1).  The driver needs to read
1/2 of the FIFO and make the data available in a /dev entry.  So far I've
got the polling for the flag working, and can get the data out of the
FIFO.  Interrupts are also possible, but I thought it best to start by
getting the polling function to work, as I will need to re-program the
firmware to enable interrupts.

The first question is how to deal with the data.  The main reason for
switching to a kernel module is that a user-side driver (which is what
I've used so far) can not always keep up with the data rate, as the FIFO
fills potentially 100 or so times/second.  My first thought is to keep a
larger buffer for the data, so that a user program can have lesser time
constraints when it comes to getting a hold of the data.

I guess it would flow something like this:

Driver polls for the 1/2 full FIFO flag, when found transfer 16k words out
of the FIFO and place this in a larger buffer, say 320k or something.
How would I maintain this buffer?  Reads to the /dev entry need to be able
to get a continuous stream from the device, how do I keep the buffer both
filling, and being read out at the same time?  Should I make the buffer a
FIFO as well?  How?  How do I keep track of what has been read from the
buffer, so that subsequent reads get new data, not data that is lower down
in the buffer?  Can I allow multiple processes to be reading from this
/dev entry without loosing data to any of them?

Also, when I read for a device like a serial port I can just do cat
/dev/ttyS0 and watch the stream coming in.  So far in my driver, a read
performs one operation, outputs whatever, and then stops.  So a cat of my
device only transfers the current data, and then just sits there.  How do
I keep that steam going so that a cat will continually update?

One more.  What's the best way to poll for the 1/2 full flag?  Right now
I'm using a queue_task(), which gets called on every timer interrupt, is
this reasonable, or is there a better way to do it?

TIA for any suggestions, or any pointers to simple skeleton sources that
might help give my foolish mind a little direction.

^t
  --------------------------------------------------------------------------
   Timothy Hamlin ** thamlin at nmt dot edu ** http://www.nmt.edu/~thamlin/
  --------------------------------------------------------------------------
       Department of Physics, NMIMT, Socorro NM 87801
       Office, Workman 251: 835-5137  Lab, Workman 246
       Home,   Polvadera  : 835-0805
       "Linux, the choice of a GNU generation."

