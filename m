Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUDLBkD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 21:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUDLBkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 21:40:03 -0400
Received: from smtp3.fuse.net ([216.68.8.173]:60913 "EHLO smtp3.fuse.net")
	by vger.kernel.org with ESMTP id S262545AbUDLBjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 21:39:51 -0400
From: "Ivica Ico Bukvic" <ico@fuse.net>
To: <daniel.ritz@gmx.ch>, "'Tim Blechmann'" <TimBlechmann@gmx.net>
Cc: "'Thomas Charbonnel'" <thomas@undata.org>, <ccheney@debian.org>,
       <linux-pcmcia@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       <alsa-devel@lists.sourceforge.net>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Sun, 11 Apr 2004 21:39:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <200404120145.22679.daniel.ritz@gmx.ch>
Thread-Index: AcQgH7jRroWd/ZufQnyiojebNrugjwACnL3A
Message-Id: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all! Great news! I managed to fix the issue in Linux. As I suspected it
was the same problem like in Windows after suspend as the distortion was
similar.

Many thanks to all for all your help! Without you I would be still stuck on
this one tearing my hair out :-).



Conclusion:
===========
Hdsp after adjusting the controller settings works absolutely flawlessly.
Yay!

-----------------------------------------------------

Things that are require attention in order for this fix to work (ENE CB1410
cardbus controller):

1) CRITICAL: Yenta_socket driver needs to be mended to adjust the proper
registers for the ENE CB1410 cardbus as follows*:

a) register 0xc9 on mine was 0x06 (like in Windows after resume) and should
be 0x04 (like in Windows before resume)
b) register 0x81 was 0x90 (again like Windows after resume) and after
connecting the cardbus it was 0xb0, yet in both cases should be 0xd0** (like
in Windows before resume)

*NOTE: It is possible that this kind of behavior might be in part due to the
buggy BIOS of this notebook. Arima is currently working with me in trying to
resolve this possibly utilizing updated BIOS. Nonetheless, IMHO it would be
nice to have this added to the yenta_socket as Arima's successfulness at
fixing it is yet to be ascertained and this one truly seems like a
low-impact fix for the driver.

**I've noted that when I use:

setpci -s a.0 0x81.b

after changing the value to 0xd0 (with setpci -s a.0 0x81.b=d0) it would
tell me that it was equal to f0, yet the "hexdump -v /proc/bus/pci/00/0a.0"
would tell me it was d0 after all (see the log below).

----------

2) PREFERRED: hdsp driver needs to adjust the cardbus controller latency
upon connection and/or resume from standby to ff (even though it will likely
play on the lower latencies as well, this way it will be less likely to
produce xruns and since official RME's driver for Windows does this, Linux
IMHO likely ought to keep-up with their driver and offer same
functionality/behavior for easier troubleshooting).

The register in question is 0x0d (mine was by default in Windows at 0x20
before connection and at 0xff after connection, while in Linux it was at
0xa8 both before and after connecting the cardbus which suggests that the
driver did not properly ramp-up its value to 0xff).

3) FOR FURTHER INVESTIGATION: Does linux hdsp driver force the f0 value upon
the 0x81 register or is it that in Linux one simply cannot select d0 value
for whatever reason (specifying it would revert the value to f0, yet that
did not directly affect the sound and judging from the suggestions of others
that this is a switch for enabling memory burst read stuff perhaps it only
takes two values and each of them possibly populate a range in which case it
should be ok either way). I need to check this a bit more just to see if the
f0 really does mess it up or not.

-----------------------------------------------------

Here's the relevant log of the activity (I am way to tired to convert the
following into a meaningful prose so I am including the console log with
some annotations in parentheses):


<BEGIN>
[root@localhost 00]# hexdump 
-v /proc/bus/pci/00/0a.0 
0000000 1524 1410 0007 0210 0000 0607 a808 0002 
0000010 f000 ffe7 00a0 0200 0200 b005 e000 ffe7 
0000020 e000 ffe7 0000 2000 f000 203f 5000 0000 
0000030 50fc 0000 5400 0000 54fc 0000 010b 05c0 
0000040 161f 2032 0001 0000 0000 0000 0000 0000 
0000050 0000 0000 0000 0000 0000 0000 0000 0000 
0000060 0000 0000 0000 0000 0000 0000 0000 0000 
0000070 0000 0000 0000 0000 0000 0000 0000 0000 
0000080 9021 4044 0000 0000 0000 0000 1002 0100 
0000090 82c0 6044 0000 0000 0000 0000 0000 0000 
00000a0 0001 fe01 0000 00c0 0000 0000 001f 0000 
00000b0 0000 0000 0000 0000 0000 0000 0000 0000 
00000c0 1000 0000 0080 0080 0600 1008 0000 0000 
00000d0 0000 0000 0000 0000 0000 0000 0000 0000 
00000e0 0000 0000 0000 0000 0000 0000 0000 0000 
00000f0 0000 0000 0000 0000 0000 0000 0000 0000 
0000100 

