Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbUJYITI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUJYITI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUJYITI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:19:08 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:46796 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261678AbUJYHfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:35:39 -0400
Date: Mon, 25 Oct 2004 17:35:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] iSeries console: cleanup after tty_write user copies
 removal
Message-Id: <20041025173524.43932e3e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__25_Oct_2004_17_35_24_+1000_B12iLCj5s.Z48zzM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__25_Oct_2004_17_35_24_+1000_B12iLCj5s.Z48zzM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch just removes more of the infrastructure in the PPC64 iSeries
console driver that is no longer needed since we no longer need to do
copies from user mode in the tty drivers.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.10-rc1-bk2/drivers/char/viocons.c 2.6.10-rc1-bk2-viocons.1/drivers/char/viocons.c
--- 2.6.10-rc1-bk2/drivers/char/viocons.c	2004-10-25 15:37:13.000000000 +1000
+++ 2.6.10-rc1-bk2-viocons.1/drivers/char/viocons.c	2004-10-25 17:03:17.000000000 +1000
@@ -83,15 +83,6 @@
 	u8 data[VIOCHAR_MAX_DATA];
 };
 
-/*
- * This is a place where we handle the distribution of memory
- * for copy_from_user() calls.  The buffer_available array is to
- * help us determine which buffer to use.
- */
-#define VIOCHAR_NUM_CFU_BUFFERS	7
-static struct viocharlpevent viocons_cfu_buffer[VIOCHAR_NUM_CFU_BUFFERS];
-static atomic_t viocons_cfu_buffer_available[VIOCHAR_NUM_CFU_BUFFERS];
-
 #define VIOCHAR_WINDOW		10
 #define VIOCHAR_HIGHWATERMARK	3
 
@@ -207,50 +198,6 @@
 }
 
 /*
- * This function should ONLY be called once from viocons_init2
- */
-static void viocons_init_cfu_buffer(void)
-{
-	int i;
-
-	for (i = 1; i < VIOCHAR_NUM_CFU_BUFFERS; i++)
-		atomic_set(&viocons_cfu_buffer_available[i], 1);
-}
-
-static struct viocharlpevent *viocons_get_cfu_buffer(void)
-{
-	int i;
-
-	/*
-	 * Grab the first available buffer.  It doesn't matter if we
-	 * are interrupted during this array traversal as long as we
-	 * get an available space.
-	 */
-	for (i = 0; i < VIOCHAR_NUM_CFU_BUFFERS; i++)
-		if (atomic_dec_if_positive(&viocons_cfu_buffer_available[i])
-				== 0 )
-			return &viocons_cfu_buffer[i];
-	hvlog("\n\rviocons: viocons_get_cfu_buffer : no free buffers found");
-	return NULL;
-}
-
-static void viocons_free_cfu_buffer(struct viocharlpevent *buffer)
-{
-	int i;
-
-	i = buffer - &viocons_cfu_buffer[0];
-	if (i >= (sizeof(viocons_cfu_buffer) / sizeof(viocons_cfu_buffer[0]))) {
-		hvlog("\n\rviocons: viocons_free_cfu_buffer : buffer pointer not found in list.");
-		return;
-	}
-	if (atomic_read(&viocons_cfu_buffer_available[i]) != 0) {
-		hvlog("\n\rviocons: WARNING : returning unallocated cfu buffer.");
-		return;
-	}
-	atomic_set(&viocons_cfu_buffer_available[i], 1);
-}
-
-/*
  * Add data to our pending-send buffers.  
  *
  * NOTE: Don't use printk in here because it gets nastily recursive.
@@ -438,15 +385,14 @@
  * NOTE: Don't use printk in here because it gets nastily recursive.  hvlog
  * can be used to log to the hypervisor buffer
  */
