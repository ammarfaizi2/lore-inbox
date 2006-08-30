Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWH3OTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWH3OTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWH3OTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:19:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:12019 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750918AbWH3OTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:19:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DliOlMcNaOg8tVBHOWcnwb42xzpQABKYmUXx3X6L3kdkaaSLsu+cVNDHTRHEJ/3awuQxWoyysyRLvOphp0OIZrhFGvExca97A4tYFFrt0Eu84H7Gbf8zG+idaWXydspxltdOtLgBx9co65ToFuCwxf/6mAmKPP51mtAFeFU53E8=
Message-ID: <44F59E79.2080402@gmail.com>
Date: Wed, 30 Aug 2006 22:19:37 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Zach Brown <zab@zabbo.net>, Andrew Morton <akpm@osdl.org>,
       linux-aio <linux-aio@kvack.org>, torvalds@osdl.org
Subject: [2.6.18-rc5 PATCH]: aio cleanup
References: <44F43F46.1070702@gmail.com> <44F48825.4050408@zabbo.net>
In-Reply-To: <44F48825.4050408@zabbo.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Zach Brown said, a cleanup patch is reasonable. Here it is.

This patch extracts the common part from aio_fsync and aio_fdsync
 and define a new inlined function aio_xsync, then aio_fsync and 
aio_fdsync just call aio_xsunc in the almost same way except second
 argument is different, one is 1 and another 0.

--- a/fs/aio.c.orig	2006-08-30 22:00:00.000000000 +0800
+++ b/fs/aio.c	2006-08-30 22:08:35.000000000 +0800
@@ -1363,24 +1363,24 @@ static ssize_t aio_pwrite(struct kiocb *
 	return ret;
 }
 
-static ssize_t aio_fdsync(struct kiocb *iocb)
+static inline ssize_t aio_xsync(struct kiocb *iocb, int flags)
 {
 	struct file *file = iocb->ki_filp;
 	ssize_t ret = -EINVAL;
 
 	if (file->f_op->aio_fsync)
-		ret = file->f_op->aio_fsync(iocb, 1);
+		ret = file->f_op->aio_fsync(iocb, flags);
 	return ret;
 }
 
-static ssize_t aio_fsync(struct kiocb *iocb)
+static ssize_t aio_fdsync(struct kiocb *iocb)
 {
-	struct file *file = iocb->ki_filp;
-	ssize_t ret = -EINVAL;
+	return aio_xsync(iocb, 1);
+}
 
-	if (file->f_op->aio_fsync)
-		ret = file->f_op->aio_fsync(iocb, 0);
-	return ret;
+static ssize_t aio_fsync(struct kiocb *iocb)
+{
+	return aio_xsync(iocb, 0);
 }
 
 /*


