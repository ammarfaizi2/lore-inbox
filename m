Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVCNDFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVCNDFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVCNDFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:05:00 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:7576 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261639AbVCNDEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:04:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.65343.691838.131927@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 14:04:31 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e4733910503131755509a9364@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<9e473391050312075548fb0f29@mail.gmail.com>
	<Pine.LNX.4.61.0503121009130.2166@montezuma.fsmlabs.com>
	<9e4733910503131755509a9364@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Jon> On Sat, 12 Mar 2005 10:11:18 -0700 (MST), Zwane Mwaikambo
Jon> <zwane@arm.linux.org.uk> wrote:
>> Alan's proposal sounds very plausible and additionally if we find
>> that we have an irq line screaming we could use the same supplied
>> information to disable userspace interrupt handled devices first.

Jon> I like it too and it would help Xen. Now we just need to modify
Jon> 800 device drivers to use it.

It's incomplete.  But you probably knew that...

The main problem I see is that even with the proposed interface, you'd
need to disable the interrupt in the interrupt controller, because
merely acknowledging an interrupt to a device doesn't stop it from
interrupting.  And you really want the device to stop asserting the
interrupt before doing an EOI, unless you're going to mask the
interrupt.  So you'd need to have an interface that not only
acknowledged the current interrupt but also prevented the device from
interrupting.  That typically means reading a status register (slow!)
and then setting one or more bits in one or more control registers.

Also for a user level driver you really want to do the EIO before
invoking user space.  Otherwise, depending on the interrupt
controller, lower numbered interrupts could be masked until the user
space returns --- which might be a long time off.

Reading the status register is typically one of the slowest
single parts of a device driver (latency can be > 2 usec), so you don't
really want to have to read it again within the driver... so you'd
probably want to pass it as part of the interrupt arguments to the
driver.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
