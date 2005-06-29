Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVF2Unv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVF2Unv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVF2Unv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:43:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262631AbVF2Und (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:43:33 -0400
Subject: [PATCH] selinux_sb_copy_data should not require a whole page
From: Eric Paris <eparis@parisplace.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:46:56 -0400
Message-Id: <1120078016.9967.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently selinux_sb_copy_data requires an entire page be allocated to
*orig when the function is called.  This "requirement" is based on the
fact that we call copy_page(in_save, nosec_save) and in_save = orig when
the data is not FS_BINARY_MOUNTDATA.  This means that if a caller were
to call do_kern_mount with only about 10 bytes of options, they would
get passed here and then we would corrupt PAGE_SIZE - 10 bytes of memory
(with all zeros.)  

Currently it appears all in kernel FS's use one page of data so this has
not been a problem.  An out of kernel FS did just what is described
above and it would almost always panic shortly after they tried to
mount.  From looking else where in the kernel it is obvious that this
string of data must always be null terminated.  (See example in do_mount
where it always zeros the last byte.)  Thus I suggest we use strcpy in
place of copy_page.  In this way we make sure the amount we copy is
always less than or equal to the amount we received and since do_mount
is zeroing the last byte this should be safe for all.

-Eric

Signed-off-by: Eric Paris <eparis@parisplace.org>

--- linux-2.6.12.1/security/selinux/hooks.c.eric	2005-06-29 14:48:54.000000000 -0400
+++ linux-2.6.12.1/security/selinux/hooks.c	2005-06-29 14:50:38.000000000 -0400
@@ -68,6 +68,7 @@
 #include <linux/personality.h>
 #include <linux/sysctl.h>
 #include <linux/audit.h>
+#include <linux/string.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -1943,7 +1944,7 @@ static int selinux_sb_copy_data(struct f
 		}
 	} while (*in_end++);
 
-	copy_page(in_save, nosec_save);
+	strcpy(in_save, nosec_save);
 	free_page((unsigned long)nosec_save);
 out:
 	return rc;


