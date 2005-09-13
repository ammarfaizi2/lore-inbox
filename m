Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVIMPJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVIMPJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVIMPJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:09:07 -0400
Received: from mail.cs.umn.edu ([128.101.34.202]:47342 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932659AbVIMPJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:09:05 -0400
Date: Tue, 13 Sep 2005 10:09:02 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: serue@us.ibm.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, lxie@us.ibm.com,
       santil@us.ibm.com
Subject: [Patch] ibmvscsi compatibility fix
Message-ID: <20050913150902.GA22071@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: serue@us.ibm.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, lxie@us.ibm.com, santil@us.ibm.com
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org> <20050913013840.GG5382@krispykreme> <20050913085643.GA24156@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913085643.GA24156@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Xie ever so gently pointed out that she had a patch
to preserve compatibility with older SLES targets, and I told
her we didn't need to push it to mainline.

This patch explicitly checks the version of the IBMVSCSI target
and ensures that large scatterlists are not sent to older 
targets.

Andrew, while this stuff usually goes through James, it would
probably make Serge happier if you could pick it up for the next
mm.  

Signed-off-by: Linda Xie <lxie@us.ibm.com>
Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>

--- linux-2.6.13-mm3-orig/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-09-13 09:50:31.000000000 -0500
+++ linux-2.6.13.1/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-09-13 09:09:41.000000000 -0500
@@ -727,6 +727,16 @@
 		if (hostdata->madapter_info.port_max_txu[0]) 
 			hostdata->host->max_sectors = 
 				hostdata->madapter_info.port_max_txu[0] >> 9;
+		
+		if (hostdata->madapter_info.os_type == 3 &&
+		    strcmp(hostdata->madapter_info.srp_version, "1.6a") <= 0) {
+			printk("ibmvscsi: host (Ver. %s) doesn't support large"
+			       "transfers\n",
+			       hostdata->madapter_info.srp_version);
+			printk("ibmvscsi: limiting scatterlists to %d\n",
+			       MAX_INDIRECT_BUFS);
+			hostdata->host->sg_tablesize = MAX_INDIRECT_BUFS;
+		}
 	}
 }
 
