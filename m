Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWARWYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWARWYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWARWYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:24:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64745 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932542AbWARWYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:24:04 -0500
Date: Wed, 18 Jan 2006 23:23:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Message-ID: <20060118222348.GG1580@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy> <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137618370.31839.12.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hum, I don't think so (but maybe someone else knows for sure), I thought
> that driver was specifically for a certain kind of IBM server, not an
> IBM laptop.  It looks like from this output that the acpiphp is not
> recognizing any hotplug capable devices on your laptop.  I believe that
> this is defined by acpiphp as a slot which is "ejectable", meaning
> contains an ACPI method called _EJ0.  I think we should take a look at
> your dsdt to make sure that it seems reasonable, and also perhaps you
> could send the output of lspci -vv -x with the laptop booted in the dock
> just to see what kind of dock bridge you have and make sure everything
> seems like it should work.  Please send the disassembled output of your
> dsdt - if you've never done it before, instructions for doing this can
> be found here: 
> http://acpi.sourceforge.net/dsdt/index.php

I sent verbose lspci and acpidump via private email. Regular lspci
looks like: (booted in dock but now undocked, sorry).

pavel@amd:~$ lspci
0000:00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Controller (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01)0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
0000:02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
0000:02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
0000:02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02)
0000:02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Ethernet Controller (Mobile) (rev
03)
0000:02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
0000:02:03.0 ffff: Texas Instruments PCI2032 PCI Docking Bridge (rev ff)
0000:09:00.0 ffff: Hewlett-Packard Company J2585B HP 10/100VG PCI LAN Adapter (rev ff)
0000:09:01.0 ffff: Silicon Image, Inc. PCI0648 (rev ff)
0000:09:02.0 ffff: Texas Instruments PCI1420 (rev ff)
0000:09:02.1 ffff: Texas Instruments PCI1420 (rev ff)

The ffff: lines are probably what is contained inside the dock.

Device GDCK looks like dock to my untrained eye. Unfortunately its
type is IBM0079... ...

Ahha, and ibm_acpi.c agrees with me.

IBM_HANDLE(dock, root, "\\_SB.GDCK",    /* X30, X31, X40 */

        Scope (\_SB)
        {
            Device (GDCK)
            {
                Name (_HID, EisaId ("IBM0079"))
                Name (_CID, 0x150CD041)
                Method (_STA, 0, NotSerialized)
                {
...
                Method (_DCK, 1, NotSerialized)
                {
                    Store (0x00, Local0)
                    If (LEqual (GGID (), 0x03))
                    {
                        Store (\_SB.PCI0.LPC.EC.SDCK (Arg0), Local0)
                    }

                    If (LEqual (GGID (), 0x00))
                    {
                        Store (\_SB.PCI0.PCI1.DOCK.DDCK (Arg0), Local0)
                    }

                    Return (Local0)
                }

                Method (_EJ0, 1, NotSerialized)
                {
                    If (LEqual (GGID (), 0x03))
                    {
                        \_SB.PCI0.LPC.EC.SEJ0 (Arg0)
                    }

                    If (LEqual (GGID (), 0x00))
                    {
                        \_SB.PCI0.PCI1.DOCK.DEJ0 (Arg0)
                    }
                }
....

Hope this helps.
						Pavel
-- 
Thanks, Sharp!