(compare this with a screenshot in Windows -- please note that the value
pairs are reversed for whatever reason (endianness?); the Win32 screenshot
can be found here:
http://meowing.ccm.uc.edu/~ico/eMachines/SE-before_suspend.jpg ; please note
that the numbers are almost identical)

[root@localhost Documents]# setpci -s a.0 0xc9.b 
06 

(this ought to be 04)

[root@localhost Documents]# setpci -s a.0 0x81.b 
90 

(this ought to be d0)

[root@localhost Documents]# hdsploader 
hdsploader - firmware loader for RME Hammerfall 
DSP cards 
Looking for HDSP + Multiface or Digiface cards : 
Card 0 : VIA 8235 at 0x1000, irq 10 
Card 1 : RME Hammerfall DSP at 0x20000000, irq 
11 
Upload firmware for card hw:1 
Firmware uploaded for card hw:1 
[root@localhost Documents]# hexdump 
-v /proc/bus/pci/00/0a.0 
0000000 1524 1410 0007 0210 0000 0607 a808 0002 
0000010 f000 ffe7 00a0 0200 0200 b005 e000 ffe7 
0000020 e000 ffe7 0000 2000 f000 203f 5000 0000 
0000030 50fc 0000 5400 0000 54fc 0000 010b 0500 
0000040 161f 2032 0001 0000 0000 0000 0000 0000 
0000050 0000 0000 0000 0000 0000 0000 0000 0000 
0000060 0000 0000 0000 0000 0000 0000 0000 0000 
0000070 0000 0000 0000 0000 0000 0000 0000 0000 
0000080 b021 4044 0000 0000 0000 0000 1002 0100 
0000090 82c0 6044 0000 0000 0000 0000 0000 0000 
00000a0 0001 fe01 0000 00c0 0801 0000 001f 0000 
00000b0 0000 0000 0000 0000 0000 0000 0000 0000 
00000c0 1000 0000 0080 0080 0600 1008 0000 0000 
00000d0 0000 0000 0000 0000 0000 0000 0000 0000 
00000e0 0000 0000 0000 0000 0000 0000 0000 0000 
00000f0 0000 0000 0000 0000 0000 0000 0000 0000 
0000100 

(hmmm, register 0x81 just became 0xb0 after reconnect but both values are
wrong)

[root@localhost Documents]# setpci -s a.0 
0xc9.b=04 

(ok, here goes nothing :-)

[root@localhost Documents]# setpci -s a.0 0xc9.b 
04 

(so far so good)

[root@localhost Documents]# setpci -s a.0 
0x81.b=D0 
 
[root@localhost Documents]# setpci -s a.0 0x81.b 
f0 

