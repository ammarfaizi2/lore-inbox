Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWJDTFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWJDTFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWJDTFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:05:20 -0400
Received: from mail.aknet.ru ([82.179.72.26]:18693 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750841AbWJDTFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:05:18 -0400
Message-ID: <45240640.4070104@aknet.ru>
Date: Wed, 04 Oct 2006 23:06:40 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <1159899820.2891.542.camel@laptopd505.fenrus.org> <4522AEA1.5060304@aknet.ru> <1159900934.2891.548.camel@laptopd505.fenrus.org> <4522B4F9.8000301@aknet.ru> <20061003210037.GO20982@devserv.devel.redhat.com>
In-Reply-To: <20061003210037.GO20982@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------030605090104080602060703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605090104080602060703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Jakub Jelinek wrote:
> Even assuming ld.so would be hacked up so that it parses /proc/mounts
> to see if you are trying to run an executable via ld.so from
> noexec mount (which isn't going to happen),
No, the solution I wanted to evaluate, is "chmod 'go-x' ld.so".
For that to work, something like this is needed:
http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0609.3/2322.html
Then you can't invoke ld.so directly and if you happen to
have "noexec" on all the writeable mounts, then you can't
also use your own ld.so.

> if mmap with PROT_EXEC
> is allowed on noexec mounts, you can always put there a shared
> library instead of a binary and put some interesting stuff in its
> constructors and then just LD_PRELOAD=/dev/shm/libmyhack.so /bin/true
Of course if ld.so would check /proc/mounts, then it will
do so also for the shared libs, so LD_PRELOAD won't trick it.
I understand that parsing /proc/mounts is silly (I have
admitted that earlier in that thread already), but why not to
at least check the access(X_OK)? ld.so _must_ check access(X_OK)
before executing - why not yet?
Oh wait, access(X_OK) doesn't seem to work...
The attached patch is needed to get it working.
Does the patch look good? I think it was just a bug.

> Really, if noexec is supposed to make any sense at all, it needs
> to prevent PROT_EXEC mapping/mprotect, otherwise it is completely
> useless.
Why not having an exec perm on a file doesn't prevent PROT_EXEC then?

In any case, guys, can the attached patch be applied?
Arjan, it enforces "noexec", just as you wanted to see. :)
Please say "no" now, not when I mail it to Andrew, if possible.


--------------030605090104080602060703
Content-Type: text/plain;
 name="acc_noex.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acc_noex.diff"

--- a/fs/namei.c	2006-08-29 14:15:47.000000000 +0400
+++ b/fs/namei.c	2006-10-04 11:28:52.000000000 +0400
@@ -249,9 +249,11 @@
 
 	/*
 	 * MAY_EXEC on regular files requires special handling: We override
-	 * filesystem execute permissions if the mode bits aren't set.
+	 * filesystem execute permissions if the mode bits aren't set or
+	 * the fs is mounted with the "noexec" flag.
 	 */
-	if ((mask & MAY_EXEC) && S_ISREG(mode) && !(mode & S_IXUGO))
+	if ((mask & MAY_EXEC) && S_ISREG(mode) && (!(mode & S_IXUGO) ||
+			(nd && nd->mnt && (nd->mnt->mnt_flags & MNT_NOEXEC))))
 		return -EACCES;
 
 	/* Ordinary permission routines do not understand MAY_APPEND. */

--------------030605090104080602060703--
