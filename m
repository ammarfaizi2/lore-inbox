Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTGBSEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTGBSEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:04:13 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:11649 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S264186AbTGBSEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:04:07 -0400
Subject: Re: ICH5 SATA causes high interrupt/system load?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F01F1F5.5050907@pobox.com>
References: <1057087443.3373.4.camel@paragon.slim>
	 <3F01F1F5.5050907@pobox.com>
Content-Type: text/plain
Message-Id: <1057169427.3261.14.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 02 Jul 2003 20:10:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 22:41, Jeff Garzik wrote:
> Well, in legacy mode (a.k.a. normal), each ATA port (a.k.a. channel 
> a.k.a. bus) gets their own interrupt, which is never shared with another 
> device.
> 
> In native mode (a.k.a. enhanced), two ATA ports share a single PCI 
> interrupt.  Further, this interrupt may be shared with any number of 
> other PCI devices.
> 
> So, high interrupt count is necessarily a worry because you're probably 
> seeing a coalescing of multiple interrupt counts into one big one.
> 
> 	Jeff
Hmm, it still looks like this is a driver problem. Because

a) your SCSI-ATA driver doesn't show this behavior..;-)
b) booting to XP also doesn't show this behavior. 

BTW it seems that all ATA ports have their own interrupt:

           CPU0       CPU1
  0:      52132      52728    IO-APIC-edge  timer
  1:          2          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       5062       5316    IO-APIC-edge  ide0
 15:          1          1    IO-APIC-edge  ide1
 16:      43464      43565   IO-APIC-level  usb-uhci, usb-uhci, nvidia
 17:      26180      26194   IO-APIC-level  Intel ICH5
 18:  119342344  119704504   IO-APIC-level  ide2, usb-uhci
 19:       1682       2649   IO-APIC-level  usb-uhci
 21:        460        467   IO-APIC-level  eth0
 22:        576        571   IO-APIC-level  SysKonnect SK-98xx
 23:         18         15   IO-APIC-level  ehci-hcd
NMI:          0          0
LOC:     104773     104781
ERR:          0
MIS:          6

Except ide2 is sharing it's interrupt with a usb controller. Doing
nothing gives:

 20:08:28  up 19 min,  3 users,  load average: 0.08, 0.06, 0.02
75 processes: 74 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:   0.5% user  20.2% system    0.0% nice   0.0% iowait  78.2%
idle
CPU1 states:   0.5% user  17.0% system    0.0% nice   0.0% iowait  81.4%
idle
Mem:   515128k av,  187396k used,  327732k free,       0k shrd,   13336k
buff
        45524k active,             118320k inactive
Swap:  787176k av,       0k used,  787176k free                   90804k
cached

With your patch and in XP a have a nice nullish system load.

Greetings,

Jurgen





