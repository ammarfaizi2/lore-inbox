Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRE3SZq>; Wed, 30 May 2001 14:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRE3SZh>; Wed, 30 May 2001 14:25:37 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:5638 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261309AbRE3SZb>;
	Wed, 30 May 2001 14:25:31 -0400
Date: Wed, 30 May 2001 10:27:03 -0700
From: Greg KH <greg@kroah.com>
To: Dawson Engler <engler@csl.Stanford.EDU>,
        Johannes Erdfelt <jerdfelt@valinux.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
Message-ID: <20010530102703.E7544@kroah.com>
In-Reply-To: <200105292200.PAA29842@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105292200.PAA29842@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Tue, May 29, 2001 at 03:00:56PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2001 at 03:00:56PM -0700, Dawson Engler wrote:
> -----------------------------------------------------------------------------
> [BUG] ./drivers/usb/bluetooth.c: dereference of 'buf' at the beginning of
>       the switch, and then does a copyin.

This is a real bug, thanks.
The attached patch, against the latest -ac tree should fix it.

greg k-h

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-bluetooth-2-2.4.5.patch"

diff -Nru a/drivers/usb/bluetooth.c b/drivers/usb/bluetooth.c
--- a/drivers/usb/bluetooth.c	Wed May 30 11:10:08 2001
+++ b/drivers/usb/bluetooth.c	Wed May 30 11:10:08 2001
@@ -1,11 +1,20 @@
 /*
- * bluetooth.c   Version 0.9
+ * bluetooth.c   Version 0.10
  *
  * Copyright (c) 2000, 2001 Greg Kroah-Hartman	<greg@kroah.com>
  * Copyright (c) 2000 Mark Douglas Corner	<mcorner@umich.edu>
  *
  * USB Bluetooth driver, based on the Bluetooth Spec version 1.0B
  * 
+ * (2001/05/28) Version 0.10 gkh
+ *	- Fixed problem with using data from userspace in the bluetooth_write
+ *	  function as found by the CHECKER project.
+ *	- Added a buffer to the write_urb_pool which reduces the number of
+ *	  buffers being created and destroyed for ever write.  Also cleans
+ *	  up the logic a bit.
+ *	- Added a buffer to the control_urb_pool which fixes a memory leak
+ *	  when the device is removed from the system.
+ *
  * (2001/05/28) Version 0.9 gkh
  *	Fixed problem with bluetooth==NULL for bluetooth_read_bulk_callback
  *	which was found by both the CHECKER project and Mikko Rahkonen.
@@ -101,7 +110,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v0.9"
+#define DRIVER_VERSION "v0.10"
 #define DRIVER_AUTHOR "Greg Kroah-Hartman, Mark Douglas Corner"
 #define DRIVER_DESC "USB Bluetooth driver"
 
@@ -264,7 +273,7 @@
 }
 
 
-static int bluetooth_ctrl_msg (struct usb_bluetooth *bluetooth, int request, int value, void *buf, int len)
+static int bluetooth_ctrl_msg (struct usb_bluetooth *bluetooth, int request, int value, const unsigned char *buf, int len)
 {
 	struct urb *urb = NULL;
 	devrequest *dr = NULL;
@@ -286,11 +295,23 @@
 		return -ENOMEM;
 	}
 
-	/* free up the last buffer that this urb used */
-	if (urb->transfer_buffer != NULL) {
-		kfree(urb->transfer_buffer);
-		urb->transfer_buffer = NULL;
+	/* keep increasing the urb transfer buffer to fit the size of the message */
+	if (urb->transfer_buffer == NULL) {
+		urb->transfer_buffer = kmalloc (len, GFP_KERNEL);
+		if (urb->transfer_buffer == NULL) {
+			err (__FUNCTION__" - out of memory");
+			return -ENOMEM;
+		}
+	}
+	if (urb->transfer_buffer_length < len) {
+		kfree (urb->transfer_buffer);
+		urb->transfer_buffer = kmalloc (len, GFP_KERNEL);
+		if (urb->transfer_buffer == NULL) {
+			err (__FUNCTION__" - out of memory");
+			return -ENOMEM;
+		}
 	}
+	memcpy (urb->transfer_buffer, buf, len);
 
 	dr->requesttype = BLUETOOTH_CONTROL_REQUEST_TYPE;
 	dr->request = request;
@@ -299,14 +320,14 @@
 	dr->length = cpu_to_le16p(&len);
 	
 	FILL_CONTROL_URB (urb, bluetooth->dev, usb_sndctrlpipe(bluetooth->dev, 0),
-			  (unsigned char*)dr, buf, len, bluetooth_ctrl_callback, bluetooth);
+			  (unsigned char*)dr, urb->transfer_buffer, len, bluetooth_ctrl_callback, bluetooth);
 
 	/* send it down the pipe */
 	status = usb_submit_urb(urb);
 	if (status)
 		dbg(__FUNCTION__ " - usb_submit_urb(control) failed with status = %d", status);
 	
-	return 0;
+	return status;
 }
 
 
