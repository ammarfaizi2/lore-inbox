Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289657AbSBKOO0>; Mon, 11 Feb 2002 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289685AbSBKOOQ>; Mon, 11 Feb 2002 09:14:16 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:6924 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S289657AbSBKOOK>;
	Mon, 11 Feb 2002 09:14:10 -0500
Message-ID: <3C67CF6E.6A086B18@yahoo.com>
Date: Mon, 11 Feb 2002 09:04:30 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: fdomain.c:1568: structure has no member named `address'
In-Reply-To: <1013398791.30864.37.camel@turbulence.megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Miles Lane wrote:

> ../fdomain.c: In function `do_fdomain_16x0_intr':
> ../fdomain.c:1568: structure has no member named `address'
> ../fdomain.c:1601: structure has no member named `address'
> ../fdomain.c: In function `fdomain_16x0_queue':
> ../fdomain.c:1687: structure has no member named `address'
> ../fdomain.c: In function `fdomain_16x0_release':
> ../fdomain.c:2046: warning: control reaches end of non-void function


Try this and let us know if it works (or if smoke and flames pour out).

Patch is against 2.5.4.

Paul.


--- drivers/scsi/fdomain.c~	Mon Feb 11 08:56:16 2002
+++ drivers/scsi/fdomain.c	Mon Feb 11 08:58:01 2002
@@ -1565,7 +1565,7 @@
 	    if (current_SC->SCp.buffers_residual) {
 	       --current_SC->SCp.buffers_residual;
 	       ++current_SC->SCp.buffer;
-	       current_SC->SCp.ptr = current_SC->SCp.buffer->address;
+	       current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
 	       current_SC->SCp.this_residual = current_SC->SCp.buffer->length;
 	    } else
 		  break;
@@ -1598,7 +1598,7 @@
 	     && current_SC->SCp.buffers_residual) {
 	    --current_SC->SCp.buffers_residual;
 	    ++current_SC->SCp.buffer;
-	    current_SC->SCp.ptr = current_SC->SCp.buffer->address;
+	    current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
 	    current_SC->SCp.this_residual = current_SC->SCp.buffer->length;
 	 }
       }
@@ -1684,7 +1684,7 @@
    if (current_SC->use_sg) {
       current_SC->SCp.buffer =
 	    (struct scatterlist *)current_SC->request_buffer;
-      current_SC->SCp.ptr              = current_SC->SCp.buffer->address;
+      current_SC->SCp.ptr              = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
       current_SC->SCp.this_residual    = current_SC->SCp.buffer->length;
       current_SC->SCp.buffers_residual = current_SC->use_sg - 1;
    } else {
@@ -2042,7 +2042,7 @@
 		free_irq(shpnt->irq, shpnt);
 	if (shpnt->io_port && shpnt->n_io_port)
 		release_region(shpnt->io_port, shpnt->n_io_port);
-
+	return 0;
 }
 
 MODULE_LICENSE("GPL");



