Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVJYTA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVJYTA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 15:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVJYTA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 15:00:28 -0400
Received: from wbm2.pair.net ([209.68.3.43]:13 "HELO wbm2.pair.net")
	by vger.kernel.org with SMTP id S932306AbVJYTA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 15:00:27 -0400
Message-ID: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com>
Date: Tue, 25 Oct 2005 15:00:24 -0400 (EDT)
Subject: Oops in do_page_fault
From: chase.venters@clientec.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Please forgive me in advanced for the length of this description - I don't
want to leave out any important details.

About two weeks ago I came home from work to find that the fan on my XFX
GeForce 6800GT PCI-E had failed. My computer, which was previously playing
music, was simply playing the last buffer-sized frame of audio repeatedly
as if it were a skipping CD. I cursed, got frustrated, and ordered a
7800GT to replace it.

While I was waiting, I took advantage of my Asus P5GDC-V Deluxe's onboard
Intel 915 graphics to get by in X. This was stable for a few days (prior
to the graphics card failure, this system was stable for a year).
Eventually, though, I was ripping a CD while listening to music and doing
some other minor things when I noticed that the system started crashing in
a very odd way.

I managed to run dmesg from a remote shell that was open, and saw so
really strange traces I didn't manage to save. Pretty soon I realized that
every process that tried to touch the disk would go into a
TASK_UNINTERRUPTIBLE sleep and freeze. The system took about 30 seconds to
crap out - amusingly enough, my music continued to play until the song was
over; then that died too.

Writing it off to a possible bug in the video driver, I rebooted and
noticed ReiserFS doing lots of cleanup. I continued on my way until the
system crashed again an hour later. Stability gradually grew much worse -
I went from a year of stability, to days, to hours, to minutes...
Eventually, I decided the best option would be to leave it alone until
replacement parts arrived.

In the mean time I ran memtest86 exhaustively to verify that my value RAM
wasn't on the fritz.

The replacement card arrived, and annoyed by what seemed to be excessive
corruption on my partition, I used a LiveCD to set one disk in the RAID10
to faulty, removed it, made an ext2 partition on it, moved my data to it
(which thankfully fit), rebuilt the ReiserFS partition on the RAID, moved
all the data back over, and resynced the disk.

The system seemed to work perfectly for days. I was happy to have fixed
the problem. Then, though, I noticed that my brand new fresh partition was
kicking up very similar errors (I think I remember seeing something about
vs-7000 nesting filesystem, as well as complaints about free space
calculations). It took 5 minutes before the system froze during an "emerge
traceroute". This time, the behavior got bad really fast. I could reliably
reproduce the behavior by running "emerge traceroute" (the last thing I
ever saw before death was portage checking /usr/share/doc). Two times it
freezed, two times it actually *immediately* rebooted without even a
visible panic, etc.

I replaced the motherboard with an identical motherboard, upgraded to a
better cooler (CPU is a 540J prescott 3.2GHz), went from a 380 watt to a
500 watt dual 12v-rail supply. Strangely enough, after these changes, I
can now reproduce the crash reliably, but I'm getting (depending on the
kernel version I boot) different but consistent behavior each time.

In 2.6.13, I get an Oops (translated by hand, sorry for inexact formatting):

Oops 0000 #1
PREEMPT SMP
(list of modules linked in includes some alsa modules, nvidia.ko and
sk98lin.ko)

CPU 0
EIP 0060:[<c01182c3>] Tainted: P VLI
EFLAGS: 00010086 (2.6.13)
EIP is at do_page_fault+0xa3/0x5db
eax: f5e50000  ebx: 0000000b  ecx: 0000000d  edx: 0000000d
esi: 0000000e  edi: c0567451  ebp: 00000000  esp: f5e5a10c

ds: 007b  es: 007b  ss: 0068

2.6.13 will oops reproducibly as above upon completion of "emerge
traceroute". Each 2.6.13 oops always happens at do_page_fault+0xa3/0x5db.
ebx and ecx are also observed to be constant.

Oddly enough, the second Oops I got on 2.6.13 reported a CPU # 2949119.

I also tested "emerge traceroute" on the same partition by booting
2.6.11.7 and 2.6.12.4. Both of these kernels failed to Oops / panic, but
simply froze.

My next step will be to try and replace the CPU (though I really
appreciate any comments as to whether I'm likely looking at a hardware
problem anymore). I ordered a replacement CPU and got sent a 478 instead
of a 775, so it looks like I'm going to have to go grab one up locally.

I tried to rebuild my kernel with SysRQ and a serial console to be of
better help; unfortunately, I can't seem to do enough IO before crashing
to succeed.

Thanks,
Chase Venters
