Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262529AbTCJHeP>; Mon, 10 Mar 2003 02:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbTCJHeP>; Mon, 10 Mar 2003 02:34:15 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:61446 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S262529AbTCJHeM>; Mon, 10 Mar 2003 02:34:12 -0500
Date: Sun, 9 Mar 2003 23:44:54 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: linux-kernel@vger.kernel.org
Subject: aacraid (dell PERC) cannot handle a degraded mirror
In-Reply-To: <5.1.1.6.2.20030101084621.00cdf9f8@pop.gmx.net>
Message-ID: <20030309233257.O74417-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you are running Linux 2.4.x and using aacraid, and a mirror degrades
(ie. one of the disks goes bad or otherwise detaches itself from the
mirror) the system will panic and crash.

This is, of course, incorrect behavior - if a mirror degrades the system
should continue running because half of the mirror is still there.

Here is a scenario I have seen about ten times in the last few months -
and it is only this frequency and consistency that has provoked me to send
this email:

1. I start getting things like this in /var/log/messages

Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Error Event
[command:0x28]
Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Medium Error, Block
Range 435200 : 435327
Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Error Too Long To
Correct
Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0) Medium Error, LBN Range
435200:435327
Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0) Starting BBR sequence

Ok, fair enough - disk 2 on channel 0 is bad or is going bad.  Good thing
I have a mirror ... wrong!


2. The problem gets worse:

Mar  9 07:13:00 system kernel: scsi : aborting command due to timeout :
pid
162469964, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 06 a3 ff 00 00 08
00
Mar  9 07:13:06 system kernel: scsi : aborting command due to timeout :
pid
162470312, scsi0, channel 0, id 1, lun 0 Read (10) 00 03 c2 c2 fb 00 00 02
00
Mar  9 07:13:06 system kernel: scsi : aborting command due to timeout :
pid
162470320, scsi0, channel 0, id 1, lun 0 Read (10) 00 05 79 83 77 00 00 02
00
Mar  9 07:13:07 system kernel: scsi : aborting command due to timeout :
pid
162470322, scsi0, channel 0, id 1, lun 0 Read (10) 00 01 b6 c3 71 00 00 02
00
Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Error Event
[command:0x28]
Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Medium Error, Block
Range 435234 : 435234
Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Error Too Long To
Correct


3. disk 2 on channel 0 fails.  No problem, it's a mirror, right ?


Mar  9 07:13:30 system kernel: SCSI host 0 abort (pid 162469964) timed out
- resetting
Mar  9 07:13:30 system kernel: SCSI bus is being reset for host 0 channel
0.
Mar  9 07:13:36 system kernel: scsi : aborting command due to timeout :
pid
162470312, scsi0, channel 0, id 1, lun 0 Read (10) 00 03 c2 c2 fb 00 00 02
00
Mar  9 07:13:36 system kernel: SCSI host 0 abort (pid 162470312) timed out
- resetting
Mar  9 07:13:36 system kernel: SCSI bus is being reset for host 0 channel
0.
Mar  9 07:13:36 system kernel: scsi : aborting command due to timeout :
pid
162470320, scsi0, channel 0, id 1, lun 0 Read (10) 00 05 79 83 77 00 00 02
00
Mar  9 07:13:36 system kernel: SCSI host 0 abort (pid 162470320) timed out
- resetting
Mar  9 07:13:36 system kernel: SCSI bus is being reset for host 0 channel
0.
Mar  9 07:13:36 system kernel: aacraid:  BBR timed out at Block 0x6a42d
Mar  9 07:13:36 system kernel: aacraid:Drive 0:2:0 returning error
Mar  9 07:13:36 system kernel: aacraid:ID(0:02:0) - IO failed, Cmd[0x28]


4. System panics and crashes (which makes _no_ sense, because the other
disk is totally healthy, has reported no errors, and makes up the other
half of the _mirror_.


Mar  9 07:13:41 system kernel: Unable to handle kernel paging request at
virtual address 405a2200
Mar  9 07:13:41 system kernel:  printing eip:
Mar  9 07:13:41 system kernel: c0114d0f
Mar  9 07:13:41 system kernel: *pde = 14629067
Mar  9 07:13:41 system kernel: *pte = 00000000
Mar  9 07:13:41 system kernel: Oops: 0000


5. upon system boot, the Dell PERC 3si reports that the mirror is
degraded, but that the other disk in the mirror is totally healthy, and
that the container is present.

6. system boots _just fine_ on the broken mirror, as it should - system
runs fine on broken mirror, as it should.


So, why does the system run fine on the broken mirror, but panics and
crashes when the mirror actually breaks ?

This is very frustrating - one of the reasons we spent money to mirror
things was to reduce possible downtimes (since a disk failure will not
crash the machine) but ... a disk failure does crash the machine.
Explanations welcome.

