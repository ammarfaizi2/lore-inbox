Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVECVsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVECVsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVECVsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:48:22 -0400
Received: from open.hands.com ([195.224.53.39]:6875 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261812AbVECVrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:47:45 -0400
Date: Tue, 3 May 2005 22:56:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: tricky challenge for getting round level-driven interrupt problem: help!
Message-ID: <20050503215634.GH8079@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, please kindly respond cc to me because i am subscribed to the
lists for post-only-and-view-archives-on-demand-to-minimise-overload
purposes.

i have a particularly acute and knotty computing problem involving
a stupid hardware design fault in a cirrus logic "maverick" EDB 7134
ARM processor (max 90Mhz).

it only does level-based interrupts and i need to create a driver
that does two-way 8-bit data communication.

i would genuinely appreciate some advice from people with
more experience than i on how to go about getting round
this stupid hardware design - in order to make a RELIABLE,
non-race-conditioned kernel driver.


hardware
--------

connected to the ARM's 8-bit port is a 6Mhz p16f877a PIC processor.

connected to the serial and other ports of the PIC processor are
various peripherals, including an LCD, a GPS satellite receiver,
an accelerometer and the battery level / charger detector.

on the PIC is some assembler code that:
--------------------------------------

* merges GPS, Accelerometer, battery and charger information
  into a data stream that goes out the 8-bit port of the PIC and
  in on the ARM's 8-bit port.

* receives instructions from the ARM down the same 8-bit port,
  in a custom-designed length-encoded data stream that tells
  the PIC what to put on the LCD, and where.

interrupts are generated as follows:
------------------------------------

* on the PIC, a "read" interrupt can be asserted to the ARM.
  it's xxxxing level-based.

* on the PIC, a "write" interrupt can be asserted to the ARM.
  it's xxxxing level-based.

* on the ARM, a SINGLE interrupt can be generated to the PIC
  by EITHER reading OR writing to the PIC's 8-bit port.
  
  unlike the stupid xxxxing ARM, it's edge triggered (thank god).

interrupts are cleared as follows:
---------------------------------

* on the PIC, in the [single!] ISR routine, if the PIC knows
  that it was doing a read, it resets the "read" interrupt
  flag to the ARM.

  [the problem is obvious: a level-based interrupt could fail
   to be acknowledged, could be masked out and accidentally
   regenerated, and we are into "nightmare" scenario time]

* on the PIC, in the [single!] ISR routine, if the PIC knows
  that it was doing a read, it resets the "read" interrupt
  flag to the ARM.

  [the problem is obvious: a level-based interrupt could fail
   to be acknowledged, could be masked out and accidentally
   regenerated, and we are into "nightmare" scenario time]

* on the ARM, in the READ isr routine, the PIC "reads" the
  byte, THIS ACT generates an interrupt to the PIC, which
  the ARM then acknowledges by waiting - in a tight loop - 
  for the PIC to clear the "read" interrupt flag.

  [this is the old code btw, not the new code: for brevity
   i have not described exactly how bad the code is]

* on the ARM, in the WRITE isr routine, similar situation
  as for "read".


the protocol that i designed to overcome the race condition
nightmare is as follows:

* ARM and PIC ****MUST**** exchange read and write bytes, interleaved.

* if the ARM does not have anything to write [to the LCD] at the
  time that a read is to be carried out, it sends a "dummy"
  or "null" encoded data stream indicating to the PIC that it
  is receiving data of zero length.

  the sole purpose of initiating this "i-am-sending-you-zero-bytes"
  dummy stream of bytes is to keep the read-write-read-write....
  cycle going.

* if the PIC does not have anything to be read [from the GPS
  and other peripherals] then it sends "0xff" instead.  the ARM
  receives this non-ascii byte and knows that it must throw it
  away.

  the sole purpose of sending this "non-ascii" byte is to keep
  the read-write-read-write... cycle going.

* if there is both read and write data to be exchanged, everything
  is hunky-dory.

* if there is no data to be exchanged, everything is hunky-dory.


here's where i have got to, and where i am stuck:
----------------------------------------------------

on the ARM, i have cut/paste the code from sonypi.c to create
a poll_wait "read" driver.  it is pretty much exactly the same
structure as sonypi.c, as far as "read" is concerned.

so, when reading, I/O is in non-blocking mode, the queue is
empty, a WAITQUEUE is woken up, present kernel process is made
"TASK_INTERRUPTIBLE", schedule()d, a read interrupt is [eventually]
generated and read data added to queue, then pic_misc_poll() detects
data now present, and "WAKES UP" the waiting blocking process.

everything hunky-dory.


here's where i have got to, and where i am stuck:
----------------------------------------------------

i don't know how to "wake up" an equivalent write process.

because there isn't one.

the situation where there is simultaneous blocking-read and
blocking-write _could_ be covered by duplicating the sonypi.c code
_again_ for writing.

that leaves the situations where there is ONLY read occurring.

bearing in mind that reads must be interleaved with writes,
and those reads must be intitiated from inside the "read"
interrupt service routine.... what the hell do i do?

i think i have a clue in that the "old" pic_write() code would
unmask the Write Interrupt, and a "write" interrupt would
immediately occur - then once we'd done, Write Interrupts
would be re-masked again.


any advice really appreciated because this is one mean comp-sci
classic that really only _actually_ occurs in real life when
there's a fuckup in the hardware design and you don't have
any choice but to make it work :)

cheers,

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
