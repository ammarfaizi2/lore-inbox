Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWDQCCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWDQCCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 22:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWDQCCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 22:02:18 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:21787 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750929AbWDQCCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 22:02:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Eke2x/RU30gqX3Ky2q07S8OwQyBm0e0JVj066wxL3+iUsd/MschyJjipzbYvts5afZrIMBLU4lBBr1CW37F/Ba08v/U26GP3E6kt9XkuOm024g/U3QUXtN/2z2+VqibBDidS2mWUFfOHJp64bw87hr2il04dK2Q3MZF2MxN2n1Q=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix potential resource leak in drivers/pci/msi.c
Date: Mon, 17 Apr 2006 04:02:54 +0200
User-Agent: KMail/1.9.1
Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604170402.54458.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The coverity checker spotted (as entry #599) that we might leak `entry' in 
drivers/pci/msi.c::msix_capability_init()
This patch should take care of that.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

--- linux-2.6.17-rc1-git12-orig/drivers/pci/msi.c	2006-04-16 11:23:18.000000000 +0200
+++ linux-2.6.17-rc1-git12/drivers/pci/msi.c	2006-04-17 03:59:14.000000000 +0200
@@ -793,8 +793,10 @@ static int msix_capability_init(struct p
 		if (!entry)
 			break;
 		vector = get_msi_vector(dev);
-		if (vector < 0)
+		if (vector < 0) {
+			kmem_cache_free(msi_cachep, entry);
 			break;
+		}
 
  		j = entries[i].entry;
  		entries[i].vector = vector;


