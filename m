Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUKSU0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUKSU0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKSUYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:24:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19413 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261613AbUKSUXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:23:32 -0500
Message-Id: <200411192023.iAJKNTGY019345@d01av04.pok.ibm.com>
Subject: [PATCH 2/2] ipr: Block config I/O during BIST
To: greg@kroah.com
Cc: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       brking@us.ibm.com
From: brking@us.ibm.com
Date: Fri, 19 Nov 2004 14:23:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is an example of how to use the new PCI APIs to block
PCI config accesses when running BIST. 

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.10-rc2-bk4-bjking1/drivers/scsi/ipr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/scsi/ipr.c~ipr_block_config_io_during_bist_generic drivers/scsi/ipr.c
--- linux-2.6.10-rc2-bk4/drivers/scsi/ipr.c~ipr_block_config_io_during_bist_generic	2004-11-19 14:06:57.000000000 -0600
+++ linux-2.6.10-rc2-bk4-bjking1/drivers/scsi/ipr.c	2004-11-19 14:06:57.000000000 -0600
@@ -4935,6 +4935,7 @@ static int ipr_reset_restore_cfg_space(s
 	int rc;
 
 	ENTER;
+	pci_unblock_config_access(ioa_cfg->pdev);
 	rc = pci_restore_state(ioa_cfg->pdev);
 
 	if (rc != PCIBIOS_SUCCESSFUL) {
@@ -4989,9 +4990,11 @@ static int ipr_reset_start_bist(struct i
 	int rc;
 
 	ENTER;
-	rc = pci_write_config_byte(ioa_cfg->pdev, PCI_BIST, PCI_BIST_START);
+	pci_block_config_access(ioa_cfg->pdev);
+	rc = pci_start_bist(ioa_cfg->pdev);
 
 	if (rc != PCIBIOS_SUCCESSFUL) {
+		pci_unblock_config_access(ioa_cfg->pdev);
 		ipr_cmd->ioasa.ioasc = cpu_to_be32(IPR_IOASC_PCI_ACCESS_ERROR);
 		rc = IPR_RC_JOB_CONTINUE;
 	} else {
_
