Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSHXJx2>; Sat, 24 Aug 2002 05:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSHXJx1>; Sat, 24 Aug 2002 05:53:27 -0400
Received: from ns2.sea.interquest.net ([66.135.144.2]:36524 "EHLO ns2.sea")
	by vger.kernel.org with ESMTP id <S315457AbSHXJx0>;
	Sat, 24 Aug 2002 05:53:26 -0400
Date: Sat, 24 Aug 2002 03:03:19 -0700
From: silvio@qualys.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL]: 2.4.19/drivers/acorn/block/fd1772.c
Message-ID: <20020824030319.A1616@hamsec.aurora.sfo.interquest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trivial patch to add check on kmalloc

--
Silvio

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.linux1"

--- linux-2.4.19/drivers/acorn/block/fd1772.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.19-dev/drivers/acorn/block/fd1772.c	Sat Aug 24 02:38:49 2002
@@ -1567,6 +1567,7 @@
 
 int fd1772_init(void)
 {
+	int err;
 	int i;
 
 	if (!machine_is_archimedes())
@@ -1584,24 +1585,28 @@
 
 	if (request_dma(FIQ_FD1772, "fd1772 end")) {
 		printk("Unable to grab DMA%d for the floppy (1772) driver\n", FIQ_FD1772);
-		free_dma(FLOPPY_DMA);
-		return 1;
+		err = 1; /* XXX */
+		goto cleanup_dma;
 	};
-	enable_dma(FIQ_FD1772);	/* This inserts a call to our command end routine */
 
 	/* initialize variables */
+	err = -ENOMEM;
 	SelectedDrive = -1;
 #ifdef TRACKBUFFER
 	BufferDrive = BufferSide = BufferTrack = -1;
 	/* Atari uses 512 - I want to eventually cope with 1K sectors */
 	DMABuffer = (char *)kmalloc((FD1772_MAX_SECTORS+1)*512,GFP_KERNEL);
+	if (DMABuffer == NULL)
+		goto cleanup_dma;
 	TrackBuffer = DMABuffer + 512;
 #else
 	/* Allocate memory for the DMAbuffer - on the Atari this takes it
 	   out of some special memory... */
 	DMABuffer = (char *) kmalloc(2048);	/* Copes with pretty large sectors */
+	if (DMABuffer == NULL)
+		goto cleanup_dma;
 #endif
-
+	enable_dma(FIQ_FD1772);	/* This inserts a call to our command end routine */
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 	}
@@ -1619,4 +1624,7 @@
 	config_types();
 
 	return 0;
+cleanup_dma:
+	free_dma(FLOPPY_DMA);
+	return err;
 }

--BXVAT5kNtrzKuDFl--
