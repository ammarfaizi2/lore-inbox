Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWDUEpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWDUEpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWDUEou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:55425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932234AbWDUEoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:07 -0400
Date: Thu, 20 Apr 2006 21:37:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       James Bottomley <James.Bottomley@SteelEye.com>, linuxraid@amcc.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/22] 3ware: kmap_atomic() fix
Message-ID: <20060421043727.GB12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="3ware-kmap_atomic-fix.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

We must disable local IRQs while holding KM_IRQ0 or KM_IRQ1.  Otherwise, an
IRQ handler could use those kmap slots while this code is using them,
resulting in memory corruption.

Thanks to Nick Orlov <bugfixer@list.ru> for reporting.

Cc: <linuxraid@amcc.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/3w-xxxx.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.16.9.orig/drivers/scsi/3w-xxxx.c
+++ linux-2.6.16.9/drivers/scsi/3w-xxxx.c
@@ -1508,10 +1508,12 @@ static void tw_transfer_internal(TW_Devi
 	struct scsi_cmnd *cmd = tw_dev->srb[request_id];
 	void *buf;
 	unsigned int transfer_len;
+	unsigned long flags = 0;
 
 	if (cmd->use_sg) {
 		struct scatterlist *sg =
 			(struct scatterlist *)cmd->request_buffer;
+		local_irq_save(flags);
 		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 		transfer_len = min(sg->length, len);
 	} else {
@@ -1526,6 +1528,7 @@ static void tw_transfer_internal(TW_Devi
 
 		sg = (struct scatterlist *)cmd->request_buffer;
 		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+		local_irq_restore(flags);
 	}
 }
 

--
