Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269289AbUINLcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbUINLcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269266AbUINLbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:31:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14736 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269289AbUINLat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:30:49 -0400
Date: Tue, 14 Sep 2004 13:32:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched: fix scheduling latencies in vgacon.c
Message-ID: <20040914113215.GB2804@elte.hu>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20040914112847.GA2804@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


this patch fixes scheduling latencies in vgacon_do_font_op(). The code
is protected by vga_lock already so it's safe to drop (and re-acquire)
the BKL.

has been tested in the -VP patchset.

	Ingo

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-vgacon.patch"


this patch fixes scheduling latencies in vgacon_do_font_op(). The code
is protected by vga_lock already so it's safe to drop (and re-acquire)
the BKL.

has been tested in the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/drivers/video/console/vgacon.c.orig	
+++ linux/drivers/video/console/vgacon.c	
@@ -49,6 +49,7 @@
 #include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 #include <video/vga.h>
 #include <asm/io.h>
 
@@ -763,6 +764,7 @@ static int vgacon_do_font_op(struct vgas
 		charmap += 4 * cmapsz;
 #endif
 
+	unlock_kernel();
 	spin_lock_irq(&vga_lock);
 	/* First, the Sequencer */
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
@@ -848,6 +850,7 @@ static int vgacon_do_font_op(struct vgas
 		vga_wattr(state->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
 	}
 	spin_unlock_irq(&vga_lock);
+	lock_kernel();
 	return 0;
 }
 

--jI8keyz6grp/JLjh--
