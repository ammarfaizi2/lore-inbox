Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264057AbUENLK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbUENLK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUENLK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:10:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:24301 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264057AbUENLKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:10:23 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2)
References: <200405131308.40477.luto@myrealbox.com>
	<20040513182010.L21045@build.pdx.osdl.net>
	<200405131945.53723.luto@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 14 May 2004 13:10:13 +0200
Message-ID: <87d657z2lm.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> +	/* Pretend we have VFS capabilities */
> +	cap_set_full(bprm->cap_inheritable);
> +	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
> +		cap_set_full(bprm->cap_permitted);
> +	else
> +		cap_clear(bprm->cap_permitted);

I'd move this to security/commoncap.c:

diff -urN a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri May 14 10:07:28 2004
+++ b/fs/exec.c	Fri May 14 12:07:18 2004
@@ -912,13 +912,6 @@
 		}
 	}
 
-	/* Pretend we have VFS capabilities */
-	cap_set_full(bprm->cap_inheritable);
-	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
-		cap_set_full(bprm->cap_permitted);
-	else
-		cap_clear(bprm->cap_permitted);
-
 	/* fill in binprm security blob */
 	retval = security_bprm_set(bprm);
 	if (retval)
diff -urN a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c	Fri May 14 10:07:28 2004
+++ b/security/commoncap.c	Fri May 14 12:08:30 2004
@@ -107,8 +107,16 @@
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
-	if (newcaps)
+	if (newcaps) {
+		/* Pretend we have VFS capabilities */
+		cap_set_full(bprm->cap_inheritable);
+		if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
+			cap_set_full(bprm->cap_permitted);
+		else
+			cap_clear(bprm->cap_permitted);
+
 		return 0;
+	}
 
 	/* Copied from fs/exec.c:prepare_binprm. */
 

> +	/* FIXME: Is this overly harsh on setgid? */
> +	if ((bprm->secflags & (BINPRM_SEC_SETUID | BINPRM_SEC_SETGID)) &&
> +	    new_pI != CAP_FULL_SET)
> +			bprm->secflags |= BINPRM_SEC_NOELEVATE;
> +
> +	if (bprm->secflags & BINPRM_SEC_NOELEVATE) {
> +		is_setuid = is_setgid = 0;
> +		cap_clear(fP);
> +	}

This prevents sendmail from being setuid mail and
cap_net_bind_service=ep.

Regards, Olaf.
