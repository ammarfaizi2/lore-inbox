Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSIATYK>; Sun, 1 Sep 2002 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSIATYK>; Sun, 1 Sep 2002 15:24:10 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:13543 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317415AbSIATYH>; Sun, 1 Sep 2002 15:24:07 -0400
Subject: Re: OOPS: USB and/or devicefs
From: Nicholas Miell <nmiell@attbi.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <20020828054647.GA26390@kroah.com>
References: <1030270093.1531.8.camel@entropy> 
	<20020828054647.GA26390@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 12:28:30 -0700
Message-Id: <1030908511.1374.17.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-27 at 22:46, Greg KH wrote:

> Does this still happen on 2.5.32?  I was unable to reproduce it on
> either 2.5.31, 2.5.31-bk, or 2.5.32.
> 

I can reproduce the oops reliably -- but you have to enable slab
poisoning to do it.

I just did it again with pure 2.5.33 (plus some minor patches to get it
to compile -- nothing USB related)

This is my device tree before I do anything:

root/
root/pci0
root/pci0/00:0f.1
root/pci0/00:0f.0
root/pci0/00:0b.0
root/pci0/00:0a.0
root/pci0/00:08.0
root/pci0/00:08.0/usb_bus
root/pci0/00:08.0/usb_bus/1
root/pci0/00:08.0/usb_bus/1/00:08.0-1:0
root/pci0/00:08.0/usb_bus/00:08.0-0:0
root/isapnp1
root/isapnp1/0
root/sys
root/sys/03?0
root/sys/0040
root/sys/0020

In a term, chdir to root/pci0/00:08.0/usb_bus/1/00:08.0-1:0, and then
unplug the hub. The following oops occurs:

