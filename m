Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTKYAXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKYAXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:23:54 -0500
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:59015 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261776AbTKYAXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:23:52 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16322.41235.39815.936201@wombat.chubb.wattle.id.au>
Date: Tue, 25 Nov 2003 11:23:47 +1100
To: linux-kernel@vger.kernel.org, gibbs@overdrive.btc.adaptec.com,
       James.Bottomley@steeleye.com
Subject: test10 hangs on startup: NMI watchdog hits Adaptec driver
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   I've been seeing random hangs on a dual 500MHz celeron here; so I
rebooted this morning with the NMI watchdog turned on.

With the watchdog, the machine shows the attached.  Looks to me as if
the lock taken at aic7xx_osm.c:1709 which is released *after*
ahc_linux_initialize_scsi_bus() should perhaps be released earlier.
Otherwise the host lock is held for the duration.


NMI Watchdog detected LOCKUP on CPU0, eip c02fb737, registers:
CPU:    0
EIP:    0060:[<c02fb737>]    Not tainted
EFLAGS: 00000086
EIP is at .text.lock.scsi+0x81/0xaa
eax: c1b01a50   ebx: c1b01800   ecx: c1b01800   edx: c1b01a00
esi: c1b01800   edi: 00000000   ebp: 00000046   esp: f7fa5da4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7fa4000 task=c1a47900)
Stack: 00000000 c1b01800 00000000 c1b01c00 00000000 c02ff2bb c1b01800 00000000 
       ffffff41 ffffffff c031f932 c1b01800 00000000 00000000 c1b01c98 00000000 
       c1b01c00 00000000 c030492f c1b01c00 c1b01c90 00000000 00000000 00000000 
Call Trace:
 [<c02ff2bb>] scsi_report_bus_reset+0x1b/0x50
 [<c031f932>] ahc_send_async+0xa2/0x2e0
 [<c030492f>] ahc_run_untagged_queues+0x2f/0x40
 [<c030fb23>] ahc_abort_scbs+0x403/0x4c0
 [<c0310016>] ahc_reset_channel+0x2b6/0x5d0
 [<c018ba09>] proc_create+0x89/0xe0
 [<c031c0dc>] ahc_linux_initialize_scsi_bus+0x1fc/0x210
 [<c031bca8>] ahc_linux_register_host+0x178/0x360
 [<c01905f4>] sysfs_add_file+0xa4/0xb0
 [<c018fee0>] init_file+0x0/0x20
 [<c028a888>] pci_create_newid_file+0x28/0x30
 [<c028ad5c>] pci_register_driver+0x7c/0xa0
 [<c031aa3c>] ahc_linux_detect+0x4c/0x80
 [<c0527b8f>] ahc_linux_init+0xf/0x30
 [<c051095c>] do_initcalls+0x2c/0xa0
 [<c013271f>] init_workqueues+0xf/0x24
 [<c01050f6>] init+0x56/0x180
 [<c01050a0>] init+0x0/0x180
 [<c0107259>] kernel_thread_helper+0x5/0xc

Code: f3 90 80 38 00 7e f9 e9 fc fc ff ff f3 90 80 38 00 7e f9 e9 
console shuts up ...
