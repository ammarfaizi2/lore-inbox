Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031795AbWLGHbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031795AbWLGHbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031801AbWLGHbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:31:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:2626 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031795AbWLGHbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:31:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=My5mP82jEAxJtDMrzd44nN7FCC7kAJWZMADtdwc2U1nRqysGqAxZfWTRDkIbHt/FwoKyBxomommOLKs+FcbOw9JSNpHrnqfuJ2lWdVepVAxPrxMJjHH25g12IL5Hjjf2NnWLPnijrwlw3ZGsivXDoRc/roUNYqdzALTqyWjtYLw=
Date: Wed, 6 Dec 2006 23:30:54 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19] drivers/char/vt.c: check kmalloc() return value.
Message-Id: <20061206233054.a69ceab3.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function con_init(), in file drivers/char/vt.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 87587b4..6aa08cb 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2640,6 +2640,15 @@ static int __init con_init(void)
 	 */
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = alloc_bootmem(sizeof(struct vc_data));
+		if (!vc_cons[currcons].d) {
+			for (--currcons; currcons >= 0; currcons--) {
+				kfree(vc_cons[currcons].d);
+				vc_cons[currcons].d = NULL;
+			}
+			release_console_sem();
+			return -ENOMEM;
+		}
+
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = (unsigned short *)alloc_bootmem(vc->vc_screenbuf_size);
 		vc->vc_kmalloced = 0;
