Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTL2BZc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTL2BZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:25:32 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:13738 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262176AbTL2BZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:25:18 -0500
Message-ID: <20031229012517.2605.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Perry Gilfillan" <perrye@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 29 Dec 2003 07:25:16 +0600
Subject: 2.4.23 segfaults on cat /proc/modules
X-Originating-Ip: 68.12.215.127
X-Originating-Server: ws5-6.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've taken a vanilla linux-2.4.23 and applied three patches, i2c-282, lm_sensors-282, and kgdb-1.9.  I've got the kgdb kernel talking to gdb, with a serial console on the side.

This Oops occured when trying to run ksymoops on a previous Oops!  The first Oops, listed second, occured trying to cat /proc/modules.  I think my list of modules from lsmod is incomplete.  I've got most everything built as mods.

# lsmod
Module                  Size  Used by    Not tainted
via686a                 9068   0  (unused)
eeprom                  4944   0  (unused)
i2c-proc                7956   0  [via686a eeprom]
i2c-isa                 1324   0  (unused)
i2c-viapro              4296   0  (unused)
i2c-core               20804   0  [via686a eeprom i2c-proc i2c-isa i2c-viapro]

Wheres the tulip driver?  Networking is up!

To reiterate, ksymoops Segfaults!  ( I just realized that ksymoops reads
/proc/modules, but it's too late now.  Ofending machine is tied up at
ide_dma_intr, and is going to stay there for a while. )

There are enough consistencies in the stack listing, and the call trace is ident
icle, which makes me think that I've got some thing specific here.

ksymoops won't give me symbol mappings for the call trace,
but I can examine memory...

0xc013304e <swap_out+110>:
        0x5a    0x59    0x8b    0x5d    0xfc    0xc9   0xc3   0x68
0xc012a118 <pte_alloc+120>:
        0xe9    0x50    0xff    0xff    0xff    0x8d   0x76   0x00
0xc01347fa <balance_classzone+602>:
        0x83    0xc4    0x18    0x89    0x45    0xe4   0xff   0x75
0xc015e3e3 <grok_partitions+3>:
        0x5a    0x89    0x45    0x1c    0x8b    0x45   0xec   0x89
0xc015c464 <task_mem+68>:
        0x83    0xc4    0x18    0x89    0xc3    0x8b   0x45   0xf0
0xc013a005 <do_readv_writev+453>:
        0x83    0xc4    0x10    0x89    0xc7    0x85   0xff   0x7e
0xc0108fc3 <system_call+51>:
        0x89    0x44    0x24    0x18    0x89    0xf6   0x8d   0xbc

I will be glad to put any relevant object files on the web server if
requested.

I'm still very wet behind the ears with regard to gdb and extracting useful
information.  Just tell me what to do, and I'll comply.  I don't have any
reason to reboot the ofending machine any time soon, so maybe it can still
yield up some good data.

I'm going to write a second problem report regarding these messages:
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

gdb on the ofending machine is finnaly reporting some thing about this!

I'll be posting pertenant information at http://gilfillan.org:8000/Oopsen/

It won't be there imediatley, so check back later.

Thanks for your time,

Perry Gilfillan

# ksymoops oops.txt
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000003
 printing eip:
0000000c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<0000000c>]    Not tainted
EFLAGS: 00010282
eax: 2020208b   ebx: c4879014   ecx: 00000000   edx: 0000000d
esi: 00000003   edi: c4879014   ebp: e3c4915f   esp: c4915eac
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 1518, stackpage=c4915000)
Stack: c10c7304 c4915ec4 c013304e c10c7304 00000001 0486e067 c4915ed8 c012a118
       080f6054 c6b95ce0 00000001 c4915f00 00000001 00000000 c038c3d0 d2951000
       00000ff9 c01347fa c038c398 c10c74e8 00003879 00000000 00000000 00000286
Call Trace:    [<c013304e>] [<c012a118>] [<c01347fa>] [<c015e3e3>] [<c015c464>]
  [<c013a005>] [<c0108fc3>]

Code:  Bad EIP value.
 invalid operand: 0000



# cat /proc/modules
Unable to handle kernel NULL pointer dereference at virtual address 00000003
 printing eip:
c011c784
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011c784>]    Not tainted
EFLAGS: 00010282
eax: 2020208b   ebx: c4bf9014   ecx: 00000000   edx: 0000000d
esi: 00000003   edi: c4bf9014   ebp: c4c47f3d   esp: c4c47eac
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 1468, stackpage=c4c47000)
Stack: c10d19bc c4c47ec4 c013304e c10d19bc 00000001 04c38067 c4c47ed8 c012a118
       0804de64 c6b95ce0 00001000 c4c47f00 00000001 00000001 c038c3dc d2951000
       00000ff9 c01347fa c038c398 c10d0ebc 00003bf9 00000000 00000001 00000286
Call Trace:    [<c013304e>] [<c012a118>] [<c01347fa>] [<c015e3e3>] [<c015c464>]
  [<c013a005>] [<c0108fc3>]

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
