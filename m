Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSFPHki>; Sun, 16 Jun 2002 03:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSFPHkh>; Sun, 16 Jun 2002 03:40:37 -0400
Received: from mailg.telia.com ([194.22.194.26]:58067 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S315971AbSFPHkf>;
	Sun, 16 Jun 2002 03:40:35 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206152148020.1839-100000@home.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jun 2002 09:40:28 +0200
Message-ID: <m2znxvbrir.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Mon, 10 Jun 2002, Patrick Mochel wrote:
> >
> > Sorry about the delay. Could you please try this patch and let me know if
> > it helps? It attempts to treat cardbus more like PCI, and let the PCI
> > helpers do the probing.
> 
> Peter, can you just remove this patch from your kernel, I don't know how
> to fix it. It does something bad to all the resource allocations. The
> child resources don't find the parent any more, and you can see the result
> in /proc/iomem and /proc/ioport clearly. The cardbus devices are not seen
> as "children" of the cardbus controller any more from a resource
> standpoint.
> 
> So can you go back to the setup before applying this patch, and do a
> debugging run of that version instead?

Sure, with an unpatched 2.5.21 kernel, bringing up eth0 fails during
boot. Tobias Diedrich posted a one-line patch that fixes this problem
for me:

--- linux-2.5.20/drivers/pcmcia/cardbus.c	Sat May 25 03:55:22 2002
+++ linux-2.5.20/drivers/pcmcia/cardbus.c	Sun Jun  9 02:27:35 2002
@@ -284,6 +284,7 @@
 		dev->dev.parent = bus->dev;
 		strcpy(dev->dev.name, dev->name);
 		strcpy(dev->dev.bus_id, dev->slot_name);
+		dev->dev.bus = &pci_bus_type;
 		device_register(&dev->dev);
 
 		/* FIXME: Do we need to enable the expansion ROM? */

But he said he didn't know if it was the right fix, and noone has
commented on that yet.

All tests I have done so far with 2.5.21 based kernels produce an oops
at shutdown, which makes the machine hang instead of rebooting or
powering off. I'm not sure if it's related to cardbus devices though.
It could also be caused by the broken cdrom drive in that machine.

Turning off swap:  
Turning off quotas:  
Unmounting file systems:  
Unmounting proc file system:  
Halting system...
flushing ide devices: hda <1>Unable to handle kernel NULL pointer dereference at
 virtual address 00000004
c017aed3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c017aed3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c02c6d24   ebx: c3ad2000   ecx: 00000000   edx: 00000000
esi: c02c6d0c   edi: c0262460   ebp: 00000000   esp: c3ad3e50
ds: 0018   es: 0018   ss: 0018
Stack: c02c6d0c c02c6bb4 00000001 c017b24d c02c6d0c c02c6bb0 c01b03dc c02c6d0c 
       c02c6bb0 c01a9af6 c02c6bb0 c0261f9c 00000000 00000003 bffffcc8 c011e27c 
       c0261f9c 00000003 00000000 00000001 c3ad2000 fee1dead c011e6ce c02a8b88 
Call Trace: [<c017b24d>] [<c01b03dc>] [<c01a9af6>] [<c011e27c>] [<c011e6ce>] 
   [<c010fde9>] [<c011c810>] [<c011c8a7>] [<c011cc45>] [<c011d81d>] [<c01380ea>]
   [<c0136bc0>] [<c0136c31>] [<c0106ee7>] 
Code: 89 4a 04 89 11 89 46 18 89 40 04 8b 43 10 48 89 43 10 8b 43 

>>EIP; c017aed3 <do_driver_detach+23/70>   <=====
Trace; c017b24d <device_read_power+d/40>
Trace; c01b03dc <idedisk_ioctl+8c/300>
Trace; c01a9af6 <drive_is_flashcard+96/a0>
Trace; c011e27c <notifier_call_chain+1c/40>
Trace; c011e6ce <sys_reboot+17e/2a0>
Trace; c010fde9 <wake_up_process+9/10>
Trace; c011c810 <deliver_signal+50/60>
Trace; c011c8a7 <send_sig_info+87/b0>
Trace; c011cc45 <kill_something_info+165/190>
Trace; c011d81d <sys_kill+4d/60>
Trace; c01380ea <fput+ea/110>
Trace; c0136bc0 <filp_close+a0/b0>
Trace; c0136c31 <sys_close+61/90>
Trace; c0106ee7 <syscall_call+7/b>
Code;  c017aed3 <do_driver_detach+23/70>
00000000 <_EIP>:
Code;  c017aed3 <do_driver_detach+23/70>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c017aed6 <do_driver_detach+26/70>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c017aed8 <do_driver_detach+28/70>
   5:   89 46 18                  mov    %eax,0x18(%esi)
Code;  c017aedb <do_driver_detach+2b/70>
   8:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c017aede <do_driver_detach+2e/70>
   b:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c017aee1 <do_driver_detach+31/70>
   e:   48                        dec    %eax
Code;  c017aee2 <do_driver_detach+32/70>
   f:   89 43 10                  mov    %eax,0x10(%ebx)
Code;  c017aee5 <do_driver_detach+35/70>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
