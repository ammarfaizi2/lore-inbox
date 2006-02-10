Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWBJRse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWBJRse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWBJRse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:48:34 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:14559 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932115AbWBJRsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:48:33 -0500
Date: Fri, 10 Feb 2006 18:48:36 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Cc: magne@samfundet.no
Subject: [PATCH] Problem with detecting the serial ports on a NetMos 9845
Message-ID: <20060210174836.GA16968@uio.no>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Spam-Score: -0.0 (/)
X-Spam-Report: Status=No hits=-0.0 required=5.0 tests=NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

[I'm not subscribed to linux-kernel, so please Cc me on any replies -- I
 tried posting this to linux-serial in December, but never got any reply, so
 I guess nobody's reading the list.]

Hi,

We have a NetMos 9845 controller with four serial ports but no parallel port, 
and tried to use parport_serial driver with it. However, all it would say was
that it had detected a parallel port at 9710:9735, and then exit.

We tracked it down, and found two problems:

  - For some reason, it detects the 9845 as a 9735 -- it appears this is
    simply related to the ordering in parport_serial_pci_tbl[]. If we move
    the 9845 up above the 9735, it prints out 9710:9845, but no change in
    behaviour. (We didn't find out why this was the case; we left it alone
    since it didn't affect our problem.)
  - The card has no parallel port (at least no physical ones), yet it reports
    (via its subsystem ID of 0x0014) one parallel port and four serial ports.
    The probe for the parallel port fails, and the driver just aborts. Thus,
    it doesn't find the serial ports.

We tested this under both 2.6.12 and 2.6.15, and both had the same problem.
The attached patch (against 2.6.12) changes the logic for the parallel port
detection: If there are detected parallel ports but the probe fails, the
number of parallel ports is simply set to zero, and the probe continues as
usual. This makes it work correctly in our case, and should not present a
problem for other systems.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="parport_serial.c.diff"

--- linux-source-2.6.12-2.6.12/drivers/parport/parport_serial.c	2005-06-17 21:48:29.000000000 +0200
@@ -418,10 +419,13 @@
 		return err;
 	}
 
-	if (parport_register (dev, id)) {
+	err = parport_register (dev, id);
+	if (err < 0) {
 		pci_set_drvdata (dev, NULL);
 		kfree (priv);
 		return -ENODEV;
+	} else if (err) {
+		priv->num_par = 0;
 	}
 
 	if (serial_register (dev, id)) {

--opJtzjQTFsWo+cga--
