Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSHYXFq>; Sun, 25 Aug 2002 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSHYXFq>; Sun, 25 Aug 2002 19:05:46 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:48567 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317641AbSHYXFo>; Sun, 25 Aug 2002 19:05:44 -0400
Subject: Re: OOPS: USB and/or devicefs
From: Nicholas Miell <nmiell@attbi.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208251519530.1021-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0208251519530.1021-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Aug 2002 16:09:54 -0700
Message-Id: <1030316995.1494.13.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-25 at 15:22, Patrick Mochel wrote:
> 
> A dentry has been created with no inode associated with it, and
> driverfs_unlink() attempts to access it without checking it.  
> 
> Could you please try the attached patch and let me know if it helps?
> 
> Thanks,
> 
> 	-pat

No help.

The first oops occurred immediately when the hub was unplugged (I was on
a console this time, not X, so I could see the oops live).

The second oops was caused by execing "ls" in
/devices/root/pci0/00:08.0/usb_bus

Both appear to be caused by slab poisoning.

(btw, this isn't straight 2.5.31, it is the BK tree as of about 15:25
PST yesterday)

ksymoops 2.4.4 on i586 2.5.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.31/ (default)
     -m /boot/System.map-2.5.31 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 25 15:42:48 entropy kernel: Unable to handle kernel paging request at virtual address 5a5a5a5e
Aug 25 15:42:48 entropy kernel: c0146d79
Aug 25 15:42:48 entropy kernel: *pde = 00000000
Aug 25 15:42:48 entropy kernel: Oops: 0002
Aug 25 15:42:48 entropy kernel: CPU:    0
Aug 25 15:42:48 entropy kernel: EIP:    0060:[<c0146d79>]    Not tainted
Aug 25 15:42:48 entropy kernel: EFLAGS: 00010206
Aug 25 15:42:48 entropy kernel: eax: c49b47f4   ebx: c49b47e4   ecx: 5a5a5a5a   edx: 5a5a5a5a
Aug 25 15:42:48 entropy kernel: esi: c1bb0314   edi: c49b47e4   ebp: c49b4c20   esp: c4843ed4
Aug 25 15:42:48 entropy kernel: ds: 0068   es: 0068   ss: 0068
Aug 25 15:42:48 entropy kernel: Stack: 00000286 00070fd0 00000282 c10cb280 c1bb0370 c1bb0314 c015b43b c49b47e4 
Aug 25 15:42:48 entropy kernel:        c49b47e4 c49b4c8c c49b4bf8 c015bc0f c1b63a44 c49b47e4 c4b824d0 c4b82610 
Aug 25 15:42:48 entropy kernel:        ffffffff c4b82400 c016d920 c4b82568 c4b824d0 c4b824d0 c4b82400 c581616a 
Aug 25 15:42:48 entropy kernel: Call Trace: [<c015b43b>] [<c015bc0f>] [<c016d920>] [<c581616a>] [<c5817edf>] 
Aug 25 15:42:48 entropy kernel:    [<c58181df>] [<c58233ee>] [<c5818360>] [<c581838b>] [<c5818360>] [<c0110820>] 
Aug 25 15:42:48 entropy kernel:    [<c01055a5>] 
Aug 25 15:42:48 entropy kernel: Code: 89 4a 04 89 11 c7 43 10 00 00 00 00 c7 40 04 00 00 00 00 89 

>>EIP; c0146d79 <d_delete+59/80>   <=====
Trace; c015b43b <driverfs_unlink+3b/50>
Trace; c015bc0f <driverfs_remove_dir+4f/a1>
Trace; c016d920 <put_device+80/b0>
Trace; c581616a <[usbcore]usb_disconnect+ea/110>
Trace; c5817edf <[usbcore]usb_hub_port_connect_change+4f/250>
Trace; c58181df <[usbcore]usb_hub_events+ff/280>
Trace; c58233ee <[usbcore].rodata.end+3673/8125>
Trace; c5818360 <[usbcore]usb_hub_thread+0/e0>
Trace; c581838b <[usbcore]usb_hub_thread+2b/e0>
Trace; c5818360 <[usbcore]usb_hub_thread+0/e0>
Trace; c0110820 <default_wake_function+0/40>
Trace; c01055a5 <kernel_thread_helper+5/10>
Code;  c0146d79 <d_delete+59/80>
00000000 <_EIP>:
Code;  c0146d79 <d_delete+59/80>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0146d7c <d_delete+5c/80>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c0146d7e <d_delete+5e/80>
   5:   c7 43 10 00 00 00 00      movl   $0x0,0x10(%ebx)
