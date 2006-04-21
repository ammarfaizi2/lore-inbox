Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWDUEpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWDUEpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWDUEos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:58753 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932237AbWDUEoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:09 -0400
Date: Thu, 20 Apr 2006 21:37:34 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adam Radford <linuxraid@amcc.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/22] 3ware 9000 disable local irqs during kmap_atomic
Message-ID: <20060421043734.GC12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="3ware-9000-disable-local-irqs-during-kmap_atomic.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch for 2.6.17-rc2 updates the 3ware 9000 driver:

- Disable local interrupts during kmap/unmap_atomic().

Signed-off-by: Adam Radford <linuxraid@amcc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/3w-9xxx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.16.9.orig/drivers/scsi/3w-9xxx.c
+++ linux-2.6.16.9/drivers/scsi/3w-9xxx.c
@@ -85,7 +85,7 @@
 #include "3w-9xxx.h"
 
 /* Globals */
-#define TW_DRIVER_VERSION "2.26.02.005"
+#define TW_DRIVER_VERSION "2.26.02.007"
 static TW_Device_Extension *twa_device_extension_list[TW_MAX_SLOT];
 static unsigned int twa_device_extension_count;
 static int twa_major = -1;
@@ -1944,9 +1944,13 @@ static void twa_scsiop_execute_scsi_comp
 		}
 		if (tw_dev->srb[request_id]->use_sg == 1) {
 			struct scatterlist *sg = (struct scatterlist *)tw_dev->srb[request_id]->request_buffer;
-			char *buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+			char *buf;
+			unsigned long flags = 0;
+			local_irq_save(flags);
+			buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 			memcpy(buf, tw_dev->generic_buffer_virt[request_id], sg->length);
 			kunmap_atomic(buf - sg->offset, KM_IRQ0);
+			local_irq_restore(flags);
 		}
 	}
 } /* End twa_scsiop_execute_scsi_complete() */

--
