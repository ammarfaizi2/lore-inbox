Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVBRMUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVBRMUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVBRMUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:20:32 -0500
Received: from mx2.mail.ru ([194.67.23.122]:260 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261336AbVBRMUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:20:12 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] __be'ify include/linux/cdrom.h
Date: Fri, 18 Feb 2005 15:20:10 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502181520.10857.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings in drivers/cdrom/cdrom.c and drivers/block/pktcdvd.c

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-warnings/include/linux/cdrom.h
===================================================================
--- linux-warnings/include/linux/cdrom.h	(revision 21)
+++ linux-warnings/include/linux/cdrom.h	(revision 22)
@@ -750,7 +750,7 @@
 #define MRW_MODE_PC			0x03
 
 struct mrw_feature_desc {
-	__u16 feature_code;
+	__be16 feature_code;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1		: 2;
 	__u8 feature_version	: 4;
@@ -777,7 +777,7 @@
 
 /* cf. mmc4r02g.pdf 5.3.10 Random Writable Feature (0020h) pg 197 of 635 */
 struct rwrt_feature_desc {
-	__u16 feature_code;
+	__be16 feature_code;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1		: 2;
 	__u8 feature_version	: 4;
@@ -804,7 +804,7 @@
 };
 
 typedef struct {
-	__u16 disc_information_length;
+	__be16 disc_information_length;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1			: 3;
         __u8 erasable			: 1;
@@ -850,7 +850,7 @@
 } disc_information;
 
 typedef struct {
-	__u16 track_information_length;
+	__be16 track_information_length;
 	__u8 track_lsb;
 	__u8 session_lsb;
 	__u8 reserved1;
@@ -881,12 +881,12 @@
 	__u8 lra_v			: 1;
 	__u8 reserved3			: 6;
 #endif
-	__u32 track_start;
-	__u32 next_writable;
-	__u32 free_blocks;
-	__u32 fixed_packet_size;
-	__u32 track_size;
-	__u32 last_rec_address;
+	__be32 track_start;
+	__be32 next_writable;
+	__be32 free_blocks;
+	__be32 fixed_packet_size;
+	__be32 track_size;
+	__be32 last_rec_address;
 } track_information;
 
 struct feature_header {
@@ -897,12 +897,12 @@
 };
 
 struct mode_page_header {
-	__u16 mode_data_length;
+	__be16 mode_data_length;
 	__u8 medium_type;
 	__u8 reserved1;
 	__u8 reserved2;
 	__u8 reserved3;
-	__u16 desc_length;
+	__be16 desc_length;
 };
 
 #ifdef __KERNEL__
@@ -1109,7 +1109,7 @@
 #endif
 	__u8 session_format;
 	__u8 reserved6;
-	__u32 packet_size;
+	__be32 packet_size;
 	__u16 audio_pause;
 	__u8 mcn[16];
 	__u8 isrc[16];
@@ -1154,7 +1154,7 @@
 } rpc_state_t;
 
 struct event_header {
-	__u16 data_len;
+	__be16 data_len;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 nea		: 1;
 	__u8 reserved1		: 4;
Index: linux-warnings/drivers/cdrom/cdrom.c
===================================================================
--- linux-warnings/drivers/cdrom/cdrom.c	(revision 21)
+++ linux-warnings/drivers/cdrom/cdrom.c	(revision 22)
@@ -705,7 +705,7 @@
 {
 	struct packet_command cgc;
 	char buffer[16];
-	__u16 *feature_code;
+	__be16 *feature_code;
 	int ret;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
@@ -718,7 +718,7 @@
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
 		return ret;
 
-	feature_code = (__u16 *) &buffer[sizeof(struct feature_header)];
+	feature_code = (__be16 *) &buffer[sizeof(struct feature_header)];
 	if (be16_to_cpu(*feature_code) == CDF_HWDM)
 		return 0;
 
@@ -2767,7 +2767,7 @@
 		   how much data is available for transfer. buffer[1] is
 		   unfortunately ambigious and the only reliable way seem
 		   to be to simply skip over the block descriptor... */
-		offset = 8 + be16_to_cpu(*(unsigned short *)(buffer+6));
+		offset = 8 + be16_to_cpu(*(__be16 *)(buffer+6));
 
 		if (offset + 16 > sizeof(buffer))
 			return -E2BIG;
