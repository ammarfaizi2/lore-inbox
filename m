Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752216AbWAEVmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbWAEVmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbWAEVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:42:43 -0500
Received: from digitalimplant.org ([64.62.235.95]:41692 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1752216AbWAEVmn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:42:43 -0500
Date: Thu, 5 Jan 2006 13:42:33 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060104213405.GC1761@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
References: <20051227213439.GA1884@elf.ucw.cz>
 <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
 <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
 <20060104213405.GC1761@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jan 2006, Pavel Machek wrote:

> On Út 27-12-05 20:22:04, Patrick Mochel wrote:

> > Heh, not really. You're not really solving any problems, only giving the
> > illusion that you've actually fixed something.
>
> Except perhaps userspace passing invalid values down to drivers in
> pm_message_t.event?

It is up to the layer parsing the value to filter out bad values.

> > As I mentioned in the thread (currently happening, BTW) on the linux-pm
> > list, what you want to do is accept a string that reflects an actual state
> > that the device supports. For PCI devices that support low-power states,
> > this would be "D1", "D2", "D3", etc. For USB devices, which only support
> > an "on" and "suspended" state, the values that this patch parses would
> > actually work.
>
> We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> and I'm not sure about those "D1" and "D2" parts. Userspace should not
> have to know about details, it will mostly use "on"/"suspend" anyway.

D0 - D3 are common for all PCI devices. "on" and "suspend" are not device
states. They are conceptual representations of device states.

I understand where you are coming from. Most users will only care that a
particular device is "on" or "off". That is fine. They will click through
a gui that turns off a device and never think any more about it.

However, we are not developing an interface for end-users. We're
developing an interface that the guis may use. And, along with the guis,
there are also people that care about everything in between "on" and
"suspend".

If we export exactly the device states that a device supports, then we can
leave it up to the layers taking user input to translate between the real
device states and the user conceptions ("on", "suspend", etc), instead of
doing the translation ourselves.

That way, the kernel PM layers (as part of the bus drivers), can easily
and simply support every device that a device may have. What happens when
device manufacturers start coming out with D4, D5, etc (like they have
with the CPU C? States)? "suspend" takes on a completely different
meaning. With a simple (and accurate) kernel interface, this will never be
an issue.

> > > One day, when we find device that needs it, we may want to add more
> > > states. I don't know about such device currently.
> >
> > There are many devices already do - there are PCI, PCI-X, PCI Express,
> > ACPI devices, etc that do. But, you simply cannot create a single
> > decent
>
> I asked for an example.

Hey, calm down.

See for yourself:

for i in `lspci | cut -d ' ' -f 1 `
do
        pm_str=`sudo lspci -s $i -vv | grep -A 1 "Power Management" | grep
Flags | cut -d ' ' -f 4-5`;

        if [ ! -z "$pm_str" ]
        then
                printf "Device: %s   ==>  Power States: %s\n" $i "$pm_str"
        fi
done


I have a firewire controller in a desktop system, and a ATI Radeon in a
T42 that support D1 and D2..

Thanks,


	Patrick

