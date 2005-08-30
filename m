Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVH3PWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVH3PWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVH3PWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:22:19 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:38667 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932185AbVH3PWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:22:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 30 Aug 2005 15:22:16.0808 (UTC) FILETIME=[9AFF0E80:01C5AD76]
Content-class: urn:content-classes:message
Subject: linux-2.6.13 PCI bogus resource allocation
Date: Tue, 30 Aug 2005 11:21:22 -0400
Message-ID: <Pine.LNX.4.61.0508301118590.4347@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux-2.6.13 PCI bogus resource allocation
Thread-Index: AcWtdpsGxrw3ka2cSO+GGNr+9adfrQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello, more problems are being found with linux-2.6.13

Some imaging systems reserve large amounts of
contiguous DMA RAM (16 megabytes) by booting
with 'mem='. In the subject systems, we boot
with "mem=768m" which makes the first available
RAM at 768 * 1024 * 1024 = 0x30000000.

Certain versions of Linux have been spoiling the
first page by writing something there. Therefore,
we have been starting at 0x30001000. Now, with
Linux-2.6.13, I see that PCI/Bus resources are
being allocated on top of this RAM!!! This should
not be. In my BIOS I always check for RAM before
allocating PCI resources. It's trivial, write 0L, read
it back after reading from some dummy location, if
it's 0L, it's RAM. The dummy read from somewhere
else is necessary to discharge bus capacity that
can store bits for a few ns in the absence of RAM.

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cfbff : Video ROM
000d0000-000d0bff : Adapter ROM
000d1000-000d57ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-2fffffff : System RAM
   00100000-003494f0 : Kernel code
   003494f1-00403607 : Kernel data


Linux-2.6.13
Somebody put PCI/Bus stuff right on top of my reserved RAM!

30000000-300fffff : PCI Bus #02
^^^^^^^^^^^^^^^^|__ This is RAM
   30000000-3001ffff : 0000:02:01.0
   30020000-3002ffff : 0000:02:00.0
30100000-301003ff : 0000:00:1f.1


30200000-34203fff : Analogic Corp DLB
e8000000-f7ffffff : PCI Bus #01
   e8000000-efffffff : 0000:01:00.0
   f0000000-f007ffff : 0000:01:00.0
   f0080000-f009ffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fc000000-fdffffff : PCI Bus #01
   fc000000-fcffffff : 0000:01:00.0
fe000000-fe1fffff : PCI Bus #02
   fe000000-fe0fffff : 0000:02:03.0
     fe000000-fe0fffff : Analogic Corp DLB
   fe130000-fe130fff : 0000:02:00.0
     fe130000-fe130fff : aic7xxx
   fe131000-fe131fff : 0000:02:07.0
   fe132000-fe132fff : 0000:02:08.0
     fe132000-fe132fff : e100
   fe133000-fe13307f : 0000:02:01.0
   fe133400-fe1335ff : 0000:02:03.0
     fe133400-fe1335ff : Analogic Corp DLB
fe200000-fe2003ff : 0000:00:1d.7
   fe200000-fe2003ff : ehci_hcd
fe200400-fe2005ff : 0000:00:1f.5
fe200800-fe2008ff : 0000:00:1f.5


Linux-2.6.12.5 works and (almost) avoids my RAM.

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cfbff : Video ROM
000d0000-000d0bff : Adapter ROM
000d1000-000d57ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-2fffffff : System RAM
   00100000-0033d080 : Kernel code
   0033d081-003f32ff : Kernel data


30000000-300003ff : 0000:00:1f.1
^^^^^^^^^^^^^^^^^|__ This is RAM!

30200000-34203fff : Analogic Corp DLB
e8000000-f7ffffff : PCI Bus #01
   e8000000-efffffff : 0000:01:00.0
   f0000000-f007ffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fc000000-fdffffff : PCI Bus #01
   fc000000-fcffffff : 0000:01:00.0
fe000000-fe0fffff : 0000:02:03.0
   fe000000-fe0fffff : Analogic Corp DLB
fe130000-fe130fff : 0000:02:00.0
   fe130000-fe130fff : aic7xxx
fe131000-fe131fff : 0000:02:07.0
fe132000-fe132fff : 0000:02:08.0
   fe132000-fe132fff : e100
fe133000-fe13307f : 0000:02:01.0
fe133400-fe1335ff : 0000:02:03.0
   fe133400-fe1335ff : Analogic Corp DLB
fe200000-fe2003ff : 0000:00:1d.7
   fe200000-fe2003ff : ehci_hcd
fe200400-fe2005ff : 0000:00:1f.5
fe200800-fe2008ff : 0000:00:1f.5


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
