Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTBPWA2>; Sun, 16 Feb 2003 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTBPWA2>; Sun, 16 Feb 2003 17:00:28 -0500
Received: from crack.them.org ([65.125.64.184]:34236 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267503AbTBPWA1>;
	Sun, 16 Feb 2003 17:00:27 -0500
Date: Sun, 16 Feb 2003 17:10:23 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Signal/gdb oddity in 2.5.61
Message-ID: <20030216221023.GA6806@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20030216191543.D12489@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216191543.D12489@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 07:15:43PM +0000, Russell King wrote:
> Hi,
> 
> I'm seeing some weird behaviour with signal handling/gdb on 2.5.61:
> 
> [root@assabet /root]$cat /dev/zero > /dev/null &
> [1] 132
> [root@assabet /root]$gdb /bin/cat    
> GNU gdb 5.0
> Copyright 2000 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "armv4l-rmk-linux"...(no debugging symbols found)...
> (gdb) attach 132
> Attaching to program: /bin/cat, Pid 132
> Reading symbols from /lib/libc.so.6...(no debugging symbols found)...done.
> Loaded symbols for /lib/libc.so.6
> Reading symbols from /lib/ld-linux.so.2...(no debugging symbols found)...done.
> Loaded symbols for /lib/ld-linux.so.2
> 0x20027a0 in _IO_putc ()
> (gdb) stepi
> 
> Program received signal SIGSTOP, Stopped (signal).
> 0x20027a0 in _IO_putc ()
> (gdb) 
> 0x20027a4 in _IO_putc ()
> (gdb) 
> 0x4008d154 in putc () from /lib/libc.so.6
> (gdb) quit
> 
> Notice the "Program received signal SIGSTOP".
> 
> Asking for the process list via <sysrq>t shows the following after
> attaching gdb:
> 
> cat           T C023CE94 3263624   132    135                     (NOTLB)
> [<c023cb98>] (schedule+0x0/0x3a0)
> 			from [<c024d020>] (get_signal_to_deliver+0x1c0/0x3e4)
> [<c024ce60>] (get_signal_to_deliver+0x0/0x3e4)
> 			from [<c0226a00>] (do_signal+0x5c/0x13c)
> [<c02269a4>] (do_signal+0x0/0x13c)
> 			from [<c0226b10>] (do_notify_resume+0x30/0x34)
> [<c0226ae0>] (do_notify_resume+0x0/0x34)
> 			from [<c0222350>] (work_pending+0x1c/0x28)
> 
> and after the first stepi:
> 
> cat           T C023CE94 3263624   132    135                     (NOTLB)
> [<c023cb98>] (schedule+0x0/0x3a0)
> 			from [<c024cbb4>] (finish_stop+0xb0/0xc8)
> [<c024cb04>] (finish_stop+0x0/0xc8)
> 			from [<c024ce54>] (do_signal_stop+0x288/0x294)
> [<c024cbcc>] (do_signal_stop+0x0/0x294)
> 			from [<c024d184>] (get_signal_to_deliver+0x324/0x3e4)
> [<c024ce60>] (get_signal_to_deliver+0x0/0x3e4)
> 			from [<c0226a00>] (do_signal+0x5c/0x13c)
> [<c02269a4>] (do_signal+0x0/0x13c)
> 			from [<c0226b10>] (do_notify_resume+0x30/0x34)
> [<c0226ae0>] (do_notify_resume+0x0/0x34)
> 			from [<c0222350>] (work_pending+0x1c/0x28)
> 
> subsequent stepi's appear as per the first trace above.


This is a consequence of ARM's separate get_signal_to_deliver. 
Roland's changes for group stops require code in get_signal_to_deliver,
so if you aren't using the common version, you're out of luck.

I think you'll have to either update yours to match, or use the new
hooks David Miller added to use the common get_signal_to_deliver.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
