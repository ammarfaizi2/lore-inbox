Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273732AbRIQWnD>; Mon, 17 Sep 2001 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273737AbRIQWmo>; Mon, 17 Sep 2001 18:42:44 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:49378 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S273740AbRIQWk5>;
	Mon, 17 Sep 2001 18:40:57 -0400
Date: Tue, 18 Sep 2001 00:41:19 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: David Acklam <dackl@post.com>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: compiled-in (non-modular) USB initialization bug
In-Reply-To: <Pine.LNX.4.30.0109171430130.3275-100000@udcnet.dyn.dhs.org>
Message-ID: <Pine.LNX.4.33.0109180025320.8401-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, David Acklam wrote:
> A few months ago I posted a bug report about the Pegasus driver not
> initializing  (or not initializing fast enough to work with NFS-Root) when
> compiled-in. I've found that this is not specific to the
> pegasus, as I have recently noticed that the kernel 'driver-initialized'
> messages for my USB mouse and keyboard (i.e. HID devices) come up AFTER
> init has been started. These drivers are also 'compiled-in'
>
> The problem this poses is that some applications (like NFSRoot) need
> access to USB devices BEFORE the kernel mounts filesystems/starts init.

I had the same problem a while ago. I haven't really looked into the
usb code, but it appears USB devices are detected from a kernel
thread, i.e., asynchronously. When the USB thread has discovered the
device, the dhcp/bootp code has already failed.

The following patch adds the "ip=wait" option. It makes ipconfig.c
retry forever until is has found a suitable device to do
dhcp/bootp/rarp.

This is untested! (I don't have a USB netdevice at home). But at least
it boots ok with a PCI network card (and waits forever if I remove
support for that card from the kernel).

Of course, in the long run, a better solution is an initrd with
dhcp/bootp/rarp client in userspace. But AFAIK there is no Debian
package that does that yet ;-).

Eric


--- linux-2.4.9-ac7/net/ipv4/ipconfig.c.orig	Wed May  2 05:59:24 2001
+++ linux-2.4.9-ac7/net/ipv4/ipconfig.c	Tue Sep 18 00:19:03 2001
@@ -102,6 +102,8 @@

 int ic_enable __initdata = 0;			/* IP config enabled? */

+int ic_wait __initdata = 0;			/* wait until a device appears? */
+
 /* Protocol choice */
 int ic_proto_enabled __initdata = 0
 #ifdef IPCONFIG_BOOTP
@@ -1105,8 +1107,12 @@
 		;

 	/* Setup all network devices */
-	if (ic_open_devs() < 0)
-		return -1;
+	if (ic_open_devs() < 0) {
+		if(!ic_wait) return -1;
+
+		printk("IP-Config: Retrying forever...\n");
+		goto try_try_again;		// wait a while and try again
+	}

 	/* Give drivers a chance to settle */
 	jiff = jiffies + CONF_POST_OPEN;
@@ -1281,6 +1287,8 @@
 		(strcmp(addrs, "none") != 0));
 	if (!ic_enable)
 		return 1;
+
+	ic_wait = *addrs && (strcmp(addrs, "wait") == 0);

 	if (ic_proto_name(addrs))
 		return 1;

