Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUDJJQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 05:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDJJQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 05:16:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:14790 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261988AbUDJJQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 05:16:14 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race
References: <4076F02E.1000809@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 10 Apr 2004 11:16:06 +0200
Message-ID: <87fzbc19d5.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> The setuid program is now running with uid=euid=500 but full permitted
> capabilities.  There are two (or three) ways to effectively get local
> root now:

What about this slightly shorter fix?

diff -urN a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri Mar 12 01:19:06 2004
+++ b/fs/exec.c	Sat Apr 10 10:54:20 2004
@@ -942,6 +942,9 @@
 			if(!capable(CAP_SETUID)) {
 				bprm->e_uid = current->uid;
 				bprm->e_gid = current->gid;
+				cap_clear (bprm->cap_inheritable);
+				cap_clear (bprm->cap_permitted);
+				cap_clear (bprm->cap_effective);
 			}
 		}
 	}

Regards, Olaf.
