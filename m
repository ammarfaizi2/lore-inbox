Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316215AbSEKMYj>; Sat, 11 May 2002 08:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316216AbSEKMYi>; Sat, 11 May 2002 08:24:38 -0400
Received: from daimi.au.dk ([130.225.16.1]:63224 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316215AbSEKMYi>;
	Sat, 11 May 2002 08:24:38 -0400
Message-ID: <3CDD0D80.E87E4169@daimi.au.dk>
Date: Sat, 11 May 2002 14:24:32 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Trivial bugfix in 3c509.c
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 3c509 compiled in kernel calling ifup after lots of
diskaccess causes an Oops.

read_eeprom was incorrectly marked as __init. This patch
applies against 2.4.19-pre8-ac1 and maybee also 2.4.19-pre8:

diff -Nur linux.old/drivers/net/3c509.c linux.new/drivers/net/3c509.c
--- linux.old/drivers/net/3c509.c       Sat May 11 13:53:45 2002
+++ linux.new/drivers/net/3c509.c       Sat May 11 13:55:09 2002
@@ -567,7 +567,7 @@
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
  */
-static ushort __init read_eeprom(int ioaddr, int index)
+static ushort read_eeprom(int ioaddr, int index)
 {
 	outw(EEPROM_READ + index, ioaddr + 10);
 	/* Pause for at least 162 us. for the read to take place. */

May 11 14:01:41 eddie ifup: Determining IP information for eth0...
May 11 14:01:41 eddie kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 11 14:01:41 eddie kernel:  printing eip:
May 11 14:01:41 eddie kernel: c02e05e0
May 11 14:01:41 eddie kernel: *pde = 00000000
May 11 14:01:41 eddie kernel: Oops: 0000
May 11 14:01:41 eddie kernel: CPU:    0
May 11 14:01:41 eddie kernel: EIP:    0010:[read_eeprom+0/48]    Not tainted
May 11 14:01:41 eddie kernel: EIP:    0010:[<c02e05e0>]    Not tainted
May 11 14:01:41 eddie kernel: EFLAGS: 00010246
May 11 14:01:41 eddie kernel: eax: 00000800   ebx: c02c63de   ecx: 00000006   edx: 0000022e
May 11 14:01:41 eddie kernel: esi: 0000022e   edi: 00000220   ebp: c02c6360   esp: c3c07ea4
May 11 14:01:41 eddie kernel: ds: 0018   es: 0018   ss: 0018
May 11 14:01:41 eddie kernel: Process dhcpcd (pid: 1715, stackpage=c3c07000)
May 11 14:01:41 eddie kernel: Stack: c01e4c80 00000220 00000014 0000022e c02c6360 00000220 00000000 c01e40ef 
May 11 14:01:41 eddie kernel:        c02c6360 c02c6360 00000000 00000063 c022150c c02c6360 c02c6360 00000002 
May 11 14:01:41 eddie ifup: ./ifup: line 250:  1715 Segmentation fault      /sbin/dhcpcd ${DHCPCDARGS} ${DEVICE}
May 11 14:01:41 eddie kernel:        c0222461 c02c6360 cb259140 c3c07f3d cbfb1744 cbfb1720 c024e274 c02c6360 
May 11 14:01:41 eddie kernel: Call Trace: [el3_up+128/464] [el3_open+111/160] [dev_open+76/176] [dev_change_flags+81/256] [devinet_ioctl+868/1696] 
May 11 14:01:41 eddie kernel: Call Trace: [<c01e4c80>] [<c01e40ef>] [<c022150c>] [<c0222461>] [<c024e274>] 
May 11 14:01:41 eddie kernel:    [do_page_fault+296/1147] [packet_ioctl+905/960] [sock_ioctl+28/32] [sys_ioctl+559/592] [system_call+51/64] 
May 11 14:01:41 eddie kernel:    [<c0112708>] [<c0258099>] [<c021b7dc>] [<c0143c1f>] [<c01089f3>] 
May 11 14:01:41 eddie kernel: 
May 11 14:01:41 eddie kernel: Code: 39 01 8b bb 1b d3 f9 1a 90 a4 24 fc 3a fa dc 62 6e 22 28 42 
May 11 14:01:41 eddie pumpd[1719]: starting at (uptime 0 days, 0:02:49) Sat May 11 14:01:41 2002  


-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
