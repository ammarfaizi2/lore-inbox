Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWJEWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWJEWNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWJEWNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:13:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24204 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932344AbWJEWNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:13:00 -0400
Message-ID: <45258355.2030104@us.ibm.com>
Date: Thu, 05 Oct 2006 15:12:37 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] aic94xx: SATA tag mask not set correctly
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The aic94xx controller has a bitmask establishing which tags are ok to
use with a SATA NCQ disk.  When the queue depth is 32, however, the
expression that is used sets the mask to zero, not 0xFFFFFFFF.
This patch widens the width of the integer so that this case is handled
properly.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--

diff --git a/drivers/scsi/aic94xx/aic94xx_dev.c b/drivers/scsi/aic94xx/aic94xx_dev.c
index 6f8901b..b3c7d5a 100644
--- a/drivers/scsi/aic94xx/aic94xx_dev.c
+++ b/drivers/scsi/aic94xx/aic94xx_dev.c
@@ -134,7 +168,7 @@ static inline int asd_init_sata(struct d
 		if (w76 & 0x100) /* NCQ? */
 			qdepth = (w75 & 0x1F) + 1;
 		asd_ddbsite_write_dword(asd_ha, ddb, SATA_TAG_ALLOC_MASK,
-					(1<<qdepth)-1);
+					(1ULL<<qdepth)-1);
 		asd_ddbsite_write_byte(asd_ha, ddb, NUM_SATA_TAGS, qdepth);
 	}
 	if (dev->dev_type == SATA_DEV || dev->dev_type == SATA_PM ||
