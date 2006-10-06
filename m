Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWJFSHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWJFSHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWJFSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:07:44 -0400
Received: from mail.aknet.ru ([82.179.72.26]:11281 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1422795AbWJFSHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:07:43 -0400
Message-ID: <45269BEE.7050008@aknet.ru>
Date: Fri, 06 Oct 2006 22:09:50 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <1159899820.2891.542.camel@laptopd505.fenrus.org> <4522AEA1.5060304@aknet.ru> <1159900934.2891.548.camel@laptopd505.fenrus.org> <4522B4F9.8000301@aknet.ru> <20061003210037.GO20982@devserv.devel.redhat.com> <45240640.4070104@aknet.ru>
In-Reply-To: <45240640.4070104@aknet.ru>
Content-Type: multipart/mixed;
 boundary="------------050100030700070308060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050100030700070308060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

The attached patch makes the access(X_OK) to take the
"noexec" mount option into an account.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>
CC: Jakub Jelinek <jakub@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Hugh Dickins <hugh@veritas.com>
CC: Ulrich Drepper <drepper@redhat.com>


--------------050100030700070308060600
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

--------------050100030700070308060600--
