Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVADXql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVADXql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVADXhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:37:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:8886 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262426AbVADXYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:24:12 -0500
Date: Tue, 4 Jan 2005 15:24:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, chrisw@osdl.org
Subject: Re: [PATCH] track capabilities in default dummy security module code
Message-ID: <20050104152409.C2357@build.pdx.osdl.net>
References: <20050104133313.D469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104133313.D469@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, Jan 04, 2005 at 01:33:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> Switch dummy logic around to set cap_* bits during exec and set*uid based
> on basic uid check.  Then check cap_* bits during capable() (rather than
> doing basic uid check).  This ensures that capability bits are properly
> initialized in case the capability module is later loaded.

OK, somehow I managed to botch this one.  It happens to work fine, but I
should have been more careful with forward porting this 1+ year old patch.
The exec-time calc should go in bprm_apply_creds, not bprm_free_security.
Thanks to Stephen for spotting my mistake.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/dummy.c 1.50 vs edited =====
--- 1.50/security/dummy.c	2005-01-04 13:14:10 -08:00
+++ edited/security/dummy.c	2005-01-04 14:45:31 -08:00
@@ -180,7 +180,6 @@ static int dummy_bprm_alloc_security (st
 
 static void dummy_bprm_free_security (struct linux_binprm *bprm)
 {
-	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
 	return;
 }
 
@@ -197,6 +196,8 @@ static void dummy_bprm_apply_creds (stru
 
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
+	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
 }
 
 static int dummy_bprm_set_security (struct linux_binprm *bprm)
