Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTBTD7F>; Wed, 19 Feb 2003 22:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTBTD7F>; Wed, 19 Feb 2003 22:59:05 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:16929 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264788AbTBTD7D>;
	Wed, 19 Feb 2003 22:59:03 -0500
Message-ID: <3E5454E2.5040007@acm.org>
Date: Wed, 19 Feb 2003 22:09:06 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
Subject: IPMI driver version 18 release
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000607060704060503030301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607060704060503030301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I found a few stupid bugs in the IPMI driver dealing with certain error
cases, and this also contains the documentation updates that I have not
sent to Linus enough times to be included yet :-).

The 2.5 version is attached.  The 2.4 version is at:
http://sourceforge.net/projects/openipmi/

-Corey

--------------000607060704060503030301
Content-Type: text/plain;
 name="linux-ipmi-2.5.62-v17-v18.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-2.5.62-v17-v18.diff"

diff -urN linux.orig/Documentation/IPMI.txt linux/Documentation/IPMI.txt
--- linux.orig/Documentation/IPMI.txt	Tue Jan 14 11:16:08 2003
+++ linux/Documentation/IPMI.txt	Fri Feb  7 21:26:31 2003
@@ -5,6 +5,18 @@
 			  <minyard@mvista.com>
 			    <minyard@acm.org>
 
+The Intelligent Platform Management Interface, or IPMI, is a
+standard for controlling intelligent devices that monitor a system.
+It provides for dynamic discovery of sensors in the system and the
+ability to monitor the sensors and be informed when the sensor's
+values change or go outside certain boundaries.  It also has a
+standardized database for field-replacable units (FRUs) and a watchdog
+timer.
+
+To use this, you need an interface to an IPMI controller in your
+system (called a Baseboard Management Controller, or BMC) and
+management software that can use the IPMI system.
+
 This document describes how to use the IPMI driver for Linux.  If you
 are not familiar with IPMI itself, see the web site at
 http://www.intel.com/design/servers/ipmi/index.htm.  IPMI is a big
diff -urN linux.orig/drivers/char/ipmi/Kconfig linux/drivers/char/ipmi/Kconfig
--- linux.orig/drivers/char/ipmi/Kconfig	Tue Jan 14 11:16:10 2003
+++ linux/drivers/char/ipmi/Kconfig	Tue Jan 14 11:19:09 2003
@@ -7,8 +7,14 @@
        tristate 'IPMI top-level message handler'
        help
          This enables the central IPMI message handler, required for IPMI
-	 to work.  Note that you must have this enabled to do any other IPMI
-	 things.  See IPMI.txt for more details.
+	 to work.
+
+         IPMI is a standard for managing sensors (temperature,
+         voltage, etc.) in a system.
+
+         See Documentation/IPMI.txt for more details on the driver.
+
+	 If unsure, say N.
 
 config IPMI_PANIC_EVENT
        bool 'Generate a panic event to all BMCs on a panic'
diff -urN linux.orig/drivers/char/ipmi/ipmi_msghandler.c linux/drivers/char/ipmi/ipmi_msghandler.c
--- linux.orig/drivers/char/ipmi/ipmi_msghandler.c	Tue Jan 14 11:16:10 2003
+++ linux/drivers/char/ipmi/ipmi_msghandler.c	Wed Feb 19 17:11:19 2003
@@ -345,7 +345,7 @@
 	unsigned int i;
 
 	for (i=intf->curr_seq;
-	     i!=(intf->curr_seq-1);
+	     (i+1)%IPMI_IPMB_NUM_SEQ != intf->curr_seq;
 	     i=(i+1)%IPMI_IPMB_NUM_SEQ)
 	{
 		if (! intf->seq_table[i].inuse)
@@ -906,8 +906,6 @@
 				   probably, so abort. */
 				spin_unlock_irqrestore(&(intf->seq_lock),
 						       flags);
-				ipmi_free_recv_msg(recv_msg);
-				ipmi_free_smi_msg(smi_msg);
 				goto out_err;
 			}
 

--------------000607060704060503030301--

