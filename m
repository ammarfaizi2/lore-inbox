Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUD3Hwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUD3Hwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 03:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUD3Hwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 03:52:32 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:23264 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265098AbUD3HwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 03:52:04 -0400
From: Duncan Sands <baldrick@free.fr>
To: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 3 USB regressions (2.6.6-rc3-bk1) that should be fixed before 2.6.6
Date: Fri, 30 Apr 2004 09:52:00 +0200
User-Agent: KMail/1.5.4
Cc: greg@kroah.com, torvalds@osdl.org, linux-usb-devel@lists.sf.net,
       speedtouch@ml.free.fr, kangur@polcom.net
References: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404300952.00454.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grzegorz,

> 1. modem_run for speedtouch stoped working somewhere between 2.6.6-rc2-bk3
> and 2.6.6-rc3-bk1. Here is the log:
>
> Apr 30 01:05:54 polb01 modem_run[9588]: [monitoring report] ADSL link went
> up
> Apr 30 01:06:11 polb01 modem_run[7828]: ADSL synchronization has been
> obtained
> Apr 30 01:06:11 polb01 modem_run[7828]: ADSL line is up (640 kbit/s down |
> 160 kbit/s up)
> Apr 30 01:06:11 polb01 modem_run[9588]: Error reading interrupts
> Apr 30 01:06:11 polb01 modem_run[9588]: [monitoring report] ADSL link went
> down
> Apr 30 01:06:12 polb01 modem_run[9588]: Device disconnected, shutting down
>
> This does not prevent ppp from connecting.

This one is fixed in Greg's latest USB tree (not pushed to Linus yet).

> 2. When I terminate the ppp connection and remove speedtouch and ppp
> modules and manually disconect speedtouch modem from my system I get:
>
> Apr 30 01:15:32 polb01 usb 1-1: USB disconnect, address 2
> Apr 30 01:15:32 polb01 drivers/usb/core/devio.c:290: spin_is_locked on
> uninitialized spinlock de35199c.

This suggests either memory corruption, or that freed memory is being accessed.
I can't see anything that could cause this at first glance, so could you please do
the following:

(1) get Greg's latest bitkeeper tree (bk://kernel.bkbits.net/gregkh/linux/usb-2.6)
(2) compile it with all the kernel hacking debug options turned on.

