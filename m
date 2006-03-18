Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWCRRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWCRRoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWCRRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:44:09 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:62155 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750745AbWCRRoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:44:07 -0500
Message-ID: <441C4636.15F57F6@tv-sign.ru>
Date: Sat, 18 Mar 2006 20:41:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Janak Desai <janak@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk,
       hch@lst.de, mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: [PATCH] for 2.6.16, disable unshare_vm()
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>		<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>		<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org> <441C0741.3BC25010@tv-sign.ru> <441C2AA0.3080200@us.ibm.com> <441C4263.B779CDA8@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_unshare() does mmput(new_mm). This is not enough
if we have mm->core_waiters. This patch is a temporary
fix for soon to be released 2.6.16.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/fork.c~	2006-03-18 23:15:13.000000000 +0300
+++ MM/kernel/fork.c	2006-03-18 23:15:56.000000000 +0300
@@ -1512,9 +1512,7 @@ static int unshare_vm(unsigned long unsh
 
 	if ((unshare_flags & CLONE_VM) &&
 	    (mm && atomic_read(&mm->mm_users) > 1)) {
-		*new_mmp = dup_mm(current);
-		if (!*new_mmp)
-			return -ENOMEM;
+		return -EINVAL;
 	}
 
 	return 0;