@@ -405,12 +426,13 @@
 {
 	struct usb_bluetooth *bluetooth = get_usb_bluetooth ((struct usb_bluetooth *)tty->driver_data, __FUNCTION__);
 	struct urb *urb = NULL;
-	unsigned char *new_buffer;
+	unsigned char *temp_buffer = NULL;
+	const unsigned char *current_buffer;
 	const unsigned char *current_position;
-	int status;
 	int bytes_sent;
 	int buffer_size;
 	int i;
+	int retval = 0;
 
 	if (!bluetooth) {
 		return -ENODEV;
@@ -440,38 +462,39 @@
 	printk ("\n");
 #endif
 
-	switch (*buf) {
+	if (from_user) {
+		temp_buffer = kmalloc (count, GFP_KERNEL);
+		if (temp_buffer == NULL) {
+			err (__FUNCTION__ "- out of memory.");
+			retval = -ENOMEM;
+			goto exit;
+		}
+		copy_from_user (temp_buffer, buf, count);
+		current_buffer = temp_buffer;
+	} else {
+		current_buffer = buf;
+	}
+
+	switch (*current_buffer) {
 		/* First byte indicates the type of packet */
 		case CMD_PKT:
 			/* dbg(__FUNCTION__ "- Send cmd_pkt len:%d", count);*/
 
 			if (in_interrupt()){
 				printk("cmd_pkt from interrupt!\n");
-				return count;
-			}
-
-			new_buffer = kmalloc (count-1, GFP_KERNEL);
-
-			if (!new_buffer) {
-				err (__FUNCTION__ "- out of memory.");
-				return -ENOMEM;
+				retval = count;
+				goto exit;
 			}
 
-			if (from_user)
-				copy_from_user (new_buffer, buf+1, count-1);
-			else
-				memcpy (new_buffer, buf+1, count-1);
-
-			if (bluetooth_ctrl_msg (bluetooth, 0x00, 0x00, new_buffer, count-1) != 0) {
-				kfree (new_buffer);
-				return 0;
+			retval = bluetooth_ctrl_msg (bluetooth, 0x00, 0x00, &current_buffer[1], count-1);
+			if (retval) {
+				goto exit;
 			}
-
-			/* need to free new_buffer somehow... FIXME */
-			return count;
+			retval = count;
+			break;
 
 		case ACL_PKT:
-			current_position = buf;
+			current_position = current_buffer;
 			++current_position;
 			--count;
 			bytes_sent = 0;
@@ -488,37 +511,25 @@
 				}
 				if (urb == NULL) {
 					dbg (__FUNCTION__ " - no free urbs");
-					return bytes_sent;
+					retval = bytes_sent;
+					goto exit;
 				}
 				
-				/* free up the last buffer that this urb used */
-				if (urb->transfer_buffer != NULL) {
-					kfree(urb->transfer_buffer);
-					urb->transfer_buffer = NULL;
-				}
 
 				buffer_size = MIN (count, bluetooth->bulk_out_buffer_size);
-				
-				new_buffer = kmalloc (buffer_size, GFP_KERNEL);
-				if (new_buffer == NULL) {
-					err(__FUNCTION__" no more kernel memory...");
-					return bytes_sent;
-				}
-
-				if (from_user)
-					copy_from_user(new_buffer, current_position, buffer_size);
-				else
-					memcpy (new_buffer, current_position, buffer_size);
+				memcpy (urb->transfer_buffer, current_position, buffer_size);
 
 				/* build up our urb */
 				FILL_BULK_URB (urb, bluetooth->dev, usb_sndbulkpipe(bluetooth->dev, bluetooth->bulk_out_endpointAddress),
-						new_buffer, buffer_size, bluetooth_write_bulk_callback, bluetooth);
+						urb->transfer_buffer, buffer_size, bluetooth_write_bulk_callback, bluetooth);
 				urb->transfer_flags |= USB_QUEUE_BULK;
 
 				/* send it down the pipe */
-				status = usb_submit_urb(urb);
-				if (status)
-					dbg(__FUNCTION__ " - usb_submit_urb(write bulk) failed with status = %d", status);
+				retval = usb_submit_urb(urb);
+				if (retval) {
+					dbg(__FUNCTION__ " - usb_submit_urb(write bulk) failed with error = %d", retval);
+					goto exit;
+				}
 #ifdef BTBUGGYHARDWARE
 				/* A workaround for the stalled data bug */
 				/* May or may not be needed...*/
@@ -531,13 +542,20 @@
 				count -= buffer_size;
 			}
 
-			return bytes_sent + 1;
+			retval = bytes_sent + 1;
+			break;
 		
 		default :
 			dbg(__FUNCTION__" - unsupported (at this time) write type");
+			retval = -EINVAL;
+			break;
 	}
 
-	return 0;
+exit:
+	if (temp_buffer != NULL)
+		kfree (temp_buffer);
+
+	return retval;
 } 
 
 
@@ -1121,7 +1139,11 @@
 			err("No free urbs available");
 			goto probe_error;
 		}
-		urb->transfer_buffer = NULL;
+		urb->transfer_buffer = kmalloc (bluetooth->bulk_out_buffer_size, GFP_KERNEL);
+		if (urb->transfer_buffer == NULL) {
+			err("out of memory");
+			goto probe_error;
+		}
 		bluetooth->write_urb_pool[i] = urb;
 	}
 	
@@ -1163,11 +1185,17 @@
 	if (bluetooth->interrupt_in_buffer)
 		kfree (bluetooth->interrupt_in_buffer);
 	for (i = 0; i < NUM_BULK_URBS; ++i)
-		if (bluetooth->write_urb_pool[i])
+		if (bluetooth->write_urb_pool[i]) {
+			if (bluetooth->write_urb_pool[i]->transfer_buffer)
+				kfree (bluetooth->write_urb_pool[i]->transfer_buffer);
 			usb_free_urb (bluetooth->write_urb_pool[i]);
+		}
 	for (i = 0; i < NUM_CONTROL_URBS; ++i) 
-		if (bluetooth->control_urb_pool[i])
+		if (bluetooth->control_urb_pool[i]) {
+			if (bluetooth->control_urb_pool[i]->transfer_buffer)
+				kfree (bluetooth->control_urb_pool[i]->transfer_buffer);
 			usb_free_urb (bluetooth->control_urb_pool[i]);
+		}
 
 	bluetooth_table[minor] = NULL;
 

--bp/iNruPH9dso1Pn--