> Apr 30 01:15:32 polb01 Unable to handle kernel paging request at virtual
> address 000149ac
> Apr 30 01:15:32 polb01 printing eip:
> Apr 30 01:15:32 polb01 c02ea517
> Apr 30 01:15:32 polb01 *pde = 00000000
> Apr 30 01:15:32 polb01 Oops: 0000 [#1]
> Apr 30 01:15:32 polb01 PREEMPT
> Apr 30 01:15:32 polb01 CPU:    0
> Apr 30 01:15:32 polb01 EIP:    0060:[<c02ea517>]    Not tainted
> Apr 30 01:15:32 polb01 EFLAGS: 00010097   (2.6.6-rc3-bk1)
> Apr 30 01:15:32 polb01 EIP is at vsnprintf+0x317/0x4a0
> Apr 30 01:15:32 polb01 eax: 000149ac   ebx: 0000000a   ecx: 000149ac
> edx: fffffffe
> Apr 30 01:15:32 polb01 esi: c0475beb   edi: 00000000   ebp: c0475f9f
> esp: dfa79dc0
> Apr 30 01:15:32 polb01 ds: 007b   es: 007b   ss: 0068
> Apr 30 01:15:32 polb01 Process khubd (pid: 5455, threadinfo=dfa78000
> task=dfa181f0)
> Apr 30 01:15:32 polb01 Stack: c0475bcf c0475f9f de35199c 00000000 00000010
> 00000008 00000007 00000001
> Apr 30 01:15:32 polb01 ffffffff ffffffff 00000400 00000046 def8c864
> 00000286 c02ea6cb c0475ba0
> Apr 30 01:15:32 polb01 00000400 e09a7b1f dfa79e78 c0475ba0 c01200fe
> c0475ba0 00000400 e09a7af4
> Apr 30 01:15:32 polb01 Call Trace:
> Apr 30 01:15:32 polb01 [<c02ea6cb>] vscnprintf+0x2b/0x40
> Apr 30 01:15:32 polb01 [<c01200fe>] printk+0x17e/0x400
> Apr 30 01:15:32 polb01 [<e099a6ac>] hcd_endpoint_disable+0x18c/0x4d0
> [usbcore]
> Apr 30 01:15:32 polb01 [<e09a0522>] destroy_async+0x432/0x440 [usbcore]
> Apr 30 01:15:32 polb01 [<e09a071c>] driver_disconnect+0x3c/0x40 [usbcore]
> Apr 30 01:15:32 polb01 [<e09940fa>] usb_unbind_interface+0x7a/0x80
> [usbcore]
> Apr 30 01:15:32 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:15:32 polb01 [<c032bc23>] bus_remove_device+0x73/0xc0
> Apr 30 01:15:32 polb01 [<c032aa8c>] device_del+0x6c/0xb0
> Apr 30 01:15:32 polb01 [<c032aae3>] device_unregister+0x13/0x30
> Apr 30 01:15:32 polb01 [<e099c6d0>] usb_disable_device+0x70/0xb0 [usbcore]
> Apr 30 01:15:32 polb01 [<e0994d3b>] usb_disconnect+0xbb/0x110 [usbcore]
> Apr 30 01:15:32 polb01 [<e099788f>] hub_port_connect_change+0x28f/0x2a0
> [usbcore]
> Apr 30 01:15:32 polb01 [<e0997243>] hub_port_status+0x43/0xb0 [usbcore]
> Apr 30 01:15:32 polb01 [<e0997c1b>] hub_events+0x37b/0x500 [usbcore]
> Apr 30 01:15:32 polb01 [<e0997dcd>] hub_thread+0x2d/0xf0 [usbcore]
> Apr 30 01:15:32 polb01 [<c010490e>] ret_from_fork+0x6/0x14
> Apr 30 01:15:32 polb01 [<c0119e80>] default_wake_function+0x0/0x20
> Apr 30 01:15:32 polb01 [<e0997da0>] hub_thread+0x0/0xf0 [usbcore]
> Apr 30 01:15:32 polb01 [<c0102291>] kernel_thread_helper+0x5/0x14
> Apr 30 01:15:32 polb01
> Apr 30 01:15:32 polb01 Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83
> e7 10 89 c3 75
> Apr 30 01:15:32 polb01 <6>note: khubd[5455] exited with preempt_count 2

Looks like this is coming from here:

                        dev_dbg (hcd->self.controller,
                                "shutdown urb %p pipe %08x ep%d%s%s\n",
                                urb, tmp, usb_pipeendpoint (tmp),
                                (tmp & USB_DIR_IN) ? "in" : "out",
                                ({ char *s; \
                                 switch (usb_pipetype (tmp)) { \
                                 case PIPE_CONTROL:     s = ""; break; \
                                 case PIPE_BULK:        s = "-bulk"; break; \
                                 case PIPE_INTERRUPT:   s = "-intr"; break; \
                                 default:               s = "-iso"; break; \
                                }; s;}));

> This problem happens with and without preemption. Same problem I reported
> with 2.6.6-rc2-bk3 kernel. But for example with 2.6.2 it works fine.
>
>
> 3. When I shutdown my system I get:
>
> Apr 30 01:12:44 polb01 drivers/usb/core/devio.c:290: spin_is_locked on
> uninitialized spinlock de4ad99c.
> Apr 30 01:12:44 polb01 Unable to handle kernel NULL pointer dereference at
> virtual address 0000009a
> Apr 30 01:12:44 polb01 printing eip:
> Apr 30 01:12:44 polb01 e09a0177
> Apr 30 01:12:44 polb01 *pde = 00000000
> Apr 30 01:12:44 polb01 Oops: 0000 [#1]
> Apr 30 01:12:44 polb01 PREEMPT
> Apr 30 01:12:44 polb01 CPU:    0
> Apr 30 01:12:44 polb01 EIP:    0060:[<e09a0177>]    Not tainted
> Apr 30 01:12:44 polb01 EFLAGS: 00010086   (2.6.6-rc3-bk1)
> Apr 30 01:12:44 polb01 EIP is at destroy_async+0x87/0x440 [usbcore]
> Apr 30 01:12:44 polb01 eax: de4ad99c   ebx: 00000096   ecx: c0474de4
> edx: c0406e98
> Apr 30 01:12:44 polb01 esi: de4ad968   edi: dfbec000   ebp: 00000292
> esp: dfbeddbc
> Apr 30 01:12:44 polb01 ds: 007b   es: 007b   ss: 0068
> Apr 30 01:12:44 polb01 Process rmmod (pid: 13440, threadinfo=dfbec000
> task=dfa4c720)
> Apr 30 01:12:44 polb01 Stack: e09a7a94 e09a6694 00000122 de4ad99c 00000001
> dfa4e000 e099c5f4 dfa4e000
> Apr 30 01:12:44 polb01 00000081 de4ad99c de307854 e09b2080 de307864
> dfa4e024 e09a071c de4ad968
> Apr 30 01:12:44 polb01 de4ad9b4 e09940fa de307854 de307854 de307864
> de307864 e09b20a0 c032bab4
> Apr 30 01:12:44 polb01 Call Trace:
> Apr 30 01:12:44 polb01 [<e099c5f4>] usb_disable_endpoint+0x74/0x80
> [usbcore]
> Apr 30 01:12:44 polb01 [<e09a071c>] driver_disconnect+0x3c/0x40 [usbcore]
> Apr 30 01:12:44 polb01 [<e09940fa>] usb_unbind_interface+0x7a/0x80
> [usbcore]
> Apr 30 01:12:44 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:12:44 polb01 [<c032bc23>] bus_remove_device+0x73/0xc0
> Apr 30 01:12:44 polb01 [<c032aa8c>] device_del+0x6c/0xb0
> Apr 30 01:12:44 polb01 [<c032aae3>] device_unregister+0x13/0x30
> Apr 30 01:12:44 polb01 [<e099c6d0>] usb_disable_device+0x70/0xb0 [usbcore]
> Apr 30 01:12:44 polb01 [<e0994d3b>] usb_disconnect+0xbb/0x110 [usbcore]
> Apr 30 01:12:44 polb01 [<e0994d7e>] usb_disconnect+0xfe/0x110 [usbcore]
> Apr 30 01:12:44 polb01 [<e099f730>] usb_hcd_pci_remove+0x80/0x180
> [usbcore]
> Apr 30 01:12:44 polb01 [<c02f080b>] pci_device_remove+0x3b/0x40
> Apr 30 01:12:44 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:12:44 polb01 [<c032bae0>] driver_detach+0x20/0x30
> Apr 30 01:12:44 polb01 [<c032bd8b>] bus_remove_driver+0x5b/0xa0
> Apr 30 01:12:44 polb01 [<c032c21a>] driver_unregister+0x1a/0x46
> Apr 30 01:12:44 polb01 [<c014084d>] __try_stop_module+0x2d/0x53
> Apr 30 01:12:44 polb01 [<c02f0a06>] pci_unregister_driver+0x16/0x30
> Apr 30 01:12:44 polb01 [<e0ae488f>] uhci_hcd_cleanup+0xf/0x61 [uhci_hcd]
> Apr 30 01:12:44 polb01 [<c013dab0>] sys_delete_module+0x140/0x1b0
> Apr 30 01:12:44 polb01 [<c01049e5>] sysenter_past_esp+0x52/0x71
> Apr 30 01:12:44 polb01
> Apr 30 01:12:44 polb01 Code: 8b 53 04 8b 03 89 50 04 89 02 89 5b 04 89 1b
> 81 7e 34 3c 4b
> Apr 30 01:12:44 polb01 <6>note: rmmod[13440] exited with preempt_count 1
> Apr 30 01:12:44 polb01 Debug: sleeping function called from invalid
> context at include/linux/rwsem.h:43
> Apr 30 01:12:44 polb01 in_atomic():1, irqs_disabled():0
> Apr 30 01:12:44 polb01 Call Trace:
> Apr 30 01:12:44 polb01 [<c011b637>] __might_sleep+0xb7/0xe0
> Apr 30 01:12:44 polb01 [<c0122ff9>] do_exit+0xb9/0x980
> Apr 30 01:12:44 polb01 [<c0117080>] do_page_fault+0x0/0x52f
> Apr 30 01:12:44 polb01 [<c010543f>] die+0x23f/0x240
> Apr 30 01:12:44 polb01 [<c011725e>] do_page_fault+0x1de/0x52f
> Apr 30 01:12:44 polb01 [<c0119eda>] __wake_up_common+0x3a/0x60
> Apr 30 01:12:44 polb01 [<c02ea6cb>] vscnprintf+0x2b/0x40
> Apr 30 01:12:44 polb01 [<c0117080>] do_page_fault+0x0/0x52f
> Apr 30 01:12:44 polb01 [<c0104c41>] error_code+0x2d/0x38
> Apr 30 01:12:44 polb01 [<e09a0177>] destroy_async+0x87/0x440 [usbcore]
> Apr 30 01:12:44 polb01 [<e099c5f4>] usb_disable_endpoint+0x74/0x80
> [usbcore]
> Apr 30 01:12:44 polb01 [<e09a071c>] driver_disconnect+0x3c/0x40 [usbcore]
> Apr 30 01:12:44 polb01 [<e09940fa>] usb_unbind_interface+0x7a/0x80
> [usbcore]
> Apr 30 01:12:44 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:12:44 polb01 [<c032bc23>] bus_remove_device+0x73/0xc0
> Apr 30 01:12:44 polb01 [<c032aa8c>] device_del+0x6c/0xb0
> Apr 30 01:12:44 polb01 [<c032aae3>] device_unregister+0x13/0x30
> Apr 30 01:12:44 polb01 [<e099c6d0>] usb_disable_device+0x70/0xb0 [usbcore]
> Apr 30 01:12:44 polb01 [<e0994d3b>] usb_disconnect+0xbb/0x110 [usbcore]
> Apr 30 01:12:44 polb01 [<e0994d7e>] usb_disconnect+0xfe/0x110 [usbcore]
> Apr 30 01:12:44 polb01 [<e099f730>] usb_hcd_pci_remove+0x80/0x180
> [usbcore]
> Apr 30 01:12:44 polb01 [<c02f080b>] pci_device_remove+0x3b/0x40
> Apr 30 01:12:44 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:12:44 polb01 [<c032bae0>] driver_detach+0x20/0x30
> Apr 30 01:12:44 polb01 [<c032bd8b>] bus_remove_driver+0x5b/0xa0
> Apr 30 01:12:44 polb01 [<c032c21a>] driver_unregister+0x1a/0x46
> Apr 30 01:12:44 polb01 [<c014084d>] __try_stop_module+0x2d/0x53
> Apr 30 01:12:44 polb01 [<c02f0a06>] pci_unregister_driver+0x16/0x30
> Apr 30 01:12:44 polb01 [<e0ae488f>] uhci_hcd_cleanup+0xf/0x61 [uhci_hcd]
> Apr 30 01:12:44 polb01 [<c013dab0>] sys_delete_module+0x140/0x1b0
> Apr 30 01:12:44 polb01 [<c01049e5>] sysenter_past_esp+0x52/0x71
> Apr 30 01:12:44 polb01
> Apr 30 01:12:44 polb01 bad: scheduling while atomic!
> Apr 30 01:12:44 polb01 Call Trace:
> Apr 30 01:12:44 polb01 [<c03bc508>] schedule+0x8c8/0x8d0
> Apr 30 01:12:44 polb01 [<c015634b>] unmap_page_range+0x4b/0x80
> Apr 30 01:12:44 polb01 [<c0156548>] unmap_vmas+0x1c8/0x2c0
> Apr 30 01:12:44 polb01 [<c015c455>] exit_mmap+0xd5/0x2c0
> Apr 30 01:12:44 polb01 [<c011c4a4>] mmput+0xb4/0x120
> Apr 30 01:12:44 polb01 [<c0123119>] do_exit+0x1d9/0x980
> Apr 30 01:12:44 polb01 [<c0117080>] do_page_fault+0x0/0x52f
> Apr 30 01:12:44 polb01 [<c010543f>] die+0x23f/0x240
> Apr 30 01:12:44 polb01 [<c011725e>] do_page_fault+0x1de/0x52f
> Apr 30 01:12:44 polb01 [<c0119eda>] __wake_up_common+0x3a/0x60
> Apr 30 01:12:44 polb01 [<c02ea6cb>] vscnprintf+0x2b/0x40
> Apr 30 01:12:44 polb01 [<c0117080>] do_page_fault+0x0/0x52f
> Apr 30 01:12:44 polb01 [<c0104c41>] error_code+0x2d/0x38
> Apr 30 01:12:44 polb01 [<e09a0177>] destroy_async+0x87/0x440 [usbcore]
> Apr 30 01:12:44 polb01 [<e099c5f4>] usb_disable_endpoint+0x74/0x80
> [usbcore]
> Apr 30 01:12:44 polb01 [<e09a071c>] driver_disconnect+0x3c/0x40 [usbcore]
> Apr 30 01:12:44 polb01 [<e09940fa>] usb_unbind_interface+0x7a/0x80
> [usbcore]
> Apr 30 01:12:44 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:12:44 polb01 [<c032bc23>] bus_remove_device+0x73/0xc0
> Apr 30 01:12:44 polb01 [<c032aa8c>] device_del+0x6c/0xb0
> Apr 30 01:12:44 polb01 [<c032aae3>] device_unregister+0x13/0x30
> Apr 30 01:12:44 polb01 [<e099c6d0>] usb_disable_device+0x70/0xb0 [usbcore]
> Apr 30 01:12:44 polb01 [<e0994d3b>] usb_disconnect+0xbb/0x110 [usbcore]
> Apr 30 01:12:44 polb01 [<e0994d7e>] usb_disconnect+0xfe/0x110 [usbcore]
> Apr 30 01:12:44 polb01 [<e099f730>] usb_hcd_pci_remove+0x80/0x180
> [usbcore]
> Apr 30 01:12:44 polb01 [<c02f080b>] pci_device_remove+0x3b/0x40
> Apr 30 01:12:44 polb01 [<c032bab4>] device_release_driver+0x64/0x70
> Apr 30 01:12:44 polb01 [<c032bae0>] driver_detach+0x20/0x30
> Apr 30 01:12:44 polb01 [<c032bd8b>] bus_remove_driver+0x5b/0xa0
> Apr 30 01:12:44 polb01 [<c032c21a>] driver_unregister+0x1a/0x46
> Apr 30 01:12:44 polb01 [<c014084d>] __try_stop_module+0x2d/0x53
> Apr 30 01:12:44 polb01 [<c02f0a06>] pci_unregister_driver+0x16/0x30
> Apr 30 01:12:44 polb01 [<e0ae488f>] uhci_hcd_cleanup+0xf/0x61 [uhci_hcd]
> Apr 30 01:12:44 polb01 [<c013dab0>] sys_delete_module+0x140/0x1b0
> Apr 30 01:12:44 polb01 [<c01049e5>] sysenter_past_esp+0x52/0x71
>
> This does not work with 2.6.6-rc2-bk3 too.

This looks like number 2, only more mighty because your system is borked.

> Some details about my system:
>
> Linux version 2.6.6-rc3-bk1 (root@polb01) (gcc version 3.3.3 20040412
> (Gentoo Linux 3.3.3-r3, ssp-3.3-7, pie-8.5.3)) #2 Thu Apr 29 17:55:16 CEST
> 2004
>
>
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 4
> model name      : AMD Athlon(tm) processor
> stepping        : 2
> cpu MHz         : 1001.690
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 1982.46
>
>
> MemTotal:       515972 kB
> MemFree:        456432 kB
> Buffers:          5608 kB
> Cached:          37428 kB
> SwapCached:          0 kB
> Active:          25688 kB
> Inactive:        20152 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       515972 kB
> LowFree:        456432 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:              20 kB
> Writeback:           0 kB
> Mapped:           8280 kB
> Slab:             7892 kB
> Committed_AS:    29964 kB
> PageTables:        272 kB
> VmallocTotal:   516052 kB
> VmallocUsed:      3748 kB
> VmallocChunk:   512144 kB
> HugePages_Total:     0
> HugePages_Free:      0
> Hugepagesize:     4096 kB
>
>
> Module                  Size  Used by
> bsd_comp                6016  0
> snd_bt87x              15556  0
> tuner                  18252  0
> tvaudio                22412  0
> bttv                  162380  0
> video_buf              24132  1 bttv
> i2c_algo_bit            9288  1 bttv
> v4l2_common             6208  1 bttv
> btcx_risc               4744  1 bttv
> i2c_core               24324  4 tuner,tvaudio,bttv,i2c_algo_bit
> videodev               10112  1 bttv
> emu10k1_gp              3648  0
> 8139too                29504  0
> mii                     5120  1 8139too
> speedtch               20336  1
> uhci_hcd               34832  0
> parport_pc             23872  0
> parport                31296  1 parport_pc
> snd_seq_midi            8672  0
> snd_emu10k1_synth       9664  0
> snd_emux_synth         46464  1 snd_emu10k1_synth
> snd_seq_virmidi         7680  1 snd_emux_synth
> snd_seq_midi_emul       8064  1 snd_emux_synth
> snd_emu10k1           117764  1 snd_emu10k1_synth
> snd_rawmidi            30880  3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1
> snd_ac97_codec         68612  1 snd_emu10k1
> snd_util_mem            4928  2 snd_emux_synth,snd_emu10k1
> snd_hwdep              10052  2 snd_emux_synth,snd_emu10k1
> snd_seq_oss            41664  0
> snd_seq_midi_event      9728  3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss
> snd_seq                70288  8
> snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,s
>nd_seq_midi_event snd_seq_device          8776  7
> snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_emu10k1,snd_rawmidi,snd_s
>eq_oss,snd_seq snd_pcm_oss            55844  0
> snd_pcm               113928  3 snd_bt87x,snd_emu10k1,snd_pcm_oss
> snd_page_alloc         11588  3 snd_bt87x,snd_emu10k1,snd_pcm
> snd_timer              35460  2 snd_seq,snd_pcm
> snd_mixer_oss          20480  1 snd_pcm_oss
> snd                    58852  17
> snd_bt87x,snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_rawmi
>di,snd_ac97_codec,snd_util_mem,snd_hwdep,snd_seq_oss,snd_seq_midi_event,snd_
>seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss soundcore    
>          11552  2 bttv,snd
> rtc                    22108  0
> usbcore               125404  4 speedtch,uhci_hcd
> ntfs                   94348  1
> vfat                   19008  1
> fat                    52192  1 vfat
> dm_mod                 45920  0
> msr                     3456  0
> edd                    10456  0
> cpuid                   3136  0
> nvram                  14024  0
> cryptoloop              3648  0
> loop                   18056  1 cryptoloop
> floppy                 65264  0
> pcspkr                  4256  0
> analog                 12448  0
> gameport                5440  2 emu10k1_gp,analog
> thermal                12624  0
> processor              12516  1 thermal
> evdev                   9600  0
> fan                     4108  0
> button                  6232  0
> ac                      4876  0
> psmouse                20104  0
> pppoatm                 6656  1
> atm                    48468  4 speedtch,pppoatm
> ppp_deflate             6144  0
> zlib_deflate           22232  1 ppp_deflate
> zlib_inflate           22272  1 ppp_deflate
> ppp_generic            41684  7 bsd_comp,pppoatm,ppp_deflate
> slhc                    7872  1 ppp_generic
> capability              4228  0
> commoncap               7360  1 capability
> unix                   31028  20
>
>
> 0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P]
> System Controller (rev 13)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 176
>         Region 0: Memory at d8000000 (32-bit, prefetchable)
>         Region 1: Memory at de019000 (32-bit, prefetchable) [size=4K]
>         Region 2: I/O ports at d000 [disabled] [size=4]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
> Rate=<none>
>
> 0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P]
> AGP Bridge (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 176
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: dc000000-ddffffff
>         Prefetchable memory behind bridge: d0000000-d7ffffff
>         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
>
> 0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
> South] (rev 40)
>         Subsystem: ABIT Computer Corp. KG7-Lite Mainboard
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc.
> VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 176
>         Region 4: I/O ports at d400 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if
> 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 176, cache line size 08
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at d800 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if
> 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 176, cache line size 08
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at dc00 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> (rev 40)
>         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin ? routed to IRQ 11
>         Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 240 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at e000
>         Region 1: Memory at de01a000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
> (rev 08)
>         Subsystem: Creative Labs SB Live! 5.1 Model SB0100
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 240 (500ns min, 5000ns max)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at e400
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game
> Port (rev 08)
>         Subsystem: Creative Labs Gameport Joystick
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 240
>         Region 0: I/O ports at e800
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:0b.0 Communication controller: 5610 56K FaxModem USR 56k Internal
> WinModem
>         Subsystem: 5610 56K FaxModem: Unknown device 00b2
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at de018000 (32-bit, prefetchable)
>         Region 1: Memory at de000000 (32-bit, prefetchable) [size=64K]
>         Region 2: Memory at de010000 (32-bit, prefetchable) [size=32K]
>         Region 3: I/O ports at ec00 [size=64]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
> PME(D0+,D1-,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>
> 0000:00:0d.0 Multimedia video controller: Brooktree Corporation Bt878
> Video Capture (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 240 (4000ns min, 10000ns max)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at de01b000 (32-bit, prefetchable)
>         Capabilities: [44] Vital Product Data
>         Capabilities: [4c] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio
> Capture (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 240 (1000ns min, 63750ns max)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at de01c000 (32-bit, prefetchable)
>         Capabilities: [44] Vital Product Data
>         Capabilities: [4c] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:01:05.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2
> GTS/Pro] (rev a4) (prog-if 00 [VGA])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 192 (1250ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at dc000000 (32-bit, non-prefetchable)
>         Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [44] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
> Rate=<none>
>
>
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 003: ID 0130:0130
> Bus 001 Device 002: ID 06b9:4061 Alcatel Telecom Speed Touch ISDN
> Bus 001 Device 001: ID 0000:0000
>
>
> Please fix these bugs because they prevent me from running 2.6.6
> normally... If I can help further mail me.

You can always use another kernel while you are waiting...

> Thanks in advance for your help,

No problem.

> Grzegorz Kulewski

Duncan.
