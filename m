Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVG1UTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVG1UTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVG1UTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:19:33 -0400
Received: from smtpauth03.mail.atl.earthlink.net ([209.86.89.63]:405 "EHLO
	smtpauth03.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261838AbVG1URf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:17:35 -0400
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: swsusp works (TP 600X) 
In-Reply-To: Your message of "Sat, 23 Jul 2005 02:35:44 +0200."
             <20050723003544.GC1988@elf.ucw.cz> 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 28 Jul 2005 16:17:22 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1DyEok-0000pa-SX@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d47826f234369f82662f8ea4b6895fcc2009ca9877bae1c30167350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>If I don't eject the pcmcia card (usually a prism54 wireless card),
>>swsusp begins the process of hibernation, but never gets to the
>>writing pages part.

> Well, it really may be the firmware loading. Add some printks to
> confirm it, then fix it.

I did more tests, this time with 2.6.13-rc3-mm2 (machine is a TP 600X),
and I don't think the problem is related to firmware loading.  If I
first physically eject the card (an Intersil wireless card), swsusp
prints

PM: Writing image
PCI: Found IRQ 11 for device .....
PCI: Sharing IRQ 11 with ...
PCI: Sharing IRQ 11 with ...
PCI: Found IRQ 11 for device .....

then it writes pages to swap and all is well.  Well, almost 100%; the
one glitch is that sometimes X comes back blank and I have to
ctrl-alt-F7 to bring back the display; or X comes back with the keyboard
acting strange (<ENTER> shifts the display left by a few hundred
pixels), and again ctrl-alt-F7 fixes it.  This is with XFree86
4.3.0.dfsg.1-14, and maybe after I upgrade (?) to the xorg server, that
glitch will go away.  Anyway, it's easy to work around.

But, if I leave the card in and prepare the hibernation with

ifdown eth0
cardctl eject
modprobe -r prism54

(so eject the module for and stop all uses of the card), then swsusp
prints the PCI messages above, but hangs before writing the pages to
swap.  I'm using a hibernate.sh script (included below) for those steps.
It does a few others like stopping the hotplug system.

After 'cardctl eject' and removing the module, there's no evidence of
the hardware available to the kernel, as far as I can tell.  lspci
doesn't show it, for example.  So the system is not loading firmware
during the hibernate attempt, and I'm not sure what step is hanging.

[Should this report go to acpi-devel and/or the ACPI or kernel bugzilla,
or is that more for S1/S3 rather than for hibernation?]

Here is lspci with the card inserted:

  0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
  0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
  0000:00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
  0000:00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
  0000:00:03.0 Communication controller: Agere Systems (former Lucent Microelectronics) WinModem 56k (rev 01)
  0000:00:06.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
  0000:00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
  0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
  0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
  0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
  0000:01:00.0 VGA compatible controller: Neomagic Corporation NM2360 [MagicMedia 256ZX]
  0000:06:00.0 Network controller: Intersil Corporation Intersil ISL3890 [Prism GT/Prism Duette] (rev 01)

Here's the lspci -v for just the card:

  0000:06:00.0 Network controller: Intersil Corporation Intersil ISL3890 [Prism GT/Prism Duette] (rev 01)
	  Subsystem: Intersil Corporation: Unknown device 0000
	  Flags: bus master, medium devsel, latency 80, IRQ 11
	  Memory at 24800000 (32-bit, non-prefetchable) [size=8K]
	  Capabilities: [dc] Power Management version 1

And lspci -vv for just the card:

  0000:06:00.0 Network controller: Intersil Corporation Intersil ISL3890 [Prism GT/Prism Duette] (rev 01)
	  Subsystem: Intersil Corporation: Unknown device 0000
	  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 80 (2500ns min, 7000ns max), Cache Line Size: 0x08 (32 bytes)
	  Interrupt: pin A routed to IRQ 11
	  Region 0: Memory at 24800000 (32-bit, non-prefetchable) [size=8K]
	  Capabilities: [dc] Power Management version 1
		  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Here is the list of modules present just before the (working and
non-working) hibernation (for debugging, the hibernate.sh script does
'lsmod |logger' before hibernating):

  ip_conntrack_ftp
  snd_mixer_oss
  ipv6
  pcmcia
  crc32
  parport_pc
  lp
  parport
  thermal
  fan
  button
  processor
  ac
  battery
  ipt_state
  ipt_LOG
  iptable_filter
  iptable_nat
  ip_conntrack
  ip_tables
  8250
  serial_core
  intel_agp
  firmware_class
  snd_cs46xx
  snd_rawmidi
  snd_seq_device
  snd_ac97_codec
  snd_pcm
  snd_timer
  snd
  soundcore
  snd_page_alloc
  yenta_socket
  rsrc_nonstatic
  pcmcia_core
  agpgart
  speedstep_lib

I don't think any of those modules intrinsically are a problem, since
swsusp works with all of them (as long as the Intersil card is not
inserted).  And here is the hibernate.sh script:


#!/bin/bash

# suspend to disk (hibernate), stopping drivers that might break the
#   hibernation setup

to_stop='chrony pdnsd mysql hotplug'
to_start='hotplug pdnsd chrony'
unload='prism54'

ifdown eth0
cardctl eject
for s in $to_stop ; do /etc/init.d/$s stop ; done
for m in $unload ; do modprobe -r $m ; done
hwclock --systohc

logger -t hibernate.sh About to hibernate
ps axwww   | logger -t "hibernate.sh ps"
lsmod | logger -t "hibernate.sh lsmod"
sync
sleep 2
echo -n disk > /sys/power/state
hwclock --hctosys
logger -t hibernate.sh Returning from hibernation
for s in $to_start ; do
  /etc/init.d/$s start
done



-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