-static int internal_write(struct port_info *pi, const char *buf,
-			  size_t len, struct viocharlpevent *viochar)
+static int internal_write(struct port_info *pi, const char *buf, size_t len)
 {
 	HvLpEvent_Rc hvrc;
 	size_t bleft;
 	size_t curlen;
 	const char *curbuf;
 	unsigned long flags;
-	int copy_needed = (viochar == NULL);
+	struct viocharlpevent *viochar;
 
 	/*
 	 * Write to the hvlog of inbound data are now done prior to
@@ -462,25 +408,13 @@
 
 	spin_lock_irqsave(&consolelock, flags);
 
-	/*
-	 * If the internal_write() was passed a pointer to a
-	 * viocharlpevent then we don't need to allocate a new one
-	 * (this is the case where we are internal_writing user space
-	 * data).  If we aren't writing user space data then we need
-	 * to get an event from viopath.
-	 */
-	if (copy_needed) {
-		/* This one is fetched from the viopath data structure */
-		viochar = (struct viocharlpevent *)
-			vio_get_event_buffer(viomajorsubtype_chario);
-		/* Make sure we got a buffer */
-		if (viochar == NULL) {
-			spin_unlock_irqrestore(&consolelock, flags);
-			hvlog("\n\rviocons: Can't get viochar buffer in internal_write().");
-			return -EAGAIN;
-		}
-		initDataEvent(viochar, pi->lp);
+	viochar = vio_get_event_buffer(viomajorsubtype_chario);
+	if (viochar == NULL) {
+		spin_unlock_irqrestore(&consolelock, flags);
+		hvlog("\n\rviocons: Can't get vio buffer in internal_write().");
+		return -EAGAIN;
 	}
+	initDataEvent(viochar, pi->lp);
 
 	curbuf = buf;
 	bleft = len;
@@ -493,25 +427,16 @@
 			curlen = bleft;
 
 		viochar->event.xCorrelationToken = pi->seq++;
-
-		if (copy_needed) {
-			memcpy(viochar->data, curbuf, curlen);
-			viochar->len = curlen;
-		}
-
+		memcpy(viochar->data, curbuf, curlen);
+		viochar->len = curlen;
 		viochar->event.xSizeMinus1 =
 		    offsetof(struct viocharlpevent, data) + curlen;
 
 		hvrc = HvCallEvent_signalLpEvent(&viochar->event);
 		if (hvrc) {
-			spin_unlock_irqrestore(&consolelock, flags);
-			if (copy_needed)
-				vio_free_event_buffer(viomajorsubtype_chario, viochar);
-
 			hvlog("viocons: error sending event! %d\n", (int)hvrc);
-			return len - bleft;
+			goto out;
 		}
-
 		curbuf += curlen;
 		bleft -= curlen;
 	}
@@ -519,14 +444,9 @@
 	/* If we didn't send it all, buffer as much of it as we can. */
 	if (bleft > 0)
 		bleft -= buffer_add(pi, curbuf, bleft);
-	/*
-	 * Since we grabbed it from the viopath data structure, return
-	 * it to the data structure.
-	 */
-	if (copy_needed)
-		vio_free_event_buffer(viomajorsubtype_chario, viochar);
+out:
+	vio_free_event_buffer(viomajorsubtype_chario, viochar);
 	spin_unlock_irqrestore(&consolelock, flags);
-
 	return len - bleft;
 }
 
@@ -603,18 +523,8 @@
 
 	hvlogOutput(s, count);
 
-	if (!viopath_isactive(pi->lp)) {
-		/*
-		 * This is a VERY noisy trace message in the case where the
-		 * path manager is not active or in the case where this
-		 * function is called prior to viocons initialization.  It is
-		 * being commented out for the sake of a clear trace buffer.
-		 */
-#if 0
-		 hvlog("\n\rviocons_write: path not active to lp %d", pi->lp);
-#endif
+	if (!viopath_isactive(pi->lp))
 		return;
-	}
 
 	/* 
 	 * Any newline character found will cause a
@@ -627,17 +537,16 @@
 			 * Newline found. Print everything up to and 
 			 * including the newline
 			 */
-			internal_write(pi, &s[begin], index - begin + 1,
-					NULL);
+			internal_write(pi, &s[begin], index - begin + 1);
 			begin = index + 1;
 			/* Emit a carriage return as well */
-			internal_write(pi, &cr, 1, NULL);
+			internal_write(pi, &cr, 1);
 		}
 	}
 
 	/* If any characters left to write, write them now */
 	if ((index - begin) > 0)
-		internal_write(pi, &s[begin], index - begin, NULL);
+		internal_write(pi, &s[begin], index - begin);
 }
 
 /*
@@ -721,11 +630,9 @@
 /*
  * TTY Write method
  */
-static int viotty_write(struct tty_struct *tty,
-			const unsigned char *buf, int count)
+static int viotty_write(struct tty_struct *tty, const unsigned char *buf,
+		int count)
 {
-	int ret;
-	int total = 0;
 	struct port_info *pi;
 
 	pi = get_port_data(tty);
@@ -746,16 +653,10 @@
 	 * viotty_write call and, since the viopath isn't active to this
 	 * partition, return count.
 	 */
-	if (!viopath_isactive(pi->lp)) {
-		/* Noisy trace.  Commented unless needed. */
-#if 0
-		 hvlog("\n\rviotty_write: viopath NOT active for lp %d.",pi->lp);
-#endif
+	if (!viopath_isactive(pi->lp))
 		return count;
-	}
 
-	total = internal_write(pi, buf, count, NULL);
-	return total;
+	return internal_write(pi, buf, count);
 }
 
 /*
@@ -774,7 +675,7 @@
 		hvlogOutput(&ch, 1);
 
 	if (viopath_isactive(pi->lp))
-		internal_write(pi, &ch, 1, NULL);
+		internal_write(pi, &ch, 1);
 }
 
 /*
@@ -1270,8 +1171,6 @@
 		viotty_driver = NULL;
 	}
 
-	viocons_init_cfu_buffer();
-
 	unregister_console(&viocons_early);
 	register_console(&viocons);
 

--Signature=_Mon__25_Oct_2004_17_35_24_+1000_B12iLCj5s.Z48zzM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBfKzB4CJfqux9a+8RAiOxAJ9o6O9SWD/ZZzy3rBZcVoMqyWWdxACfUa/S
tk6qC+jeypdy2U5qH6CHC7o=
=8iF8
-----END PGP SIGNATURE-----

--Signature=_Mon__25_Oct_2004_17_35_24_+1000_B12iLCj5s.Z48zzM--
