Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJIKYb>; Tue, 9 Oct 2001 06:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRJIKYL>; Tue, 9 Oct 2001 06:24:11 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:48017 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S273912AbRJIKYG>;
	Tue, 9 Oct 2001 06:24:06 -0400
To: <linux-kernel@vger.kernel.org>
Subject: keyboard + PS/2 mouse locks after opening psaux
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 09 Oct 2001 12:21:48 +0200
Message-ID: <m3elodw1tv.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having the following problem: after I start X11 (or gpm with no X)
my keyboard and PS/2 mouse sometimes locks up. What could that be?

440BX UP celeron mobo here (Abit - BH6?), '94 AT keyboard, '2000 A4tech
2-wheel mouse, various Linux 2.4 versions (usually -ac, currently 2.4.10ac3).
I'm using NVidia Xserver module, but it doesn't seem related (the lookup
occured with no X while starting gpm once or twice).

If I kill Xserver (haven't tried with gpm), the keyboard (and mouse) start
working again (the next Xserver spawn works fine).

For me, it looks like some race condition between open_aux and mouse
(kbd?) interrupt, causing interrupts or kbd controller to stay disabled
after the mouse device is opened. The interrupt counters for both kbd
and psaux stay constant when I move the mouse and/or press buttons/keyboard
keys:

intrepid:~$ cat /proc/interrupts 
           CPU0       
  0:    1528212          XT-PIC  timer
  1:          6          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:     189554          XT-PIC  serial
  9:    1587447          XT-PIC  acpi, nvidia
 11:      15215          XT-PIC  usb-uhci, eth0, eth1
 12:          2          XT-PIC  PS/2 Mouse
 14:      49181          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
ERR:          3

I'm currently keeping this machine in locked state, so I can provide more
info.

What I also found is that open_aux routine isn't protected by lock_kernel(),
while release_aux is. Is that correct? Would a mouse interrupt received
before open_aux() is completed cause such a lookup?

-- 
Krzysztof Halasa
Network Administrator
