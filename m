Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270394AbTGRV2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271883AbTGRV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:27:29 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:12292 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272020AbTGRVVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:21:17 -0400
Date: Fri, 18 Jul 2003 23:31:35 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] 2.6.0-test1-after-alan-s-patch - Unchecked copy_to_user disturb harmony
Message-ID: <20030718233135.B780@electric-eye.fr.zoreil.com>
References: <200307181431.h6IEV7Sm017874@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307181431.h6IEV7Sm017874@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 18, 2003 at 03:31:07PM +0100
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Assortment of unchecked copy_to_user().

Afaiks, the wild return statement in harmony_audio_write() don't add
extra leak (or whatever).


 sound/oss/harmony.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff -puN sound/oss/harmony.c~janitor-copy_to_user-harmony sound/oss/harmony.c
--- linux-2.6.0-test1-20030718_0517/sound/oss/harmony.c~janitor-copy_to_user-harmony	Fri Jul 18 22:58:28 2003
+++ linux-2.6.0-test1-20030718_0517-fr/sound/oss/harmony.c	Fri Jul 18 23:28:32 2003
@@ -442,9 +442,12 @@ static ssize_t harmony_audio_read(struct
 		buf_to_read = harmony.first_filled_record;
 
 		/* Copy the page to an aligned buffer */
-		copy_to_user(buffer+count, 
-			     recorded_buf.addr+(HARMONY_BUF_SIZE*buf_to_read), 
-			     HARMONY_BUF_SIZE);
+		if (copy_to_user(buffer+count, recorded_buf.addr +
+				 (HARMONY_BUF_SIZE*buf_to_read),
+				 HARMONY_BUF_SIZE)) {
+			count = -EFAULT;
+			break;
+		}
 		
 		harmony.nb_filled_record--;
 		harmony.first_filled_record++;
@@ -474,13 +477,16 @@ static ssize_t harmony_audio_read(struct
 #define test_rate(tested,real_value,harmony_value) if ((tested)<=(real_value))\
                                                     
 
-static void harmony_format_auto_detect(const char *buffer, int block_size)
+static int harmony_format_auto_detect(const char *buffer, int block_size)
 {
 	u8 file_header[24];
 	u32 start_string;
+	int ret = 0;
 	
 	if (block_size>24) {
-		copy_from_user(file_header, buffer, sizeof(file_header));
+		if (copy_from_user(file_header, buffer, sizeof(file_header)))
+			ret = -EFAULT;
+			
 		start_string = four_bytes_to_u32(0);
 		
 		if ((file_header[4]==0) && (start_string==0x2E736E64)) {
@@ -505,7 +511,7 @@ static void harmony_format_auto_detect(c
 			default:
 				harmony_set_control(HARMONY_DF_16BIT_LINEAR,
 						HARMONY_SR_44KHZ, HARMONY_SS_STEREO);
-				return;
+				goto out;
 			}
 			switch (nb_voices) {
 			case HARMONY_MAGIC_MONO:
@@ -520,10 +526,12 @@ static void harmony_format_auto_detect(c
 			}
 			harmony_set_rate(harmony_detect_rate(&speed));
 			harmony.dac_rate = speed;
-			return;			
+			goto out;
 		}
 	}
 	harmony_set_control(HARMONY_DF_8BIT_ULAW, HARMONY_SR_8KHZ, HARMONY_SS_MONO);
+out:
+	return ret;
 }
 #undef four_bytes_to_u32
 
@@ -538,8 +546,10 @@ static ssize_t harmony_audio_write(struc
 	int frame_size;
 	int buf_to_fill;
 
-	if (!harmony.format_initialized) 
-	   harmony_format_auto_detect(buffer, total_count);
+	if (!harmony.format_initialized) {
+		if (harmony_format_auto_detect(buffer, total_count))
+			return -EFAULT;
+	}
 	
 	while (count<total_count) {
 		/* Wait until we're out of control mode */
@@ -573,8 +583,9 @@ static ssize_t harmony_audio_write(struc
 		}
 
 		/* Copy the page to an aligned buffer */
-		copy_from_user(played_buf.addr + (HARMONY_BUF_SIZE*buf_to_fill) + harmony.play_offset, 
-				buffer+count, frame_size);
+		if (copy_from_user(played_buf.addr +(HARMONY_BUF_SIZE*buf_to_fill) + harmony.play_offset, 
+				   buffer+count, frame_size))
+			return -EFAULT;
 		CHECK_WBACK_INV_OFFSET(played_buf, (HARMONY_BUF_SIZE*buf_to_fill + harmony.play_offset), 
 				frame_size);
 	

_
