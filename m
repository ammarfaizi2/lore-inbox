Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUHFCmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUHFCmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUHFCld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:41:33 -0400
Received: from c3-1d224.neo.rr.com ([24.93.233.224]:31618 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S268079AbUHFCkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:40:46 -0400
Date: Thu, 5 Aug 2004 22:32:16 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: rmk@arm.linux.org.uk
Cc: linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia driver model support [5/5]
Message-ID: <20040805223216.GF11641@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm alright with dropping this patch if it creates a potential compatibility
problem with possible 2.6 future *hotplug interfaces, but I do think that it is
rather reasonable and close to whatever the final interface will be.

[PCMCIA] add *hotplug support

This patch allows for hotplug events.  It reports vers_1 information.

--- a/drivers/pcmcia/ds.c	2004-08-05 21:28:48.000000000 +0000
+++ b/drivers/pcmcia/ds.c	2004-08-05 21:34:29.000000000 +0000
@@ -577,6 +577,59 @@
 	up(&s->device_mutex);
 }
 
+#ifdef	CONFIG_HOTPLUG
+
+int pcmcia_bus_hotplug(struct device *pdev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	struct pcmcia_device *dev;
+	char *scratch;
+	int i = 0;
+	int length = 0;
+
+	if (!pdev)
+		return -ENODEV;
+
+	dev = to_pcmcia_device(pdev);
+
+	scratch = buffer;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	envp[i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "PRODUCT=");
+	for (i = 0; i < dev->vers_1.ns; i++) {
+		length += snprintf(scratch,buffer_size - length, "%s\"%s\"", (i>0) ? "," : "",
+			       dev->vers_1.str+dev->vers_1.ofs[i]);
+	}
+
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp [i++] = scratch;
+	length += snprintf (scratch, buffer_size - length, "MANFID=0x%04x,0x%04x",
+			    dev->manfid.manf, dev->manfid.card);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i] = 0;
+
+	return 0;
+}
+
+#else /* CONFIG_HOTPLUG */
+
+int pcmcia_bus_hotplug(struct device *pdev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_HOTPLUG */
+
 /*======================================================================
 
     These manage a ring buffer of events pending for one user process
@@ -1332,6 +1385,7 @@
 
 struct bus_type pcmcia_bus_type = {
 	.name = "pcmcia",
+	.hotplug = pcmcia_bus_hotplug,
 };
 
 EXPORT_SYMBOL(pcmcia_bus_type);
