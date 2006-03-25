Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWCYE1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWCYE1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWCYE1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:27:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28348
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750809AbWCYE0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:26:49 -0500
Date: Fri, 24 Mar 2006 20:26:27 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Mark Lord <mlord@pobox.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/20] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060325042627.GE21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="2.6.xx-sata_mv-another-critical-fix.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Mark Lord <lkml@rtr.ca>

This patch addresses a number of weird behaviours observed
for the sata_mv driver, by fixing an "off by one" bug in processing
of the EDMA response queue.

Basically, sata_mv was looking in the wrong place for
command results, and this produced a lot of unpredictable behaviour.

Signed-off-by: Mark Lord <mlord@pobox.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/scsi/sata_mv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.16.orig/drivers/scsi/sata_mv.c
+++ linux-2.6.16/drivers/scsi/sata_mv.c
@@ -1102,6 +1102,7 @@ static u8 mv_get_crpb_status(struct ata_
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
 	u32 out_ptr;
+	u8 ata_status;
 
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
@@ -1109,6 +1110,8 @@ static u8 mv_get_crpb_status(struct ata_
 	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
+	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
 
@@ -1123,7 +1126,7 @@ static u8 mv_get_crpb_status(struct ata_
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
-	return (pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT);
+	return ata_status;
 }
 
 /**

--
