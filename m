Return-Path: <linux-kernel-owner+w=401wt.eu-S1030309AbXAKXoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbXAKXoA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbXAKXoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:44:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:34611 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030273AbXAKXn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:43:58 -0500
Date: Thu, 11 Jan 2007 17:43:56 -0600
To: Bino.Sebastian@Emulex.Com
Cc: James.Smart@Emulex.Com, rlary@us.ibm.com, Laurie.Barry@Emulex.Com,
       strosake@us.ibm.com, vaios.papadimitriou@Emulex.Com,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Bug: 2.6.20 scsi/block device/elevator recursion loop
Message-ID: <20070111234356.GL6177@austin.ibm.com>
References: <332A49C36DB0F64198D1A011FB1AA79132A7FD@xbl3.emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332A49C36DB0F64198D1A011FB1AA79132A7FD@xbl3.emulex.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 11, 2007 at 04:22:52PM -0500, Bino.Sebastian@Emulex.Com wrote:
> This patch is present in upstream and is also present 
> in 2.6.20. So this is a new issue.

What was the patch last time around? 

It seems I'm seeing this more often than expected. The first time,
the system spewed the softlockup error, but then recovered after 
a few minutes. This time, even after an hour, the system remained
hung. It was pingable, but the console, and all ssh sessions
were unresponsive.

After hitting the little yellow button, I got a stack trace
(below) in _spin_unlock_irqrestore, which makes me think that
perhaps the system was being flooded with irq's. I'll try 
to investigate further tommorrow.

--linas

Background:
kernel 2.6.20-rc4
IBM Power4 pSeries (630)
lpfc scsi (Emulex)

 chsysstate -r sys -n io-raiders  -o reset

io-raiders:~ # cpu 0x0: Vector: 100 (System Reset) at [c00000003ff69520]
    pc: c00000000023d794: ._raw_spin_unlock+0xb4/0xd4
    lr: c00000000046d5ac: ._spin_unlock_irqrestore+0x18/0x3c
    sp: c00000003ff697a0
   msr: 9000000000009032
  current = 0xc0000000043e21f0
  paca    = 0xc000000000674080
    pid   = 1123, comm = kblockd/0
enter ? for help
[c00000003ff69820] c00000000046d5ac ._spin_unlock_irqrestore+0x18/0x3c
[c00000003ff698b0] c00000000021bbe0 .blk_run_queue+0xc8/0xec
[c00000003ff69950] c000000000320728 .scsi_run_queue+0x248/0x278
[c00000003ff69a00] c000000000321948 .scsi_queue_insert+0x88/0xa8
[c00000003ff69a90] c00000000031bc34 .scsi_dispatch_cmd+0x2b8/0x2e4
[c00000003ff69b30] c000000000322804 .scsi_request_fn+0x2c4/0x3c0
[c00000003ff69be0] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff69c60] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff69d00] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff69d90] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff69e40] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff69ec0] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff69f60] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff69ff0] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6a0a0] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6a120] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6a1c0] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6a250] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6a300] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6a380] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6a420] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6a4b0] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6a560] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6a5e0] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6a680] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6a710] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6a7c0] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6a840] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6a8e0] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6a970] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6aa20] c00000000021bbac .blk_run_queue+0x94/0xec
[c00000003ff6aac0] c000000000320728 .scsi_run_queue+0x248/0x278
[c00000003ff6ab70] c000000000321948 .scsi_queue_insert+0x88/0xa8
[c00000003ff6ac00] c00000000031bc34 .scsi_dispatch_cmd+0x2b8/0x2e4
[c00000003ff6aca0] c000000000322804 .scsi_request_fn+0x2c4/0x3c0
[c00000003ff6ad50] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6add0] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6ae70] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6af00] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6afb0] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6b030] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6b0d0] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6b160] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6b210] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6b290] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6b330] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6b3c0] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6b470] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6b4f0] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6b590] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6b620] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6b6d0] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6b750] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6b7f0] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6b880] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6b930] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6b9b0] c000000000216d6c .elv_insert+0x240/0x268
[c00000003ff6ba50] c00000000021a25c .blk_requeue_request+0x38/0x54
[c00000003ff6bae0] c000000000322864 .scsi_request_fn+0x324/0x3c0
[c00000003ff6bb90] c00000000021ae30 .__generic_unplug_device+0x54/0x6c
[c00000003ff6bc10] c00000000021b3b0 .generic_unplug_device+0x30/0x50
[c00000003ff6bca0] c0000000002177d0 .blk_unplug_work+0x34/0x48
[c00000003ff6bd20] c000000000072214 .run_workqueue+0xe8/0x1d4
[c00000003ff6bdc0] c00000000007305c .worker_thread+0x148/0x1b8
0:mon>

