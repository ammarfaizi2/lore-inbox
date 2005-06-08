Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVFHU12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFHU12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFHU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:27:28 -0400
Received: from chewbacca.arl.wustl.edu ([128.252.153.149]:23173 "EHLO
	chewbacca.arl.wustl.edu") by vger.kernel.org with ESMTP
	id S261597AbVFHU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:27:23 -0400
Date: Wed, 8 Jun 2005 15:27:15 -0500 (CDT)
From: Manfred Georg <mgeorg@arl.wustl.edu>
To: gregkh@suse.de
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] capabilities not inherited
Message-ID: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was working with passing capabilities through an exec and it
didn't do what I expected it to.  That is, if I set a bit in
the inherited capabilities, it is not "inherited" after an
exec().  After going through the code many times, and still not
understanding it, I hacked together this patch.  It probably
has unforseen side effects and there was probably some
reason it was not done in the first place.

Thanks for the kernel, I have a new found appreciation for it.

Manfred

Patch against 2.6.12-rc6:

Signed-off-by: Manfred Georg <mgeorg@arl.wustl.edu>

diff -uprN -X dontdiff linux-2.6.12-rc6/security/commoncap.c linux/security/commoncap.c
--- linux-2.6.12-rc6/security/commoncap.c	2005-03-02 01:38:07.000000000 -0600
+++ linux/security/commoncap.c	2005-06-08 14:02:21.000000000 -0500
@@ -113,10 +113,11 @@ int cap_bprm_set_security (struct linux_
 {
 	/* Copied from fs/exec.c:prepare_binprm. */

-	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	bprm->cap_inheritable = current->cap_inheritable;
+	bprm->cap_permitted = cap_intersect(current->cap_inheritable,
+	                                    current->cap_permitted);
+	bprm->cap_effective = cap_intersect(bprm->cap_permitted,
+	                                    current->cap_effective);

 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three

