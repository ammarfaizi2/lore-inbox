Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUJPAiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUJPAiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 20:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJPAiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 20:38:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34495 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268059AbUJPAie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 20:38:34 -0400
Date: Fri, 15 Oct 2004 17:38:09 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, akpm@osdl.org
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       gnb@sgi.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20041016003809.GA299051@sgi.com>
References: <200409271103.39913.jbarnes@engr.sgi.com> <200409291555.29138.jbarnes@engr.sgi.com> <20040930071541.GA201816@sgi.com> <Pine.LNX.4.60.0409302317590.3449@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0409302317590.3449@poirot.grange>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 11:21:39PM +0200, Guennadi Liakhovetski wrote:
> 
> A pretty obvious note: instead of repeating this nice but pretty lengthy 
> comment 3 times in the same file, wouldn't it be better to write at 
> further locations something like
> 
> 	/* Enforce IO-ordering. See comment in <function> for details. */
> 
> Also helps if you later have to modify the comment, or move it, or add 
> more mmiowb()s, or do some other modifications.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski

Suggestion applied.  Now that the mmiowb is in the mm patch, this
patch to qla1280 should be ready for inclusion therein also.

signed-off-by: Jeremy Higdon <jeremy@sgi.com>


--- linux-2.6.9-rc4.orig/drivers/scsi/qla1280.c	2004-10-15 17:21:21.000000000 -0700
+++ linux-2.6.9-rc4/drivers/scsi/qla1280.c	2004-10-15 17:23:08.000000000 -0700
@@ -3409,7 +3409,8 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
+	mmiowb();
 
  out:
 	if (status)
@@ -3677,7 +3678,8 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
+	mmiowb();
 
 out:
 	if (status)
@@ -3787,9 +3789,21 @@
 	} else
 		ha->request_ring_ptr++;
 
-	/* Set chip new ring index. */
+	/*
+	 * Update request index to mailbox4 (Request Queue In).
+	 * The mmiowb() ensures that this write is ordered with writes by other
+	 * CPUs.  Without the mmiowb(), it is possible for the following:
+	 *    CPUA posts write of index 5 to mailbox4
+	 *    CPUA releases host lock
+	 *    CPUB acquires host lock
+	 *    CPUB posts write of index 6 to mailbox4
+	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
+	 *       causing chip to issue full queue of stale commands
+	 * The mmiowb() prevents future writes from crossing the barrier.
+	 * See Documentation/DocBook/deviceiobook.tmpl for more information.
+	 */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	mmiowb();
 
 	LEAVE("qla1280_isp_cmd");
 }
