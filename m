Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269954AbTGKNZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269955AbTGKNZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:25:53 -0400
Received: from mail.scs.ch ([212.254.229.5]:6788 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S269954AbTGKNZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:25:47 -0400
Subject: USB audio.c: make trigger semantics more OSS compliant
From: Thomas Sailer <sailer@scs.ch>
To: alan@redhat.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-3f5Kgl7CzAIo6qJZC2F7"
Organization: SCS
Message-Id: <1057930807.10684.26.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 15:40:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3f5Kgl7CzAIo6qJZC2F7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch should make USB audio trigger semantics more OSS compliant.
It is against Redhat's current 2.4 kernel, but should apply also to
other kernels as USB audio.c didn't change a lot the last year or so.

Tom


--=-3f5Kgl7CzAIo6qJZC2F7
Content-Disposition: attachment; filename=audio.c.diff
Content-Type: text/plain; name=audio.c.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- audio.c.original	2003-06-30 16:45:59.000000000 +0200
+++ audio.c	2003-06-30 17:08:26.000000000 +0200
@@ -105,6 +105,8 @@
  *              functionality. Tested and used in production with the emag=
ic emi 2|6=20
  *              on PPC and Intel. Also fixed a few logic 'crash and burn' =
corner=20
  *              cases.
+ * 2003-06-30:  Thomas Sailer
+ *              Fix SETTRIGGER non OSS API conformity
  */
=20
 /*
@@ -279,23 +281,24 @@
 	unsigned int srate;
 	/* physical buffer */
 	unsigned char *sgbuf[NRSGBUF];
-	unsigned bufsize;
-	unsigned numfrag;
-	unsigned fragshift;
-	unsigned wrptr, rdptr;
-	unsigned total_bytes;
+	unsigned int bufsize;
+	unsigned int numfrag;
+	unsigned int fragshift;
+	unsigned int wrptr, rdptr;
+	unsigned int total_bytes;
 	int count;
-	unsigned error; /* over/underrun */
+	unsigned int error; /* over/underrun */
 	wait_queue_head_t wait;
 	/* redundant, but makes calculations easier */
-	unsigned fragsize;
-	unsigned dmasize;
+	unsigned int fragsize;
+	unsigned int dmasize;
 	/* OSS stuff */
-	unsigned mapped:1;
-	unsigned ready:1;
-	unsigned ossfragshift;
+	unsigned int mapped:1;
+	unsigned int ready:1;
+	unsigned int enabled:1;
+	unsigned int ossfragshift;
 	int ossmaxfrags;
-	unsigned subdivision;
+	unsigned int subdivision;
 };
=20
 struct usb_audio_state;
@@ -562,6 +565,7 @@
 			break;
 	}
 	db->bufsize =3D nr << PAGE_SHIFT;
+	db->enabled =3D 1;
 	db->ready =3D 1;
 	dprintk((KERN_DEBUG "usbaudio: dmabuf_init bytepersec %d bufs %d ossfrags=
hift %d ossmaxfrags %d "
 	         "fragshift %d fragsize %d numfrag %d dmasize %d bufsize %d fmt 0=
x%x srate %d\n",
@@ -2299,7 +2303,7 @@
 		if (cnt > count)
 			cnt =3D count;
 		if (cnt <=3D 0) {
-			if (usbin_start(as)) {
+			if (as->usbin.dma.enabled && usbin_start(as)) {
 				if (!ret)
 					ret =3D -ENODEV;
 				break;
@@ -2332,6 +2336,11 @@
 		count -=3D cnt;
 		buffer +=3D cnt;
 		ret +=3D cnt;
+		if (as->usbin.dma.enabled && usbin_start(as)) {
+			if (!ret)
+				ret =3D -ENODEV;
+			break;
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&as->usbin.dma.wait, &wait);
@@ -2378,7 +2387,7 @@
 		if (cnt > count)
 			cnt =3D count;
 		if (cnt <=3D 0) {
-			if (usbout_start(as)) {
+			if (as->usbout.dma.enabled && usbout_start(as)) {
 				if (!ret)
 					ret =3D -ENODEV;
 				break;
@@ -2411,7 +2420,7 @@
 		count -=3D cnt;
 		buffer +=3D cnt;
 		ret +=3D cnt;
-		if (as->usbout.dma.count >=3D start_thr && usbout_start(as)) {
+		if (as->usbout.dma.enabled && as->usbout.dma.count >=3D start_thr && usb=
out_start(as)) {
 			if (!ret)
 				ret =3D -ENODEV;
 			break;
@@ -2616,19 +2625,25 @@
 			if (val & PCM_ENABLE_INPUT) {
 				if (!as->usbin.dma.ready && (ret =3D prog_dmabuf_in(as)))
 					return ret;
+				as->usbin.dma.enabled =3D 1;
 				if (usbin_start(as))
 					return -ENODEV;
-			} else
+			} else {
+				as->usbin.dma.enabled =3D 0;
 				usbin_stop(as);
+			}
 		}
 		if (file->f_mode & FMODE_WRITE) {
 			if (val & PCM_ENABLE_OUTPUT) {
 				if (!as->usbout.dma.ready && (ret =3D prog_dmabuf_out(as)))
 					return ret;
+				as->usbout.dma.enabled =3D 1;
 				if (usbout_start(as))
 					return -ENODEV;
-			} else
+			} else {
+				as->usbout.dma.enabled =3D 0;
 				usbout_stop(as);
+			}
 		}
 		return 0;
=20
@@ -2827,10 +2842,14 @@
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 	}
-	if (file->f_mode & FMODE_READ)
+	if (file->f_mode & FMODE_READ) {
 		as->usbin.dma.ossfragshift =3D as->usbin.dma.ossmaxfrags =3D as->usbin.d=
ma.subdivision =3D 0;
-	if (file->f_mode & FMODE_WRITE)
+		as->usbin.dma.enabled =3D 1;
+	}
+	if (file->f_mode & FMODE_WRITE) {
 		as->usbout.dma.ossfragshift =3D as->usbout.dma.ossmaxfrags =3D as->usbou=
t.dma.subdivision =3D 0;
+		as->usbout.dma.enabled =3D 1;
+	}
 	if (set_format(as, file->f_mode, ((minor & 0xf) =3D=3D SND_DEV_DSP16) ? A=
FMT_S16_LE : AFMT_U8 /* AFMT_ULAW */, 8000)) {
 		up(&open_sem);
 		return -EIO;

--=-3f5Kgl7CzAIo6qJZC2F7--
