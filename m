Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWDJTmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWDJTmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWDJTmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:42:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:9305 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932117AbWDJTma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:42:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=l6DOfPPXjd3+Udhx+YZe8MOP3mpUvWKmEN0r7uxSL6ugILF0QjU9KUjPJQdPgt73I
	KMfRY/JRs4TmpUBuqVZ4A==
Message-ID: <608a53b0604101242v4778af80ybaf639c38cc00587@mail.google.com>
Date: Tue, 11 Apr 2006 01:12:24 +0530
From: "Prasanna Meda" <mlp@google.com>
To: akpm@osdl.org, ebiederm@xmission.com
Subject: Comment about proc-dont-lock-task_structs-indefinitely.patch
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   In reply to http://marc.theaimsgroup.com/?l=linux-kernel&m=114119848908725&q=raw
I was not following and  just noticed it.  The bug is introduced in the patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/proc-dont-lock-task_structs-indefinitely.patch

The task decrement problem is fixed, but I think we have two more
problems in the following patch segment.

The priv->tail_vma should not be set NULL; In old code, the local
variable tail vma was overloaded for two more purposes as return value
and also in version calculation, in addition to beging initialised
from  gate vma. It we set the priv->tail_vma as NULL as the following
patch does, and if we seek back, we will not be able to see the gate
vma anymore from m_next.

@@ -337,35 +349,37 @@ static void *m_start(struct seq_file *m,
 	}

 	if (l != mm->map_count)
-		tail_vma = NULL; /* After gate vma */
+		priv->tail_vma = NULL; /* After gate vma */

 out:
  	if (vma)
  		return vma;

  	/* End of vmas has been reached */
-	m->version = (tail_vma != NULL)? 0: -1UL;
+	m->version = (priv->tail_vma != NULL)? 0: -1UL;
 	up_read(&mm->mmap_sem);
  	mmput(mm);
-	return tail_vma;
+	return priv->tail_vma;


Thanks,
Prasanna.
