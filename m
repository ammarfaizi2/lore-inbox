Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUATFZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUATFZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:25:46 -0500
Received: from 82-68-130-110.dsl.in-addr.zen.co.uk ([82.68.130.110]:28032 "EHLO
	homer") by vger.kernel.org with ESMTP id S264540AbUATFZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:25:24 -0500
From: John <cirrus@the-penguin.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [2.6.1] ppp Badness in local_bh_enable at kernel/softirq.c
Date: Tue, 20 Jan 2004 05:25:15 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401200525.15379.cirrus@the-penguin.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been mentioned before for the 2.6.0, and I did have the same problem in 2.6.0 myself.

Kernel: 2.6.1
pppd version 2.4.1

I have got similar errors in the logs in two cases. The first one is when connecting my Speedtouch ADSL modem using the user-mode drivers (modem_run and pppoa3), where as the second one occurred when trying to initiate a ppp connection with my Sony Clie PDA. Both of these are using a USB interface.

Speedtouch:

# /usr/sbin/modem_run -m -f /lib/mgmt.o

Jan 20 04:12:29 homer modem_run[1982]: modem_run version 1.2-beta2 started by root uid 0
Jan 20 04:12:29 homer usb.agent[2020]: ... no modules for USB product 6b9/4061/0Jan 20 04:12:30 homer usb.ag
ent[2038]: ... no modules for USB product 6b9/4061/0Jan 20 04:12:30 homer usb.agent[2054]: ... no modules fo
r USB product 6b9/4061/0Jan 20 04:12:32 homer kernel: usb 4-2.2: bulk timeout on ep5in
Jan 20 04:12:32 homer kernel: usbfs: USBDEVFS_BULK failed dev 3 ep 0x85 len 512
ret -110
Jan 20 04:12:35 homer usb.agent[2110]: ... no modules for USB product 6b9/4061/0Jan 20 04:12:35 homer usb.ag
ent[2128]: ... no modules for USB product 6b9/4061/0Jan 20 04:12:35 homer usb.agent[2144]: ... no modules fo
r USB product 6b9/4061/0Jan 20 04:12:57 homer modem_run[1982]: ADSL synchronization has been obtained
Jan 20 04:12:57 homer modem_run[1982]: ADSL line is up (1152 kbit/s down | 288 kbit/s up)
Jan 20 04:12:57 homer modem_run[2163]: Error reading interrupts
Jan 20 04:12:57 homer kernel: usbfs: process 2163 (modem_run) did not claim interface 0 before use

All seems allmost ok so far. I've had similar messages with a 2.4.24 kernel which was just fine.

# /usr/sbin/pppd call adsl

Jan 20 04:13:15 homer pppd[2176]: pppd 2.4.1 started by root, uid 0
Jan 20 04:13:15 homer pppd[2176]: Using interface ppp0
Jan 20 04:13:15 homer pppd[2176]: Connect: ppp0 <--> /dev/pts/0
Jan 20 04:13:15 homer pppoa3[2177]: pppoa3 version 1.2-beta2 started by root (uid 0)
Jan 20 04:13:15 homer pppoa3[2177]: Control thread ready
Jan 20 04:13:15 homer pppoa3[2177]: Modem found!
Jan 20 04:13:15 homer modem_run[2163]: Error reading interrupts
Jan 20 04:13:15 homer usb.agent[2226]: ... no modules for USB product 6b9/4061/0Jan 20 04:13:15 homer usb.ag
ent[2217]: ... no modules for USB product 6b9/4061/0Jan 20 04:13:15 homer usb.agent[2222]: ... no modules fo
r USB product 6b9/4061/0Jan 20 04:13:15 homer pppoa3[2271]: host  --> pppoa3 --> modem stream ready
Jan 20 04:13:15 homer pppoa3[2272]: modem --> pppoa3 --> host  stream ready
Jan 20 04:13:17 homer pppd[2176]: Remote message: CHAP authentication success, unit 6702
Jan 20 04:13:17 homer pppd[2176]: local  IP address xxx.xxx.xxx.xxx
Jan 20 04:13:17 homer pppd[2176]: remote IP address yyy.yyy.yyy.yyy

Connection was initiated and everything seems fine.
As soon as I try to disconnect I get the following in my logs.

Jan 20 04:13:27 homer pppd[2176]: Terminating on signal 15.
Jan 20 04:13:27 homer pppoa3[2177]: Received signal 15 (thread 1024)
Jan 20 04:13:27 homer pppoa3[2177]: Woken by a sem_post event -> Exiting
Jan 20 04:13:27 homer pppoa3[2177]: Read from usb Canceled
Jan 20 04:13:27 homer pppoa3[2271]: Cleaning Read from usb data
Jan 20 04:13:27 homer pppoa3[2177]: Write to usb Canceled
Jan 20 04:13:27 homer pppoa3[2272]: Cleaning Write to usb data
Jan 20 04:13:27 homer pppoa3[2177]: Exiting
Jan 20 04:13:27 homer kernel: Badness in local_bh_enable at kernel/softirq.c:121
Jan 20 04:13:27 homer kernel: Call Trace:
Jan 20 04:13:27 homer kernel:  [local_bh_enable+53/104] local_bh_enable+0x35/0x68
Jan 20 04:13:27 homer kernel:  [ppp_sync_push+233/372] ppp_sync_push+0xe9/0x174
Jan 20 04:13:27 homer kernel:  [ppp_sync_wakeup+39/72] ppp_sync_wakeup+0x27/0x48
Jan 20 04:13:27 homer kernel:  [do_tty_hangup+336/908] do_tty_hangup+0x150/0x38cJan 20 04:13:27 homer kernel:  [tty_vhangup+10/16] tty_v hangup+0xa/0x10
Jan 20 04:13:27 homer kernel:  [pty_close+253/260] pty_close+0xfd/0x104
Jan 20 04:13:27 homer kernel:  [release_dev+506/1464] release_dev+0x1fa/0x5b8
Jan 20 04:13:27 homer kernel:  [zap_pmd_range+53/80] zap_pmd_range+0x35/0x50
Jan 20 04:13:27 homer kernel:  [unmap_page_range+58/92] unmap_page_range+0x3a/0x5c
Jan 20 04:13:27 homer kernel:  [tty_release+34/88] tty_release+0x22/0x58
Jan 20 04:13:27 homer kernel:  [__fput+66/240] __fput+0x42/0xf0
Jan 20 04:13:27 homer kernel:  [fput+19/20] fput+0x13/0x14
Jan 20 04:13:27 homer kernel:  [filp_close+98/108] filp_close+0x62/0x6c
Jan 20 04:13:27 homer kernel:  [put_files_struct+76/180] put_files_struct+0x4c/0xb4
Jan 20 04:13:27 homer kernel:  [do_exit+475/920] do_exit+0x1db/0x398
Jan 20 04:13:27 homer kernel:  [sys_exit+14/16] sys_exit+0xe/0x10
Jan 20 04:13:27 homer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 20 04:13:27 homer kernel:
Jan 20 04:13:27 homer pppd[2176]: ioctl(PPPIOCSASYNCMAP): Inappropriate ioctl for device(25)
Jan 20 04:13:27 homer pppd[2176]: tcflush failed: Input/output error
Jan 20 04:13:27 homer pppd[2176]: Exit.

Sony Clie:

# /usr/sbin/pppd call clie

Jan 20 04:17:09 homer kernel: hub 4-2:1.0: new USB device on port 4, assigned address 5
Jan 20 04:17:10 homer kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
Jan 20 04:17:10 homer kernel: drivers/usb/core/usb.c: registered new driver usbserial
Jan 20 04:17:10 homer kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Jan 20 04:17:10 homer kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
Jan 20 04:17:10 homer kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
Jan 20 04:17:10 homer kernel: drivers/usb/core/usb.c: registered new driver visor
Jan 20 04:17:10 homer kernel: drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
Jan 20 04:17:10 homer kernel: usbserial 4-2.4:1.0: Handspring Visor / Palm OS converter detected
Jan 20 04:17:10 homer kernel: usb 4-2.4: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Jan 20 04:17:10 homer kernel: usb 4-2.4: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Jan 20 04:17:14 homer pppd[3511]: pppd 2.4.1 started by root, uid 0
Jan 20 04:17:14 homer pppd[3511]: using channel 2
Jan 20 04:17:14 homer pppd[3511]: Using interface ppp0
Jan 20 04:17:14 homer pppd[3511]: Connect: ppp0 <--> /dev/pilot
Jan 20 04:17:14 homer pppd[3511]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x6ab36e27> <accomp>]
Jan 20 04:17:14 homer kernel: Badness in local_bh_enable at kernel/softirq.c:121
Jan 20 04:17:14 homer kernel: Call Trace:
Jan 20 04:17:14 homer kernel:  [local_bh_enable+53/104] local_bh_enable+0x35/0x68
Jan 20 04:17:14 homer kernel:  [ppp_input+460/468] ppp_input+0x1cc/0x1d4
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+25601/2432522] ppp_async_input+0x41a/0x504 [ppp_async]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+22251/2432522] ppp_asynctty_receive+0x3c/0x88 [ppp_async]
Jan 20 04:17:14 homer kernel:  [flush_to_ldisc+203/212] flush_to_ldisc+0xcb/0xd4
Jan 20 04:17:14 homer kernel :  [tty_flip_buffer_push+19/40] tty_flip_buffer_push+0x13/0x28
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+563956/2432522] visor_read_bulk_callback+0x1e5/0x264 [visor]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416890/2432522] usb_hcd_giveback_urb+0x57/0x64 [usbcore]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+170611/2432522] finish_urb+0xa8/0xb0 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+174636/2432522] dl_done_list+0x79/0x114 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+177039/2432522] ohci_irq+0xb4/0x144 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416947/2432522] usb_hcd_irq+0x2c/0x50 [usbcore]
Jan 20 04:17:14 homer kernel:  [handle_IRQ_event+43/80] handle_IRQ_event+0x2b/0x50
Jan 20 04:17:14 homer kernel:  [do_IRQ+150/308] do_IRQ+0x96/0x134
Jan 20 04:17:14 homer kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 20 04:17:14 homer kernel:
Jan 20 04:17:14 homer kernel: Badness in local_bh_enable at kernel/softirq.c:121
Jan 20 04:17:14 homer kernel: Call Trace:
Jan 20 04:17:14 homer kernel:  [local_bh_enable+53/104] local_bh_enable+0x35/0x68
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+22274/2432522] ppp_asynctty_receive+0x53/0x88 [ppp_async]
Jan 20 04:17:14 homer kernel:  [flush_to_ldisc+203/212] flush_to_ldisc+0xcb/0xd4
Jan 20 04:17:14 homer kernel:  [tty_flip_buffer_push+19/40] tty_flip_buffer_push+0x13/0x28
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+563956/2432522] visor_read_bulk_callback+0x1e5/0x264 [visor]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416890/2432522] usb_hcd_giveback_urb+0x57/0x64 [usbcore]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+170611/2432522] finish_urb+0xa8/0xb0 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+174636/2432522] dl_done_list+0x79/0x114 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+177039/2432522] ohci_irq+0xb4/0x144 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416947/2432522] usb_hcd_irq+0x2c/0x50 [usbcore]
Jan 20 04:17:14 homer kernel:  [handle_IRQ_event+43/80] handle_IRQ_event+0x2b/0x50
Jan 20 04:17:14 homer kernel:  [do_IRQ+150/308] do_IRQ+0x96/0x134
Jan 20 04:17:14 homer kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 20 04:17:14 homer kernel:
Jan 20 04:17:14 homer pppd[3511]: rcvd [LCP ConfRej id=0x1 <magic 0x6ab36e27>]
Jan 20 04:17:14 homer pppd[3511]: sent [LCP ConfReq id=0x2 <asyncmap 0x0> <accomp>]
Jan 20 04:17:14 homer kernel: Call Trace:
Jan 20 04:17:14 homer kernel:  [local_bh_enable+53/104] local_bh_enable+0x35/0x68
Jan 20 04:17:14 homer kernel:  [ppp_input+460/468] ppp_input+0x1cc/0x1d4
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+25601/2432522] ppp_async_input+0x41a/0x504 [ppp_async]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+22251/2432522] ppp_asynctty_receive+0x3c/0x88 [ppp_async]
Jan 20 04:17:14 homer kernel:  [flush_to_ldisc+203/212] flush_to_ldisc+0xcb/0xd4
Jan 20 04:17:14 homer kernel:  [tty_flip_buffer_push+19/40] tty_flip_buffer_push+0x13/0x28
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+563956/2432522] visor_read_bulk_callback+0x1e5/0x264 [visor]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416890/2432522] usb_hcd_giveback_urb+0x57/0x64 [usbcore]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+170611/2432522] finish_urb+0xa8/0xb0 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+174636/2432522] dl_done_list+0x79/0x114 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+177039/2432522] ohci_irq+0xb4/0x144 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416947/2432522] usb_hcd_irq+0x2c/0x50 [usbcore]
Jan 20 04:17:14 homer kernel:  [handle_IRQ_event+43/80] handle_IRQ_event+0x2b/0x50
Jan 20 04:17:14 homer kernel:  [do_IRQ+150/308] do_IRQ+0x96/0x134
Jan 20 04:17:14 homer kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 20 04:17:14 homer kernel:  [rest_init+0/80] _stext+0x0/0x50
Jan 20 04:17:14 homer kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 20 04:17:14 homer kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 20 04:17:14 homer kernel:  [rest_init+0/80] _stext+0x0/0x50
Jan 20 04:17:14 homer kernel:  [default_idle+35/40] default_idle+0x23/0x28
Jan 20 04:17:14 homer kernel:  [cpu_idle+50/64] cpu_idle+0x32/0x40
Jan 20 04:17:14 homer kernel:  [rest_init+77/80] _stext+0x4d/0x50
Jan 20 04:17:14 homer kernel:  [start_kernel+363/368] start_kernel+0x16b/0x170
Jan 20 04:17:14 homer kernel:
Jan 20 04:17:14 homer kernel: Badness in local_bh_enable at kernel/softirq.c:121
Jan 20 04:17:14 homer kernel: Call Trace:
Jan 20 04:17:14 homer kernel:  [local_bh_enable+53/104] local_bh_enable+0x35/0x68
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+22274/2432522] ppp_asynctty_receive+0x53/0x88 [ppp_async]
Jan 20 04:17:14 homer kernel:  [flush_to_ldisc+203/212] flush_to_ldisc+0xcb/0xd4
Jan 20 04:17:14 homer kernel:  [tty_flip_buffer_push+19/40] tty_flip_buffer_push+0x13/0x28
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+563956/2432522] visor_read_bulk_callback+0x1e5/0x264 [visor]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416890/2432522] usb_hcd_giveback_urb+0x57/0x64 [usbcore]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+170611/2432522] finish_urb+0xa8/0xb0 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+174636/2432522] dl_done_list+0x79/0x114 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+177039/2432522] ohci_irq+0xb4/0x144 [ohci_hcd]
Jan 20 04:17:14 homer kernel:  [__crc_tty_hung_up_p+416947/2432522] usb_hcd_irq+0x2c/0x50 [usbcore]
Jan 20 04:17:14 homer kernel:  [handle_IRQ_event+43/80] handle_IRQ_event+0x2b/0x50
Jan 20 04:17:14 homer kernel:  [do_IRQ+150/308] do_IRQ+0x96/0x134
Jan 20 04:17:14 homer kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 20 04:17:14 homer kernel:  [rest_init+0/80] _stext+0x0/0x50
Jan 20 04:17:14 homer kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jan 20 04:17:14 homer kernel:  [default_idle+0/40] default_idle+0x0/0x28
Jan 20 04:17:14 homer kernel:  [rest_init+0/80] _stext+0x0/0x50
Jan 20 04:17:14 homer kernel:  [default_idle+35/40] default_idle+0x23/0x28
Jan 20 04:17:14 homer kernel:  [cpu_idle+50/64] cpu_idle+0x32/0x40
Jan 20 04:17:14 homer kernel:  [rest_init+77/80] _stext+0x4d/0x50
Jan 20 04:17:14 homer kernel:  [start_kernel+363/368] start_kernel+0x16b/0x170
Jan 20 04:17:14 homer kernel:
Jan 20 04:17:14 homer pppd[3511]: rcvd [LCP ConfAck id=0x2 <asyncmap 0x0> <accomp>]
Jan 20 04:17:17 homer pppd[3511]: sent [LCP ConfReq id=0x2 <asyncmap 0x0> <accomp>]

An IP is finally assigned to the Clie but the messages continue repeating in a high rate and the system is really slow. 
As soon as the connection is killed everything goes back to normal.

When trying the same with a 2.6.0 kernel I patched it using the ppp_async patch from Paul.
(found at http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0206.html)
The messages would not be displayed on the logs, but something strange happened and 3 out of my 4 usb ports died.
I think they are the USB 1 ports whereas the last one is a USB2 one. So probably the usb1 controller is gone.
I think this might be unrelated and caused by the Speedtouch USB, as it is rumoured to create problems with some controllers.

Is there any solution to this problem yet? I think, I might try 2.6.1-bk5 later on. I'll report back if its all the same.
Ah and I almost forgot.
Kernel was patched with the acpi patch from acpi.sf.net (it is a laptop). I'll also try without the patch later on.

Also here is an output from lspci:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 80)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 14)
00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 91)
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 031a (rev a1)

If anyone would like any more information, or me to try anything, please feel free to sent me an email.
Thanks

-- 
John
