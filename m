Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUAUTkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbUAUTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:40:00 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:6297 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266116AbUAUTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:39:56 -0500
Date: Wed, 21 Jan 2004 19:38:35 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-dvb@linuxtv.org, greg@kroah.com
Subject: Fix up 4KB stack allocation in DVB USB driver.
Message-ID: <20040121193835.GD9327@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linux-dvb@linuxtv.org,
	greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating 4KB on the stack can't be healthy.

		Dave


diff -Nru a/drivers/media/dvb/ttusb-dec/ttusb_dec.c b/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- a/drivers/media/dvb/ttusb-dec/ttusb_dec.c	Wed Jan 21 19:10:44 2004
+++ b/drivers/media/dvb/ttusb-dec/ttusb_dec.c	Wed Jan 21 19:10:44 2004
@@ -1145,7 +1145,7 @@
 		    0x00, 0x00, 0x00, 0x00,
 		    0x61, 0x00 };
 	u8 b1[] = { 0x61 };
-	u8 b[ARM_PACKET_SIZE];
+	u8 *b;
 	char idstring[21];
 	u8 *firmware = NULL;
 	size_t firmware_size = 0;
@@ -1202,6 +1202,10 @@
 	trans_count = 0;
 	j = 0;
 
+	b = kmalloc(ARM_PACKET_SIZE, GFP_KERNEL);
+	if (b == NULL)
+		return -ENOMEM;
+
 	for (i = 0; i < firmware_size; i += COMMAND_PACKET_SIZE) {
 		size = firmware_size - i;
 		if (size > COMMAND_PACKET_SIZE)
@@ -1228,6 +1232,8 @@
 	}
 
 	result = ttusb_dec_send_command(dec, 0x43, sizeof(b1), b1, NULL, NULL);
+
+	kfree(b);
 
 	return result;
 }

