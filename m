Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130361AbQKWVoE>; Thu, 23 Nov 2000 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130371AbQKWVn4>; Thu, 23 Nov 2000 16:43:56 -0500
Received: from netcore.fi ([193.94.160.1]:30472 "EHLO netcore.fi")
        by vger.kernel.org with ESMTP id <S130405AbQKWVjY>;
        Thu, 23 Nov 2000 16:39:24 -0500
Date: Thu, 23 Nov 2000 23:09:18 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Raising MAX_UNITS in net drivers oopses kernel reproducibly 
Message-ID: <Pine.LNX.4.30.0011232253350.21863-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Using RHL 2.2.16-3 kernel on i686.

Raising MAX_UNITS define from 8 to 16 or 32 in net drivers (tested
tulip.c) causes reproducible oops.  The latest Don Becker driver also does
this.  Using DFE-570TX quad ethernet cards.

So, why change MAX_UNITS?  Interfaces 9-> can't be passed options=,
full_duplex= or similar parameters otherwise.  The actual interfaces
should work in autonegotiation though.

I've gotten this crash every time.  It can be done as follows:

1) recompile a new tulip module with changed MAX_UNITS.
2) insmod the module
3) take one interface up, with e.g. ifup eth0. [note: traffic doesn't go
anywhere]
4) try to take the interface down, with e.g. ifconfig eth0
5) watch oops in your syslog.

Previous message on syslog was 'Trying to free free IRQ9'.

See below:
-----
Unable to handle kernel paging request at virtual address 0000109f
current->tss.cr3 = 01d69000, %%cr3 = 01d69000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[de4x5:de4x5_probe+24259/37172]
EFLAGS: 00010282
eax: c4056f00   ebx: 00001043   ecx: 00000246   edx: 00000000
esi: 00001043   edi: c38cc5a0   ebp: c103deb4   esp: c103deac
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 1924, process nr: 7, stackpage=c103d000)
Stack: 00000000 c38cc480 00001042 c014fe92 c38cc5a0 00001043 c38cc5a0 c0150980
       c38cc5a0 c29c6300 00001042 c29c6324 c103df40 c0170f9c c38cc5a0 00001042
       00008914 00008914 bffff9f4 c2671740 00008913 00000000 c103df40 c0150ee9
Call Trace: [dev_close+78/156] [dev_change_flags+80/268] [devinet_ioctl+620/1404] [dev_ioctl+337/792] [inet_ioctl+294/412] [free_pages+36/40] [sock_ioctl+29/36]
       [sys_ioctl+421/448] [system_call+52/56]
Code: 8b 56 5c 31 c0 0f ab 46 24 19 c0 85 c0 74 29 a1 80 47 21 c0
-----

Note! EIP shows de4x5 for some reason.  Please note that de4x5 driver
also "works" with this card.  The driver is _really_ buggy with it though.
With Don Becker drivers the output is about the same; EIP is
__insmod_tulip_S and Call Trace: begins with dev_deactivate.


Any ideas?  _Should_ raising MAX_UNITS work as I described or are there
any known problems with it?

Please Cc:.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Pekka.Savola@netcore.fi      not those you stumble over and fall"


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
