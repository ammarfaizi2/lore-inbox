Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270373AbTHCUdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270432AbTHCUdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:33:40 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:2063 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270373AbTHCUdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:33:36 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2-mm3-1: Badness in class_dev_release followed by 5 NFS server hangs
Date: Mon, 4 Aug 2003 04:33:08 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308040328.26830.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Computer mhfl2 running kde 3.1 on 2.6.0-test2-mm3-1, kppp, kmail, opera.

pppd is version 2.4.1 and has been used without problems since 2.5.5x

Did a bit of web and this got inthe logs:

Aug  4 00:45:08 mhfl2 pppd[8622]: Terminating on signal 15.
Aug  4 00:45:08 mhfl2 pppd[8622]: Connection terminated.
Aug  4 00:45:08 mhfl2 pppd[8622]: Connect time 11.9 minutes.
Aug  4 00:45:08 mhfl2 pppd[8622]: Sent 81253 bytes, received 660560 bytes.
Aug  4 00:45:09 mhfl2 kernel: kobject 'statistics' does not have a release() function, it is broken and must be fixed.
Aug  4 00:45:09 mhfl2 kernel: Badness in kobject_cleanup at lib/kobject.c:402
Aug  4 00:45:09 mhfl2 kernel: Call Trace:
Aug  4 00:45:09 mhfl2 kernel:  [<c01d939c>] kobject_cleanup+0x5c/0x74
Aug  4 00:45:09 mhfl2 kernel:  [<c01d93ca>] kobject_put+0x16/0x1c
Aug  4 00:45:09 mhfl2 kernel:  [<c01d92fb>] kobject_unregister+0x13/0x1c
Aug  4 00:45:09 mhfl2 kernel:  [<c028c100>] netdev_unregister_sysfs+0x1c/0x34
Aug  4 00:45:09 mhfl2 kernel:  [<c028b696>] netdev_run_todo+0xfa/0x16c
Aug  4 00:45:09 mhfl2 kernel:  [<c028eb65>] rtnl_unlock+0x3d/0x44
Aug  4 00:45:09 mhfl2 kernel:  [<c0247e6f>] unregister_netdev+0x17/0x1e
Aug  4 00:45:09 mhfl2 kernel:  [<c024b8f1>] ppp_shutdown_interface+0x55/0xa0
Aug  4 00:45:09 mhfl2 kernel:  [<c0248645>] ppp_ioctl+0x55/0x7e4
Aug  4 00:45:09 mhfl2 kernel:  [<c0158eaf>] sys_ioctl+0x1ef/0x20c
Aug  4 00:45:09 mhfl2 kernel:  [<c0149907>] sys_close+0x4b/0x60
Aug  4 00:45:09 mhfl2 kernel:  [<c02eb9c7>] syscall_call+0x7/0xb

[ 2 more times the above ]

There is a change to ppp_async for xonxoff in -mm2 and -mm3, 
could this be related?

===== drivers/net/ppp_async.c 1.12 vs edited =====
--- 1.12/drivers/net/ppp_async.c        Fri Jun 20 09:48:08 2003
+++ edited/drivers/net/ppp_async.c      Sun Aug  3 18:38:39 2003
@@ -891,6 +891,11 @@
                        process_input_packet(ap);
                } else if (c == PPP_ESCAPE) {
                        ap->state |= SC_ESCAPE;
+               } else if (I_IXON(ap->tty)) {
+                       if (c == START_CHAR(ap->tty))
+                               start_tty(ap->tty);
+                       else if (c == STOP_CHAR(ap->tty))
+                               stop_tty(ap->tty);
                }
                /* otherwise it's a char in the recv ACCM */
                ++n;

----------------------
The NFS hangs:

Computer mhfl4 is NFS client running kde 3.1 on 
2.4.22-pre10 connected by 100baset to mhfl2.

Keyboard/mouse of mhfl4 is run from mhfl2 via x2x and 
worked fine throughout the occurences, excluding a basic
network problem. 

Directory "data" is located on mhfl2 and mounted via NFS
using mount options "hard,intr"

Did this:

[mhf@mhfl4 01:30:25 data]$ ls
111.umq  211.umq  311.umq  411.umq  
112.umq  212.umq  312.umq  412.umq  
[mhf@mhfl4 01:30:27 data]$ mkdir t
[mhf@mhfl4 01:30:36 data]$ cp * t
[mhf@mhfl4 01:32:40 data]$

Takes 120 or so seconds to copy 8 files totalling 1280K

[mhf@mhfl4 01:42:15 data]$ cd t
[mhf@mhfl4 01:42:21 t]$ ll
total 1280
-rw-rw-r--    1 mhf        109846 Aug  4 01:30 111.umq
-rw-rw-r--    1 mhf        114192 Aug  4 01:30 112.umq
-rw-rw-r--    1 mhf         30120 Aug  4 01:30 211.umq
-rw-rw-r--    1 mhf         25260 Aug  4 01:30 212.umq
-rw-rw-r--    1 mhf        138204 Aug  4 01:31 311.umq
-rw-rw-r--    1 mhf        117122 Aug  4 01:31 312.umq
-rw-rw-r--    1 mhf        399738 Aug  4 01:32 411.umq
-rw-rw-r--    1 mhf        339736 Aug  4 01:32 412.umq

mhfl4 log is below and file times match the log. 

Aug  4 01:30:42 mhfl4 kernel: nfs: server mhfl2 not responding, still trying
Aug  4 01:30:43 mhfl4 kernel: nfs: server mhfl2 OK
Aug  4 01:30:45 mhfl4 kernel: nfs: server mhfl2 not responding, still trying
Aug  4 01:31:24 mhfl4 kernel: nfs: server mhfl2 OK
Aug  4 01:31:26 mhfl4 kernel: nfs: server mhfl2 not responding, still trying
Aug  4 01:31:45 mhfl4 kernel: nfs: server mhfl2 OK
Aug  4 01:31:56 mhfl4 kernel: nfs: server mhfl2 not responding, still trying
Aug  4 01:32:24 mhfl4 kernel: nfs: server mhfl2 OK
Aug  4 01:32:25 mhfl4 kernel: nfs: server mhfl2 not responding, still trying
Aug  4 01:32:56 mhfl4 kernel: nfs: server mhfl2 OK

In short, Server hung 5 times for 8 files - why?

Checked logs and found above badness in logs of mhfl2 
but nothing about NFS server.

Rebooted mhfl2 and will see if it happens again.

Both occurences and their combination are new to me. 
Used mostly -mm1 since July 30, no problems seen.

Regards
Michael

-- 
Powered by linux-2.6-test2-mm3-1. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/


