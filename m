Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965673AbWKDU3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965673AbWKDU3t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965672AbWKDU3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:29:39 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:54208 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965674AbWKDU3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:29:17 -0500
Message-id: <124776749725612723@wsc.cz>
Subject: [PATCH 7/8] Char: istallion, free only isa
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:29:28 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, free only isa

Only ISA cards should be freed in module exit. Pci probed are freed in
pci_remove. Define a flag, where we store this info a what to check
against.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 0e8470b600af83b7421c85d85c1b7c9b63ad21aa
tree 8bc93e102991bfc544bcbd268a48721b974053b8
parent 177cc17270356497ba04bb03b5688e429c3cfbdb
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:48:29 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:48:29 +0059

 drivers/char/istallion.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 6569398..0502e5d 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -202,6 +202,7 @@ static int		stli_shared;
  */
 #define	BST_FOUND	0x1
 #define	BST_STARTED	0x2
+#define	BST_PROBED	0x4
 
 /*
  *	Define the set of port state flags. These are marked for internal
@@ -791,7 +792,7 @@ static void __exit istallion_module_exit
 	kfree(stli_txcookbuf);
 
 	for (j = 0; (j < stli_nrbrds); j++) {
-		if ((brdp = stli_brds[j]) == NULL)
+		if ((brdp = stli_brds[j]) == NULL || (brdp->state & BST_PROBED))
 			continue;
 
 		stli_cleanup_ports(brdp);
@@ -3956,6 +3957,7 @@ static int __devinit stli_pciprobe(struc
 	if (retval)
 		goto err_null;
 
+	brdp->state |= BST_PROBED;
 	pci_set_drvdata(pdev, brdp);
 
 	return 0;
