Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUDNUzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUDNUzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:55:50 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:59012 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261741AbUDNUzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:55:36 -0400
Date: Wed, 14 Apr 2004 04:56:22 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045622.GC12732@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20040414045552.GB12732@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414045552.GB12732@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Wed Apr 14 04:41:52 2004
+++ b/drivers/pnp/manager.c	Wed Apr 14 04:41:52 2004
@@ -452,23 +452,19 @@
 
 	if (!dev->dependent) {
 		if (pnp_assign_resources(dev, 0))
-			return 1;
-		else
 			return 0;
+	} else {
+		dep = dev->dependent;
+		do {
+			if (pnp_assign_resources(dev, i))
+				return 0;
+			dep = dep->next;
+			i++;
+		} while (dep);
 	}

-	dep = dev->dependent;
-	do {
-		if (pnp_assign_resources(dev, i))
-			return 1;
-
-		/* if this dependent resource failed, try the next one */
-		dep = dep->next;
-		i++;
-	} while (dep);
-
 	pnp_err("Unable to assign resources to device %s.", dev->dev.bus_id);
-	return 0;
+	return -EBUSY;
 }

 /**
@@ -486,7 +482,7 @@
 	}

 	/* ensure resources are allocated */
-	if (!pnp_auto_config_dev(dev))
+	if (pnp_auto_config_dev(dev))
 		return -EBUSY;

 	if (!pnp_can_write(dev)) {