0:mon> r
R00 = 0000000000000000   R16 = 4000000003a10000
R01 = c00000003ff697a0   R17 = c00000000055e0b0
R02 = c0000000007b0128   R18 = 0000000000000000
R03 = c00000000339b330   R19 = 0000000000000000
R04 = 0000000000000001   R20 = 0000000004041e98
R05 = 0000000000000000   R21 = c000000000631e98
R06 = 0000000000000000   R22 = 0000000004042108
R07 = 0000000000000000   R23 = c000000000632108
R08 = c00000003ffe5f90   R24 = c00000000339b198
R09 = 0000000000000000   R25 = c00000002f440438
R10 = c00000003ffe5fa0   R26 = c00000002f440338
R11 = c0000003feee8cd8   R27 = 0000000000000001
R12 = d0000000008d2480   R28 = 0000000000000040
R13 = c000000000674080   R29 = 0000000000000001
R14 = 0000000000000000   R30 = c0000000006da320
R15 = c00000000055f688   R31 = c00000000339b330
pc  = c00000000023d794 ._raw_spin_unlock+0xb4/0xd4
lr  = c00000000046d5ac ._spin_unlock_irqrestore+0x18/0x3c
msr = 9000000000009032   cr  = 24002082
ctr = c0000000002240c0   xer = 0000000000000000   trap =  100
0:mon>

0:mon> di c00000000023d6e0
c00000000023d6e0  7c0802a6      mflr    r0
c00000000023d6e4  fbc1fff0      std     r30,-16(r1)
c00000000023d6e8  fbe1fff8      std     r31,-8(r1)
c00000000023d6ec  ebc2e2b8      ld      r30,-7496(r2)
c00000000023d6f0  7c7f1b78      mr      r31,r3
c00000000023d6f4  f8010010      std     r0,16(r1)
c00000000023d6f8  f821ff81      stdu    r1,-128(r1)
c00000000023d6fc  3c00dead      lis     r0,-8531
c00000000023d700  60004ead      ori     r0,r0,20141
c00000000023d704  81230004      lwz     r9,4(r3)
c00000000023d708  7f890000      cmpw    cr7,r9,r0
c00000000023d70c  41be000c      beq     cr7,c00000000023d718    # ._raw_spin_unlock+0x38/0xd4
c00000000023d710  e89e8008      ld      r4,-32760(r30)
c00000000023d714  4bfffef9      bl      c00000000023d60c        # .spin_bug+0x0/0xd4
c00000000023d718  801f0000      lwz     r0,0(r31)
c00000000023d71c  2fa00000      cmpdi   cr7,r0,0
0:mon>
c00000000023d720  40be0010      bne     cr7,c00000000023d730    # ._raw_spin_unlock+0x50/0xd4
c00000000023d724  e89e8038      ld      r4,-32712(r30)
c00000000023d728  7fe3fb78      mr      r3,r31
c00000000023d72c  4bfffee1      bl      c00000000023d60c        # .spin_bug+0x0/0xd4
c00000000023d730  e80d01a0      ld      r0,416(r13)
c00000000023d734  e93f0010      ld      r9,16(r31)
c00000000023d738  7fa90000      cmpd    cr7,r9,r0
c00000000023d73c  41be0010      beq     cr7,c00000000023d74c    # ._raw_spin_unlock+0x6c/0xd4
c00000000023d740  e89e8010      ld      r4,-32752(r30)
c00000000023d744  7fe3fb78      mr      r3,r31
c00000000023d748  4bfffec5      bl      c00000000023d60c        # .spin_bug+0x0/0xd4
c00000000023d74c  a00d000a      lhz     r0,10(r13)
c00000000023d750  813f0008      lwz     r9,8(r31)
c00000000023d754  7f890000      cmpw    cr7,r9,r0
c00000000023d758  41be0010      beq     cr7,c00000000023d768    # ._raw_spin_unlock+0x88/0xd4
c00000000023d75c  e89e8018      ld      r4,-32744(r30)
0:mon>
c00000000023d760  7fe3fb78      mr      r3,r31
c00000000023d764  4bfffea9      bl      c00000000023d60c        # .spin_bug+0x0/0xd4
c00000000023d768  3800ffff      li      r0,-1
c00000000023d76c  901f0008      stw     r0,8(r31)
c00000000023d770  f81f0010      std     r0,16(r31)
c00000000023d774  60000000      nop
c00000000023d778  880d01ca      lbz     r0,458(r13)
c00000000023d77c  2f800000      cmpwi   cr7,r0,0
c00000000023d780  41be0010      beq     cr7,c00000000023d790    # ._raw_spin_unlock+0xb0/0xd4
c00000000023d784  7c0004ac      sync
c00000000023d788  38000000      li      r0,0
c00000000023d78c  980d01ca      stb     r0,458(r13)
c00000000023d790  7c2004ac      lwsync
c00000000023d794  38000000      li      r0,0
c00000000023d798  38210080      addi    r1,r1,128
c00000000023d79c  901f0000      stw     r0,0(r31)
0:mon>


