Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422918AbWJYD4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422918AbWJYD4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 23:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWJYD4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 23:56:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54209 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161335AbWJYD4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 23:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=L/qbt5c2Hob+txkr095hQFUMAi6y9ZKlFH2Br0NjTJz7kcJ25p3SGfjiV8e/jJn+xXydUmFwNHSFAfcXCwFICqbgU6uHwjqf+/zkPtaNLpkx6huvKRnTCa0RgZeOOVZONdAJTRxTBpSTQGeZNQbQXdbXnOja41aAZFksFRLr3KU=
Date: Tue, 24 Oct 2006 20:56:44 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH 2.6.19-rc3] drivers/char/synclink.c: check kmalloc() return
 value.
Message-Id: <20061024205644.5ce58504.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function mgsl_alloc_intermediate_txbuffer_memory(), in file drivers/char/synclink.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index 06784ad..24f99bc 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -4012,8 +4012,13 @@ static int mgsl_alloc_intermediate_txbuf
 	for ( i=0; i<info->num_tx_holding_buffers; ++i) {
 		info->tx_holding_buffers[i].buffer =
 			kmalloc(info->max_frame_size, GFP_KERNEL);
-		if ( info->tx_holding_buffers[i].buffer == NULL )
+		if (info->tx_holding_buffers[i].buffer == NULL) {
+			for (--i; i >= 0; i--) {
+				kfree(info->tx_holding_buffers[i].buffer);
+				info->tx_holding_buffers[i].buffer = NULL;
+			}
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
