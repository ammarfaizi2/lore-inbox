Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVHDSkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVHDSkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVHDSkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:40:41 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:39693 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262548AbVHDSkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:40:36 -0400
Date: Thu, 4 Aug 2005 14:40:25 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch 2.6.13-rc3] i810_audio: fix release_region misordering in error exit from i810_probe
Message-ID: <20050804184023.GA11137@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-order release_region calls in i810_probe to properly unwind preceding
allocations.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Calls to release_region should be in reverse order of calls to
request_region for error exit.  Whoops...

 sound/oss/i810_audio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -3430,9 +3430,9 @@ out_iospace:
 		release_mem_region(card->iobase_mmio_phys, 256);
 	}
 out_pio:	
-	release_region(card->iobase, 64);
-out_region2:
 	release_region(card->ac97base, 256);
+out_region2:
+	release_region(card->iobase, 64);
 out_region1:
 	pci_free_consistent(pci_dev, sizeof(struct i810_channel)*NR_HW_CH,
 	    card->channel, card->chandma);
-- 
John W. Linville
linville@tuxdriver.com
