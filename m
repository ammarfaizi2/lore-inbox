Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293712AbSCAUVj>; Fri, 1 Mar 2002 15:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293713AbSCAUV2>; Fri, 1 Mar 2002 15:21:28 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5106 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S293712AbSCAUVW>; Fri, 1 Mar 2002 15:21:22 -0500
Date: Fri, 1 Mar 2002 21:21:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe Korty <joe.korty@ccur.com>
cc: Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] irq0 affinity broke on some i386 boxes
In-Reply-To: <200203011951.TAA12018@rudolph.ccur.com>
Message-ID: <Pine.GSO.3.96.1020301210300.10687A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Joe Korty wrote:

> PS: My original dmesg logs may now be found at
> http://www.mindspring.com/~jakorty/irq0.bugreport.orig.

 If you only have a line similar to this one:

..TIMER: vector=0x31 pin1=2 pin2=0

then a normal I/O APIC interrupt (pin1) is used and the patch is
irrelevant. 

 If you have lines like these:

..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.

then IRQ 0 is not registered so far (pin1 is -1) and add_pin_to_irq() 
(added by your patch) is invoked ordinarily for pin2 like for other
interrupts.

 But if you have lines like these:

..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.

then IRQ 0 needs to be rerouted from pin1 to pin2 and replace_pin_at_irq() 
is intended to do so.  I'd be pleased to hear from someone with such a
system (they are quite common surprisingly); I'll simulate such a
configuration with my development system anyway.

 Other timer configurations (they are two more, sigh) don't matter as they
don't route IRQ 0 via an I/O APIC.  They are very rare as well.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

