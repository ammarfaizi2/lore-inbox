Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTBPTFt>; Sun, 16 Feb 2003 14:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTBPTFt>; Sun, 16 Feb 2003 14:05:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4370 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267330AbTBPTFs>; Sun, 16 Feb 2003 14:05:48 -0500
Date: Sun, 16 Feb 2003 19:15:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Signal/gdb oddity in 2.5.61
Message-ID: <20030216191543.D12489@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing some weird behaviour with signal handling/gdb on 2.5.61:

[root@assabet /root]$cat /dev/zero > /dev/null &
[1] 132
[root@assabet /root]$gdb /bin/cat    
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "armv4l-rmk-linux"...(no debugging symbols found)...
(gdb) attach 132
Attaching to program: /bin/cat, Pid 132
Reading symbols from /lib/libc.so.6...(no debugging symbols found)...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/ld-linux.so.2
0x20027a0 in _IO_putc ()
(gdb) stepi

Program received signal SIGSTOP, Stopped (signal).
0x20027a0 in _IO_putc ()
(gdb) 
0x20027a4 in _IO_putc ()
(gdb) 
0x4008d154 in putc () from /lib/libc.so.6
(gdb) quit

Notice the "Program received signal SIGSTOP".

Asking for the process list via <sysrq>t shows the following after
attaching gdb:

cat           T C023CE94 3263624   132    135                     (NOTLB)
[<c023cb98>] (schedule+0x0/0x3a0)
			from [<c024d020>] (get_signal_to_deliver+0x1c0/0x3e4)
[<c024ce60>] (get_signal_to_deliver+0x0/0x3e4)
			from [<c0226a00>] (do_signal+0x5c/0x13c)
[<c02269a4>] (do_signal+0x0/0x13c)
			from [<c0226b10>] (do_notify_resume+0x30/0x34)
[<c0226ae0>] (do_notify_resume+0x0/0x34)
			from [<c0222350>] (work_pending+0x1c/0x28)

and after the first stepi:

cat           T C023CE94 3263624   132    135                     (NOTLB)
[<c023cb98>] (schedule+0x0/0x3a0)
			from [<c024cbb4>] (finish_stop+0xb0/0xc8)
[<c024cb04>] (finish_stop+0x0/0xc8)
			from [<c024ce54>] (do_signal_stop+0x288/0x294)
[<c024cbcc>] (do_signal_stop+0x0/0x294)
			from [<c024d184>] (get_signal_to_deliver+0x324/0x3e4)
[<c024ce60>] (get_signal_to_deliver+0x0/0x3e4)
			from [<c0226a00>] (do_signal+0x5c/0x13c)
[<c02269a4>] (do_signal+0x0/0x13c)
			from [<c0226b10>] (do_notify_resume+0x30/0x34)
[<c0226ae0>] (do_notify_resume+0x0/0x34)
			from [<c0222350>] (work_pending+0x1c/0x28)

subsequent stepi's appear as per the first trace above.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

