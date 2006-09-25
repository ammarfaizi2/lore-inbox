Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWIYByu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWIYByu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWIYByu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:54:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49128 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964795AbWIYByt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:54:49 -0400
Date: Mon, 25 Sep 2006 02:54:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] wrong thing iounmapped (qla3xxx)
Message-ID: <20060925015446.GD29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ql3xxx_probe() does ioremap and stores result in
->mem_map_registers.  On failure exit it does iounmap()
of the same thing.  OTOH, ql3xxx_remove() does iounmap()
of ->mmap_virt_base which is (a) never assigned and
(b) never used other than in that iounmap() call.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/qla3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/qla3xxx.c b/drivers/net/qla3xxx.c
index c184cd8..1574718 100644
--- a/drivers/net/qla3xxx.c
+++ b/drivers/net/qla3xxx.c
@@ -3508,7 +3508,7 @@ static void __devexit ql3xxx_remove(stru
 		qdev->workqueue = NULL;
 	}
 
-	iounmap(qdev->mmap_virt_base);
+	iounmap(qdev->mem_map_registers);
 	pci_release_regions(pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(ndev);
-- 
1.4.2.GIT

