Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754190AbWKGLWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbWKGLWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbWKGLWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:22:40 -0500
Received: from SMT02002.global-sp.net ([193.168.50.254]:12726 "EHLO
	SMT02002.global-sp.net") by vger.kernel.org with ESMTP
	id S1754190AbWKGLWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:22:39 -0500
Message-ID: <45506C9A.5010009@privacy.net>
Date: Tue, 07 Nov 2006 12:23:06 +0100
From: John <me@privacy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux.nics@intel.com, hpa@zytor.com, saw@saw.sw.com.sg, thockin@hockin.org
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com>
In-Reply-To: <454BF0F1.5050700@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2006 11:24:44.0945 (UTC) FILETIME=[5380D810:01C7025F]
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: me@privacy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> John wrote:
> 
>> Several people have reported the same error. Intel's Auke Kok has
>> stated that ignoring the error is a BAD idea.
>>
>> http://lkml.org/lkml/2006/7/10/215
>>
>> What tool is used to reprogram the EEPROM? ethtool?
>> I suppose I'll have to ask the manufacturer for an updated EEPROM?
>>
>> # ethtool -e eth0
>> Cannot get EEPROM data: Operation not supported
>>
>> I'm not sure why I can't dump the contents of the EEPROM.
>> Does the driver need to be loaded?
> 
> Yes, the driver needs to be loaded.
> 
> Basically, Auke wants you to throw away your NIC and/or motherboard.
> Since you're effectively dead, the only damage you can do by
> disabling the check has already been done.  This unfortunately seems
> to be fairly common with e100, especially for the on-motherboard
> version, and you basically have two options: either disable the check
> or write an offline tool to reprogram the EEPROM.
> 
> The latest netdev tree (if it's not in Linus' tree already, which it
> might be) does add back the option to ignore the check so you can
> update the EEPROM, which will automatically fix the checksum.

I have investigated further.

I changed e100_eeprom_load() to return 0 even when the checksum fails.

Loading e100.ko reports:

e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
e100: 0000:00:08.0: e100_eeprom_load: EEPROM corrupted
e100: eth0: e100_probe: addr 0xe6302000, irq 11, MAC addr FF:FF:FF:FF:FF:FF
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 12 (level, 
low) -> IRQ 12
e100: eth1: e100_probe: addr 0xe6301000, irq 12, MAC addr 00:30:64:04:E6:E5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 10 (level, 
low) -> IRQ 10
e100: eth2: e100_probe: addr 0xe6300000, irq 10, MAC addr 00:30:64:04:E6:E6

I had thought all cards would have the same problem, but only the
first NIC seems affected.

The MAC address for eth0 should be 00:30:64:04:E6:E4
(0x003064 is an ADLINK OUI.)

#ip addr
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
5: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether ff:ff:ff:ff:ff:ff brd ff:ff:ff:ff:ff:ff
6: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e5 brd ff:ff:ff:ff:ff:ff
7: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e6 brd ff:ff:ff:ff:ff:ff


I then used ethtool to dump the contents of the EEPROMs.

# ethtool -e eth0
Offset          Values
------          ------
0x0000          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0010          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0020          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0030          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0040          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0050          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0060          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x0070          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

# ethtool -e eth1
Offset          Values
------          ------
0x0000          00 30 64 04 e6 e5 03 0e 00 00 01 02 01 47 00 00
0x0010          13 72 10 83 a2 40 01 00 86 80 00 00 00 00 00 00
0x0020          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060          28 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070          00 00 00 00 00 00 00 00 00 00 00 00 00 00 f7 91

# ethtool -e eth2
Offset          Values
------          ------
0x0000          00 30 64 04 e6 e6 03 0e 00 00 01 02 01 47 00 00
0x0010          13 72 10 83 a2 40 01 00 86 80 00 00 00 00 00 00
0x0020          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050          00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060          28 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070          00 00 00 00 00 00 00 00 00 00 00 00 00 00 f7 90


Either the EEPROM image on eth0 is corrupted, or ethtool is not
able to read the contents of the EEPROM.

So I tried the other driver, eepro100.c which, AFAIU, e100.c is
supposed to supersede.

Loading eepro100.ko reports:

eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
eth0: 0000:00:08.0, 00:30:64:04:E6:E4, IRQ 11.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 12 (level, 
low) -> IRQ 12
eth1: 0000:00:09.0, 00:30:64:04:E6:E5, IRQ 12.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 10 (level, 
low) -> IRQ 10
eth2: 0000:00:0a.0, 00:30:64:04:E6:E6, IRQ 10.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).


NOTE: eepro100.ko found the correct MAC address for eth0.

#ip addr
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e4 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e5 brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
     link/ether 00:30:64:04:e6:e6 brd ff:ff:ff:ff:ff:ff


I then used Donald Becker's program to dump the contents of all
the EEPROMs. ( ftp://www.scyld.com/pub/diag/ )

# eepro100-diag -ee
eepro100-diag.c:v2.13 2/28/2005 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html

Index #1: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xd800.
EEPROM contents, size 64x16:
     00: 3000 0464 e4e6 0e03 0000 0201 4701 0000  _0d__________G__
   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
       ...
   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
   0x38: 0000 0000 0000 0000 0000 0000 0000 92f7  ________________
  The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
   Station address 00:30:64:04:E6:E4.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.

Index #2: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xdc00.
EEPROM contents, size 64x16:
     00: 3000 0464 e5e6 0e03 0000 0201 4701 0000  _0d__________G__
   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
       ...
   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
   0x38: 0000 0000 0000 0000 0000 0000 0000 91f7  ________________
  The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
   Station address 00:30:64:04:E6:E5.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.

Index #3: Found a Intel i82557/8/9 EtherExpressPro100 adapter at 0xe000.
EEPROM contents, size 64x16:
     00: 3000 0464 e6e6 0e03 0000 0201 4701 0000  _0d__________G__
   0x08: 7213 8310 40a2 0001 8086 0000 0000 0000  _r___@__________
       ...
   0x30: 0128 0000 0000 0000 0000 0000 0000 0000  (_______________
   0x38: 0000 0000 0000 0000 0000 0000 0000 90f7  ________________
  The EEPROM checksum is correct.
Intel EtherExpress Pro 10/100 EEPROM contents:
   Station address 00:30:64:04:E6:E6.
   Board assembly 721383-016, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
    Sleep mode is enabled.  This is not recommended.
    Under high load the card may not respond to
    PCI requests, and thus cause a master abort.
    To clear sleep mode use the '-G 0 -w -w -f' options.


Apparently, eepro100.ko is able to read the contents of the EEPROM on 
eth0 and it declares the checksum correct. Is it possible that there is 
a bug in e100.c that makes it fail to read the EEPROM on eth0?

Regards,

John
