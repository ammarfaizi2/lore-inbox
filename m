Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUIMDt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUIMDt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUIMDt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:49:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265195AbUIMDtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:49:47 -0400
Date: Sun, 12 Sep 2004 20:49:24 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, drivers@neukum.org, marcelo.tosatti@cyclades.com,
       sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH][2.4.28-pre3] USB drivers gcc-3.4 fixes
Message-Id: <20040912204924.4a2cd872@lembas.zaitcev.lan>
In-Reply-To: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
References: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about this now?

-- Pete

diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/audio.c linux-2.4.28-pre3-usb/drivers/usb/audio.c
--- linux-2.4.28-pre3/drivers/usb/audio.c	2004-08-24 12:38:50.000000000 -0700
+++ linux-2.4.28-pre3-usb/drivers/usb/audio.c	2004-09-12 17:49:35.000000000 -0700
@@ -593,9 +593,10 @@ static int dmabuf_mmap(struct dmabuf *db
 	return 0;
 }
 
-static void dmabuf_copyin(struct dmabuf *db, const void *buffer, unsigned int size)
+static void dmabuf_copyin(struct dmabuf *db, const void *_buffer, unsigned int size)
 {
 	unsigned int pgrem, rem;
+	const char *buffer = _buffer;
 
 	db->total_bytes += size;
 	for (;;) {
@@ -609,16 +610,17 @@ static void dmabuf_copyin(struct dmabuf 
 			pgrem = rem;
 		memcpy((db->sgbuf[db->wrptr >> PAGE_SHIFT]) + (db->wrptr & (PAGE_SIZE-1)), buffer, pgrem);
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		db->wrptr += pgrem;
 		if (db->wrptr >= db->dmasize)
 			db->wrptr = 0;
 	}
 }
 
-static void dmabuf_copyout(struct dmabuf *db, void *buffer, unsigned int size)
+static void dmabuf_copyout(struct dmabuf *db, void *_buffer, unsigned int size)
 {
 	unsigned int pgrem, rem;
+	char *buffer = _buffer;
 
 	db->total_bytes += size;
 	for (;;) {
@@ -632,16 +634,17 @@ static void dmabuf_copyout(struct dmabuf
 			pgrem = rem;
 		memcpy(buffer, (db->sgbuf[db->rdptr >> PAGE_SHIFT]) + (db->rdptr & (PAGE_SIZE-1)), pgrem);
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		db->rdptr += pgrem;
 		if (db->rdptr >= db->dmasize)
 			db->rdptr = 0;
 	}
 }
 
-static int dmabuf_copyin_user(struct dmabuf *db, unsigned int ptr, const void *buffer, unsigned int size)
+static int dmabuf_copyin_user(struct dmabuf *db, unsigned int ptr, const void *_buffer, unsigned int size)
 {
 	unsigned int pgrem, rem;
+	const char *buffer = _buffer;
 
 	if (!db->ready || db->mapped)
 		return -EINVAL;
@@ -657,16 +660,17 @@ static int dmabuf_copyin_user(struct dma
 		if (copy_from_user((db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & (PAGE_SIZE-1)), buffer, pgrem))
 			return -EFAULT;
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		ptr += pgrem;
 		if (ptr >= db->dmasize)
 			ptr = 0;
 	}
 }
 
-static int dmabuf_copyout_user(struct dmabuf *db, unsigned int ptr, void *buffer, unsigned int size)
+static int dmabuf_copyout_user(struct dmabuf *db, unsigned int ptr, void *_buffer, unsigned int size)
 {
 	unsigned int pgrem, rem;
+	char *buffer = _buffer;
 
 	if (!db->ready || db->mapped)
 		return -EINVAL;
@@ -682,7 +686,7 @@ static int dmabuf_copyout_user(struct dm
 		if (copy_to_user(buffer, (db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & (PAGE_SIZE-1)), pgrem))
 			return -EFAULT;
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		ptr += pgrem;
 		if (ptr >= db->dmasize)
 			ptr = 0;
diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/hpusbscsi.c linux-2.4.28-pre3-usb/drivers/usb/hpusbscsi.c
--- linux-2.4.28-pre3/drivers/usb/hpusbscsi.c	2003-06-13 07:51:36.000000000 -0700
+++ linux-2.4.28-pre3-usb/drivers/usb/hpusbscsi.c	2004-09-12 17:23:57.000000000 -0700
@@ -182,7 +182,7 @@ hpusbscsi_usb_probe (struct usb_device *
 
 	memcpy (&(new->ctempl), &hpusbscsi_scsi_host_template,
 		sizeof (hpusbscsi_scsi_host_template));
-	(struct hpusbscsi *) new->ctempl.proc_dir = new;
+	new->ctempl.proc_dir = (void *) new;
 	new->ctempl.module = THIS_MODULE;
 
 	if (scsi_register_module (MODULE_SCSI_HA, &(new->ctempl)))
diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/microtek.c linux-2.4.28-pre3-usb/drivers/usb/microtek.c
--- linux-2.4.28-pre3/drivers/usb/microtek.c	2002-11-28 15:53:14.000000000 -0800
+++ linux-2.4.28-pre3-usb/drivers/usb/microtek.c	2004-09-12 17:23:58.000000000 -0700
@@ -987,7 +987,7 @@ static void * mts_usb_probe (struct usb_
 	/* Initialize the host template based on the default one */
 	memcpy(&(new_desc->ctempl), &mts_scsi_host_template, sizeof(mts_scsi_host_template));
 	/* HACK from usb-storage - this is needed for scsi detection */
-	(struct mts_desc *)new_desc->ctempl.proc_dir = new_desc; /* FIXME */
+	new_desc->ctempl.proc_dir = (void *)new_desc; /* FIXME */
 
 	MTS_DEBUG("registering SCSI module\n");
 
diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/uss720.c linux-2.4.28-pre3-usb/drivers/usb/uss720.c
--- linux-2.4.28-pre3/drivers/usb/uss720.c	2001-10-20 19:13:11.000000000 -0700
+++ linux-2.4.28-pre3-usb/drivers/usb/uss720.c	2004-09-12 20:48:13.000000000 -0700
@@ -327,13 +327,14 @@ static size_t parport_uss720_epp_read_da
 {
 	struct parport_uss720_private *priv = pp->private_data;	
 	size_t got = 0;
+	char *buff = buf;
 
 	if (change_mode(pp, ECR_EPP))
 		return 0;
 	for (; got < length; got++) {
-		if (get_1284_register(pp, 4, (char *)buf))
+		if (get_1284_register(pp, 4, buff))
 			break;
-		((char*)buf)++;
+		buff++;
 		if (priv->reg[0] & 0x01) {
 			clear_epp_timeout(pp);
 			break;
@@ -348,13 +349,14 @@ static size_t parport_uss720_epp_write_d
 #if 0
 	struct parport_uss720_private *priv = pp->private_data;	
 	size_t written = 0;
+	const char *buff = buf;
 
 	if (change_mode(pp, ECR_EPP))
 		return 0;
 	for (; written < length; written++) {
-		if (set_1284_register(pp, 4, (char *)buf))
+		if (set_1284_register(pp, 4, *buff))
 			break;
-		((char*)buf)++;
+		buff++;
 		if (get_1284_register(pp, 1, NULL))
 			break;
 		if (priv->reg[0] & 0x01) {
@@ -386,13 +388,14 @@ static size_t parport_uss720_epp_read_ad
 {
 	struct parport_uss720_private *priv = pp->private_data;	
 	size_t got = 0;
+	char *buff = buf;
 
 	if (change_mode(pp, ECR_EPP))
 		return 0;
 	for (; got < length; got++) {
-		if (get_1284_register(pp, 3, (char *)buf))
+		if (get_1284_register(pp, 3, buff))
 			break;
-		((char*)buf)++;
+		buff++;
 		if (priv->reg[0] & 0x01) {
 			clear_epp_timeout(pp);
 			break;
@@ -406,13 +409,14 @@ static size_t parport_uss720_epp_write_a
 {
 	struct parport_uss720_private *priv = pp->private_data;	
 	size_t written = 0;
+	const char *buff = buf;
 
 	if (change_mode(pp, ECR_EPP))
 		return 0;
 	for (; written < length; written++) {
-		if (set_1284_register(pp, 3, *(char *)buf))
+		if (set_1284_register(pp, 3, *buff))
 			break;
-		((char*)buf)++;
+		buff++;
 		if (get_1284_register(pp, 1, NULL))
 			break;
 		if (priv->reg[0] & 0x01) {
@@ -463,13 +467,14 @@ static size_t parport_uss720_ecp_read_da
 static size_t parport_uss720_ecp_write_addr(struct parport *pp, const void *buffer, size_t len, int flags)
 {
 	size_t written = 0;
+	const char *buff = buffer;
 
 	if (change_mode(pp, ECR_ECP))
 		return 0;
 	for (; written < len; written++) {
-		if (set_1284_register(pp, 5, *(char *)buffer))
+		if (set_1284_register(pp, 5, *buff))
 			break;
-		((char*)buffer)++;
+		buff++;
 	}
 	change_mode(pp, ECR_PS2);
 	return written;
