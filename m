Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314239AbSESHjH>; Sun, 19 May 2002 03:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314281AbSESHjG>; Sun, 19 May 2002 03:39:06 -0400
Received: from panda.sul.com.br ([200.219.150.4]:34564 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314239AbSESHjE>;
	Sun, 19 May 2002 03:39:04 -0400
Date: Sat, 18 May 2002 22:38:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: [BKPATCH] USB: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020519013808.GF4279@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> <20020518225535.GA4101@conectiva.com.br> <20020518235418.GB4164@conectiva.com.br> <20020519001915.GA4279@conectiva.com.br> <20020519011601.GD4279@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 18, 2002 at 10:16:01PM -0300, Arnaldo C. Melo escreveu:
> 4th heads up:
> 
> USB will be on its way to Linus in some minutes, I already talked with Greg :)

Linus, Greg,

	Please consider pulling from:

http://kernel-acme.bkbits.net:8080/usb-copy_tofrom_user-2.5

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.545   -> 1.546  
#	drivers/usb/class/cdc-acm.c	1.16    -> 1.17   
#	drivers/usb/host/uhci-debug.c	1.1     -> 1.2    
#	drivers/usb/class/bluetty.c	1.21    -> 1.22   
#	drivers/usb/serial/safe_serial.c	1.1     -> 1.2    
#	drivers/usb/serial/ipaq.c	1.8     -> 1.9    
#	drivers/usb/misc/auerswald.c	1.13    -> 1.14   
#	drivers/usb/input/hiddev.c	1.12    -> 1.13   
#	drivers/usb/class/audio.c	1.18    -> 1.19   
#	drivers/usb/media/dabusb.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.546
# drivers/usr/*.c
# 
# 	- fix copy_{to,from}_user error handling (thanks to Rusty for pointing this out)
# --------------------------------------------
#
diff -Nru a/drivers/usb/class/audio.c b/drivers/usb/class/audio.c
--- a/drivers/usb/class/audio.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/class/audio.c	Sun May 19 04:33:19 2002
@@ -2542,7 +2542,9 @@
 		if (as->usbin.dma.mapped)
 			as->usbin.dma.count &= as->usbin.dma.fragsize-1;
 		spin_unlock_irqrestore(&as->lock, flags);
-		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+		if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -2554,7 +2556,9 @@
 		if (as->usbout.dma.mapped)
 			as->usbout.dma.count &= as->usbout.dma.fragsize-1;
 		spin_unlock_irqrestore(&as->lock, flags);
-		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+		if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
        case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/class/bluetty.c	Sun May 19 04:33:19 2002
@@ -490,7 +490,10 @@
 			retval = -ENOMEM;
 			goto exit;
 		}
-		copy_from_user (temp_buffer, buf, count);
+		if (copy_from_user (temp_buffer, buf, count)) {
+			retval = -EFAULT;
+			goto exit;
+		}
 		current_buffer = temp_buffer;
 	} else {
 		current_buffer = buf;
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/class/cdc-acm.c	Sun May 19 04:33:19 2002
@@ -367,9 +367,10 @@
 
 	count = (count > acm->writesize) ? acm->writesize : count;
 
-	if (from_user)
-		copy_from_user(acm->writeurb->transfer_buffer, buf, count);
-	else
+	if (from_user) {
+		if (copy_from_user(acm->writeurb->transfer_buffer, buf, count))
+			return -EFAULT;
+	} else
 		memcpy(acm->writeurb->transfer_buffer, buf, count);
 
 	acm->writeurb->transfer_buffer_length = count;
diff -Nru a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
--- a/drivers/usb/host/uhci-debug.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/host/uhci-debug.c	Sun May 19 04:33:19 2002
@@ -552,7 +552,8 @@
 	if (!access_ok(VERIFY_WRITE, buf, nbytes))
 		return -EINVAL;
 
-	copy_to_user(buf, up->data + pos, nbytes);
+	if (copy_to_user(buf, up->data + pos, nbytes))
+		return -EFAULT;
 
 	*ppos += nbytes;
 
diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/input/hiddev.c	Sun May 19 04:33:19 2002
@@ -389,7 +389,9 @@
 		dinfo.product = dev->descriptor.idProduct;
 		dinfo.version = dev->descriptor.bcdDevice;
 		dinfo.num_applications = hid->maxapplication;
-		return copy_to_user((void *) arg, &dinfo, sizeof(dinfo));
+		if (copy_to_user((void *) arg, &dinfo, sizeof(dinfo)))
+			return -EFAULT;
+		return 0;
 	}
 
 	case HIDIOCGFLAG:
@@ -480,7 +482,9 @@
 
 		rinfo.num_fields = report->maxfield;
 
-		return copy_to_user((void *) arg, &rinfo, sizeof(rinfo));
+		if (copy_to_user((void *) arg, &rinfo, sizeof(rinfo)))
+			return -EFAULT;
+		return 0;
 
 	case HIDIOCGFIELDINFO:
 	{
@@ -512,7 +516,9 @@
 		finfo.unit_exponent = field->unit_exponent;
 		finfo.unit = field->unit;
 
-		return copy_to_user((void *) arg, &finfo, sizeof(finfo));
+		if (copy_to_user((void *) arg, &finfo, sizeof(finfo)))
+			return -EFAULT;
+		return 0;
 	}
 
 	case HIDIOCGUCODE:
@@ -533,7 +539,9 @@
 
 		uref.usage_code = field->usage[uref.usage_index].hid;
 
-		return copy_to_user((void *) arg, &uref, sizeof(uref));
+		if (copy_to_user((void *) arg, &uref, sizeof(uref)))
+			return -EFAULT;
+		return 0;
 
 	case HIDIOCGUSAGE:
 	case HIDIOCSUSAGE:
@@ -564,7 +572,9 @@
 
 		if (cmd == HIDIOCGUSAGE) {
 			uref.value = field->value[uref.usage_index];
-			return copy_to_user((void *) arg, &uref, sizeof(uref));
+			if (copy_to_user((void *) arg, &uref, sizeof(uref)))
+				return -EFAULT;
+			return 0;
 		} else {
 			field->value[uref.usage_index] = uref.value;
 		}
diff -Nru a/drivers/usb/media/dabusb.c b/drivers/usb/media/dabusb.c
--- a/drivers/usb/media/dabusb.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/media/dabusb.c	Sun May 19 04:33:19 2002
@@ -680,7 +680,9 @@
 
 		ret=dabusb_bulk (s, pbulk);
 		if(ret==0)
-			ret = copy_to_user ((void *) arg, pbulk, sizeof (bulk_transfer_t));
+			if (copy_to_user((void *)arg, pbulk,
+					 sizeof(bulk_transfer_t)))
+				ret = -EFAULT;
 		kfree (pbulk);
 		break;
 
diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/misc/auerswald.c	Sun May 19 04:33:19 2002
@@ -1553,7 +1553,7 @@
 		if (u > devinfo.bsize) {
 			u = devinfo.bsize;
 		}
-		ret = copy_to_user(devinfo.buf, cp->dev_desc, u);
+		ret = copy_to_user(devinfo.buf, cp->dev_desc, u) ? -EFAULT : 0;
 		break;
 
 	/* get the max. string descriptor length */
@@ -1803,7 +1803,7 @@
 		wake_up (&cp->bufferwait);
 		up (&cp->mutex);
 		up (&ccp->mutex);
-		return -EIO;
+		return -EFAULT;
 	}
 
 	/* set the header byte */
diff -Nru a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
--- a/drivers/usb/serial/ipaq.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/serial/ipaq.c	Sun May 19 04:33:19 2002
@@ -353,7 +353,8 @@
 	}
 
 	if (from_user) {
-		copy_from_user(pkt->data, buf, count);
+		if (copy_from_user(pkt->data, buf, count))
+			return -EFAULT;
 	} else {
 		memcpy(pkt->data, buf, count);
 	}
diff -Nru a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
--- a/drivers/usb/serial/safe_serial.c	Sun May 19 04:33:19 2002
+++ b/drivers/usb/serial/safe_serial.c	Sun May 19 04:33:19 2002
@@ -319,7 +319,8 @@
 	memset (data, '0', packet_length);
 
 	if (from_user) {
-		copy_from_user (data, buf, count);
+		if (copy_from_user (data, buf, count))
+			return -EFAULT;
 	} else {
 		memcpy (data, buf, count);
 	}
