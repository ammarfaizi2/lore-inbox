Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbTLMSth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbTLMSth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 13:49:37 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:57353 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265274AbTLMSt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 13:49:28 -0500
Date: Sat, 13 Dec 2003 19:49:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups (2/4)
Message-Id: <20031213194955.3f67fa34.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the i2c documentation files to what we have in our
repository. There are various fixes, and a more complete protocol
summary.

Please apply.

--- linux-old/Documentation/i2c/dev-interface	Thu Oct 11 15:05:47 2001
+++ linux/Documentation/i2c/dev-interface	Wed Dec 10 06:50:16 2003
@@ -87,7 +87,7 @@
 
 ioctl(file,I2C_TENBIT,long select)
   Selects ten bit addresses if select not equals 0, selects normal 7 bit
-  addresses if select equals 0.
+  addresses if select equals 0. Default 0.
 
 ioctl(file,I2C_FUNCS,unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
--- linux-old/Documentation/i2c/i2c-protocol	Fri Jul 28 19:50:51 2000
+++ linux/Documentation/i2c/i2c-protocol	Wed Dec 10 06:50:16 2003
@@ -52,10 +52,10 @@
 We have found some I2C devices that needs the following modifications:
 
   Flag I2C_M_NOSTART: 
-    In a combined transaction, no 'S Addr' is generated at some point.
-    For example, setting I2C_M_NOSTART on the second partial message
+    In a combined transaction, no 'S Addr Wr/Rd [A]' is generated at some
+    point. For example, setting I2C_M_NOSTART on the second partial message
     generates something like:
-      S Addr Rd [A] [Data] NA Wr [A] Data [A] P
+      S Addr Rd [A] [Data] NA Data [A] P
     If you set the I2C_M_NOSTART variable for the first partial message,
     we do not generate Addr, but we do generate the startbit S. This will
     probably confuse all other clients on your bus, so don't try this.
@@ -65,4 +65,3 @@
     need to emit an Rd instead of a Wr, or vice versa, you set this
     flag. For example:
       S Addr Rd [A] Data [A] Data [A] ... [A] Data [A] P
-                      
--- linux-old/Documentation/i2c/smbus-protocol	Fri Feb 16 23:53:08 2001
+++ linux/Documentation/i2c/smbus-protocol	Wed Dec 10 06:50:16 2003
@@ -1,3 +1,10 @@
+SMBus Protocol Summary
+======================
+The following is a summary of the SMBus protocol. It applies to
+all revisions of the protocol (1.0, 1.1, and 2.0).
+Certain protocol features which are not supported by
+this package are briefly described at the end of this document.
+
 Some adapters understand only the SMBus (System Management Bus) protocol,
 which is a subset from the I2C protocol. Fortunately, many devices use
 only the same subset, which makes it possible to put them on an SMBus.
@@ -6,7 +13,7 @@
 I2C protocol). This makes it possible to use the device driver on both
 SMBus adapters and I2C adapters (the SMBus command set is automatically
 translated to I2C on I2C adapters, but plain I2C commands can not be
-handled at all on a pure SMBus adapter).
+handled at all on most pure SMBus adapters).
 
 Below is a list of SMBus commands.
 
@@ -54,7 +61,7 @@
 This is the reverse of Read Byte: it sends a single byte to a device.
 See Read Byte for more information.
 
-S Addr Wr [A] Data NA P
+S Addr Wr [A] Data [A] P
 
 
 SMBus Read Byte Data
@@ -109,7 +116,7 @@
 SMBus Block Read
 ================
 
-This command reads a block of upto 32 bytes from a device, from a 
+This command reads a block of up to 32 bytes from a device, from a 
 designated register that is specified through the Comm byte. The amount
 of data is specified by the device in the Count byte.
 
@@ -120,8 +127,90 @@
 SMBus Block Write
 =================
 
-The opposite of the Block Read command, this writes upto 32 bytes to 
+The opposite of the Block Read command, this writes up to 32 bytes to 
 a device, to a designated register that is specified through the
 Comm byte. The amount of data is specified in the Count byte.
 
 S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P
