Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285170AbRLMUmo>; Thu, 13 Dec 2001 15:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285168AbRLMUme>; Thu, 13 Dec 2001 15:42:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38020 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285166AbRLMUmQ>;
	Thu, 13 Dec 2001 15:42:16 -0500
Date: Thu, 13 Dec 2001 12:42:05 -0800 (PST)
Message-Id: <20011213.124205.38323630.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: that stupid aic7xxx AHC_NSEGS bug
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We simply forget to initialize scb->sg_count in the non use_sg
case, so if the previous usage of that scb has sg_count==AHC_NSEGS
then we'd hit that panic erroneously.  Here is the fix below.

"It can't possibly be my driver, something broke in some Linux
subsystem which is making my driver break", sheesh get over it
Justin...

--- drivers/scsi/aic7xxx/aic7xxx_linux.c.~1~	Fri Dec  7 22:54:31 2001
+++ drivers/scsi/aic7xxx/aic7xxx_linux.c	Thu Dec 13 12:38:30 2001
@@ -1699,6 +1699,7 @@
 			       cmd->request_buffer,
 			       cmd->request_bufflen,
 			       scsi_to_pci_dma_dir(cmd->sc_data_direction));
+			scb->sg_count = 0;
 			scb->sg_count = ahc_linux_map_seg(ahc, scb,
 							  sg, addr,
 							  cmd->request_bufflen);
