Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129971AbQLDN3c>; Mon, 4 Dec 2000 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbQLDN3X>; Mon, 4 Dec 2000 08:29:23 -0500
Received: from wsa-245.sibintek.net ([213.128.193.245]:52254 "EHLO
	mail.ixcelerator.com") by vger.kernel.org with ESMTP
	id <S129971AbQLDN3F>; Mon, 4 Dec 2000 08:29:05 -0500
Date: Mon, 4 Dec 2000 15:57:51 +0300
From: Oleg Drokin <green@ixcelerator.com>
To: linux-kernel@vger.kernel.org
Subject: Race/problem with hotplug & network interfaces
Message-ID: <20001204155751.B11731@iXcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   It seems I have found some kind of race, if hotplug is enabled,
   and one have changing number of network interfaces (observed on ppp).
   I use 2.4.0-test11. Problem is 100% repeatable.

   My test case is this: I start ppp over ssh session, then do ifconfig
   and then kill pppd (by kill -9 pid).
   Immediatelly I getting: 1. waitpid(<somepid>) failed, -512 2. oops.
   Inspecting oops, I have found that
   current->files == NULL in kmod.c::exec_usermodehelper.
   After some investigations, it appears, that when pppd exits,
   ppp interface gets destroyed, and /sbin/hotplug net is called,
   using now dead pppd as parent.
   Simple (and probably not that good) solution is attached as patch, below.
   It get gid of oops, but waitpid failed thing is still there.

   Also I post oops here, too. (sorry, no Code decoding)
 
--- kmod.c.orig	Mon Dec  4 15:31:38 2000
+++ kmod.c	Mon Dec  4 15:32:25 2000
@@ -99,8 +99,10 @@
 	flush_signal_handlers(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	for (i = 0; i < current->files->max_fds; i++ ) {
-		if (current->files->fd[i]) close(i);
+	if ( current->files ) {
+		for (i = 0; i < current->files->max_fds; i++ ) {
+			if (current->files->fd[i]) close(i);
+		}
 	}
 
 	/* Drop the "current user" thing */

Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01122a4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01122a4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c7acea64   ebx: c7a20000   ecx: c1292000   edx: 00000000
esi: 00000006   edi: 00000000   ebp: c1228320   esp: c7a21fb8
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 181, stackpage=c7a21000)
Stack: 00000100 c7c43d84 c7c43db4 c7a76b20 c7b8c0c0 c1228320 c7f87a60 c7f87a60 
       c7f87a60 c7f87a60 c011259c c01d7ba0 c7c43e44 c7c43e30 c01073f8 c7c43db4 
       00000078 c7c43e44 
Call Trace: [<c011259c>] [<c01073f8>] 
Code: 8b 4f 08 39 ca 7d 22 90 8b 47 14 83 3c 90 00 74 13 89 f0 89 

>>EIP; c01122a4 <exec_usermodehelper+298/3d8>   <=====
Trace; c011259c <request_module+1b8/1bc>
Trace; c01073f8 <kernel_thread+28/1b8>

Bye,
    Oleg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
