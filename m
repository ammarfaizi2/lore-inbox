Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbUKQWam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbUKQWam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUKQW2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:28:42 -0500
Received: from mail.convergence.de ([212.227.36.84]:12509 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262596AbUKQW0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:26:09 -0500
Date: Wed, 17 Nov 2004 23:29:49 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: linux-kernel@vger.kernel.org
Cc: Gerd Knorr <kraxel@bytesex.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: modprobe + request_module() deadlock
Message-ID: <20041117222949.GA9006@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems that modprobe in newer versions of module-init-tools
(here: 3.1-pre6) gets an exclusive lock on the module's .ko file:

                struct flock lock;
                lock.l_type = F_WRLCK;
                lock.l_whence = SEEK_SET;
                lock.l_start = 0;
                lock.l_len = 1;
                fcntl(fd, F_SETLKW, &lock);

This leads to a deadlock when the loaded module calls
request_module() in its module_init() function, to load
a module which in turn depends on the first module.

E.g. drivers/media/video/saa7134/saa7134-core.c calls
request_module("saa7134-empress") when it detected that
the card is a BMK MPEG2 encoder card.

Question: Is this a bug in modprobe or in saa7134-core.c?


Here are the two modprobe call stacks from SysRq-T:

Nov 16 22:38:33 abc kernel: modprobe      D DB9A2D54     0  7915   7334                     (NOTLB)
Nov 16 22:38:33 abc kernel: db9a2d68 00200082 00000000 db9a2d54 c011452a 00000001 db9a2d64 c0114304 
Nov 16 22:38:33 abc kernel: 00000864 86734aec 00000293 f73129e0 f7312b3c db9a2e24 db9a2000 db9a2000 
Nov 16 22:38:33 abc kernel: db9a2dbc c039a2c7 00000000 f73129e0 c0114d5e 00000000 00000000 00001230 
Nov 16 22:38:33 abc kernel: Call Trace:
Nov 16 22:38:33 abc kernel: [<c039a2c7>] wait_for_completion+0x85/0xd9
Nov 16 22:38:33 abc kernel: [<c0125fcc>] call_usermodehelper+0x90/0x98
Nov 16 22:38:33 abc kernel: [<c0125d90>] request_module+0x88/0xca
Nov 16 22:38:33 abc kernel: [<f8dd8745>] saa7134_initdev+0x63a/0x785 [saa7134]
Nov 16 22:38:33 abc kernel: [<c020a92a>] pci_device_probe_static+0x49/0x58
Nov 16 22:38:33 abc kernel: [<c020a96c>] __pci_device_probe+0x33/0x43
Nov 16 22:38:33 abc kernel: [<c020a9a2>] pci_device_probe+0x26/0x42
Nov 16 22:38:33 abc kernel: [<c024546a>] driver_probe_device+0x2c/0x62
Nov 16 22:38:33 abc kernel: [<c0245582>] driver_attach+0x53/0x7d
Nov 16 22:38:33 abc kernel: [<c02459ec>] bus_add_driver+0x9c/0xc1
Nov 16 22:38:33 abc kernel: [<c0245f24>] driver_register+0x2b/0x2f
Nov 16 22:38:33 abc kernel: [<c020ab96>] pci_register_driver+0x5f/0x7b
Nov 16 22:38:33 abc kernel: [<c012dc96>] sys_init_module+0x18a/0x23e
Nov 16 22:38:33 abc kernel: [<c0102413>] syscall_call+0x7/0xb

Nov 16 22:38:33 abc kernel: modprobe      S F72B8324     0  7989   7988                     (NOTLB)
Nov 16 22:38:33 abc kernel: db99cf14 00000086 00000003 f72b8324 00000246 f72b8324 8672a32e 00000293 
Nov 16 22:38:33 abc kernel: 001ea8f3 8672a32e 00000293 dc6b2a60 dc6b2bbc f70bce34 f70bce50 db99c000 
Nov 16 22:38:33 abc kernel: db99cf90 c015fcfd c015e321 db99c000 00000000 fffffff5 f72b8324 00000007 
Nov 16 22:38:33 abc kernel: Call Trace:
Nov 16 22:38:33 abc kernel: [<c015fcfd>] fcntl_setlk+0x202/0x283
Nov 16 22:38:33 abc kernel: [<c015bdfc>] do_fcntl+0xd5/0x15e
Nov 16 22:38:33 abc kernel: [<c015bf34>] sys_fcntl64+0x63/0x6f
Nov 16 22:38:33 abc kernel: [<c0102413>] syscall_call+0x7/0xb

# ps -p 7915 -o pid,args
  PID COMMAND
 7915 /sbin/modprobe -s -q saa7134
# ps -p 7989 -o pid,args
  PID COMMAND
 7989 /sbin/modprobe -q -- saa7134_empress


Johannes
