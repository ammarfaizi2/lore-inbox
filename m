Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTERWRw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTERWRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:17:52 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:43906 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262226AbTERWRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:17:50 -0400
Subject: Oops during ALSA insmod when OSS was loaded on 2.5.69-mm5
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053297043.13624.24.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 00:30:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have the OSS driver for my sb16 loaded (ALSA didn't work in some
kernel a while ago so I switched to OSS and forgot to switch back)

I just performed an upgrade of my Debian system and it tried to activate
ALSA and thus started loading the modules. Kernel is 2.5.69-mm5. This is
what I got:

Unable to handle kernel paging request at virtual address f4a52958
 printing eip:
eeaba090
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<eeaba090>]    Not tainted VLI
EFLAGS: 00010202
EIP is at snd_minor_search+0x18/0x4c [snd]
eax: eeac6ea8   ebx: 00000021   ecx: eeac6780   edx: eeac6ea8
esi: eeac6780   edi: c8021f8c   ebp: eb845f6c   esp: eb845f68
ds: 007b   es: 007b   ss: 0068  
Process modprobe (pid: 10236, threadinfo=eb844000 task=e0c79b20)
Stack: 00000021 eb845f88 eeaba318 00000021 d21a8dd8 c032bda0 c032bd60 c8021f70
       eb845fa8 ec88f08a 00000021 00000000 00000000 eeae07b8 eeade877 eeae07e0
       eb845fbc c0135abd 0804f258 00000002 00000000 eb844000 c0109853 0804f258
Call Trace:
 [<eeaba318>] snd_register_device+0x98/0x10c [snd]
 [<ec88f08a>] +0x8a/0xa5 [snd_timer]
 [<eeae07b8>] snd_timer_reg+0x0/0x1c [snd_timer]
 [<eeade877>] +0x377/0x63e [snd_timer]
 [<eeae07e0>] +0x0/0xe0 [snd_timer]
 [<c0135abd>] sys_init_module+0x201/0x2d8
 [<c0109853>] syscall_call+0x7/0xb

Code: eb 05 b8 97 03 ac ee 50 e8 ee 23 67 d1 89 ec 5d c3 89 f6 55 89 e5 53 8b 5d 08 89 d8 c1 f8 05 8b 14 c5 a0 6e ac ee 8b 02 0f 18 00 <00> 89 d8 c1 f8 05 8d 04 c5 a0 6e ac ee 39 c2 74 1b 89 c1 39 5a

It was probably snd_timer it failed on, The error scrolled off the
screen quite fast. lsmod says snd_timer is loaded but the module-loader
complained it couldn't find some symbols from snd_timer:

snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_timer_new
and later:
snd_seq: Unknown symbol snd_timer_stop
snd_seq: Unknown symbol snd_timer_close
snd_seq: Unknown symbol snd_timer_open
snd_seq: Unknown symbol snd_timer_start
snd_seq: Unknown symbol snd_timer_resolution
snd_seq: Unknown symbol snd_timer_pause

If those symbols would have been found snd_pcm would have been tried for
loading and would probably have Oopsed again because of the previous
error.

Yup, cat /proc/modules tells us which module it was:

snd_timer 27109 1 - Loading 0xeeada000

I havn't tried reproducing it, I havn't tried it without OSS modules
loaded either. The OSS modules loaded when this happened was:

sb                     10368  2 
sb_lib                 53680  1 sb
uart401                10756  1 sb_lib
sound                  90908  4 sb_lib,uart401

-- 
/Martin
