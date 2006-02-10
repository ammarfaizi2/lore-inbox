Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWBJUj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWBJUj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBJUj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbWBJUj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:39:27 -0500
Date: Fri, 10 Feb 2006 12:38:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1 - BUG: unable to handle kernel NULL pointer
 dereference at virtual address 0000003a
Message-Id: <20060210123848.7cb84eeb.akpm@osdl.org>
In-Reply-To: <a44ae5cd0602101224l63886192sec85a8771cf77ba9@mail.gmail.com>
References: <a44ae5cd0602101224l63886192sec85a8771cf77ba9@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> BUG: unable to handle kernel NULL pointer dereference at virtual
>  address 0000003a
>   printing eip:
>  0000003a
>  *pde = 00000000
>  Oops: 0000 [#1]
>  SMP
>  last sysfs file: /devices/pci0000:00/0000:00:02.2/usb3/idProduct
>  Modules linked in: sr_mod eth1394 snd_mpu401 8250_pnp snd_mpu401_uart
>  snd_rawmidi pcspkr ehci_hcd autofs4 vfat
>   fat 3c59x mii forcedeth parport_pc parport 8250 serial_core ohci1394
>  ieee1394 ohci_hcd uhci_hcd usbcore conta
>  iner ide_cd cdrom ide_scsi
>  CPU:    0
>  EIP:    0060:[<0000003a>]    Not tainted VLI
>  EFLAGS: 00010286   (2.6.16-rc2-mm1 #9)
>  EIP is at 0x3a
>  eax: ffffff85   ebx: 00000000   ecx: 00000000   edx: 00000020
>  esi: 00020070   edi: 12000000   ebp: 00000000   esp: f6b60c70
>  ds: 007b   es: 007b   ss: 0068
>  Process cdrom_id (pid: 3482, threadinfo=f6b60000 task=f6b6f6f0)
>  Stack: <0>00000000 00000000 00000000 00000000 00000000 00000000
>  00000000 00000000
>         00000000 00000000 00000000 00000000 00000043 00000000 0000400c c04aaca4
>         0000000c ffffff85 00000000 00000002 00000001 00007530 00000000 f64006ac
>  Call Trace:
>   <c01038b9> show_stack_log_lvl+0xaa/0xb5   <c01039fd> show_registers+0x139/0x1a5
>   <c0103cf6> die+0x162/0x1ef   <c01120e6> do_page_fault+0x389/0x4cc
>   <c01032bf> error_code+0x4f/0x54
>  Code:  Bad EIP value.
>   BUG: cdrom_id/3482, lock held at task exit time!
>   [dfca557c] {init_once}
>  .. held by:          cdrom_id: 3482 [f6b6f6f0, 123]
>  ... acquired at:               do_open+0x61/0x2f0

gack, what a mess.  At a guess, I'd say that block_dev.c:do_open() found a
stupid value in disk->fops->open and did an indirect jump to it.

What is `cdrom_id'?

Can you describe what was happening at the time?  What does your cdrom
setup look like, which cdrom drivers were loaded at the time, etc?

It might help if you could change the value of CONFIG_FRAME_POINTER, try
again, see if we can get a better backtrace.

Also, try disabling cdrom_id (mv cdrom_id cdrom_id~), then when the machine
is booted, run `strace cdrom_id'.  But one would need to work out which
arguments were begin passed to cdrom_id.

