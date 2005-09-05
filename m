Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVIESdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVIESdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVIESc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:32:58 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:46435 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932383AbVIEScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:53 -0400
Message-Id: <20050905183244.880731000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:10 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 01/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-fix-ieee1284-device-id-reading.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential buffer overflow in case the device ID did not end in
semicolon. Also might fail to negotiate back to IEEE1284_MODE_COMPAT
in case of failure. parport_device_id did not return what
Documentation/parport-lowlevel.txt said, so I changed it to match it.

Determining device ID length is overly complicated, but Tim Waugh
recalled on linux-parport seeing some buggy device that might need it.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 drivers/parport/probe.c |  193 ++++++++++++++++++++++++++++++++----------------
 1 files changed, 130 insertions(+), 63 deletions(-)

Index: linux-dvb/drivers/parport/probe.c
===================================================================
--- linux-dvb.orig/drivers/parport/probe.c	2005-08-29 19:21:48.000000000 +0300
+++ linux-dvb/drivers/parport/probe.c	2005-08-29 20:11:07.000000000 +0300
@@ -129,8 +129,131 @@ static void parse_data(struct parport *p
 	kfree(txt);
 }
 
+/* Read up to count-1 bytes of device id. Terminate buffer with
+ * '\0'. Buffer begins with two Device ID length bytes as given by
+ * device. */
+static ssize_t parport_read_device_id (struct parport *port, char *buffer,
+				       size_t count)
+{
+	unsigned char length[2];
+	unsigned lelen, belen;
+	size_t idlens[4];
+	unsigned numidlens;
+	unsigned current_idlen;
+	ssize_t retval;
+	size_t len;
+
+	/* First two bytes are MSB,LSB of inclusive length. */
+	retval = parport_read (port, length, 2);
+
+	if (retval < 0)
+		return retval;
+	if (retval != 2)
+		return -EIO;
+
+	if (count < 2)
+		return 0;
+	memcpy(buffer, length, 2);
+	len = 2;
+
+	/* Some devices wrongly send LE length, and some send it two
+	 * bytes short. Construct a sorted array of lengths to try. */
+	belen = (length[0] << 8) + length[1];
+	lelen = (length[1] << 8) + length[0];
+	idlens[0] = min(belen, lelen);
+	idlens[1] = idlens[0]+2;
+	if (belen != lelen) {
+		int off = 2;
+		/* Don't try lenghts of 0x100 and 0x200 as 1 and 2 */
+		if (idlens[0] <= 2)
+			off = 0;
+		idlens[off] = max(belen, lelen);
+		idlens[off+1] = idlens[off]+2;
+		numidlens = off+2;
+	}
+	else {
+		/* Some devices don't truly implement Device ID, but
+		 * just return constant nibble forever. This catches
+		 * also those cases. */
+		if (idlens[0] == 0 || idlens[0] > 0xFFF) {
+			printk (KERN_DEBUG "%s: reported broken Device ID"
+				" length of %#zX bytes\n",
+				port->name, idlens[0]);
+			return -EIO;
+		}
+		numidlens = 2;
+	}
+
+	/* Try to respect the given ID length despite all the bugs in
+	 * the ID length. Read according to shortest possible ID
+	 * first. */
+	for (current_idlen = 0; current_idlen < numidlens; ++current_idlen) {
+		size_t idlen = idlens[current_idlen];
+		if (idlen+1 >= count)
+			break;
+
+		retval = parport_read (port, buffer+len, idlen-len);
+
+		if (retval < 0)
+			return retval;
+		len += retval;
+
+		if (port->physport->ieee1284.phase != IEEE1284_PH_HBUSY_DAVAIL) {
+			if (belen != len) {
+				printk (KERN_DEBUG "%s: Device ID was %d bytes"
+					" while device told it would be %d"
+					" bytes\n",
+					port->name, len, belen);
+			}
+			goto done;
+		}
+
+		/* This might end reading the Device ID too
+		 * soon. Hopefully the needed fields were already in
+		 * the first 256 bytes or so that we must have read so
+		 * far. */
+		if (buffer[len-1] == ';') {
+ 			printk (KERN_DEBUG "%s: Device ID reading stopped"
+				" before device told data not available. "
+				"Current idlen %d of %d, len bytes %02X %02X\n",
+				port->name, current_idlen, numidlens,
+				length[0], length[1]);
+			goto done;
+		}
+	}
+	if (current_idlen < numidlens) {
+		/* Buffer not large enough, read to end of buffer. */
+		size_t idlen, len2;
+		if (len+1 < count) {
+			retval = parport_read (port, buffer+len, count-len-1);
+			if (retval < 0)
+				return retval;
+			len += retval;
+		}
+		/* Read the whole ID since some devices would not
+		 * otherwise give back the Device ID from beginning
+		 * next time when asked. */
+		idlen = idlens[current_idlen];
+		len2 = len;
+		while(len2 < idlen && retval > 0) {
+			char tmp[4];
+			retval = parport_read (port, tmp,
+					       min(sizeof tmp, idlen-len2));
+			if (retval < 0)
+				return retval;
+			len2 += retval;
+		}
+	}
+	/* In addition, there are broken devices out there that don't
+	   even finish off with a semi-colon. We do not need to care
+	   about those at this time. */
+ done:
+	buffer[len] = '\0';
+	return len;
+}
+
 /* Get Std 1284 Device ID. */
