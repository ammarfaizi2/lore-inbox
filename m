Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSGEQSP>; Fri, 5 Jul 2002 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGEQSO>; Fri, 5 Jul 2002 12:18:14 -0400
Received: from dsl-linz4-236-240.utaonline.at ([212.152.236.240]:23025 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S317474AbSGEQSM>;
	Fri, 5 Jul 2002 12:18:12 -0400
Message-ID: <3D25C5DB.1B6B2839@falke.mail>
Date: Fri, 05 Jul 2002 18:14:19 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange problem with 2.5.24
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: thomas@winischhofer.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I - well, more precisely one of my testers - experience(s) a strange
problem with 2.5.24 using my recent sisfb (SiS framebuffer driver) and
with the SiS X driver. This applies to the SiS630 as well as 650 (and
possible others as well.)

A little background info: The SiS video BIOS provides some information
on the machine's memory and the buswidth in sequencer register 0x14.
(Communication with the sequencer is done by writing the address of the
port to be read/written to port 0x3c4 and read/write the register
contents to/from port 0x3c5.)

Using any of the 2.4 series kernels, the sequencer register 0x14
contains 0x5f - which means the machine has 32MB shared graphics memory
(0x1f) and a buswidth of 64 bit (0x40) according to the specs. This is
correct.

When running the 2.5.24 kernel, this register right from the beginning
(ie. when sisfb's init function is called) says 0xdf - which means 32MB
of shared memory (0x1f) and a bus width of 32bit (0xc0) - the latter is
incorrect (0xc0 was only possible on the SiS300 and is not used on the
630.)

This leads to incorrect timing calculations in sisfb as well as the X
driver.

I have disassembled the video BIOS code now completely and found only
one place where SR14 is being written. And this code makes it IMPOSSIBLE
that it contains 0xdf (11011111). The bits 7 and 6 can NEVER contain the
same value, as the code looks in about like this:

  and ah, 3fh
  shl bh,7
  or ah, bh
  shr bh, 1
  xor bh, 40h
  or ah, bh
  ...-> write ah to SR14

Bit 0 of bh in the beginning is the result of an undocumented int 15h
call, holding the code for the buswidth. As you see, xor-ing the bit
before or-ing it into ah again makes it impossible that the register
holds 0xdf.

Again: This does not happen if a 2.4 kernel is used!

Since the video BIOS's init routine (which is the only place where SR14
is set) is very probably *not* called AFTER the kernel has been loaded
and started, my only idea is that any other kernel component incorrectly
writes to SR14.

Has anybody any idea why this may happen?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                 
mailto:thomas@winischhofer.net            http://www.winischhofer.net/

