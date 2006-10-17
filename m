Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWJQSwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWJQSwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWJQSwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:52:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:8262 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751036AbWJQSwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:52:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tSEs9dLtj6CvENwN2t9TJW+tXaL8Y9ufnfnMGBZexzMCkpzjq3UaZlIW4Ji4TzVa8eRslZkHhEqAQjX+xHVtIX2eyiAQYpgv1zQ69CEuqAYoT1TUhWM9Tz6zf65g+ys8Tn670Ee5kegO1SVJD433uW8sk+dG5cGbiH0/jaCWXuA=
Message-ID: <4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com>
Date: Tue, 17 Oct 2006 11:52:16 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 - another DWARF2
In-Reply-To: <20061017063710.GA27139@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061017063710.GA27139@gimli>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/06, Martin Lorenz <martin@lorenz.eu.org> wrote:
> just got the following on resume:
>
> [87026.242000] usb 4-2: USB disconnect, address 18
> [87026.448000] usb 4-2: new full speed USB device using uhci_hcd and address
> 20
> [87026.613000] usb 4-2: configuration #1 chosen from 1 choice
> [87026.704000] IRQ handler type mismatch for IRQ 90
> [87026.704000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
> [87026.704000]  [<c01044cb>] show_trace+0xf/0x11
> [87026.705000]  [<c01045ce>] dump_stack+0x15/0x17
> [87026.705000]  [<c01403d7>] setup_irq+0x17d/0x190
> [87026.705000]  [<c0140466>] request_irq+0x7c/0x98
> [87026.706000]  [<c0251745>] e1000_open+0xcd/0x1a4
> [87026.707000]  [<c029565c>] dev_open+0x2b/0x62
> [87026.708000]  [<c0294181>] dev_change_flags+0x47/0xe4
> [87026.709000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
> [87026.711000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
> [87026.712000]  [<c016b6af>] do_ioctl+0x1f/0x62
> [87026.712000]  [<c016b937>] vfs_ioctl+0x245/0x257
> [87026.713000]  [<c016b995>] sys_ioctl+0x4c/0x67
> [87026.714000]  [<c0102db3>] syscall_call+0x7/0xb
> [87026.714000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> [87026.715000] Leftover inexact backtrace:
> [87026.715000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
> Error: -16

I'm pretty sure this isn't an e1000 problem.  you need to talk to
whoever is maintaining the IRQ subsystem for x86.  E1000 is attempting
to register a shared interrupt and someone has already registered that
interrupt unshared.
from your dmesg
[    0.289935] Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
[    0.290030] Copyright (c) 1999-2006 Intel Corporation.
[    0.290196] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level,
low) -> IRQ 201
[    0.291176] PCI: Setting latency timer of device 0000:02:00.0 to 64
[    0.336827] e1000: 0000:02:00.0: e1000_probe: (PCI
Express:2.5Gb/s:Width x1) 00:16:d3:22:9b:82
[    0.381316] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[    0.381553] netconsole: not configured, aborting
[    0.381759] libata version 2.00 loaded.
[    0.381815] ahci 0000:00:1f.2: version 2.0
[    0.381835] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level,
low) -> IRQ 201
and
[    7.107822] USB Universal Host Controller Interface driver v3.0
[    7.107988] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level,
low) -> IRQ 201

looks like several devices are sharing IRQ 201 (aka GSI 16) and ahci
or usb uhci_hcd is likely the problem, or the (acpi) power management
subsystem.

Hope this helps get the right people involved.

Jesse
