Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264876AbSJ3UVG>; Wed, 30 Oct 2002 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSJ3UVG>; Wed, 30 Oct 2002 15:21:06 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:60426 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S264876AbSJ3UVF>; Wed, 30 Oct 2002 15:21:05 -0500
Date: Wed, 30 Oct 2002 14:23:55 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021030142355.A1492@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
[...]
> Anyway, here is a new cciss patch to work with your ll_rw_blk.c patch
> to use more than 31 scatter gather entries.

And that patch was missing something important.  It didn't unmap
all the addresses correctly.  That's what I get for sitting on a patch
since 2.5.7, I guess.  Here's a patch to fix that.

-- steve

 drivers/block/cciss.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions, 4 deletions

--- lx2544ac5/drivers/block/cciss.c~sgc4	Wed Oct 30 14:09:56 2002
+++ lx2544ac5-root/drivers/block/cciss.c	Wed Oct 30 14:09:56 2002
@@ -1719,6 +1719,8 @@ static inline void complete_command( ctl
 	int i;
 	int retry_cmd = 0;
 	u64bit temp64;
+	int sgpage, sgelem;
+	SGDescriptor_struct *sgd;
 		
 	if (timeout)
 		status = 0; 
@@ -1830,13 +1832,23 @@ static inline void complete_command( ctl
 	}	
 	/* command did not need to be retried */
 	/* unmap the DMA mapping for all the scatter gather elements */
-	for(i=0; i<cmd->Header.SGList; i++) {
-		temp64.val32.lower = cmd->SG[i].Addr.lower;
-		temp64.val32.upper = cmd->SG[i].Addr.upper;
+	sgpage = 0;
+	sgelem = 0;
+	for(i=0; i<cmd->Header.SGTotal; i++) {
+		sgd = &cmd->sgdlist[sgpage].sgd[sgelem];
+		if (sgelem == MAXSGENTRIES-1 && sgd->Ext) {
+			i++;
+			sgpage++;
+			sgelem=0;
+			sgd = &cmd->sgdlist[sgpage].sgd[sgelem];
+		}
+		temp64.val32.lower = sgd->Addr.lower;
+		temp64.val32.upper = sgd->Addr.upper;
 		pci_unmap_page(hba[cmd->ctlr]->pdev,
-			temp64.val, cmd->SG[i].Len,
+			temp64.val, sgd->Len,
 			(cmd->Request.Type.Direction == XFER_READ) ?
 				PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
+		sgelem++;
 	}
 	complete_buffers(cmd->rq->bio, status);
 

.
