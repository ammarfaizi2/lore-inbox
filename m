Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUCWK0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUCWK0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:26:43 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:12943 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262439AbUCWK0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:26:38 -0500
Date: Tue, 23 Mar 2004 11:26:37 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Robert_Hentosh@Dell.com, fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.44.0403222105380.3493-100000@poirot.grange>
Message-ID: <Pine.LNX.4.55.0403231103260.16819@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0403222105380.3493-100000@poirot.grange>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Guennadi Liakhovetski wrote:

> 1) during start-up 1 message
> spurious 8259A interrupt: IRQ7.

 That's probably a result of our local APIC setup code being a bit 
careless when seting up the ExtINTA mode.  The mode is used for a 
cooperation between an 8259A PIC and a local APIC in the so-called 
virtual-wire mode.

> 2) at run-time ERR: count increases - sometimes several per
> second, sometimes it remains constant for some time.
> 3) No more "spurious" messages

 It's output at most once not to clutter the log.

> 4) I saw definitely situations, when between 2 /proc/interrupts snapshots
> the sum of all (except the timer) interrupts was smaller, than the number
> of errors, e.g.
> 
>            CPU0 (2nd shot)
>   0:      36557  37638 +1081 XT-PIC  timer
>   1:         59     65    +6 XT-PIC  i8042
>   2:          0      0       XT-PIC  cascade
>   5:          0      0       XT-PIC  VIA686A
>   8:          3      3       XT-PIC  rtc
>   9:          0      0       XT-PIC  acpi, uhci_hcd, uhci_hcd
>  10:          0      0       XT-PIC  eth0
>  12:         84     84       XT-PIC  i8042
>  14:       1910   1918    +8 XT-PIC  ide0
>  15:          1      1       XT-PIC  ide1
> NMI:         18     18
> LOC:      36460  37541 +1081
> ERR:         36     57   +21
> 
> ide0 + i8042 (keyboard) = 14, whereas errors increased by 21. So, if you
> are right, than Alan's wrong (or my understanding of his statement), and
> those spurious interrupts occur not only after real ones, or, one real
> interrupt can produce several spurious ones.

 The PIT timer (IRQ 0 above) is edge-triggered, so it cannot cause
spurious interrupts as a trail of real ones.  Ditto for the keyboard
controller (IRQ 1) and onboard IDE (IRQ 14).  The local APIC timer
interrupt (LOC) doesn't go through the 8259A.

 So without additonal debugging, I'd suspect noise on the interrupt lines,
either due to a board design error or an erratum in one of devices (IRQ
9?).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
