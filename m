Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270559AbTGSWl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270558AbTGSWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 18:41:25 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:42923 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S270557AbTGSWlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 18:41:22 -0400
Date: Sun, 20 Jul 2003 00:56:17 +0200
From: Frank van de Pol <fvdpol@home.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: aha152x scsi OOPS with 2.6.0-pre1
Message-ID: <20030719225617.GA944@obelix.fvdpol.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test1 i686
User-Agent: Mutt/1.5.4i
X-MailScanner-Information: Please contact support@home.nl for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The aha152x driver fails for my Adaptec AVA-1505 scsi card for 2.6.0-pre1
(using a dual P-II cpu, SMP kernel with preemption enabled)

1) when loading the module the driver crashes when trying the software
   interrupt (line 1053 of aha152x.c). Fortunate a patch exists for this in
   the scsi bk tree, which I applied to my box. The driver now loads OK.
   see: http://linux-scsi.bkbits.net:8080/scsi-for-linus-2.6/cset@1.1358.11.2

2) when I tried to access my tapedrive using tar I got an OOPS. Machine was
   fairly dead (unresponsive) but interrupts still working though.

Jul 19 23:59:58 obelix kernel: aha152x: BIOS test: passed, detected 1 controller(s)
Jul 19 23:59:58 obelix kernel: aha152x: resetting bus...
Jul 19 23:59:59 obelix kernel: aha152x0: vital data: rev=1, io=0x340 (0x340/0x340), irq=10, scsiid=7, reconnect=disabled, parity=enabled, synchronous=disabled, delay=1000, extended translation=disabled
Jul 20 00:00:00 obelix kernel: aha152x0: trying software interrupt, ok.
Jul 20 00:00:00 obelix kernel: scsi0 : Adaptec 152x SCSI driver; $Revision: 2.5 $
Jul 20 00:00:01 obelix kernel:   Vendor: DEC       Model: DLT2000           Rev: 8523
Jul 20 00:00:01 obelix kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Jul 20 00:00:01 obelix kernel: Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Jul 20 00:00:01 obelix kernel: st0: try direct i/o: yes, max page reachable by HBA 131056
Jul 20 00:00:01 obelix kernel: Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 1

<this is where started the tar>

Jul 20 00:00:25 obelix kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000068
Jul 20 00:00:25 obelix kernel:  printing eip:
Jul 20 00:00:25 obelix kernel: e097f071
Jul 20 00:00:25 obelix kernel: *pde = 00000000
Jul 20 00:00:25 obelix kernel: Oops: 0002 [#1]
Jul 20 00:00:25 obelix kernel: CPU:    0
Jul 20 00:00:25 obelix kernel: EIP:    0060:[_end+543106825/1070012056]    Not tainted
Jul 20 00:00:25 obelix kernel: EFLAGS: 00010046
Jul 20 00:00:25 obelix kernel: EIP is at busfree_run+0x391/0x570 [aha152x]
Jul 20 00:00:25 obelix kernel: eax: d204f000   ebx: cf33ca00   ecx: d24cc060   edx: 00000000
Jul 20 00:00:25 obelix kernel: esi: d204f000   edi: dff80000   ebp: 00000286   esp: dff81f10
Jul 20 00:00:25 obelix kernel: ds: 007b   es: 007b   ss: 0068
Jul 20 00:00:25 obelix kernel: Process events/0 (pid: 6, threadinfo=dff80000 task=dff852c0)
Jul 20 00:00:25 obelix kernel: Stack: dffef670 00000020 c02dbce0 dff852c0 d4247040 d24cc060 00000002 d204f000 
Jul 20 00:00:25 obelix kernel:        00000008 00000000 00000001 e098154d d204f000 c150abc0 00000092 dff81f70 
Jul 20 00:00:25 obelix kernel:        00000092 0d42429a 00000000 e0986b44 e0986b40 00000216 e097ec10 d204f000 
Jul 20 00:00:25 obelix kernel: Call Trace:
Jul 20 00:00:25 obelix kernel:  [_end+543116261/1070012056] is_complete+0x2ed/0x330 [aha152x]
Jul 20 00:00:25 obelix kernel:  [_end+543105704/1070012056] run+0x40/0x50 [aha152x]
Jul 20 00:00:25 obelix kernel:  [worker_thread+533/816] worker_thread+0x215/0x330
Jul 20 00:00:25 obelix kernel:  [_end+543105640/1070012056] run+0x0/0x50 [aha152x]
Jul 20 00:00:25 obelix kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Jul 20 00:00:25 obelix kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jul 20 00:00:25 obelix kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Jul 20 00:00:25 obelix kernel:  [worker_thread+0/816] worker_thread+0x0/0x330
Jul 20 00:00:25 obelix kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jul 20 00:00:25 obelix kernel: 
Jul 20 00:00:25 obelix kernel: Code: 89 42 68 8b 41 04 8b 53 04 8b 80 9c 00 00 00 89 82 9c 00 00 
Jul 20 00:00:25 obelix kernel:  <6>note: events/0[6] exited with preempt_count 1

Cheers,
Frank.

- 
+---- --- -- -  -   -    -
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?
