Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWETQYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWETQYL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 12:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWETQYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 12:24:11 -0400
Received: from bay20-f21.bay20.hotmail.com ([64.4.54.110]:19032 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751431AbWETQYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 12:24:10 -0400
Message-ID: <BAY20-F217B1ED87121D07EDC80F7BAA40@phx.gbl>
X-Originating-IP: [70.31.13.136]
X-Originating-Email: [fastcossy@hotmail.com]
From: "Victor B" <fastcossy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.6.16.16] 64bit + Ethernet + Bluetooth = no go
Date: Sat, 20 May 2006 16:24:06 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 20 May 2006 16:24:09.0498 (UTC) FILETIME=[D292D7A0:01C67C29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have MSI K8NGM2-FID (AMD64) motherboard with onboard Nvidia NIC. I also 
have
CSR Bluetooth USB dongle for keyboard and mouse.

I used 32bit distro with 32bit mainstream kernel for several months without 
any
issues.

This weekend, I switched over to 64bit distro, recompiled latest kernel and 
this
is when things went wrong. (Compiling previous working kernel in 64-bits 
didn't help).

Bluetooth (bluez) and ethernet (forcedeth) no longer work together. By not
loading either kernel module, I can use either one or the other (e.g. no
bluetooth, yes ethernet and vice versa) but not both at the same time.

Typically, hci0 is down and uninitialized. Any attempts to bring it up with 
hciconfig just cause the command to hang. Dmesg:

	hci_usb_rx_complete: hci0 corrupted packet: type 4 count 14

Thinking it's something with forcedeth, I disabled onboard NIC and put in an 
old
network card I had (via-rhine). This time, both BT and ETH worked for a bit,
however both crashed after about 2 minutes of light network traffic. [See 
output]

bash-3.00# ping 192.168.1.1  [MY ROUTER]
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
>From 192.168.1.2 icmp_seq=2 Destination Host Unreachable
>From 192.168.1.2 icmp_seq=3 Destination Host Unreachable
>From 192.168.1.2 icmp_seq=4 Destination Host Unreachable

--- 192.168.1.1 ping statistics ---
5 packets transmitted, 0 received, +3 errors, 100% packet loss, time 3999ms
, pipe 3

In dmesg, this message keeps repeating

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 782d, resetting...
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1



bash-3.00# hciconfig -a
hci0:   Type: USB
        BD Address: 00:50:F2:E4:4D:3C ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:388 acl:0 sco:0 events:17 errors:0
        TX bytes:315 acl:0 sco:0 commands:20 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
Can't read local name on hci0: Connection timed out (110)


In dmesg:
hci_cmd_task: hci0 command tx timeout


Interesting thing to note, hciconfig breaks on trying to retrieve local HCI 
device name (defined in hcid.conf). And via-rhine reports link up, but it 
doesn't actually work.

It seems to me that BT and ETH share some network/socket layer which somehow
crashes, and ONLY in 64-bit mode, thereby disabling both.

I'll be happy to provide developers with more info/debug output -- just let 
me know what's requried.

thanks

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