+
+
+SMBus Block Process Call
+========================
+
+SMBus Block Process Call was introduced in Revision 2.0 of the specification.
+
+This command selects a device register (through the Comm byte), sends
+1 to 31 bytes of data to it, and reads 1 to 31 bytes of data in return.
+
+S Addr Wr [A] Comm [A] Count [A] Data [A] ...
+                             S Addr Rd [A] [Count] A [Data] ... NA P
+
+
+SMBus Host Notify
+=================
+
+This command is sent from a SMBus device acting as a master to the
+SMBus host acting as a slave.
+It is the same form as Write Word, with the command code replaced by the
+alerting device's address.
+
+[S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
+
+
+Packet Error Checking (PEC)
+===========================
+Packet Error Checking was introduced in Revision 1.1 of the specification.
+
+PEC adds a CRC-8 error-checking byte to all transfers.
+
+
+Address Resolution Protocol (ARP)
+=================================
+The Address Resolution Protocol was introduced in Revision 2.0 of
+the specification. It is a higher-layer protocol which uses the
+messages above.
+
+ARP adds device enumeration and dynamic address assignment to
+the protocol. All ARP communications use slave address 0x61 and
+require PEC checksums.
+
+
+I2C Block Transactions
+======================
+The following I2C block transactions are supported by the
+SMBus layer and are described here for completeness.
+I2C block transactions do not limit the number of bytes transferred
+but the SMBus layer places a limit of 32 bytes.
+
+
+I2C Block Read
+==============
+
+This command reads a block of bytes from a device, from a 
+designated register that is specified through the Comm byte.
+
+S Addr Wr [A] Comm [A] 
+           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
+
+
+I2C Block Read (2 Comm bytes)
+=============================
+
+This command reads a block of bytes from a device, from a 
+designated register that is specified through the two Comm bytes.
+
+S Addr Wr [A] Comm1 [A] Comm2 [A] 
+           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
+
+
+I2C Block Write
+===============
+
+The opposite of the Block Read command, this writes bytes to 
+a device, to a designated register that is specified through the
+Comm byte. Note that command lengths of 0, 2, or more bytes are
+supported as they are indistinguishable from data.
+
+S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
+
+
--- linux-old/Documentation/i2c/summary	Thu Oct 11 15:05:47 2001
+++ linux/Documentation/i2c/summary	Wed Dec 10 06:50:16 2003
@@ -4,7 +4,7 @@
 =============
 
 I2C (pronounce: I squared C) is a protocol developed by Philips. It is a 
-slow two-wire protocol (10-100 kHz), but it suffices for many types of 
+slow two-wire protocol (10-400 kHz), but it suffices for many types of 
 devices.
 
 SMBus (System Management Bus) is a subset of the I2C protocol. Many
@@ -43,15 +43,15 @@
 
 Included Bus Drivers
 ====================
-Note that not only stable drivers are patched into the kernel by 'mkpatch'.
+Note that only stable drivers are patched into the kernel by 'mkpatch'.
 
 
 Base modules
 ------------
 
-i2c-core: The basic I2C code, including the /proc interface
-i2c-dev:  The /dev interface
-i2c-proc: The /proc interface for device (client) drivers
+i2c-core: The basic I2C code, including the /proc/bus/i2c* interface
+i2c-dev:  The /dev/i2c-* interface
+i2c-proc: The /proc/sys/dev/sensors interface for device (client) drivers
 
 Algorithm drivers
 -----------------
--- linux-old/Documentation/i2c/writing-clients	Thu Oct 11 15:05:47 2001
+++ linux/Documentation/i2c/writing-clients	Wed Dec 10 06:50:17 2003
@@ -365,7 +328,7 @@
 
 The detect client function is called by i2c_probe or i2c_detect.
 The `kind' parameter contains 0 if this call is due to a `force'
-parameter, and 0 otherwise (for i2c_detect, it contains 0 if
+parameter, and -1 otherwise (for i2c_detect, it contains 0 if
 this call is due to the generic `force' parameter, and the chip type
 number if it is due to a specific `force' parameter).
 
@@ -448,9 +411,9 @@
     /* Note that we reserve some space for foo_data too. If you don't
        need it, remove it. We do it here to help to lessen memory
        fragmentation. */
-    if (! (new_client = kmalloc(sizeof(struct i2c_client)) + 
+    if (! (new_client = kmalloc(sizeof(struct i2c_client) + 
                                 sizeof(struct foo_data),
-                                GFP_KERNEL)) {
+                                GFP_KERNEL))) {
       err = -ENOMEM;
       goto ERROR0;
     }


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
