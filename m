Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUJWHxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUJWHxH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJWHxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:53:07 -0400
Received: from ozlabs.org ([203.10.76.45]:44996 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265943AbUJWHw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:52:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16762.3510.255380.586200@cargo.ozlabs.ibm.com>
Date: Sat, 23 Oct 2004 17:52:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Linas Vepstas <linas@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: crash during firmware flash update
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Linas Vepstas <linas@austin.ibm.com>.

Race conditions during system shutdown after a firmware
flash can sometimes lead to an invalid pointer deref (deref
to freed memory).  This patch fixes this.  In addition, it makes
sure that the proc entries created by the firmware flash module
are removed when the module is unloaded. 

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/rtas_flash.c test/arch/ppc64/kernel/rtas_flash.c
--- linux-2.5/arch/ppc64/kernel/rtas_flash.c	2004-06-25 07:03:03.000000000 +1000
+++ test/arch/ppc64/kernel/rtas_flash.c	2004-10-23 17:38:33.445013280 +1000
@@ -562,6 +562,7 @@
 		validate_flash(args_buf);
 	}
 
+	/* The matching atomic_inc was in rtas_excl_open() */
 	atomic_dec(&dp->count);
 
 	return 0;
@@ -572,7 +573,8 @@
 	if (dp) {
 		if (dp->data != NULL)
 			kfree(dp->data);
-		remove_proc_entry(dp->name, NULL);
+		dp->owner = NULL;
+		remove_proc_entry(dp->name, dp->parent);
 	}
 }
 
