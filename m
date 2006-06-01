Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWFATRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWFATRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWFATRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:17:32 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:40390 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S964940AbWFATRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:17:31 -0400
Date: Thu, 1 Jun 2006 21:16:54 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Greg KH <gregkh@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       lcapitulino@mandriva.com.br, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipaq.c bugfixes
Message-ID: <20060601191654.GA1757@fks.be>
References: <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be> <20060531215523.GA13745@suse.de> <20060531224245.GB17711@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531224245.GB17711@fks.be>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.816,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 12:42:45AM +0200, Frank Gevaerts wrote:
> This patch fixes several problems in the ipaq.c driver with connecting
> and disconnecting pocketpc devices: 

Unfortunately, it is apparently not the whole story.

There are some problems:

With this patch, whenever the usb_control_msg returns with ENODEV (-19),
we get the following :

Jun  1 10:02:06 localhost kernel: BUG: unable to handle kernel paging request at virtual address 723d4ecb
Jun  1 10:02:06 localhost kernel:  printing eip:
Jun  1 10:02:06 localhost kernel: b01e579b
Jun  1 10:02:06 localhost kernel: *pde = 00000000
Jun  1 10:02:06 localhost kernel: Oops: 0000 [#1]
Jun  1 10:02:06 localhost kernel: Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc usbhid ipaq uhci_hcd usbserial ohci_hcd ehci_hcd usbcore 8139too mii sr_mod sbp2 scsi_mod ieee1394 psmouse ide_generic ide_cd cdrom genrtc ext3 jbd mbcache ide_disk generic via82cxxx ide_core evdev mousedev
Jun  1 10:02:06 localhost kernel: CPU:    0
Jun  1 10:02:06 localhost kernel: EIP:    0060:[check_tty_count+39/110]    Not tainted VLI
Jun  1 10:02:06 localhost kernel: EFLAGS: 00010246   (2.6.17-rc4 #4)
Jun  1 10:02:06 localhost kernel: EIP is at check_tty_count+0x27/0x6e
Jun  1 10:02:06 localhost kernel: eax: 723d4e4f   ebx: c95f6000   ecx: c95f6170   edx: c95f6170
Jun  1 10:02:06 localhost kernel: esi: 00000000   edi: b0287619   ebp: 00000000   esp: cbec7f44
Jun  1 10:02:06 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jun  1 10:02:06 localhost kernel: Process events/0 (pid: 4, threadinfo=cbec6000 task=cbfdfa70)
Jun  1 10:02:06 localhost kernel: Stack: <0>c95f613c c95f6000 00000283 b01e5fb0 cbfe53a8 cbfe53a8 c95f613c cbfe53a0
Jun  1 10:02:06 localhost kernel:        00000283 c95f6000 b01219b1 c95f6000 b01e5f75 cbfe53a8 cbfe53a0 cbfe53b0
Jun  1 10:02:06 localhost kernel:        b0121a55 b0121b34 00000001 00000000 000f41fa 00010000 00000000 00000000
Jun  1 10:02:06 localhost kernel: Call Trace:
Jun  1 10:02:06 localhost kernel:  <b01e5fb0> do_tty_hangup+0x3b/0x263   <b01219b1> run_workqueue+0x64/0x94
Jun  1 10:02:06 localhost kernel:  <b01e5f75> do_tty_hangup+0x0/0x263   <b0121a55> worker_thread+0x0/0x10f
Jun  1 10:02:06 localhost kernel:  <b0121b34> worker_thread+0xdf/0x10f   <b01137ca> default_wake_function+0x0/0x15
Jun  1 10:02:06 localhost kernel:  <b0123f4a> kthread+0x94/0xc1   <b0123eb6> kthread+0x0/0xc1
Jun  1 10:02:06 localhost kernel:  <b0101005> kernel_thread_helper+0x5/0xb
Jun  1 10:02:06 localhost kernel: Code: 59 5e 5f c3 57 89 d7 56 31 f6 53 89 c3 8b 90 70 01 00 00 eb 03 46 89 ca 8b 0a 0f 18 01 90 8d 83 70 01 00 00 39 c2 75 ed 8b 43 04 <81> 78 7c 04 00 02 00 75 16 8b 83 cc 00 00 00 85 c0 74 0c 8b 80
Jun  1 10:02:06 localhost kernel: EIP: [check_tty_count+39/110] check_tty_count+0x27/0x6e SS:ESP 0068:cbec7f44

When I changed te ipaq_open code to only submit the read urb after the
control message succeeds, these disappear.

Whenever the usb_control_msg returns with ETIMEDOUT (-110), in both code
variants, when the device is disconnected we get:

Jun  1 20:23:55 localhost kernel: ------------[ cut here ]------------
Jun  1 20:23:55 localhost kernel: kernel BUG at kernel/workqueue.c:110!
Jun  1 20:23:55 localhost kernel: invalid opcode: 0000 [#1]
Jun  1 20:23:55 localhost kernel: Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc uhci_hcd ohci_hcd usbhid ipaq usbserial ehci_hcd usbcore tun 8139too mii sr_mod sbp2 scsi_mod ieee1394 psmouse ide_generic ide_cd cdrom genrtc ext3 jbd mbcache ide_disk generic via82cxxx ide_core evdev mousedev
Jun  1 20:23:55 localhost kernel: CPU:    0
Jun  1 20:23:55 localhost kernel: EIP:    0060:[queue_work+23/47]    Not tainted VLI
Jun  1 20:23:55 localhost kernel: EFLAGS: 00010a93   (2.6.17-rc4 #4)
Jun  1 20:23:55 localhost kernel: EIP is at queue_work+0x17/0x2f
Jun  1 20:23:55 localhost kernel: eax: c383113c   ebx: b13f29c0   ecx: 00000000   edx: c3831138
Jun  1 20:23:55 localhost kernel: esi: c44e8d60   edi: ca2f4814   ebp: 00000000   esp: c6bafeb8
Jun  1 20:23:55 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jun  1 20:23:55 localhost kernel: Process khubd (pid: 1629, threadinfo=c6bae000 task=cbfd3a90)
Jun  1 20:23:55 localhost kernel: Stack: <0>c44e8d60 cc9bfad3 c3831000 ca2f4800 cc9bcb40 cc9bcb64 ca2f4814 cc9dd838
Jun  1 20:23:55 localhost kernel:        ca2f4800 ca2f487c ca2f4814 b01fb254 ca2f4814 ca2f4814 00000000 cc9f0ba0
Jun  1 20:23:55 localhost kernel:        b01fb419 ca2f4814 b01fac3d ca2f4814 ca2f485c ca2f4814 c5cc3858 00000000
Jun  1 20:23:55 localhost kernel: Call Trace:
Jun  1 20:23:55 localhost kernel:  <cc9bfad3> usb_serial_disconnect+0x59/0xa1 [usbserial]   <cc9dd838> usb_unbind_interface+0x36/0x6f [usbcore]
Jun  1 20:23:55 localhost kernel:  <b01fb254> __device_release_driver+0x5c/0x72   <b01fb419> device_release_driver+0x18/0x26
Jun  1 20:23:55 localhost kernel:  <b01fac3d> bus_remove_device+0x74/0x8c   <b01fa0cc> device_del+0x39/0x65
Jun  1 20:23:55 localhost kernel:  <cc9dcaa1> usb_disable_device+0x6a/0xd4 [usbcore]   <cc9d9225> usb_disconnect+0x7c/0xc9 [usbcore]
Jun  1 20:23:55 localhost kernel:  <cc9d9f3d> hub_thread+0x35b/0x9eb [usbcore]   <b0123f84> autoremove_wake_function+0x0/0x3a
Jun  1 20:23:55 localhost kernel:  <b0123f36> kthread+0x80/0xc1   <cc9d9be2> hub_thread+0x0/0x9eb [usbcore]
Jun  1 20:23:55 localhost kernel:  <b0123f4a> kthread+0x94/0xc1   <b0123eb6> kthread+0x0/0xc1
Jun  1 20:23:55 localhost kernel:  <b0101005> kernel_thread_helper+0x5/0xb
Jun  1 20:23:55 localhost kernel: Code: 89 d8 5b 5e 5f c3 89 d1 89 c2 a1 f4 71 32 b0 e9 86 ff ff ff 53 89 c3 0f ba 2a 00 19 c0 31 c9 85 c0 75 1c 8d 42 04 39 42 04 74 08 <0f> 0b 6e 00 64 61 27 b0 8b 03 e8 4a fc ff ff b9 01 00 00 00 5b
Jun  1 20:23:55 localhost kernel: EIP: [queue_work+23/47] queue_work+0x17/0x2f SS:ESP 0068:c6bafeb8

This seems to be 100% reproducible. I noticed that serial_open (in
usb-serial.c) sets port->tty = tty and tty->driver_data = port, but
doesn't set them back to NULL if the type->open() fails. Is that correct
?

Also, we have discovered that the slow response of the ipaq on connect
is actually largely caused by the control message retries, so we have
added a sleep at the start of ipaq_open.

The current patch we are testing (not yet ready for inclusion, since
it doesn't work correctly yet and it produces some output that is not
useful in general) is :

diff -urp linux-2.6.17-rc4/drivers/usb/serial/ipaq.c linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c
--- linux-2.6.17-rc4/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c	2006-06-01 20:08:54.000000000 +0200
@@ -71,6 +71,8 @@
 
 static __u16 product, vendor;
 static int debug;
+static int connect_retries = KP_RETRIES;
+static int initial_wait;
 
 /* Function prototypes for an ipaq */
 static int  ipaq_open (struct usb_serial_port *port, struct file *filp);
@@ -583,7 +585,7 @@ static int ipaq_open(struct usb_serial_p
 	struct ipaq_private	*priv;
 	struct ipaq_packet	*pkt;
 	int			i, result = 0;
-	int			retries = KP_RETRIES;
+	int			retries = connect_retries;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -647,12 +649,12 @@ static int ipaq_open(struct usb_serial_p
 	port->read_urb->transfer_buffer_length = URBDATA_SIZE;
 	port->bulk_out_size = port->write_urb->transfer_buffer_length = URBDATA_SIZE;
 	
+	msleep(1000*initial_wait);
 	/* Start reading from the device */
 	usb_fill_bulk_urb(port->read_urb, serial->dev, 
 		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
 		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
 		      ipaq_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
 	if (result) {
 		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
 		goto error;
@@ -669,12 +671,15 @@ static int ipaq_open(struct usb_serial_p
 	while (retries--) {
 		result = usb_control_msg(serial->dev,
 				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
-				0x1, 0, NULL, 0, 100);
+				0x1, 0, NULL, 0, 50);
 		if (result == 0) {
+			info("%s - submitted read urb to %s (serial:%s) after %d retries", __FUNCTION__,serial->dev->devpath,serial->dev->serial==NULL?"":serial->dev->serial,connect_retries-retries);
+			result = usb_submit_urb(port->read_urb, GFP_KERNEL);
 			return 0;
 		}
+		msleep(1000);
 	}
-	err("%s - failed doing control urb, error %d", __FUNCTION__, result);
+	err("%s - failed doing control urb to %s (serial:%s), error %d", __FUNCTION__,serial->dev->devpath,serial->dev->serial==NULL?"":serial->dev->serial, result);
 	goto error;
 
 enomem:
@@ -692,6 +697,7 @@ static void ipaq_close(struct usb_serial
 	struct ipaq_private	*priv = usb_get_serial_port_data(port);
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
+	info("%s - closed %s (serial:%s)", __FUNCTION__,port->serial->dev->devpath,port->serial->dev->serial==NULL?"":port->serial->dev->serial);
 			 
 	/*
 	 * shut down bulk read and write
@@ -855,6 +861,7 @@ static void ipaq_write_bulk_callback(str
 	
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
+		return;
 	}
 
 	spin_lock_irqsave(&write_list_lock, flags);
@@ -967,3 +974,9 @@ MODULE_PARM_DESC(vendor, "User specified
 
 module_param(product, ushort, 0);
 MODULE_PARM_DESC(product, "User specified USB idProduct");
+
+module_param(connect_retries, int, 0);
+MODULE_PARM_DESC(connect_retries, "Maximum number of connect retries (100ms each)");
+
+module_param(initial_wait, int, 0);
+MODULE_PARM_DESC(initial_wait, "Time to wait before attempting a connection (in seconds)");
diff -urp linux-2.6.17-rc4/drivers/usb/serial/usb-serial.c linux-2.6.17-rc4.test/drivers/usb/serial/usb-serial.c
--- linux-2.6.17-rc4/drivers/usb/serial/usb-serial.c	2006-05-30 19:01:16.000000000 +0200
+++ linux-2.6.17-rc4.test/drivers/usb/serial/usb-serial.c	2006-05-30 19:01:24.000000000 +0200
@@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
 		}
 	}
 
+	flush_scheduled_work();		/* port->work */
+
 	usb_put_dev(serial->dev);
 
 	/* free up any memory that we allocated */


-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
