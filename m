Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTADPFk>; Sat, 4 Jan 2003 10:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbTADPFk>; Sat, 4 Jan 2003 10:05:40 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56548 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266948AbTADPFh>; Sat, 4 Jan 2003 10:05:37 -0500
Date: Sat, 4 Jan 2003 16:14:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, claus@momo.math.rwth-aachen.de,
       linux-tape@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [2.5 patch] re-add zft_dirty to zftape-ctl.c
Message-ID: <20030104151404.GX6114@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

your

  [PATCH] rescue ftape from the ravages of that Rusty chap

removed zft_dirty from zftape-ctl.c in Linus' 2.5 tree. This seems to be
accidentially and wrong, it was the only definition of zft_dirty in the
whole kernel sources and now there's an error at the final linking of
the kernel. The patch below (against 2.5.54) re-adds it.

cu
Adrian

--- linux/drivers/char/ftape/zftape/zftape-ctl.c	2003-01-02 04:21:44.000000000 +0100
+++ linux/drivers/char/ftape/zftape/zftape-ctl.c	2000-10-16 21:58:51.000000000 +0200
@@ -648,6 +648,50 @@
 	TRACE_EXIT 0;
 }
 
+/*  decide when we should lock the module in memory, even when calling
+ *  the release routine. This really is necessary for use with
+ *  kerneld.
+ *
+ *  NOTE: we MUST NOT use zft_write_protected, because this includes
+ *  the file access mode as well which has no meaning with our 
+ *  asynchronous update scheme.
+ *
+ *  Ugly, ugly. We need to look the module if we changed the block size.
+ *  How sad! Need persistent modules storage!
+ *
+ *  NOTE: I don't want to lock the module if the number of dma buffers 
+ *  has been changed. It's enough! Stop the story! Give me persisitent
+ *  module storage! Do it!
+ */
+int zft_dirty(void)
+{
+	if (!ft_formatted || zft_offline) { 
+		/* cannot be dirty if not formatted or offline */
+		return 0;
+	}
+	if (zft_blk_sz != CONFIG_ZFT_DFLT_BLK_SZ) {
+		/* blocksize changed, must lock */
+		return 1;
+	}
+	if (zft_mt_compression != 0) {
+		/* compression mode with /dev/qft, must lock */
+		return 1;
+	}
+	if (!zft_header_read) {
+		/* tape is logical at BOT, no lock */
+		return 0;
+	}
+	if (!zft_tape_at_lbot(&zft_pos)) {
+		/* somewhere inside a volume, lock tape */
+		return 1;
+	}
+	if (zft_volume_table_changed || zft_header_changed) {
+		/* header segments dirty if tape not write protected */
+		return !(ft_write_protected || zft_old_ftape);
+	}
+	return 0;
+}
+
 /*      OPEN routine called by kernel-interface code
  *
  *      NOTE: this is also called by mt_reset() with dev_minor == -1
