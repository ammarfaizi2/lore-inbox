Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261931AbTCLTwO>; Wed, 12 Mar 2003 14:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbTCLTwO>; Wed, 12 Mar 2003 14:52:14 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:31137 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S261931AbTCLTwN>;
	Wed, 12 Mar 2003 14:52:13 -0500
Date: Wed, 12 Mar 2003 23:00:50 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       david-b@pacbell.net, wahrenbruch@kobil.de, torvalds@transmeta.com
Subject: Memleak in KOBIL USB Smart Card Terminal Driver
Message-ID: <20030312200050.GA28090@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a memleak on error exit path in KOBIL USB Smart Card Terminal
   Driver in both current 2.4 and 2.5.
   See the patch.
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/usb/serial/kobil_sct.c 1.2 vs edited =====
--- 1.2/drivers/usb/serial/kobil_sct.c	Wed Dec 11 03:31:09 2002
+++ edited/drivers/usb/serial/kobil_sct.c	Wed Mar 12 22:57:33 2003
@@ -254,6 +254,7 @@
 		port->write_urb = usb_alloc_urb(0);  
 		if (!port->write_urb) {
 			dbg("%s - port %d usb_alloc_urb failed", __FUNCTION__, port->number);
+			kfree(transfer_buffer);
 			return -1;
 		}
 	}
@@ -261,6 +262,7 @@
 	// allocate memory for write_urb transfer buffer
 	port->write_urb->transfer_buffer = (unsigned char *) kmalloc(write_urb_transfer_buffer_length, GFP_KERNEL);
 	if (! port->write_urb->transfer_buffer) {
+		kfree(transfer_buffer);
 		return -1;
 	} 
 
