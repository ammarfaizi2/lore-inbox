Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280949AbRKOSD0>; Thu, 15 Nov 2001 13:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280968AbRKOSDR>; Thu, 15 Nov 2001 13:03:17 -0500
Received: from air-1.osdl.org ([65.201.151.5]:27287 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S280949AbRKOSDC>;
	Thu, 15 Nov 2001 13:03:02 -0500
Date: Thu, 15 Nov 2001 10:05:48 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ACPI: kbd-pw-on/WOL doesn't work anymore with 2.4.14
In-Reply-To: <20011115184322.A625@darkside.ddts.net>
Message-ID: <Pine.LNX.4.33.0111150957220.21985-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> since 2.4.14 kernel, after issuing 'halt', the Keyboard Power-ON or
> Wake-On-LAN doesn't work anymore. I have to switch the machine on
> with its Power Button.
> With 2.4.13 kernel it works very well.
>
> I'm using Asus P3B-F board with 440BX chipset.
>
> Does ACPI use another State in Power Off since 2.4.14?

No, it uses the same state. But, the behavior is a little different.

Wake events for devices that are controlled via the southbridge are
considered General Purpose Events (GPEs). On the southbridge there are two
banks of registers for GPEs - an enable bank and a status bank.

When you hit the "Wake" or "Power" key on the keyboard, it sets the status
bit, which is ANDed with the enable bit. If the result is true, an
interrupt is delivered (either SMI or SCI).

Behavior is different because in 2.4.14, all GPE enable bits are cleared
just before we enter a sleep state.

The location of these banks and the meaning of each bit is specific to the
southbridge, so there is no way to generically enable Wake-on-Key in the
kernel.

However, the GPE banks are exported via /proc/acpi/gpe. If a userspace
tool was to have knowledge of the southbridge on the system, one could
have a decent interface for configuring wake events.

(The kernel behavior would still have to change a bit, since the disabling
of the GPEs doesn't regard the events that have been set to wake the
system up).

Wake-on-Lan is a separate issue. If it's a PCI card with PM capabilities,
telling it to generate a wake event means setting a bit in the PCI config
space. You can do this with setpci. Why it would stop working, I don't
know...

	-pat


