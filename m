Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161927AbWKJSKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161927AbWKJSKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161928AbWKJSKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:10:31 -0500
Received: from mail.ggsys.net ([69.26.161.131]:13953 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1161927AbWKJSKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:10:30 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <454CDE6E.5000507@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Fri, 10 Nov 2006 11:36:24 -0600
Message-Id: <1163180185.28843.13.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The saga continues. It happened again this morning even with the
patch:

irq 193: nobody cared (try booting with the "irqpoll" option)
 <c013e19a> __report_bad_irq+0x2a/0xa0  <c013d970> handle_IRQ_event
+0x30/0x70
 <c013e2b0> note_interrupt+0x80/0xf0  <c013da8c> __do_IRQ+0xdc/0xf0
 <c0105799> do_IRQ+0x19/0x30  <c010391a> common_interrupt+0x1a/0x20
 <c0100d91> default_idle+0x41/0x70  <c0100e60> cpu_idle+0x80/0x90
 <c046699d> start_kernel+0x18d/0x1d0  <c0466330> unknown_bootoption
+0x0/0x1d0
handlers:
[<c0301300>] (qs_intr+0x0/0x240)
Disabling IRQ #193
ata4: command 0xea timeout, stat 0xff host_stat 0x0
ata1: command 0xea timeout, stat 0xff host_stat 0x0

[...]

The drives on this controller went offline.

This is my interrupts table:

cat /proc/interrupts
           CPU0       CPU1
  0:   48405419   48520371    IO-APIC-edge  timer
  1:         60        146    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          3    IO-APIC-edge  rtc
 10:         13         13   IO-APIC-level  ohci_hcd:usb1
 14:     228219     237351    IO-APIC-edge  ide0
 15:          3          9    IO-APIC-edge  ide1
145:          0          0   IO-APIC-level  ivtv0
153:    2272523    2393822   IO-APIC-level  ide2, ide3, ide4, ide5
161:       5416      23455   IO-APIC-level  ide8, ide9
169:       7148      22129   IO-APIC-level  ide6, ide7
185:    3680365         86   IO-APIC-level  eth0
193:     337154     162846   IO-APIC-level  libata
NMI:          0          0
LOC:   96924026   96924027
ERR:          0
MIS:          0

lspci -v shows this for the controller. No other device (at least
pci device) is using IRQ 193.


0000:01:03.0 0106: Pacific Digital Corp: Unknown device 2068 (rev 01)
        Subsystem: Pacific Digital Corp: Unknown device 2068
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
        I/O ports at eff0 [size=8]
        I/O ports at efe0 [size=8]
        I/O ports at efa8 [size=8]
        I/O ports at efa0 [size=8]
        Memory at febf0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: <available only to root>


Any other ideas I can try to look for? Is there any other type
of device that may be using the IRQ but not listed with the above
commands?

Thanks,

Alberto


On Sat, 2006-11-04 at 13:39 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > I have a Pacific Digital qstor card on irq 193. I am using kernel
> > 2.6.17.13 SMP
> > 
> > The error happens every now and then. I have not been able to
> > figure out any triggers and I can not reproduce it on demand. Today
> > it happened 3 times within a 40 minutes period. 
> > 
> > All disks connected to the card are disabled and I can't do anything
> > other than a reboot to get them back.
> > 
> > It is reported as follows:
> > 
> > irq 193: nobody cared (try booting with the "irqpoll" option)
> >  <c013e19a> __report_bad_irq+0x2a/0xa0  <c013d970> handle_IRQ_event
> > +0x30/0x70
> >  <c013e2b0> note_interrupt+0x80/0xf0  <c013da8c> __do_IRQ+0xdc/0xf0
> >  <c0105799> do_IRQ+0x19/0x30  <c010391a> common_interrupt+0x1a/0x20
> >  <c0100d91> default_idle+0x41/0x70  <c0100e60> cpu_idle+0x80/0x90
> >  <c046699d> start_kernel+0x18d/0x1d0  <c0466330> unknown_bootoption
> > +0x0/0x1d0
> > handlers:
> > [<c0301300>] (qs_intr+0x0/0x220)
> > Disabling IRQ #193
> 
> What other devices are routed to that same interrupt line?
> 
> The sata_qstor driver is very rigorous in acknowledging *only* it's own
> interrupts, to prevent other devices sharing the same IRQ from losing theirs.
> 
> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
> Try this patch (attached) and report back.
> 
> Thanks.
> 
> 
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

