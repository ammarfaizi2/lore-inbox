Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUEVPLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUEVPLq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUEVPLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:11:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37089 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261474AbUEVPLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:11:44 -0400
Date: Sat, 22 May 2004 08:11:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: herbert@gondor.apana.org.au
Subject: [Bug 2748] New: Missing locks in video1394_ioctl
Message-ID: <7560000.1085238696@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2748

           Summary: Missing locks in video1394_ioctl
    Kernel Version: 2.6.6
            Status: NEW
          Severity: normal
             Owner: bcollins@debian.org
         Submitter: herbert@gondor.apana.org.au


This bug was reported at http://bugs.debian.org/248996.

The last few messages are:

video1394_0: Iso receive DMA: 8 buffers of size 614400 allocated for a frame sis
video1394_0: iso context 1 listen on channel 0
video1394_0: Waking up iso dma ctx=1
video1394_0: Buffer 3 is already used
video1394_0: Iso context 1 stop talking on channel 0
NMI Watchdog detected LOCKUP on CPU1, eip c02920f0, registers:
CPU:    1
EIP:    0060:[<c02920f0>]    Not tainted
EFLAGS: 00200086   (2.6.6-1-686-smp)
EIP is at .text.lock.sched+0x34/0xa4
eax: 00000000   ebx: f3106000   ecx: c1813be0   edx: f3106000
esi: f3c49edc   edi: 00200286   ebp: f3107ed0   esp: f3107ea4
ds: 007b   es: 007b   ss: 0068
Process Simulation_trac (pid: 2218, threadinfo=f3106000 task=f77ba0d0)
Stack: 00000000 f77ba0d0 c011bb60 f3c49ee0 f3c49ee0 c01b48c2 f3107f44 bf5ffa84
       f3106000 f3c49e48 f3106000 00200297 f8aafbcd f77f7a20 00000001 00000000
       f77ba0d0 c011bb60 00000000 00000000 f77515b8 f77ba5f4 f3107fc4 f3c49edc
Call Trace:
 [<c011bb60>] default_wake_function+0x0/0x20
 [<c01b48c2>] copy_from_user+0x42/0x70
 [<f8aafbcd>] video1394_ioctl+0xacd/0x1070 [video1394]
 [<c011bb60>] default_wake_function+0x0/0x20
 [<c010dc66>] convert_fxsr_from_user+0x26/0xf0
 [<c01e4f8e>] tty_write+0x19e/0x2f0
 [<c01eab80>] write_chan+0x0/0x230
 [<c015d7b7>] vfs_write+0x107/0x160
 [<c0171c08>] sys_ioctl+0x148/0x2d0
 [<c0102313>] huft_build+0x1d3/0x540
 [<c010621b>] syscall_call+0x7/0xb
 [<c0102313>] huft_build+0x1d3/0x540
                                                                               
                                                                               
                  
Code: 80 3e 00 7e f9 e9 9e fb ff ff f3 90 80 3e 00 7e f9 e9 11 fc
console shuts up ...

So it looks like someone did a WAIT/POLL BUFFER which sleeps without holding a
lock on d, and then someone did a UNLISTEN/UNTALK CHANNEL, which frees d...