-ssize_t parport_device_id (int devnum, char *buffer, size_t len)
+ssize_t parport_device_id (int devnum, char *buffer, size_t count)
 {
 	ssize_t retval = -ENXIO;
 	struct pardevice *dev = parport_open (devnum, "Device ID probe",
@@ -140,76 +263,20 @@ ssize_t parport_device_id (int devnum, c
 
 	parport_claim_or_block (dev);
 
-	/* Negotiate to compatibility mode, and then to device ID mode.
-	 * (This is in case we are already in device ID mode.) */
+	/* Negotiate to compatibility mode, and then to device ID
+	 * mode. (This so that we start form beginning of device ID if
+	 * already in device ID mode.) */
 	parport_negotiate (dev->port, IEEE1284_MODE_COMPAT);
 	retval = parport_negotiate (dev->port,
 				    IEEE1284_MODE_NIBBLE | IEEE1284_DEVICEID);
 
 	if (!retval) {
-		int idlen;
-		unsigned char length[2];
-
-		/* First two bytes are MSB,LSB of inclusive length. */
-		retval = parport_read (dev->port, length, 2);
-
-		if (retval != 2) goto end_id;
-
-		idlen = (length[0] << 8) + length[1] - 2;
-		/*
-		 * Check if the caller-allocated buffer is large enough
-		 * otherwise bail out or there will be an at least off by one.
-		 */
-		if (idlen + 1 < len)
-			len = idlen;
-		else {
-			retval = -EINVAL;
-			goto out;
-		}
-		retval = parport_read (dev->port, buffer, len);
-
-		if (retval != len)
-			printk (KERN_DEBUG "%s: only read %Zd of %Zd ID bytes\n",
-				dev->port->name, retval,
-				len);
-
-		/* Some printer manufacturers mistakenly believe that
-                   the length field is supposed to be _exclusive_.
-		   In addition, there are broken devices out there
-                   that don't even finish off with a semi-colon. */
-		if (buffer[len - 1] != ';') {
-			ssize_t diff;
-			diff = parport_read (dev->port, buffer + len, 2);
-			retval += diff;
-
-			if (diff)
-				printk (KERN_DEBUG
-					"%s: device reported incorrect "
-					"length field (%d, should be %Zd)\n",
-					dev->port->name, idlen, retval);
-			else {
-				/* One semi-colon short of a device ID. */
-				buffer[len++] = ';';
-				printk (KERN_DEBUG "%s: faking semi-colon\n",
-					dev->port->name);
-
-				/* If we get here, I don't think we
-                                   need to worry about the possible
-                                   standard violation of having read
-                                   more than we were told to.  The
-                                   device is non-compliant anyhow. */
-			}
-		}
-
-	end_id:
-		buffer[len] = '\0';
+		retval = parport_read_device_id (dev->port, buffer, count);
 		parport_negotiate (dev->port, IEEE1284_MODE_COMPAT);
+		if (retval > 2)
+			parse_data (dev->port, dev->daisy, buffer+2);
 	}
 
-	if (retval > 2)
-		parse_data (dev->port, dev->daisy, buffer);
-
-out:
 	parport_release (dev);
 	parport_close (dev);
 	return retval;

--
