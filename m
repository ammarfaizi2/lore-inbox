Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266456AbUFQMly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266456AbUFQMly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUFQMly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:41:54 -0400
Received: from main.gmane.org ([80.91.224.249]:61118 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266456AbUFQMl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:41:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: repeatable tty OOPSes w/ 2.6.7
Date: Thu, 17 Jun 2004 12:41:25 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrncd34bn.35b.lunz@orr.homenet>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: finn.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I put 2.6.7 on my workstation yesterday. For some reason, the fgetty on tty3
causes this whenever it tries to start (i get 10 of these every 5
minutes from init trying to respawn the fgetty):

	Unable to handle kernel NULL pointer dereference at virtual address 00000000
	printing eip:
	c01d3b5e
	*pde = 00000000
	Oops: 0000 [#1]
	PREEMPT 
	Modules linked in: cls_u32 sch_sfq sch_htb ipt_REJECT ipt_LOG ipt_limit ipt_state iptable_filter joydev evdev usbhid uhci_hcd usbcore parport_pc parport snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore mga_vid 8250_pnp 8250 serial_core ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack w83781d i2c_sensor i2c_viapro i2c_core sr_mod cdrom aic7xxx scsi_mod rtc
	CPU:    0
	EIP:    0060:[vt_ioctl+30/7216]    Not tainted
	EFLAGS: 00010282   (2.6.7) 
	EIP is at vt_ioctl+0x1e/0x1c30
	eax: 00000000   ebx: 00005401   ecx: 00000000   edx: bffffdc4
	esi: c01d3b40   edi: c9f9f000   ebp: c888aec0   esp: cab65ea4
	ds: 007b   es: 007b   ss: 0068
	Process fgetty (pid: 2118, threadinfo=cab64000 task=cabb2e30)
	Stack: c13b220c c015fda2 c13b220c 00000002 00000000 00000292 c888aec0 c028e898 
	00000002 00000000 c9f9f000 c888aec0 c01dde2b cab64000 cab64000 cffcf800 
	00000000 c01cde97 c9f9f000 c888aec0 cab65f00 00020006 00400003 c9f9f000 
	Call Trace:
	[dput+34/528] dput+0x22/0x210
	[__down_failed+8/12] __down_failed+0x8/0xc
	[con_open+43/192] con_open+0x2b/0xc0
	[tty_open+567/864] tty_open+0x237/0x360
	[tty_open+0/864] tty_open+0x0/0x360
	[chrdev_open+230/528] chrdev_open+0xe6/0x210
	[open_namei+159/1024] open_namei+0x9f/0x400
	[dentry_open+260/544] dentry_open+0x104/0x220
	[copy_from_user+66/128] copy_from_user+0x42/0x80
	[vt_ioctl+0/7216] vt_ioctl+0x0/0x1c30
	[tty_ioctl+1096/1344] tty_ioctl+0x448/0x540
	[sys_ioctl+239/608] sys_ioctl+0xef/0x260
	[sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

	Code: 8b 30 8b 04 b5 a0 6c 37 c0 89 34 24 89 44 24 50 e8 fd 68 00 

oddly, this only happens on tty3. The identically-configured fgettys on
the other 5 ttys work fine. Which makes me think that the scsi cd writer
that burned up yesterday may have taken some other hardware with it?

FWIW, with vmware tainting the kernel, the trace changes to this:

	<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
	printing eip:
	c01d3b5e
	*pde = 00000000
	Oops: 0000 [#53]
	PREEMPT 
	Modules linked in: vmnet vmmon cls_u32 sch_sfq sch_htb ipt_REJECT ipt_LOG ipt_limit ipt_state iptable_filter joydev evdev usbhid uhci_hcd usbcore parport_pc parport snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore mga_vid 8250_pnp 8250 serial_core ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack w83781d i2c_sensor i2c_viapro i2c_core sr_mod cdrom aic7xxx scsi_mod rtc
	CPU:    0
	EIP:    0060:[vt_ioctl+30/7216]    Tainted: P  
	EFLAGS: 00010282   (2.6.7) 
	EIP is at vt_ioctl+0x1e/0x1c30
	eax: 00000000   ebx: 00005401   ecx: 00000000   edx: bffffdc4
	esi: c01d3b40   edi: cc30c000   ebp: c443f6a0   esp: c438bea4
	ds: 007b   es: 007b   ss: 0068
	Process fgetty (pid: 3360, threadinfo=c438a000 task=c4d8d810)
	Stack: 00000000 00000000 c438a000 0001cd18 fffff17c c01154bb 00000000 c0157534 
	00000002 00000000 cc30c000 c443f6a0 c01dde2b c438a000 c438a000 cffcf800 
	00000000 c01cde97 cc30c000 c443f6a0 c438bf00 00020006 00400003 cc30c000 
	Call Trace:
	[release_console_sem+203/224] release_console_sem+0xcb/0xe0
	[link_path_walk+1604/2400] link_path_walk+0x644/0x960
	[con_open+43/192] con_open+0x2b/0xc0
	[tty_open+567/864] tty_open+0x237/0x360
	[tty_open+0/864] tty_open+0x0/0x360
	[chrdev_open+230/528] chrdev_open+0xe6/0x210
	[open_namei+159/1024] open_namei+0x9f/0x400
	[dentry_open+260/544] dentry_open+0x104/0x220
	[copy_from_user+66/128] copy_from_user+0x42/0x80
	[vt_ioctl+0/7216] vt_ioctl+0x0/0x1c30
	[tty_ioctl+1096/1344] tty_ioctl+0x448/0x540
	[sys_ioctl+239/608] sys_ioctl+0xef/0x260
	[sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

	Code: 8b 30 8b 04 b5 a0 6c 37 c0 89 34 24 89 44 24 50 e8 fd 68 00 

jason