(oops? Let's try that again:)

[root@localhost Documents]# setpci -s a.0 
0x81.b=D0 
 
[root@localhost Documents]# setpci -s a.0 0x81.b 
f0 

(hmmm, let's see the hexdump)

[root@localhost Documents]# hexdump 
-v /proc/bus/pci/00/0a.0 
0000000 1524 1410 0007 0210 0000 0607 a808 0002 
0000010 f000 ffe7 00a0 0200 0200 b005 e000 ffe7 
0000020 e000 ffe7 0000 2000 f000 203f 5000 0000 
0000030 50fc 0000 5400 0000 54fc 0000 010b 0500 
0000040 161f 2032 0001 0000 0000 0000 0000 0000 
0000050 0000 0000 0000 0000 0000 0000 0000 0000 
0000060 0000 0000 0000 0000 0000 0000 0000 0000 
0000070 0000 0000 0000 0000 0000 0000 0000 0000 
0000080 d021 4044 0000 0000 0000 0000 1002 0100 
0000090 82c0 6044 0000 0000 0000 0000 0000 0000 
00000a0 0001 fe01 0000 00c0 0801 0000 001f 0000 
00000b0 0000 0000 0000 0000 0000 0000 0000 0000 
00000c0 1000 0000 0080 0080 0400 1008 0000 0000 
00000d0 0000 0000 0000 0000 0000 0000 0000 0000 
00000e0 0000 0000 0000 0000 0000 0000 0000 0000 
00000f0 0000 0000 0000 0000 0000 0000 0000 0000 
0000100 

(well it says here it is 0xd0 so I guess I'll take hexdump's word for it)

[root@localhost Documents]# hdspconf 
 
HDSPConf 1.4 - Copyright (C) 2003 Thomas 
Charbonnel <thomas@undata.org> 
This program comes WITH ABSOLUTELY NO WARRANTY 
HDSPConf is free software, see the file copying 
for details 
 
Looking for HDSP cards : 
Card 0 : VIA 8235 at 0x1000, irq 10 
Card 1 : RME Hammerfall DSP + Multiface at 
0x20000000, irq 11 
Multiface found ! 
1 Hammerfall DSP card found. 

[root@localhost Documents]# hexdump 
-v /proc/bus/pci/00/0a.0 
0000000 1524 1410 0007 0210 0000 0607 a808 0002 
0000010 f000 ffe7 00a0 0200 0200 b005 e000 ffe7 
0000020 e000 ffe7 0000 2000 f000 203f 5000 0000 
0000030 50fc 0000 5400 0000 54fc 0000 010b 0500 
0000040 161f 2032 0001 0000 0000 0000 0000 0000 
0000050 0000 0000 0000 0000 0000 0000 0000 0000 
0000060 0000 0000 0000 0000 0000 0000 0000 0000 
0000070 0000 0000 0000 0000 0000 0000 0000 0000 
0000080 f021 4044 0000 0000 0000 0000 1002 0100 
0000090 82c0 6044 0000 0000 0000 0000 0000 0000 
00000a0 0001 fe01 0000 00c0 0801 0000 001f 0000 
00000b0 0000 0000 0000 0000 0000 0000 0000 0000 
00000c0 1000 0000 0080 0080 0400 1008 0000 0000 
00000d0 0000 0000 0000 0000 0000 0000 0000 0000 
00000e0 0000 0000 0000 0000 0000 0000 0000 0000 
00000f0 0000 0000 0000 0000 0000 0000 0000 0000 
0000100 

(dang it! 0xf0 even in hexdump now, let's try it again:)

[root@localhost Documents]# setpci -s a.0 
0x81.b=d0 
 
[root@localhost Documents]# setpci -s a.0 0x81.b 
f0 

(DOH!)

[root@localhost Documents]# hexdump 
-v /proc/bus/pci/00/0a.0 
0000000 1524 1410 0007 0210 0000 0607 a808 0002 
0000010 f000 ffe7 00a0 0200 0200 b005 e000 ffe7 
0000020 e000 ffe7 0000 2000 f000 203f 5000 0000 
0000030 50fc 0000 5400 0000 54fc 0000 010b 0500 
0000040 161f 2032 0001 0000 0000 0000 0000 0000 
0000050 0000 0000 0000 0000 0000 0000 0000 0000 
0000060 0000 0000 0000 0000 0000 0000 0000 0000 
0000070 0000 0000 0000 0000 0000 0000 0000 0000 
0000080 d021 4044 0000 0000 0000 0000 1002 0100 
0000090 82c0 6044 0000 0000 0000 0000 0000 0000 
00000a0 0001 fe01 0000 00c0 0801 0000 001f 0000 
00000b0 0000 0000 0000 0000 0000 0000 0000 0000 
00000c0 1000 0000 0080 0080 0400 1008 0000 0000 
00000d0 0000 0000 0000 0000 0000 0000 0000 0000 
00000e0 0000 0000 0000 0000 0000 0000 0000 0000 
00000f0 0000 0000 0000 0000 0000 0000 0000 0000 
0000100 

(at least hexdump is happy)

[root@localhost Documents]# hdspmixer 
 
HDSPMixer 1.6 - Copyright (C) 2003 Thomas 
Charbonnel <thomas@undata.org> 
This program comes with ABSOLUTELY NO WARRANTY 
HDSPMixer is free software, see the file COPYING 
for details 
 
Looking for HDSP cards : 
Card 0 : VIA 8235 at 0x1000, irq 10 
Card 1 : RME Hammerfall DSP + Multiface at 
0x20000000, irq 11 
Multiface found ! 
1 Hammerfall DSP card found. 
Initializing default presets 

(let's set the latency how RME likes it)

[root@localhost Documents]# setpci -s a.0 0x0d.b 
a8 
[root@localhost Documents]# setpci -s a.0 
0x0d.b=ff 
 
(at this point I played the sound using jack and jack_metro and the thing
sounded like a beautiful...sine tone :-)
<END>

Again, thanks all for your help!

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/


