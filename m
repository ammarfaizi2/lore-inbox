Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWEaUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWEaUal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWEaUak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:30:40 -0400
Received: from gw.goop.org ([64.81.55.164]:62094 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751644AbWEaUaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:30:18 -0400
Message-ID: <447DFBC5.70200@goop.org>
Date: Wed, 31 May 2006 13:25:41 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: gregkh@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH RFC] maxSize option for usb-serial to increase max endpoint
 buffer size
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People using 1xEV-DO devices report that usb-serial must be changed to 
allow an increased buffer size in order to get good throughput a full 
data-rate.

There's a page at 
http://www.junxion.com/opensource/linux_highspeed_usbserial.html which 
describes the problem and solution, but the patch they offer for 2.6 
kernels seems broken, because it drops a call to le16_to_cpu(), which 
will presumably cause problems on big-endian systems.

I don't know if this patch is 1) really necessary, or 2) really 
correct.  This patch certainly works for me, but I haven't exercised it 
much.

I know this patch was posted to linux-usb-devel before, but the 
discussion didn't go anywhere.  I'm posting this RFC to see what the 
correct fix really is.

    J

--
Add a module option to increase the USB endpoint buffer size.  This is
needed to get efficient throughput when using an 1xEV-DO card.

This change is derived from the patch posted at
http://www.junxion.com/opensource/linux_highspeed_usbserial.html, but
that patch seems to have endian problems.

Description from that page:

Wireless WAN PC Card modem devices such as the Novatel Merlin
V620/S620 and Kyocera KPC650 on a 1xEV-DO network experience a stalled
data connection due to high data rates when operated on Linux kernel
2.4.x and 2.6.x. This issue does not occur when the cards are
connected at 1xRTT data rates.

BACKGROUND

The affected modems are PCMCIA cards that use a USB host controller
interface to expose a serial device to the Linux operating system. The
generic usbserial driver can be used to talk to these devices as if
they were serial modems.

There are 2 potential problems that this work-around resolves:

1. The current usbcore and usbserial driver do not correctly recognize
the maximum packet size on the inbound bulk endpoint.
2. The cards themselves are not advertising the correct maximum data
packet size to the usb sub-system on Linux.

By default the linux usb core sees only 64 bytes of capacity. Without
this work-around there is no way to specify what the maximum packet
size on the inbound bulk endpoint should be. If you consider that the
MTU on these cards is set at 1500 and the usb bulk endpoint callbacks
are only reading 64 bytes at a time off of the serial tty, it doesn't
take long to start dropping packets and seriously junkify your
connection.

This patch adds a third module parameter so you can specify what you
think the inbound endpoint maximum packet size should be. If the
parameter is not set at module loading time, it defaults to 0 and the
maximum packet size detected by the usb core will be used.


Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff -r a68e12afb6a4 drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Tue May 30 23:20:05 2006 -0700
+++ b/drivers/usb/serial/usb-serial.c	Tue May 30 23:23:14 2006 -0700
@@ -56,6 +56,7 @@ struct usb_driver usb_serial_driver = {
    drivers depend on it.
 */
 
+static ushort maxSize;
 static int debug;
 static struct usb_serial *serial_table[SERIAL_TTY_MINORS];	/* initially all NULL */
 static LIST_HEAD(usb_serial_driver_list);
@@ -838,7 +839,7 @@ int usb_serial_probe(struct usb_interfac
 			dev_err(&interface->dev, "No free urbs available\n");
 			goto probe_error;
 		}
-		buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+		buffer_size = (le16_to_cpu(endpoint->wMaxPacketSize) > maxSize) ? le16_to_cpu(endpoint->wMaxPacketSize) : maxSize;
 		port->bulk_in_size = buffer_size;
 		port->bulk_in_endpointAddress = endpoint->bEndpointAddress;
 		port->bulk_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
@@ -1214,3 +1215,5 @@ MODULE_LICENSE("GPL");
 
 module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debug enabled or not");
+module_param(maxSize, ushort,0);
+MODULE_PARM_DESC(maxSize,"User specified USB endpoint size");



