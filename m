Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWFRQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWFRQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWFRQ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:59:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37566 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932254AbWFRQ7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:59:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 18:59:18 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 2/6] ieee1394: do not spawn a kernel_thread for
 user-initiated bus rescan
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
Message-ID: <tkrat.7fb54747c3c78ac1@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
 <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
 <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.877) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nodemgr.c::fw_set_rescan() is used to re-run the driver core over
nodemgr's representation of unit directories in order to initiate
protocol driver probes.  It is initiated via write access to one of
nodemgr's sysfs attributes.  The purpose is to attach drivers to
units after switching a unit's ignore_driver attribute from 1 to 0.

It is not really necessary to fork a kernel_thread for this job.
The call to kernel_thread() can be eliminated to avoid the deprecated
API and to simplify the code a bit.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-18 09:11:18.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-18 09:15:45.000000000 +0200
@@ -402,26 +402,11 @@ static ssize_t fw_get_destroy_node(struc
 }
 static BUS_ATTR(destroy_node, S_IWUSR | S_IRUGO, fw_get_destroy_node, fw_set_destroy_node);
 
-static int nodemgr_rescan_bus_thread(void *__unused)
-{
-	/* No userlevel access needed */
-	daemonize("kfwrescan");
-
-	bus_rescan_devices(&ieee1394_bus_type);
-
-	return 0;
-}
 
 static ssize_t fw_set_rescan(struct bus_type *bus, const char *buf, size_t count)
 {
-	int state = simple_strtoul(buf, NULL, 10);
-
-	/* Don't wait for this, or care about errors. Root could do
-	 * something stupid and spawn this a lot of times, but that's
-	 * root's fault. */
-	if (state == 1)
-		kernel_thread(nodemgr_rescan_bus_thread, NULL, CLONE_KERNEL);
-
+	if (simple_strtoul(buf, NULL, 10) == 1)
+		bus_rescan_devices(&ieee1394_bus_type);
 	return count;
 }
 static ssize_t fw_get_rescan(struct bus_type *bus, char *buf)


