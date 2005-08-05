Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVHEMyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVHEMyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVHEMyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:54:19 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:7817 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S263007AbVHEMyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:54:18 -0400
Message-ID: <42F3617E.9040808@gmail.com>
Date: Fri, 05 Aug 2005 14:54:22 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] sunrpc as module and bad proc/sys link count
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
When sunrpc is as module, sysctl adds to proc fs proc/sys/sunrpc, adds 1 
to number of proc/sys link (see later), but when it's ls-ed, there is 
still old count.
I.e.
my proc/sys before modprobe-ing sunrpc:
# ls -la /proc/sys
celkem 0
dr-xr-xr-x    9 root root 0 srp  5 12:43 .
dr-xr-xr-x  114 root root 0 srp  5  2005 ..
dr-xr-xr-x    2 root root 0 srp  5 14:33 debug
dr-xr-xr-x    4 root root 0 srp  5 14:33 dev
dr-xr-xr-x    5 root root 0 srp  5 12:43 fs
drwxr-xr-x    5 root root 0 srp  5 14:33 kernel
dr-xr-xr-x    7 root root 0 srp  5 14:33 net
dr-xr-xr-x    2 root root 0 srp  5 14:33 proc
dr-xr-xr-x    2 root root 0 srp  5 14:33 vm
# stat /proc/sys
  File: `/proc/sys'
  Size: 0               Blocks: 0          IO Block: 1024   directory
Device: 3h/3d   Inode: -268435429  Links: 9
*[BTW This seems like bad interpretation of the un/signed number (real 
inode from ls out is 4026531867.]*
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2005-08-05 12:43:12.066160750 +0200
Modify: 2005-08-05 12:43:12.066160750 +0200
Change: 2005-08-05 12:43:12.066160750 +0200

after:
#modprobe sunrpc
#ls -la /proc/sys
celkem 0
dr-xr-xr-x    9 root root 0 srp  5 12:43 . <-- The 9 here should be now 10
dr-xr-xr-x  114 root root 0 srp  5  2005 ..
dr-xr-xr-x    2 root root 0 srp  5 14:35 debug
dr-xr-xr-x    4 root root 0 srp  5 14:35 dev
dr-xr-xr-x    5 root root 0 srp  5 12:43 fs
drwxr-xr-x    5 root root 0 srp  5 14:35 kernel
dr-xr-xr-x    7 root root 0 srp  5 14:35 net
dr-xr-xr-x    2 root root 0 srp  5 14:35 proc
dr-xr-xr-x    2 root root 0 srp  5 14:35 sunrpc
dr-xr-xr-x    2 root root 0 srp  5 14:35 vm
# stat /proc/sys
  File: `/proc/sys'
  Size: 0               Blocks: 0          IO Block: 1024   directory
Device: 3h/3d   Inode: -268435429  Links: 9
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2005-08-05 12:43:12.066160750 +0200
Modify: 2005-08-05 12:43:12.066160750 +0200
Change: 2005-08-05 12:43:12.066160750 +0200

When I add printk to proc/generic.c into create_proc_entry before and 
after proc_register, it prints 9 and after 10 (so the nlink is added here).

On the other side, when sunrpc is in the kernel (not as module) it works 
fine, and the count returned by proc fs is 10, so ok.

This appears in kernels 2.6.11.12 through 2.6.13-rc4-mm1, maybe in older 
kernels too.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

