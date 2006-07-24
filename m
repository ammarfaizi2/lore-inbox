Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWGXRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWGXRVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWGXRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:21:50 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:21736 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932227AbWGXRVt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:21:49 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 1/4] FB: Get the Geode GX frambuffer size from the BIOS
Date: Mon, 24 Jul 2006 10:56:00 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165600.18822.56476.stgit@cosmic.amd.com>
In-Reply-To: <20060724165454.18822.30310.stgit@cosmic.amd.com>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:51:58.0173 (UTC)
 FILETIME=[7A0830D0:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA25240Y8101924-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Use the Geode GX BIOS virtual registers to get the actual size of the
framebuffer.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/display_gx.c |   15 ++++++++++++---
 drivers/video/geode/display_gx.h |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 825c340..0245169 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,10 +21,19 @@ #include <asm/delay.h>
 #include "geodefb.h"
 #include "display_gx.h"
 
-int gx_frame_buffer_size(void)
+unsigned int gx_frame_buffer_size(void)
 {
-	/* Assuming 16 MiB. */
-	return 16*1024*1024;
+	unsigned int val;
+
+	/* FB size is reported by a virtual register */
+	/* Virtual register class = 0x02 */
+	/* VG_MEM_SIZE(512Kb units) = 0x00 */
+
+	outw(0xFC53, 0xAC1C);
+	outw(0x0200, 0xAC1C);
+
+	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	return (val << 19);
 }
 
 int gx_line_delta(int xres, int bpp)
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 86c6233..41e79f4 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -11,7 +11,7 @@
 #ifndef __DISPLAY_GX_H__
 #define __DISPLAY_GX_H__
 
-int gx_frame_buffer_size(void);
+unsigned int gx_frame_buffer_size(void);
 int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;