Code;  c0146d85 <d_delete+65/80>
   c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
Code;  c0146d8c <d_delete+6c/80>
  13:   89 00                     mov    %eax,(%eax)

Aug 25 15:43:08 entropy kernel:  <1>Unable to handle kernel paging request at virtual address 5a5a5aca
Aug 25 15:43:08 entropy kernel: c013e6ef
Aug 25 15:43:08 entropy kernel: *pde = 00000000
Aug 25 15:43:08 entropy kernel: Oops: 0000
Aug 25 15:43:08 entropy kernel: CPU:    0
Aug 25 15:43:08 entropy kernel: EIP:    0060:[<c013e6ef>]    Not tainted
Aug 25 15:43:08 entropy kernel: EFLAGS: 00010246
Aug 25 15:43:08 entropy kernel: eax: c4b40080   ebx: 00000003   ecx: c1bfbf70   edx: c1bfbed4
Aug 25 15:43:08 entropy kernel: esi: 00000003   edi: c1bfbf70   ebp: 5a5a5a5a   esp: c1bfbec0
Aug 25 15:43:08 entropy kernel: ds: 0068   es: 0068   ss: 0068
Aug 25 15:43:08 entropy kernel: Stack: c1bfbed4 00000003 c474c000 c10dd368 c488ef44 00000000 00000000 00000000 
Aug 25 15:43:08 entropy kernel:        0000201b 00000a03 00002503 0000201b 00000003 c1bfbf60 c0122c8d c474c005 
Aug 25 15:43:08 entropy kernel:        00000004 01b42f73 c1d061c8 00000003 00000003 c1bfbf70 00018801 c013f6ec 
Aug 25 15:43:08 entropy kernel: Call Trace: [<c0122c8d>] [<c013f6ec>] [<c010f190>] [<c010757d>] [<c01343d4>] 
Aug 25 15:43:08 entropy kernel:    [<c0134755>] [<c0107347>] 
Aug 25 15:43:08 entropy kernel: Code: 8b 45 70 89 14 24 eb 09 8b 45 70 8d b6 00 00 00 00 66 8b 5d 

>>EIP; c013e6ef <link_path_walk+6f/880>   <=====
Trace; c0122c8d <vm_enough_memory+2d/c0>
Trace; c013f6ec <open_namei+7c/3d0>
Trace; c010f190 <do_page_fault+0/48f>
Trace; c010757d <error_code+2d/40>
Trace; c01343d4 <filp_open+34/60>
Trace; c0134755 <sys_open+35/70>
Trace; c0107347 <syscall_call+7/b>
Code;  c013e6ef <link_path_walk+6f/880>
00000000 <_EIP>:
Code;  c013e6ef <link_path_walk+6f/880>   <=====
   0:   8b 45 70                  mov    0x70(%ebp),%eax   <=====
Code;  c013e6f2 <link_path_walk+72/880>
   3:   89 14 24                  mov    %edx,(%esp,1)
Code;  c013e6f5 <link_path_walk+75/880>
   6:   eb 09                     jmp    11 <_EIP+0x11> c013e700 <link_path_walk+80/880>
Code;  c013e6f7 <link_path_walk+77/880>
   8:   8b 45 70                  mov    0x70(%ebp),%eax
Code;  c013e6fa <link_path_walk+7a/880>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c013e700 <link_path_walk+80/880>
  11:   66 8b 5d 00               mov    0x0(%ebp),%bx



1 warning issued.  Results may not be reliable.

