Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTKPFdd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 00:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTKPFdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 00:33:33 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:36768 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262458AbTKPFbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 00:31:52 -0500
Date: Sun, 16 Nov 2003 00:27:47 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test9
Message-ID: <20031116002747.GE13220@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20031116002620.GB13220@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116002620.GB13220@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/11/15	ambx1@neo.rr.com	1.1450
# [BUG][PATCH] isapnp does not detect some cards
# 
# From: Paul L. Rogers <rogerspl@datasync.com>
# 
# Plug and Play Cards (Tested only one at a time.  One ISA slot):
#               NCI1000 NewCom  33.6KifxC  ISA PnP Data/Fax Modem
#               ADP1542 Adaptec AHA-1542CP ISA PnP SCSI Host Adapter
# 
# Problem Description:
# The Linux ISA PnP subsystem assumes that the checksum of the
# Vendor ID and the Serial Number returned by a PnP card in
# the Config state is valid.  However, the Plug and Play ISA
# Specification (Version 1.0a) found at
# http://www.nondot.org/sabre/os/files/PlugNPlay/PNP-ISA-v1.0a.pdf,
# states in Section 4.5 that when a card enters the Config state
# directly from the Sleep state and the 9-byte serial identifier
# is read, the checksum byte is not valid.
# 
# While some cards do return a valid checksum in this case
# (ADP1542), others do not (NCI1000) and thus are not detected
# since isapnp_build_device_list requires that the computed
# checksum match the checksum returned by the card.
# 
# Workaround:
# Continue using the isapnp utility instead of the kernel PnP support.
# 
# Proposed solution:
# The attached patch removes checksum related tests from
# isapnp_build_device_list and instead relies on the behavior
# documented in Section 6.1 of the PnP ISA Specification that
# specifies that Bit[7] of Vendor ID Byte 0 must be 0 to
# determine if the selected CSN is returning valid data.
# 
# A longer term solution would be for isapnp_build_device_list to
# only access CSNs that were assigned during the Isolation process.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Nov 16 00:24:55 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Nov 16 00:24:55 2003
@@ -890,11 +890,9 @@
 			header[4], header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		/* Don't be strict on the checksum, here !
-                   e.g. 'SCM SwapBox Plug and Play' has header[8]==0 (should be: b7)*/
-		if (header[8] == 0)
-			;
-		else if (checksum == 0x00 || checksum != header[8])	/* not valid CSN */
+		/* Per Section 6.1 of the Plug and Play ISA Specification (Version 1.0a), */
+		/* Bit[7] of Vendor ID Byte 0 must be 0 */
+		if (header[0] & 0x80)	/* not valid CSN */
 			continue;
 		if ((card = isapnp_alloc(sizeof(struct pnp_card))) == NULL)
 			continue;
