Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269414AbUHZTIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269414AbUHZTIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbUHZTF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:05:56 -0400
Received: from mx1.valuehost.ru ([62.118.251.208]:27920 "HELO mx1.valuehost.ru")
	by vger.kernel.org with SMTP id S269392AbUHZTC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:02:29 -0400
Date: Thu, 26 Aug 2004 21:00:19 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: 2.6.9-rc1: kernel BUG at mm/slab.c:1828 (sunrpc)
Message-ID: <20040826190019.GA3359@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this running X and some gnome applications for a while (~10sec).
After the bug, keyboard stays locked, mouse (usb) works, and I can
finish the session. It brings me to a blank console:

    kernel:  <6>SysRq : Emergency Sync
    kernel: Emergency Sync complete
    gconfd (raa-3333): Received signal 1, shutting down cleanly
    gconfd (raa-3333): Exiting
    init: open(/dev/console): Input/output error

Ctrl-Alt-Del worked, though:

    init: Switching to runlevel: 6

It is reproducable with latest bk as of Aug 26 20:00 CET.
The system is ht/smt P4 with preempt, Gentoo (no hotplug and udev).

There is a suspect:
    struct auth_domain *auth_unix_lookup(struct in_addr addr)
	    ...
	    key.m_class = "nfsd";
	    key.m_addr = addr;

And ip_map_put contains a "kfree(im->m_class)".
I wasn't able to reproduce the bug after removing the kfree.
The strdups to m_class will leak now, I suppose.


This is how the bug looks like:

 kfree_debugcheck: out of range ptr f8a2de00h.
 ------------[ cut here ]------------
 kernel BUG at mm/slab.c:1828!
 invalid operand: 0000 [#1]
 PREEMPT SMP 
 Modules linked in: md5 ipv6 nfsd exportfs lockd sunrpc e100 rtc reiserfs snd_intel8x0 snd_ac97_code
c snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sd_mod usb_storage usbhid uhci_hcd us
bcore
 CPU:    0
 EIP:    0060:[kfree_debugcheck+101/111]    Not tainted VLI
 EIP:    0060:[<c0149cf8>]    Not tainted VLI
 EFLAGS: 00010086   (2.6.9-rc1) 
 EIP is at kfree_debugcheck+0x65/0x6f
 eax: 00000031   ebx: 00038a2d   ecx: c02e3d20   edx: c02e3d20
 esi: f8a2de00   edi: f8a2de00   ebp: f7cb4ef4   esp: f7cb4ee4
 ds: 007b   es: 007b   ss: 0068
 Process events/0 (pid: 6, threadinfo=f7cb4000 task=f7ced8b0)
 Stack: c02baa74 f8a2de00 f8a2de00 00000001 f7cb4f0c c014abab 00000286 f7d50a9c 
        00000001 f7cb4000 f7cb4f18 f8a43dd1 f7d50a9c f7cb4f30 f8a469ff f8a54dc0 
        00000005 f7cb6d74 f8a54f44 f7cb4f3c f8a46b99 f7cb4000 f7cb4fc8 c01323d9 
 Call Trace:
  [show_stack+122/144] show_stack+0x7a/0x90
  [<c0105fc1>] show_stack+0x7a/0x90
  [show_registers+338/438] show_registers+0x152/0x1b6
  [<c0106144>] show_registers+0x152/0x1b6
  [die+236/473] die+0xec/0x1d9
  [<c0106323>] die+0xec/0x1d9
  [do_invalid_op+152/154] do_invalid_op+0x98/0x9a
  [<c0106709>] do_invalid_op+0x98/0x9a
  [error_code+45/56] error_code+0x2d/0x38
  [<c0105c8d>] error_code+0x2d/0x38
  [kfree+33/145] kfree+0x21/0x91
  [<c014abab>] kfree+0x21/0x91
  [pg0+946167249/1069613056] ip_map_put+0x39/0x56 [sunrpc]
  [<f8a43dd1>] ip_map_put+0x39/0x56 [sunrpc]
  [pg0+946178559/1069613056] cache_clean+0x1c0/0x34c [sunrpc]
  [<f8a469ff>] cache_clean+0x1c0/0x34c [sunrpc]
  [pg0+946178969/1069613056] do_cache_clean+0xe/0x45 [sunrpc]
  [<f8a46b99>] do_cache_clean+0xe/0x45 [sunrpc]
  [worker_thread+446/796] worker_thread+0x1be/0x31c
  [<c01323d9>] worker_thread+0x1be/0x31c
  [kthread+159/164] kthread+0x9f/0xa4
  [<c0136dc4>] kthread+0x9f/0xa4
  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
  [<c010327d>] kernel_thread_helper+0x5/0xb
 Code: c3 89 74 24 04 c7 04 24 50 aa 2b c0 e8 6a 78 fd ff 0f 0b 29 07 de 9f 2b c0 eb dc 89 44 24 04 
c7 04 24 74 aa 2b c0 e8 50 78 fd ff <0f> 0b 24 07 de 9f 2b c0 eb b0 55 89 e5 57 56 89 c6 53 83 ec 18 


The config, a bootlog, an alt-sysrq-t of another bug, cpuinfo and lspci:
http://home.arcor.de/fork0/bug/

--
Alex Riesen
