Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319010AbSH1V45>; Wed, 28 Aug 2002 17:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSH1V45>; Wed, 28 Aug 2002 17:56:57 -0400
Received: from holomorphy.com ([66.224.33.161]:39040 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319010AbSH1V4y>;
	Wed, 28 Aug 2002 17:56:54 -0400
Date: Wed, 28 Aug 2002 15:01:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] mysterious tty deadlock
Message-ID: <20020828220114.GA878@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One such stuck process had the following backtrace:

#0  schedule_timeout (timeout=-150765944) at timer.c:864
#1  0xc01a28a3 in uart_wait_until_sent (tty=0xf7669000, timeout=2147483647)
    at core.c:1320
#2  0xc01afca8 in tty_wait_until_sent (tty=0xf7669000, timeout=0)
    at tty_ioctl.c:66
#3  0xc01b0049 in set_termios (tty=0xf7669000, arg=3221221720, opt=2)
    at tty_ioctl.c:164
#4  0xc01b03dc in n_tty_ioctl (tty=0xf7669000, file=0xf716b8a0, cmd=21507, 
    arg=3221221720) at tty_ioctl.c:409
#5  0xc01ac3b0 in tty_ioctl (inode=0xf72b9cf4, file=0xf716b8a0, cmd=21507, 
    arg=3221221720) at tty_io.c:1798
#6  0xc0152cf6 in sys_ioctl (fd=0, cmd=21507, arg=3221221720) at ioctl.c:128
#7  0xc01078df in syscall_call () at process.c:982


This doesn't appear to be serial-specific. Another stuck process is:


(gdb) bt
#0  schedule_timeout (timeout=2147483647) at timer.c:836
#1  0xc01af23d in read_chan (tty=0xf73da000, file=0xf781f6a0, 
    buf=0xbffffd93 "", nr=1) at n_tty.c:1043
#2  0xc01aa4b6 in tty_read (file=0xf781f6a0, buf=0xbffffd93 "", count=1, 
    ppos=0xf781f6c0) at tty_io.c:677
#3  0xc0142e2c in vfs_read (file=0xf781f6a0, buf=0xbffffd93 "", count=1, 
    pos=0xf781f6c0) at read_write.c:193
#4  0xc0142ffe in sys_read (fd=0, buf=0xbffffd93 "", count=1)
    at read_write.c:232
#5  0xc01078df in syscall_call () at process.c:982

It's actually possible to kick these by sending them signal-generating
characters, though the forward progress one can make this way is limited.

(1) type "ls &"
(2) This will not echo.
(3) type ^Z (^C doesn't work for some reason)
(4) "ls &" echoes
(5) no prompt appears
(6) type ^Z again
(7) the prompt doesn't appear
(8) type ^Z again
(9) the prompt appears

... this is a little oversimplified. Some pounding on the return keys is
usually also required. serial and non-serial behave identically here.


Cheers,
Bill
