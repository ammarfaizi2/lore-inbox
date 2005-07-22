Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVGVIKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVGVIKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVGVIKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:10:15 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:776 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262060AbVGVIKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:10:13 -0400
Message-ID: <42E0A968.8060105@tuxrocks.com>
Date: Fri, 22 Jul 2005 02:08:08 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: New timeofday subsystem: Lockups
References: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
In-Reply-To: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

John, Nish, others:

I'm not sure whether this is an issue with John's TOD patches, John's
NTP rework, or Nish's softtimer patches, but something in this
combination seems to be locking up my system frequently.  Often, it will
completely hang during boot, and it periodically hangs while starting X
or even just under normal (unstressed) use.

During several of the boot-ups, the NMI Watchdog has caught lockups.
Here is the output of one of those lockups (hand-copied, so hopefully no
mistakes):

NMI Watchdog detected LOCKUP on CPU0, eip c01248bb, registers:
Modules linked in: ipw2200 ieee80211 ieee80211_crypt
CPU:	0
EIP:	0060:[<c01248bb>]	Not tainted VLI
EFLAGS:	00000046   (2.6.13-rc3-skas3-v9-pre7-fs6)
EIP is at get_jiffies_64+0x2b/0x40
eax: 00000000	ebx: ffbf503	ecx: 00011c84	edx: 00000000
esi: 00000000	edi: 00000000	ebp: c05cba00	esp: c065ff00
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c065f000 task=c0552b80)
Stack: 000094ad 000088e3 c03b01d7 c06aca50 c0330d90 67347457 0000000c
000088e1
       00000000 c0558080 c065f000 f7c42de4 00000000 00000082 c05cba00
c013e908
       c06ac9c0 00000080 00000aa2 00000aa2 fffb7e00 f7c42de4 00000000
00000082
Call Trace:
 [<c03b01d7>] read_tsc_interp+0x17/0x120
 [<c0330d90>] __ide_do_rw_disk+0x200/0540
 [<c013e908>] do_monotonic_clock+0x28/0x130
 [<c01283e6>] add_timer+0x16/0x60
 [<c0328738>] ide_set_handler+0x28/0x60
 [<c032c7df>] task_in_intr+0x4f/0x100
 [<c0327405>] ide_intr+0x95/0x1d0
 [<c032c790>] task_in_intr+0x0/0x100
 [<c014cae3>] handle_IRQ_event+0x33/0x70
 [<c014cbe6>] __do_IRQ+0x53/0xa0
 =========================
 [<c03b01d7>] read_tsc_interp+0x17/0x120
 [<c0104b86>] common_interrupt+0x1a/0x20
 [<c013007b>] alloc_pidmap+0x8b/0x1f0
 [<c03b016f>] tsc_interp_sync+0x4f/0xa0
 [<c03b0120>] tsc_interp_sync+0x0/0xa0
 [<c0128884>] run_timer_softirq+0xb4/0x1d0
 [<c0124912>] __do_softirq+0x42/0xa0
 [<c010688e>] do_softirq+0x4e/0x60
 =======================
 [<c0124a35>] irq_exit+0x35/0x40
 [<c010674a>] do_IRQ+0x5a/0xa0
 [<c0104b86>] common_interrupt+0x1a/0x20
 [<c02b16fa>] acpi_processor_idle+0x10e/0x28e
 [<c0102030>] default_idle+0x0/0x30
 [<c01020d4>] cpu_idle+0x34/0x50
 [<c0621856>] start_kernel+0x186/0x1f0
 Code: 8b 0d 64 da 68 c0 56 53 90 8d b4 26 00 00 00 00 89 c8 8b 1d 80 5e
55 c0 8b 35 84 5e 55 c0 89 ca 8b 0d 64 da 68 c0 83 e2 01 31 c8 <09> c2
75 e1 89 d8 89 f2 5b 5e c3 90 90 90 90 90 90 90 90 90 90
 console shuts up ...

Hopefully someone can make something out of this!

Any ideas?

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC4KloaI0dwg4A47wRAiosAKD7Hn+nzJEizqKvXDaXIfXw0T+0RACgrQnF
NikzhdmXzPjL0Bi2D2aBOk4=
=EN1O
-----END PGP SIGNATURE-----
