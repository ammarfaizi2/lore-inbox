Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWFBM7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWFBM7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFBM7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:59:37 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:12709 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751210AbWFBM7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:59:36 -0400
Date: Fri, 2 Jun 2006 09:59:35 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] ipaq.c bugfixes
Message-ID: <20060602095935.65257a1b@doriath.conectiva>
In-Reply-To: <20060601191654.GA1757@fks.be>
References: <20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
	<20060530115329.30184aa0@doriath.conectiva>
	<20060530174821.GA15969@fks.be>
	<20060530113327.297aceb7.zaitcev@redhat.com>
	<20060531213828.GA17711@fks.be>
	<20060531215523.GA13745@suse.de>
	<20060531224245.GB17711@fks.be>
	<20060601191654.GA1757@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 21:16:54 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| When I changed te ipaq_open code to only submit the read urb after the
| control message succeeds, these disappear.
| 
| Whenever the usb_control_msg returns with ETIMEDOUT (-110), in both code
| variants, when the device is disconnected we get:

 Did you mean that it happens even if you send the read urb after the
control message?

| Jun  1 20:23:55 localhost kernel: ------------[ cut here ]------------
| Jun  1 20:23:55 localhost kernel: kernel BUG at kernel/workqueue.c:110!
| Jun  1 20:23:55 localhost kernel: invalid opcode: 0000 [#1]
| Jun  1 20:23:55 localhost kernel: Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc uhci_hcd ohci_hcd usbhid ipaq usbserial ehci_hcd usbcore tun 8139too mii sr_mod sbp2 scsi_mod ieee1394 psmouse ide_generic ide_cd cdrom genrtc ext3 jbd mbcache ide_disk generic via82cxxx ide_core evdev mousedev
| Jun  1 20:23:55 localhost kernel: CPU:    0
| Jun  1 20:23:55 localhost kernel: EIP:    0060:[queue_work+23/47]    Not tainted VLI
| Jun  1 20:23:55 localhost kernel: EFLAGS: 00010a93   (2.6.17-rc4 #4)
| Jun  1 20:23:55 localhost kernel: EIP is at queue_work+0x17/0x2f
| Jun  1 20:23:55 localhost kernel: eax: c383113c   ebx: b13f29c0   ecx: 00000000   edx: c3831138
| Jun  1 20:23:55 localhost kernel: esi: c44e8d60   edi: ca2f4814   ebp: 00000000   esp: c6bafeb8
| Jun  1 20:23:55 localhost kernel: ds: 007b   es: 007b   ss: 0068
| Jun  1 20:23:55 localhost kernel: Process khubd (pid: 1629, threadinfo=c6bae000 task=cbfd3a90)
| Jun  1 20:23:55 localhost kernel: Stack: <0>c44e8d60 cc9bfad3 c3831000 ca2f4800 cc9bcb40 cc9bcb64 ca2f4814 cc9dd838
| Jun  1 20:23:55 localhost kernel:        ca2f4800 ca2f487c ca2f4814 b01fb254 ca2f4814 ca2f4814 00000000 cc9f0ba0
| Jun  1 20:23:55 localhost kernel:        b01fb419 ca2f4814 b01fac3d ca2f4814 ca2f485c ca2f4814 c5cc3858 00000000
| Jun  1 20:23:55 localhost kernel: Call Trace:
| Jun  1 20:23:55 localhost kernel:  <cc9bfad3> usb_serial_disconnect+0x59/0xa1 [usbserial]   <cc9dd838> usb_unbind_interface+0x36/0x6f [usbcore]
| Jun  1 20:23:55 localhost kernel:  <b01fb254> __device_release_driver+0x5c/0x72   <b01fb419> device_release_driver+0x18/0x26
| Jun  1 20:23:55 localhost kernel:  <b01fac3d> bus_remove_device+0x74/0x8c   <b01fa0cc> device_del+0x39/0x65
| Jun  1 20:23:55 localhost kernel:  <cc9dcaa1> usb_disable_device+0x6a/0xd4 [usbcore]   <cc9d9225> usb_disconnect+0x7c/0xc9 [usbcore]
| Jun  1 20:23:55 localhost kernel:  <cc9d9f3d> hub_thread+0x35b/0x9eb [usbcore]   <b0123f84> autoremove_wake_function+0x0/0x3a
| Jun  1 20:23:55 localhost kernel:  <b0123f36> kthread+0x80/0xc1   <cc9d9be2> hub_thread+0x0/0x9eb [usbcore]
| Jun  1 20:23:55 localhost kernel:  <b0123f4a> kthread+0x94/0xc1   <b0123eb6> kthread+0x0/0xc1
| Jun  1 20:23:55 localhost kernel:  <b0101005> kernel_thread_helper+0x5/0xb
| Jun  1 20:23:55 localhost kernel: Code: 89 d8 5b 5e 5f c3 89 d1 89 c2 a1 f4 71 32 b0 e9 86 ff ff ff 53 89 c3 0f ba 2a 00 19 c0 31 c9 85 c0 75 1c 8d 42 04 39 42 04 74 08 <0f> 0b 6e 00 64 61 27 b0 8b 03 e8 4a fc ff ff b9 01 00 00 00 5b
| Jun  1 20:23:55 localhost kernel: EIP: [queue_work+23/47] queue_work+0x17/0x2f SS:ESP 0068:c6bafeb8
| 
| This seems to be 100% reproducible. I noticed that serial_open (in
| usb-serial.c) sets port->tty = tty and tty->driver_data = port, but
| doesn't set them back to NULL if the type->open() fails. Is that correct
| ?

 I don't think it would cause the problem you're getting. 'port' is
valid even if the driver's open() function fails.

| Also, we have discovered that the slow response of the ipaq on connect
| is actually largely caused by the control message retries, so we have
| added a sleep at the start of ipaq_open.
| 
| The current patch we are testing (not yet ready for inclusion, since
| it doesn't work correctly yet and it produces some output that is not
| useful in general) is :

 Well, I'm afraid that every new patch leads to a new problem..
Maybe it's something else..

-- 
Luiz Fernando N. Capitulino
