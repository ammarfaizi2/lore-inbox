Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310686AbSCSX3f>; Tue, 19 Mar 2002 18:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310695AbSCSX31>; Tue, 19 Mar 2002 18:29:27 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:63183 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S310686AbSCSX3O>;
	Tue, 19 Mar 2002 18:29:14 -0500
Date: Wed, 20 Mar 2002 00:29:11 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: rob1@rekl.yi.org
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IP Autoconfig doesn't work for USB network devices
In-Reply-To: <Pine.LNX.4.40.0203161810290.16559-100000@rekl.dyn.dhs.org>
Message-ID: <Pine.LNX.4.44.0203200025470.4107-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 rob1@rekl.yi.org wrote:
> I tried the suggestion in this thread:
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=100912381726661&w=2
>
> It made no difference.  I also looked through the messages on
> linux-usb-devel, but they seem to be more related to having USB floppies
> or USB hard drives recognized, instead of network cards, which I believe
> is my problem.

That's right. I made a separate patch for USB (or other hotplug)
network cards (see below).

Eric


--- linux-2.4.9-ac7/net/ipv4/ipconfig.c.orig	Wed May  2 05:59:24 2001
+++ linux-2.4.9-ac7/net/ipv4/ipconfig.c	Tue Sep 18 17:16:07 2001
@@ -80,6 +80,8 @@
 #define CONF_PRE_OPEN		(HZ/2)	/* Before opening: 1/2 second */
 #define CONF_POST_OPEN		(1*HZ)	/* After opening: 1 second */

+#define CONF_DEV_WAIT		(1*HZ)
+
 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
 #define CONF_SEND_RETRIES 	6	/* Send six requests per open */
@@ -1105,8 +1107,20 @@
 		;

 	/* Setup all network devices */
-	if (ic_open_devs() < 0)
+	while (ic_open_devs() < 0) {
+#ifdef CONFIG_ROOT_NFS
+		if (ROOT_DEV == MKDEV(UNNAMED_MAJOR, 255)) {
+			printk(KERN_ERR
+				"IP-Config: Retrying forever (NFS root)...\n");
+
+			// wait a while and try again
+		        current->state = TASK_INTERRUPTIBLE;
+                	schedule_timeout(CONF_DEV_WAIT);
+                	continue;
+		}
+#endif
 		return -1;
+        }

 	/* Give drivers a chance to settle */
 	jiff = jiffies + CONF_POST_OPEN;

