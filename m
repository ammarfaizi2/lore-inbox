Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTIHQdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTIHQdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:33:12 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:44435 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262725AbTIHQdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:33:10 -0400
Message-ID: <3F5CB08C.2040307@pacbell.net>
Date: Mon, 08 Sep 2003 09:38:36 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] IDE:PORTS ALREADY IN USE | USB: irq 11: nobody
 cared! | loop pcmcia_core.ko which needs pcmcia_core.ko | 2.6.0-test4 cset
 20030906_2214
References: <200309072132.15278.arekm@pld-linux.org>
In-Reply-To: <200309072132.15278.arekm@pld-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:

> 4) USB no longer working. Was working fine in vanilla test4.

I'm suspecting this is because of a change to make UHCI
initialization more closely match what EHCI and OHCI do:
kick out pre-OS (BIOS/SMM/...) boot time hooks, then reset.

Try changing uhci_reset() so it calls hc_reset() first,
and then does the config space write to get rid of "legacy
support mode".   That's the sequence it used before, which
seems odd because it's resetting hardware that it's not yet
responsible for.  Maybe the hc_reset() code should turn off
that legacy mode, and do some IRQ blocking.


> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
> v2.1
> uhci-hcd 0000:00:11.2: UHCI Host Controller
> irq 11: nobody cared!
> Call Trace:
>  [<c010cbdb>] __report_bad_irq+0x2b/0x90
>  [<c010ccd4>] note_interrupt+0x64/0xa0
>  [<c010cf6e>] do_IRQ+0x12e/0x140
>  [<c010b49c>] common_interrupt+0x18/0x20
>  [<c0124603>] do_softirq+0x43/0xa0
>  [<c010cf48>] do_IRQ+0x108/0x140
>  [<c010b49c>] common_interrupt+0x18/0x20
>  [<c01add8c>] pci_bus_write_config_word+0x5c/0x80
>  [<cf9f94a0>] uhci_reset+0x40/0x50 [uhci_hcd]

There's the problem ... at least with your hardware and BIOS;
it worked OK on mine.

Seems that whatever mode the hardware is in at that point,
it feels free to send an un-asked-for IRQ.


>  [<cf8a6a32>] usb_hcd_pci_probe+0x192/0x480 [usbcore]
>  [<c01b176b>] pci_device_probe_static+0x4b/0x60
>  [<c01b18d6>] __pci_device_probe+0x36/0x50
>  [<c01b191c>] pci_device_probe+0x2c/0x50
>  [<c01f5dad>] bus_match+0x3d/0x70
>  [<c01f5f00>] driver_attach+0x70/0xb0
>  [<c01f6201>] bus_add_driver+0xa1/0xc0
>  [<c01f6651>] driver_register+0x31/0x40
>  [<c01b1b9e>] pci_register_driver+0x5e/0x90
>  [<cf8e90c7>] uhci_hcd_init+0xc7/0x143 [uhci_hcd]
>  [<c0137043>] sys_init_module+0x123/0x270
>  [<c010b32f>] syscall_call+0x7/0xb
> 
> handlers:
> [<cf91c4b0>] (snd_via82xx_interrupt+0x0/0x110 [snd_via82xx])
> Disabling IRQ #11
> uhci-hcd 0000:00:11.2: irq 11, io base 0000d400
> uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
> hub 1-0:0: USB hub found
> hub 1-0:0: 2 ports detected
> uhci-hcd 0000:00:11.3: UHCI Host Controller
> uhci-hcd 0000:00:11.3: irq 11, io base 0000d800
> uhci-hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
> hub 2-0:0: USB hub found
> hub 2-0:0: 2 ports detected
> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
> hub 1-0:0: new USB device on port 1, assigned address 2
> usb 1-1: control timeout on ep0out
> uhci-hcd 0000:00:11.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.

Unclear why it's now not receiving IRQ 11 ... it's fair to
disable IRQ #11 when there's no IRQ handler for it, but at that
point there is a handler and I'd sure expect it to work.  Which
suggests there is a second IRQ-related problem here.

- Dvae



