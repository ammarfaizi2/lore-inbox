Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275454AbTHJB1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 21:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275453AbTHJB1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 21:27:24 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:3248 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S275452AbTHJB1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 21:27:09 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: more oddities in test3, was advansys failures, now various
Date: Sat, 9 Aug 2003 21:27:07 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308092127.07750.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.63.55] at Sat, 9 Aug 2003 20:27:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I logged into a second console, and used vim to keep a log of what I 
was doing, this time managing without locking up the machine.
Here is that log:
----------------------------
[root@coyote root]# modprobe advansys
  Vendor: ARCHIVE   Model: Python 28849-XXX  Rev: 4.CM
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Attached scsi tape st0 at scsi1, channel 0, id 1, lun 0
st0: try direct i/o: yes, max page reachable by HBA 131056
Attached scsi generic sg0 at scsi1, channel 0, id 1, lun 0,  type 1
  Vendor: ARCHIVE   Model: Python 28849-XXX  Rev: 4.CM
  Type:   Medium Changer                     ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 1,  type 8
advansys: advansys_reset: board 0: SCSI bus reset started...
advansys: advansys_reset: board 0: SCSI bus reset successful.
[root@coyote root]#

It took about 45 seconds to get that prompt back.

Ok, now some fooling around
[root@coyote root]# mt -f /dev/nst0 status
/dev/nst0: Input/output error

It took it at least 30 seconds to report this,
 as if it was out in lala land for a while
The drive had not loaded a tape (its a changer)
so I manually loaded the first one.

[root@coyote root]# mt -f /dev/nst0 status
st0: Block limits 1 - 16777215 bytes.
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x24 (DDS-2).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN

It took at least 30 seconds to return the above

[root@coyote root]# mt -f /dev/nst0 status
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x24 (DDS-2).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN

and another 15 seconds to return the above.
I run at a 32k blocksize, so next is to
reset st to that.

[root@coyote root]#mt -f /dev/nst0 setblk 32768

which took 10 seconds or more to return, almost
like its a random thing.

It IS random, because the console return is blocked
UNTIL I MOVE THE MOUSE!

If I issue these commands, and immediately move the 
mouse, then the prompt return is as instant as I can
get to the mouse and move it.  WTF?

Just for grins, and keeping the mouse in motion:
[root@coyote root]# rmmod advansys
[root@coyote root]# modprobe advansys
  Vendor: ARCHIVE   Model: Python 28849-XXX  Rev: 4.CM
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Attached scsi tape st0 at scsi2, channel 0, id 1, lun 0
st0: try direct i/o: yes, max page reachable by HBA 131056
Attached scsi generic sg0 at scsi2, channel 0, id 1, lun 0,  type 1
  Vendor: ARCHIVE   Model: Python 28849-XXX  Rev: 4.CM
  Type:   Medium Changer                     ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi2, channel 0, id 1, lun 1,  type 8
[root@coyote root]#
And I got my prompt back in about the time it takes to do a
complete, scan all luns, scsi bus scan, 5 seconds or so.
-------------------------------

Ok, I'll bite, what the heck has the console mouse (non x, nvidia 
isn't working) got to do with this?  Hummmm, I wonder if x would work 
if I kept the mouse in motion after doing the startx?  According to 
the XFree86.2.6.log, it stops here:

[root@coyote root]# tail -n3 /var/log/XFree86.2.6.log
        [29] 0  0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(II) NVIDIA(0): AGP 4X successfully initialized
(II) NVIDIA(0): Setting mode "1600x1200/60Hz"
[root@coyote root]#

But for this 2.4.22-rc2 boot, it continues on a bit:

[root@coyote root]# tail -n32 /var/log/XFree86.0.log
(II) NVIDIA(0): AGP 4X successfully initialized
(II) NVIDIA(0): Setting mode "1600x1200/60Hz"
(II) NVIDIA(0): Using the NVIDIA 2D acceleration architecture
(==) NVIDIA(0): Backing store disabled
(==) NVIDIA(0): Silken mouse enabled
(II) Loading extension NV-GLX
(II) Loading extension NV-CONTROL
Symbol __glXActiveScreens from module 
/usr/X11R6/lib/modules/extensions/libdri.a is unresolved!
Symbol __glXActiveScreens from module 
/usr/X11R6/lib/modules/extensions/libdri.a is unresolved!
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) [GLX]: Initializing GLX extension
(**) Option "Protocol" "IMPS/2"
(**) Mouse0: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/mouse"
(**) Option "Emulate3Buttons" "no"
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
(II) XINPUT: Adding extended input device "NVIDIA Event Handler" 
(type: Other)
[root@coyote root]#
----------------
let me also join the chorus complaining about the keyboard repeat, its 
very easy to get ddddd for a single press of the key.  But I suspect 
thats probably not an issue once X is running?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

