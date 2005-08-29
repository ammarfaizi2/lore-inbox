Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVH2SnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVH2SnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVH2SnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:43:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:63938 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751288AbVH2SnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:43:16 -0400
Subject: [patch] fix: dmi_check_system
From: Robert Love <rml@novell.com>
To: Mr Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 14:43:15 -0400
Message-Id: <1125340995.27035.24.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Background:

	1) dmi_check_system() returns the count of the number of 
	   matches.  Zero thus means no matches.
	2) A match callback can return nonzero to stop the match
	   checking.

Bug: The count is incremented after we check for the nonzero return
value, so it does not reflect the actual count.  We could say this is
intended, for some dumb reason, except that it means that a match on the
first check returns zero--no matches--if the callback returns nonzero.

Attached patch implements the count before calling the callback and thus
before potentially short-circuiting.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 arch/i386/kernel/dmi_scan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6.13/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- linux-2.6.13/arch/i386/kernel/dmi_scan.c	2005-08-29 14:28:33.000000000 -0400
+++ linux/arch/i386/kernel/dmi_scan.c	2005-08-29 14:35:06.000000000 -0400
@@ -218,9 +218,9 @@
 			/* No match */
 			goto fail;
 		}
+		count++;
 		if (d->callback && d->callback(d))
 			break;
-		count++;
 fail:		d++;
 	}
 


