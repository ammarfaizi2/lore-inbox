Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSHaVKV>; Sat, 31 Aug 2002 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSHaVKV>; Sat, 31 Aug 2002 17:10:21 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:232 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S318013AbSHaVKU>; Sat, 31 Aug 2002 17:10:20 -0400
Date: Sat, 31 Aug 2002 23:14:41 +0200
Message-Id: <200208312114.g7VLEfX22764@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: linux-kernel@vger.kernel.org
Subject: setpci is no changing values
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some trouble with a laptop's NIC (it's a 8139C realtek chip, I use the rtl8139 module). With
a lot help I think the problem is tracked down to a problem with the PCI bus bandwidth.

The diagnosis  is as follows:

after a scp of 17 MBytes in 9 seconds /proc/net/dev gave this:

Inter-| Receive | Transmit
face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed
lo: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
dummy0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
eth0:18454280 12218 1257 1257 1257 0 0 0 868920 12225 0 0 0 7 0 0


and there are the errors as reported by ifconfig:

eth0 Link encap:Ethernet HWaddr 00:07:CA:00:AC:A3
inet addr:10.0.0.30 Bcast:10.255.255.255 Mask:255.0.0.0
UP BROADCAST NOTRAILERS RUNNING MULTICAST MTU:1500 Metric:1
RX packets:12215 errors:1257 dropped:1257 overruns:1257 frame:0
TX packets:12220 errors:0 dropped:0 overruns:0 carrier:0
collisions:7 txqueuelen:100
RX bytes:18454074 (17.5 Mb) TX bytes:868093 (847.7 Kb)
Interrupt:10 Base address:0x1c00

this is from /var/log/messages:

Aug 31 20:51:14 wally last message repeated 3 times
Aug 31 20:51:14 wally kernel: eth0: Abnormal interrupt, status 00000040.
Aug 31 20:51:14 wally last message repeated 2 times
Aug 31 20:51:14 wally kernel: eth0: Abnormal interrupt, status 00000041.
Aug 31 20:51:14 wally last message repeated 3 times
Aug 31 20:51:14 wally kernel: eth0: Abnormal interrupt, status 00000040.
Aug 31 20:51:14 wally last message repeated 7 times
Aug 31 20:51:14 wally kernel: eth0: Abnormal interrupt, status 00000041.
Aug 31 20:51:14 wally kernel: eth0: Abnormal interrupt, status 00000040.
Aug 31 20:51:14 wally kernel: eth0: Abnormal interrupt, status 00000040.

I was suggested to increase the minimum grant to 64, so I did the following:

joerg@notebook> setpci -v -s 0:9.0.0 min_gnt=40
00:09.0:3e 40

BUT when I compared the output of lspci -vvvxxx -s 0:9.0 before and after
the setpci command, then I found no difference. Is this the expected behaviour?
I strace setpci and I found that the 62. Byte (== 0x3e) was written on
/proc/bus/pci/00/09.0

Any suggestions how to change the minimum grant?
Any other suggestions how to get rid of the NIC errors?

I used differne 2.4 kernels with the latest acpi (otherwise I dont get
a IRQ for the nic), up  to 20-pre5 with roughly the same results.

    TIA
    Joerg

ps: since I am not on the list, it would be nice to cc be - but I also read
lkml on the web.

