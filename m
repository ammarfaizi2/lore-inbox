Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965545AbWKGRCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965545AbWKGRCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965554AbWKGRCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:02:40 -0500
Received: from master.altlinux.org ([62.118.250.235]:16139 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S965545AbWKGRCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:02:39 -0500
From: Sergey Vlasov <vsu@altlinux.ru>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       stable@kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] Input: psmouse - fix attribute access on 64-bit systems
Date: Tue,  7 Nov 2006 20:02:36 +0300
Message-Id: <11629189562984-git-send-email-vsu@altlinux.ru>
X-Mailer: git-send-email 1.4.3.3.gddcc6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

psmouse_show_int_attr() and psmouse_set_int_attr() were accessing
unsigned int fields as unsigned long, which gave garbage on x86_64.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 drivers/input/mouse/psmouse-base.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

 The problem was found in 2.6.18.2; the same patch applies to the
 current tree.

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 343afa3..07b0604 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1332,20 +1332,22 @@ ssize_t psmouse_attr_set_helper(struct d
 
 static ssize_t psmouse_show_int_attr(struct psmouse *psmouse, void *offset, char *buf)
 {
-	unsigned long *field = (unsigned long *)((char *)psmouse + (size_t)offset);
+	unsigned int *field = (unsigned int *)((char *)psmouse + (size_t)offset);
 
-	return sprintf(buf, "%lu\n", *field);
+	return sprintf(buf, "%u\n", *field);
 }
 
 static ssize_t psmouse_set_int_attr(struct psmouse *psmouse, void *offset, const char *buf, size_t count)
 {
-	unsigned long *field = (unsigned long *)((char *)psmouse + (size_t)offset);
+	unsigned int *field = (unsigned int *)((char *)psmouse + (size_t)offset);
 	unsigned long value;
 	char *rest;
 
 	value = simple_strtoul(buf, &rest, 10);
 	if (*rest)
 		return -EINVAL;
+	if ((unsigned int)value != value)
+		return -EINVAL;
 
 	*field = value;
 
-- 
1.4.3.3.gddcc6

