Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTGYBlB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGYBlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:41:01 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:63157 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263930AbTGYBk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:40:58 -0400
Subject: Re: another must-fix: major PS/2 mouse problem
From: Albert Cahalan <albert@users.sf.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, linux-yoann@ifrance.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, vortex@scyld.com, jgarzik@pobox.com
In-Reply-To: <20030724103047.31e91a96.akpm@osdl.org>
References: <1054431962.22103.744.camel@cube> <3EDCF47A.1060605@ifrance.com>
	 <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com>
	 <1058921044.943.12.camel@cube>  <20030724103047.31e91a96.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059097601.1220.75.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jul 2003 21:46:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-24 at 13:30, Andrew Morton wrote:
> Albert Cahalan <albert@users.sourceforge.net> wrote:

> > Using the lockmeter on a 2.5.75 kernel, I discovered
> > that boomerang_interrupt() grabs a spinlock for over
> > 1/4 second. No joke, 253 ms. Interrupts are off AFAIK.
> 
> boomerang_interrupt() doesn't disable interrupts.  Is the NIC sharing the
> mouse's IRQ line?

No.

           CPU0       
  0:     746770          XT-PIC  timer
  1:        936          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          9          XT-PIC  serial
  5:          0          XT-PIC  uhci-hcd, uhci-hcd
 11:       2417          XT-PIC  eth0
 12:         60          XT-PIC  i8042
 14:      13844          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0 
LOC:     751552 
ERR:          0
MIS:          0


> boomerang_interrupt() is only used by nasty old NICs and yes, I guess it is
> possible that something has gone wrong and is causing occasional long spins
> in there.
> 
> But I am more suspecting that you're not really using boomerang_interrupt()
> at all, and that something has gone wrong with lockmeter.  What sort of NIC
> are you using?

I hope you don't consider a 100 Mb/s PCI device to be
a nasty old NIC. It's not an NE2000 you know! I have this:

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at ec00 [size=128]
        Memory at df001000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

Without heavy net usage, boomerang_interrupt can take
as long as 1950 microseconds. That would be from mounting
an NFS filesystem and receiving broadcast packets.
I didn't have an opportunity to hit NFS hard today.

That's from rdtsc on a 1002-MHz Pentium III.

> Bear in mind that if some other device generates an interrupt while the CPU
> is running boomerang_interrupt(), lockmeter will count the time spent in
> that other device's interrupt as "time spent in boomerand_interrupt()". 
> Which is very true, but it is not much help when one is trying to identify
> the source of the problem.

Do the Intel IRQ controller priority rules play a role here?

> Perhaps what you should do is to do an rdtsc on entry and exit of do_IRQ()
> and print stuff out when "long" periods of time in do_IRQ() are noticed.

I added code to the top and bottom of do_IRQ, as well as to
the top and bottom of boomerang_interrupt. The lockmeter was
compiled into the kernel but never enabled. I record the
minimum and maximum time in microseconds.

-------------------------------
IRQ    num use      min     max
--- ------ -------- --- -------   
  0 746770 timer     40  103595
  1    936 i8042     13  389773
  2      0 cascade    -       -
  3      - -          -       -
  4      9 serial    28      56
  5      0 uhci-hcd   -       -
  6      - -        711     711
  7      - -         25      25
  8      - -          -       -
  9      - -          -       -
 10      - -          -       -
 11   2417 eth0      87 1535331
 12     60 i8042     18  102895
 13      - -          -       -
 14  13844 ide0       8   51944
 15      2 ide1       7      11 
NMI      0
LOC 751552
ERR      0
MIS      0
-------------------------------



