Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVIDXqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVIDXqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVIDXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:44:50 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:47745 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932104AbVIDXat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:49 -0400
Message-Id: <20050904232330.992028000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:37 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@linuxtv.org>
Content-Disposition: inline; filename=dvb-bt8xx-dst-ca-simplification.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 38/54] dst: remove unnecessary code
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

Code Simplification: CA PMT object is not parsed in the driver anymore.

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst_ca.c |  115 ++++++---------------------------------
 1 file changed, 20 insertions(+), 95 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst_ca.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst_ca.c	2005-09-04 22:28:33.000000000 +0200
@@ -260,8 +260,6 @@ static int ca_get_slot_info(struct dst_s
 }
 
 
-
-
 static int ca_get_message(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
 {
 	u8 i = 0;
@@ -298,10 +296,14 @@ static int ca_get_message(struct dst_sta
 static int handle_dst_tag(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer, u32 length)
 {
 	if (state->dst_hw_cap & DST_TYPE_HAS_SESSION) {
-		hw_buffer->msg[2] = p_ca_message->msg[1];		/*		MSB			*/
-		hw_buffer->msg[3] = p_ca_message->msg[2];		/*		LSB			*/
-	}
-	else {
+		hw_buffer->msg[2] = p_ca_message->msg[1];	/*	MSB	*/
+		hw_buffer->msg[3] = p_ca_message->msg[2];	/*	LSB	*/
+	} else {
+		if (length > 247) {
+			dprintk("%s: Message too long ! *** Bailing Out *** !\n", __FUNCTION__);
+			return -1;
+		}
+
 		hw_buffer->msg[0] = (length & 0xff) + 7;
 		hw_buffer->msg[1] = 0x40;
 		hw_buffer->msg[2] = 0x03;
@@ -309,6 +311,11 @@ static int handle_dst_tag(struct dst_sta
 		hw_buffer->msg[4] = 0x03;
 		hw_buffer->msg[5] = length & 0xff;
 		hw_buffer->msg[6] = 0x00;
+		/*
+		 *	Need to compute length for EN50221 section 8.3.2, for the time being
+		 *	assuming 8.3.2 is not applicable
+		 */
+		memcpy(&hw_buffer->msg[7], &p_ca_message->msg[4], length);
 	}
 	return 0;
 }
@@ -348,15 +355,6 @@ u32 asn_1_decode(u8 *asn_1_array)
 	return length;
 }
 
-static int init_buffer(u8 *buffer, u32 length)
-{
-	u32 i;
-	for (i = 0; i < length; i++)
-		buffer[i] = 0;
-
-	return 0;
-}
-
 static int debug_string(u8 *msg, u32 length, u32 offset)
 {
 	u32 i;
@@ -369,95 +367,22 @@ static int debug_string(u8 *msg, u32 len
 	return 0;
 }
 
-static int copy_string(u8 *destination, u8 *source, u32 dest_offset, u32 source_offset, u32 length)
-{
-	u32 i;
-	dprintk("%s: Copying [", __FUNCTION__);
-	for (i = 0; i < length; i++) {
-		destination[i + dest_offset] = source[i + source_offset];
-		dprintk(" %02x", source[i + source_offset]);
-	}
-	dprintk("]\n");
-
-	return i;
-}
-
-static int modify_4_bits(u8 *message, u32 pos)
-{
-	message[pos] &= 0x0f;
-
-	return 0;
-}
-
-
-
 static int ca_set_pmt(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer, u8 reply, u8 query)
 {
-	u32 length = 0, count = 0;
-	u8 asn_1_words, program_header_length;
-	u16 program_info_length = 0, es_info_length = 0;
-	u32 hw_offset = 0, buf_offset = 0, i;
-	u8 dst_tag_length;
+	u32 length = 0;
+	u8 tag_length = 8;
 
 	length = asn_1_decode(&p_ca_message->msg[3]);
 	dprintk("%s: CA Message length=[%d]\n", __FUNCTION__, length);
 	dprintk("%s: ASN.1 ", __FUNCTION__);
-	debug_string(&p_ca_message->msg[4], length, 0); // length does not include tag and length
+	debug_string(&p_ca_message->msg[4], length, 0); /*	length is excluding tag & length	*/
 
-	init_buffer(hw_buffer->msg, length);
+	memset(hw_buffer->msg, '\0', length);
 	handle_dst_tag(state, p_ca_message, hw_buffer, length);
+	put_checksum(hw_buffer->msg, hw_buffer->msg[0]);
 
-	hw_offset = 7;
-	asn_1_words = 1; // just a hack to test, should compute this one
-	buf_offset = 3;
-	program_header_length = 6;
-	dst_tag_length = 7;
-
-//	debug_twinhan_ca_params(state, p_ca_message, hw_buffer, reply, query, length, hw_offset, buf_offset);
-//	dprintk("%s: Program Header(BUF)", __FUNCTION__);
-//	debug_string(&p_ca_message->msg[4], program_header_length, 0);
-//	dprintk("%s: Copying Program header\n", __FUNCTION__);
-	copy_string(hw_buffer->msg, p_ca_message->msg, hw_offset, (buf_offset + asn_1_words), program_header_length);
-	buf_offset += program_header_length, hw_offset += program_header_length;
-	modify_4_bits(hw_buffer->msg, (hw_offset - 2));
-	if (state->type_flags & DST_TYPE_HAS_INC_COUNT) {	// workaround
-		dprintk("%s: Probably an ASIC bug !!!\n", __FUNCTION__);
-		debug_string(hw_buffer->msg, (hw_offset + program_header_length), 0);
-		hw_buffer->msg[hw_offset - 1] += 1;
-	}
-
-//	dprintk("%s: Program Header(HW), Count=[%d]", __FUNCTION__, count);
-//	debug_string(hw_buffer->msg, hw_offset, 0);
-
-	program_info_length =  ((program_info_length | (p_ca_message->msg[buf_offset - 1] & 0x0f)) << 8) | p_ca_message->msg[buf_offset];
-	dprintk("%s: Program info length=[%02x]\n", __FUNCTION__, program_info_length);
-	if (program_info_length) {
-		count = copy_string(hw_buffer->msg, p_ca_message->msg, hw_offset, (buf_offset + 1), (program_info_length + 1) ); // copy next elem, not current
-		buf_offset += count, hw_offset += count;
-//		dprintk("%s: Program level ", __FUNCTION__);
-//		debug_string(hw_buffer->msg, hw_offset, 0);
-	}
-
-	buf_offset += 1;// hw_offset += 1;
-	for (i = buf_offset; i < length; i++) {
-//		dprintk("%s: Stream Header ", __FUNCTION__);
-		count = copy_string(hw_buffer->msg, p_ca_message->msg, hw_offset, buf_offset, 5);
-		modify_4_bits(hw_buffer->msg, (hw_offset + 3));
-
-		hw_offset += 5, buf_offset += 5, i += 4;
-//		debug_string(hw_buffer->msg, hw_offset, (hw_offset - 5));
-		es_info_length = ((es_info_length | (p_ca_message->msg[buf_offset - 1] & 0x0f)) << 8) | p_ca_message->msg[buf_offset];
-		dprintk("%s: ES info length=[%02x]\n", __FUNCTION__, es_info_length);
-		if (es_info_length) {
-			// copy descriptors @ STREAM level
-			dprintk("%s: Descriptors @ STREAM level...!!! \n", __FUNCTION__);
-		}
-
-	}
-	hw_buffer->msg[length + dst_tag_length] = dst_check_sum(hw_buffer->msg, (length + dst_tag_length));
-//	dprintk("%s: Total length=[%d], Checksum=[%02x]\n", __FUNCTION__, (length + dst_tag_length), hw_buffer->msg[length + dst_tag_length]);
-	debug_string(hw_buffer->msg, (length + dst_tag_length + 1), 0);	// dst tags also
-	write_to_8820(state, hw_buffer, (length + dst_tag_length + 1), reply);	// checksum
+	debug_string(hw_buffer->msg, (length + tag_length), 0); /*	tags too	*/
+	write_to_8820(state, hw_buffer, (length + tag_length), reply);
 
 	return 0;
 }

--

