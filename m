Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313644AbSDPJNy>; Tue, 16 Apr 2002 05:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313645AbSDPJNx>; Tue, 16 Apr 2002 05:13:53 -0400
Received: from slip-202-135-75-110.ca.au.prserv.net ([202.135.75.110]:22156
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313644AbSDPJNv>; Tue, 16 Apr 2002 05:13:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk, sailer@ife.ee.ethz.ch, bhards@bigpond.net.au,
        greg@kroah.com, torvalds@transmeta.com
Subject: [PATCH] USB set-bit takes a long tweaks
Date: Tue, 16 Apr 2002 19:16:01 +1000
Message-Id: <E16xP4X-0005OC-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes gratuitous & operators in front of USB's
dev->bus->devmap.devicemap and state->unitbitmap, for bitops.

This just makes it so it doesn't warn when set_bit et. al take a
long...

No object code changes,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre3/drivers/usb/class/audio.c tmp/drivers/usb/class/audio.c
--- linux-2.5.8-pre3/drivers/usb/class/audio.c	Wed Apr 10 21:47:50 2002
+++ tmp/drivers/usb/class/audio.c	Wed Apr 10 23:25:34 2002
@@ -3523,7 +3523,7 @@
 	unsigned char *p1;
 	unsigned int i, j;
 
-	if (test_and_set_bit(unitid, &state->unitbitmap)) {
+	if (test_and_set_bit(unitid, state->unitbitmap)) {
 		printk(KERN_INFO "usbaudio: mixer path revisits unit %d\n", unitid);
 		return;
 	}
@@ -3613,7 +3613,7 @@
 	state.buffer = buffer;
 	state.buflen = buflen;
 	state.ctrlif = ctrlif;
-	set_bit(oterm[3], &state.unitbitmap);  /* mark terminal ID as visited */
+	set_bit(oterm[3], state.unitbitmap);  /* mark terminal ID as visited */
 	printk(KERN_DEBUG "usbaudio: constructing mixer for Terminal %u type 0x%04x\n",
 	       oterm[3], oterm[4] | (oterm[5] << 8));
 	usb_audio_recurseunit(&state, oterm[7]);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre3/drivers/usb/core/hub.c tmp/drivers/usb/core/hub.c
--- linux-2.5.8-pre3/drivers/usb/core/hub.c	Wed Apr 10 21:47:50 2002
+++ tmp/drivers/usb/core/hub.c	Wed Apr 10 23:24:06 2002
@@ -1122,7 +1122,7 @@
 					dev->devpath,
 					sizeof(dev->descriptor), ret);
         
-			clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+			clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 			dev->devnum = -1;
 			return -EIO;
 		}
@@ -1131,7 +1131,7 @@
 		if (ret < 0) {
 			err("unable to get configuration (error=%d)", ret);
 			usb_destroy_configuration(dev);
-			clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+			clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 			dev->devnum = -1;
 			return 1;
 		}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre3/drivers/usb/core/usb.c tmp/drivers/usb/core/usb.c
--- linux-2.5.8-pre3/drivers/usb/core/usb.c	Wed Apr 10 21:47:50 2002
+++ tmp/drivers/usb/core/usb.c	Wed Apr 10 23:23:10 2002
@@ -1784,7 +1784,7 @@
 
 	/* Free the device number and remove the /proc/bus/usb entry */
 	if (dev->devnum > 0) {
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		usbfs_remove_device(dev);
 		put_device(&dev->dev);
 	}
@@ -2484,7 +2484,7 @@
 	if (err < 0) {
 		err("USB device not accepting new address=%d (error=%d)",
 			dev->devnum, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2497,7 +2497,7 @@
 			err("USB device not responding, giving up (error=%d)", err);
 		else
 			err("USB device descriptor short read (expected %i, got %i)", 8, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2512,7 +2512,7 @@
 			err("USB device descriptor short read (expected %Zi, got %i)",
 				sizeof(dev->descriptor), err);
 	
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2521,7 +2521,7 @@
 	if (err < 0) {
 		err("unable to get device %d configuration (error=%d)",
 			dev->devnum, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2531,7 +2531,7 @@
 	if (err) {
 		err("failed to set device %d default configuration (error=%d)",
 			dev->devnum, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
