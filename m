Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVEZHSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEZHSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEZHSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:18:32 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:23786 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261232AbVEZHS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:18:29 -0400
Date: Thu, 26 May 2005 17:18:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
       axboe@suse.de
Subject: [PATCH] ppc64 iSeries: make virtual DVD-RAMs writable again
Message-Id: <20050526171806.2a996350.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

It appears that another test has been added in the Uniform CDROM layer
that must be passed before a DVD-RAM is considered wrieable.  This patch
implements an emulation of the needed packet command for the viocd driver.

Signed-off-by:  Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/drivers/cdrom/viocd.c linus-viocd.dvd/drivers/cdrom/viocd.c
--- linus/drivers/cdrom/viocd.c	2005-05-20 09:03:44.000000000 +1000
+++ linus-viocd.dvd/drivers/cdrom/viocd.c	2005-05-13 16:00:10.000000000 +1000
@@ -488,6 +488,20 @@ static int viocd_packet(struct cdrom_dev
 					 & (CDC_DVD_RAM | CDC_RAM)) != 0;
 		}
 		break;
+	case GPCMD_GET_CONFIGURATION:
+		if (cgc->cmd[3] == CDF_RWRT) {
+			struct rwrt_feature_desc *rfd = (struct rwrt_feature_desc *)(cgc->buffer + sizeof(struct feature_header));
+
+			if ((buflen >=
+			     (sizeof(struct feature_header) + sizeof(*rfd))) &&
+			    (cdi->ops->capability & ~cdi->mask
+			     & (CDC_DVD_RAM | CDC_RAM))) {
+				rfd->feature_code = cpu_to_be16(CDF_RWRT);
+				rfd->curr = 1;
+				ret = 0;
+			}
+		}
+		break;
 	default:
 		if (cgc->sense) {
 			/* indicate Unknown code */
