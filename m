Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289340AbSAVOyq>; Tue, 22 Jan 2002 09:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289334AbSAVOyg>; Tue, 22 Jan 2002 09:54:36 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:58129 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S289337AbSAVOyR>; Tue, 22 Jan 2002 09:54:17 -0500
Date: Tue, 22 Jan 2002 07:53:50 -0700 (MST)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
In-Reply-To: <Pine.LNX.4.43.0201220943060.6639-100000@flubber.jvb.tudelft.nl>
To: Robbert Kouprie <robbert@jvb.tudelft.nl>
Cc: jussi.laako@kolumbus.fi, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0201220746440.13692-100000@jbourne2.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Robbert Kouprie wrote:

>
> Jussi Laako wrote:
>
> > Robbert Kouprie wrote:
> > >
> > > Thanks for the quick reply :) Just checked it, and it's in slot 2, so
> > > that's not the problem. It doesn't share the HPT366 IRQ. This is my
> > > /proc/interrupts:
> >
> > Driver is eepro100? I suspect there is something in eepro100 driver that
> > should be protected by a spinlock but is not. I haven't got time to
> > analyze it further, yet...
> >
> >  - Jussi Laako
>
> Yes, eepro100.c. Let me know if I can test something, although I would
> need a reproducible testcase also. Still doing some tests with high
> network load, as this caused the similar lockup in the other thread.
>
> - Robbert
>

Perhaps this will help.  Yesterday we had a strange error on an eepro100
NIC.  System is 4-way Xeon, 4G RAM, 4 eepro100 nics (2 in use), Dell PE6400.
Kernel is 2.4.17, no additional patches.  The system has not locked up
though.

The error was
eth0: can't fill rx buffer (force 0)!
eth0: Tx ring dump,  Tx queue 3013060 / 3013060:
eth0:     0 200ca000.
eth0:     1 000ca000.
eth0:     2 000ca000.
eth0:     3 400ca000.
eth0:  *= 4 000ca000.
eth0:     5 000ca000.
[... all the same ...]
eth0:    30 000ca000.
eth0:    31 000ca000.
eth0: Printing Rx ring (next to receive into 2522947, dirty index 2522946).
eth0:     0 00000001.
eth0: l   1 c0000001.
eth0:  *  2 00000000.
eth0:   = 3 00000001.
eth0:     4 00000001.
eth0:     5 00000001.
[... all the same ...]
eth0:    30 00000001.
eth0:    31 00000001.

System has only 4 days uptime, eth0 output is:
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3049032 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3566542 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:580129470 (553.2 Mb)  TX bytes:2775810991 (2647.2 Mb)
          Interrupt:26

/proc/interrupts
loki:bash# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:   10332192   10317829   10310969   10381268    IO-APIC-edge  timer
  1:        292        307        250        273    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  8:         26         32         30         27    IO-APIC-edge  rtc
 17:          6          4          3          3   IO-APIC-level  aic7xxx
 18:          2          5          2          7   IO-APIC-level  aic7xxx
 22:     766030     765530     764892     765127   IO-APIC-level  eth1
 23:     388900     388509     388022     388376   IO-APIC-level  megaraid
 26:    1395108    1395240    1394961    1396555   IO-APIC-level  eth0
NMI:          0          0          0          0
LOC:   41347538   41347536   41347536   41347494
ERR:          0
MIS:          0

lspci
loki:bash# lspci
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:04.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a)
00:05.0 SCSI storage controller: Adaptec 7899P (rev 01)
00:05.1 SCSI storage controller: Adaptec 7899P (rev 01)
00:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
03:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
03:09.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
03:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
03:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
04:00.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
04:01.0 SCSI storage controller: Q Logic QLA12160 (rev 06)
05:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)


Although I haven't had much time to track this yet (was planning later
today) I thought it might be related to the above...  If any other
information would help, please let me know.

Regards
James Bourne

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

