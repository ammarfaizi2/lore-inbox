Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWD0AFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWD0AFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWD0AFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 20:05:38 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.25.9.100]:5579 "EHLO
	ms-smtp-01.southeast.rr.com") by vger.kernel.org with ESMTP
	id S1751309AbWD0AFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 20:05:37 -0400
Subject: s390 lcs incorrect test
From: Greg Smith <gsmith@nc.rr.com>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, pavlic@de.ibm.com
Content-Type: text/plain
Date: Wed, 26 Apr 2006 20:05:30 -0400
Message-Id: <1146096330.3012.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging why our LCS emulator is having some problems I noticed
the following weirdness in drivers/s390/net/lcs.c routine lcs_irq:

--- lcs.c.orig	2006-04-24 16:20:24.000000000 -0400
+++ lcs.c	2006-04-26 19:56:45.000000000 -0400
@@ -1354,7 +1354,7 @@
 		index = (struct ccw1 *) __va((addr_t) irb->scsw.cpa) 
 			- channel->ccws;
 		if ((irb->scsw.actl & SCSW_ACTL_SUSPENDED) ||
-		    (irb->scsw.cstat | SCHN_STAT_PCI))
+		    (irb->scsw.cstat & SCHN_STAT_PCI))
 			/* Bloody io subsystem tells us lies about cpa... */
 			index = (index - 1) & (LCS_NUM_BUFFS - 1);
 		while (channel->io_idx != index) {

The `if' statement is always true since SCHN_STAT_PCI is defined as
0x80.  Don't know if this has anything to do with our LCS problems but
thought I would pass it on.

Greg Smith


