Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTLWMsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 07:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbTLWMsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 07:48:55 -0500
Received: from camus.xss.co.at ([194.152.162.19]:46340 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265127AbTLWMst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 07:48:49 -0500
Message-ID: <3FE839AF.9090904@xss.co.at>
Date: Tue, 23 Dec 2003 13:48:47 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.23, 2.4.24-pre: Interrupt balancing problem
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Interrupt balancing doesn't work anymore on an Asus Dual
Xeon Server (AP1700-S5, ASUS PR-DLS533 MB, Dual Xeon HT).

Last kernel where this worked was 2.4.21-ac:

 cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:   32414607   32353905   32486435   32470963    IO-APIC-edge  timer
  1:          1          0          0          1    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
 15:          1          0          0          1    IO-APIC-edge  ide1
 18:   22702419   22631022   22668864   22843971   IO-APIC-level  eth0
 22:   15021656   15223388   15112963   14929184   IO-APIC-level  ioc0
 23:          9          7         15         11   IO-APIC-level  ioc1
NMI:          0          0          0          0
LOC:  129727116  129727115  129727114  129727114
ERR:          0
MIS:          0

Note that on this particular hardware, I have to boot with
"acpi=off" or "pci=noacpi" in order to get the Fusion MPT
hardware recognized (see my other bug report a few minutes ago)

I didn't check 2.4.22, but with 2.4.23 and 2.4.24-pre2
I get something like the following:

Booted with "acpi=off":
root@tolstoi:~ {502} $ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:      41424          0          0          0    IO-APIC-edge  timer
  1:          2          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
 11:          0          0          0          0   IO-APIC-level  usb-ohci
 18:       8235          0          0          0   IO-APIC-level  eth0
 22:      34704          0          0          0   IO-APIC-level  ioc0
 23:         42          0          0          0   IO-APIC-level  ioc1
NMI:          0          0          0          0
LOC:      41271      41270      41270      41269
ERR:          0
MIS:          0


Booted with "pci=noacpi":
root@tolstoi:~ {502} $ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:      89806          0          0          0    IO-APIC-edge  timer
  1:          2          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  9:          0          0          0          0          XT-PIC  acpi
 11:          0          0          0          0   IO-APIC-level  usb-ohci
 18:      12481          0          0          0   IO-APIC-level  eth0
 22:      12518          0          0          0   IO-APIC-level  ioc0
 23:         42          0          0          0   IO-APIC-level  ioc1
NMI:          0          0          0          0
LOC:      89651      89650      89650      89650
ERR:          0
MIS:          0


I also tried boot options "noirqbalance" and "acpi_irq_balance",
but interrupts were still served on CPU0 only (SMP is working,
though: I can build the kernel with "make -j4" and as "top" tells
all four logical CPU's are used perfectly well)

Bug or feature?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6DmtxJmyeGcXPhERAtRnAJ0aJwcH0BL2yY2o9hz1rNU4Nmh9DgCfeUHc
LRlp1wMHcRRPd25q0LiQk2c=
=13fn
-----END PGP SIGNATURE-----

