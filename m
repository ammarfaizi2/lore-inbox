Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265796AbUFDPAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUFDPAD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUFDPAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:00:03 -0400
Received: from [141.156.69.115] ([141.156.69.115]:54509 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265796AbUFDO77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:59:59 -0400
Message-ID: <40C08E6D.8080606@infosciences.com>
Date: Fri, 04 Jun 2004 10:59:57 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: [PATCH] Memory leak in visor.c and ftdi_sio.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that I have not verified any of the below on
hardware associated with drivers/usb/serial/ftdi_sio.c,
only with drivers/usb/serial/visor.c.  If anyone has
hardware for this device, I would appreciate your comments.

A memory leak occurs in both drivers/usb/serial/ftdi_sio.c
and drivers/usb/serial/visor.c when the usb device is
unplugged while data is being written to the device.  This
patch should clear that up.

This was prepared against 2.6.7-rc2.

Signed-off-by: Joe Nardelli <jnardelli@infosciences.com>


diff -uprN -X dontdiff linux-2.6.7-rc2.orig/drivers/usb/serial/ftdi_sio.c linux-2.6.7-rc2/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.7-rc2.orig/drivers/usb/serial/ftdi_sio.c  2004-06-04 10:10:21.112743024 -0400
+++ linux-2.6.7-rc2/drivers/usb/serial/ftdi_sio.c       2004-06-04 09:53:27.000000000 -0400
@@ -1504,6 +1504,7 @@ static int ftdi_write (struct usb_serial
       if (status) {
               err("%s - failed submitting write urb, error %d", __FUNCTION__, status);
               count = status;
+               kfree (buffer);
       }

       /* we are done with this urb, so let the host driver
diff -uprN -X dontdiff linux-2.6.7-rc2.orig/drivers/usb/serial/visor.c linux-2.6.7-rc2/drivers/usb/serial/visor.c
--- linux-2.6.7-rc2.orig/drivers/usb/serial/visor.c     2004-06-04 10:10:21.210728128 -0400
+++ linux-2.6.7-rc2/drivers/usb/serial/visor.c  2004-06-04 10:13:10.214035720 -0400
@@ -515,6 +515,7 @@ static int visor_write (struct usb_seria
               dev_err(&port->dev, "%s - usb_submit_urb(write bulk) failed with status = %d\n",
                       __FUNCTION__, status);
               count = status;
+               kfree (buffer);
       } else {
               bytes_out += count;
       }

-- 
Joe Nardelli
jnardelli@infosciences.com

