Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273414AbRIRTTZ>; Tue, 18 Sep 2001 15:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273415AbRIRTTP>; Tue, 18 Sep 2001 15:19:15 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:1217 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S273414AbRIRTTI>;
	Tue, 18 Sep 2001 15:19:08 -0400
Date: Tue, 18 Sep 2001 21:19:30 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: David Acklam <dackl@post.com>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>, <greg@kroah.com>
Subject: Re: compiled-in (non-modular) USB initialization bug
In-Reply-To: <Pine.LNX.4.33.0109180025320.8401-100000@ally.lammerts.org>
Message-ID: <Pine.LNX.4.33.0109182108001.10503-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Sep 2001, Eric Lammerts wrote:
>
> The following patch adds the "ip=wait" option. It makes ipconfig.c
> retry forever until is has found a suitable device to do
> dhcp/bootp/rarp.

This was a dumb patch. It didn't schedule so the USB kernel thread
could not do anything. This is fixed in the patch below. The ip=wait
parameter is gone now: it'll always wait for a net device if you're
doing nfsroot.

I've tested it with a Pegasus USB ethernet adapter and it works ok.

You can even boot the kernel without any adapter plugged in. It will
patiently wait for you to plug one in. Then it'll start the
dhcp/bootp/rarp stuff.

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