Sep  1 11:55:14 entropy kernel: usb.c: USB disconnect on device 2
Sep  1 11:55:14 entropy kernel: Unable to handle kernel paging request at virtual address 5a5a5a5e
Sep  1 11:55:14 entropy kernel:  printing eip:
Sep  1 11:55:14 entropy kernel: c0148f99
Sep  1 11:55:14 entropy kernel: *pde = 00000000
Sep  1 11:55:14 entropy kernel: Oops: 0002
Sep  1 11:55:14 entropy kernel: CPU:    0
Sep  1 11:55:14 entropy kernel: EIP:    0060:[<c0148f99>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  1 11:55:14 entropy kernel: EFLAGS: 00010206
Sep  1 11:55:14 entropy kernel: eax: c33afcf0   ebx: c33afce0   ecx: 5a5a5a5a   edx: 5a5a5a5a
Sep  1 11:55:14 entropy kernel: esi: c33afce0   edi: c24b5a64   ebp: c33afa50   esp: c4df5ed4
Sep  1 11:55:14 entropy kernel: ds: 0068   es: 0068   ss: 0068
Sep  1 11:55:14 entropy kernel: Process khubd (pid: 93, threadinfo=c4df4000 task=c487cb80)
Sep  1 11:55:15 entropy kernel: Stack: 00000286 000b5400 00000286 c10cb280 c24b5ac0 c33afce0 c015f027 c33afce0 
Sep  1 11:55:15 entropy kernel:        c33afce0 c33afba4 c33afa28 c015f7ef c24b5314 c33afce0 c3da3cd0 c3da3e1c 
Sep  1 11:55:15 entropy kernel:        c58422a4 c3da3c00 c0171a50 c3da3d70 c3da3cd0 c3da3cd0 c3da3c40 c583509a 
Sep  1 11:55:15 entropy kernel: Call Trace: [<c015f027>] [<c015f7ef>] [<c58422a4>] [<c0171a50>] [<c583509a>] 
Sep  1 11:55:15 entropy kernel:    [<c5836f2f>] [<c583722f>] [<c58426bb>] [<c58373b0>] [<c58373db>] [<c58373b0>] 
Sep  1 11:55:15 entropy kernel:    [<c01123d0>] [<c0107145>] 
Sep  1 11:55:15 entropy kernel: Code: 89 4a 04 89 11 c7 43 10 00 00 00 00 c7 40 04 00 00 00 00 89 

>>EIP; c0148f99 <d_delete+59/80>   <=====
Trace; c015f027 <driverfs_unlink+37/40>
Trace; c015f7ef <driverfs_remove_dir+4f/a1>
Trace; c58422a4 <[usbcore].rodata.end+3429/84c5>
Trace; c0171a50 <put_device+80/b0>
Trace; c583509a <[usbcore]usb_disconnect+ea/110>
Trace; c5836f2f <[usbcore]usb_hub_port_connect_change+4f/250>
Trace; c583722f <[usbcore]usb_hub_events+ff/280>
Trace; c58426bb <[usbcore].rodata.end+3840/84c5>
Trace; c58373b0 <[usbcore]usb_hub_thread+0/e0>
Trace; c58373db <[usbcore]usb_hub_thread+2b/e0>
Trace; c58373b0 <[usbcore]usb_hub_thread+0/e0>
Trace; c01123d0 <default_wake_function+0/40>
Trace; c0107145 <kernel_thread_helper+5/10>
Code;  c0148f99 <d_delete+59/80>
00000000 <_EIP>:
Code;  c0148f99 <d_delete+59/80>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0148f9c <d_delete+5c/80>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c0148f9e <d_delete+5e/80>
   5:   c7 43 10 00 00 00 00      movl   $0x0,0x10(%ebx)
Code;  c0148fa5 <d_delete+65/80>
   c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
Code;  c0148fac <d_delete+6c/80>
  13:   89 00                     mov    %eax,(%eax)

Then do a ls in the term that was left in
root/pci0/00:08.0/usb_bus/1/00:08.0-1:0, which produces the following
oops:

Sep  1 11:55:33 entropy kernel:  <1>Unable to handle kernel paging request at virtual address 5a5a5aca
Sep  1 11:55:33 entropy kernel:  printing eip:
Sep  1 11:55:33 entropy kernel: c014089f
Sep  1 11:55:33 entropy kernel: *pde = 00000000
Sep  1 11:55:33 entropy kernel: Oops: 0000
Sep  1 11:55:33 entropy kernel: CPU:    0
Sep  1 11:55:33 entropy kernel: EIP:    0060:[<c014089f>]    Not tainted
Sep  1 11:55:33 entropy kernel: EFLAGS: 00010246
Sep  1 11:55:33 entropy kernel: eax: c487cb80   ebx: 00000003   ecx: c0e3ff70   edx: c0e3fed4
Sep  1 11:55:33 entropy kernel: esi: 00000003   edi: c0e3ff70   ebp: 5a5a5a5a   esp: c0e3fec0
Sep  1 11:55:33 entropy kernel: ds: 0068   es: 0068   ss: 0068
Sep  1 11:55:33 entropy kernel: Process ls (pid: 1887, threadinfo=c0e3e000 task=c487cb80)
Sep  1 11:55:33 entropy kernel: Stack: c0e3fed4 00000003 c204c000 c4ffd3f0 c1111c8c 00000000 00000000 00000000 
Sep  1 11:55:33 entropy kernel:        00001e91 000000d2 0000a3d6 00001e91 00000003 c0e3ff60 c012498d c204c005 
Sep  1 11:55:33 entropy kernel:        00000004 01b42f73 c39e26d4 00000003 00000003 c0e3ff70 00018801 c014189c 
Sep  1 11:55:33 entropy kernel: Call Trace: [<c012498d>] [<c014189c>] [<c0110d40>] [<c01090bd>] [<c0136474>] 
Sep  1 11:55:33 entropy kernel:    [<c01367f5>] [<c0108e87>] 
Sep  1 11:55:33 entropy kernel: Code: 8b 45 70 89 14 24 eb 09 8b 45 70 8d b6 00 00 00 00 66 8b 5d 

>>EIP; c014089f <link_path_walk+6f/880>   <=====
Trace; c012498d <vm_enough_memory+2d/c0>
Trace; c014189c <open_namei+7c/3d0>
Trace; c0110d40 <do_page_fault+0/48f>
Trace; c01090bd <error_code+2d/40>
Trace; c0136474 <filp_open+34/60>
Trace; c01367f5 <sys_open+35/70>
Trace; c0108e87 <syscall_call+7/b>
Code;  c014089f <link_path_walk+6f/880>
00000000 <_EIP>:
Code;  c014089f <link_path_walk+6f/880>   <=====
   0:   8b 45 70                  mov    0x70(%ebp),%eax   <=====
Code;  c01408a2 <link_path_walk+72/880>
   3:   89 14 24                  mov    %edx,(%esp,1)
Code;  c01408a5 <link_path_walk+75/880>
   6:   eb 09                     jmp    11 <_EIP+0x11> c01408b0 <link_path_walk+80/880>
Code;  c01408a7 <link_path_walk+77/880>
   8:   8b 45 70                  mov    0x70(%ebp),%eax
Code;  c01408aa <link_path_walk+7a/880>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c01408b0 <link_path_walk+80/880>
  11:   66 8b 5d 00               mov    0x0(%ebp),%bx

Afterwards, "find root/ -type d" produces this, with find dying in
down() (probably because khubd died).

root/
root/pci0
root/pci0/00:0f.1
root/pci0/00:0f.0
root/pci0/00:0b.0
root/pci0/00:0a.0
root/pci0/00:08.0
root/pci0/00:08.0/usb_bus

Again, there are lots of 0x5a bytes in the oops, indicating that
something is being used after it is freed and slab poisoning is catching
that error.

