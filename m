Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVIAIAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVIAIAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVIAIAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:00:36 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:24415 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965082AbVIAIAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:00:36 -0400
Message-ID: <4316B61B.9070305@sw.ru>
Date: Thu, 01 Sep 2005 12:04:43 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] replace hack with dget/mntget usage in fs/dcookies.c
Content-Type: multipart/mixed;
 boundary="------------050008070107000403050509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050008070107000403050509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch replaces manual incrementing of refcounters on dentry/mnt in 
fs/dcookie.c with calls to dget()/mntget().
Noticed this when tried to change logic in dget() and it began to oops.

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------050008070107000403050509
Content-Type: text/plain;
 name="diff-fs-dcookie-20050823"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-fs-dcookie-20050823"

--- linux-2.6.8.1-t032/fs/dcookies.c.dget	2004-08-14 14:54:46.000000000 +0400
+++ linux-2.6.8.1-t032/fs/dcookies.c	2005-08-23 14:09:00.000000000 +0400
@@ -93,12 +93,10 @@ static struct dcookie_struct * alloc_dco
 	if (!dcs)
 		return NULL;
 
-	atomic_inc(&dentry->d_count);
-	atomic_inc(&vfsmnt->mnt_count);
 	dentry->d_cookie = dcs;
 
-	dcs->dentry = dentry;
-	dcs->vfsmnt = vfsmnt;
+	dcs->dentry = dget(dentry);
+	dcs->vfsmnt = mntget(vfsmnt);
 	hash_dcookie(dcs);
 
 	return dcs;

--------------050008070107000403050509--

