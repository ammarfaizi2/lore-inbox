Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUEJWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUEJWA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUEJWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:00:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:43668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbUEJV7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:59:32 -0400
Date: Mon, 10 May 2004 15:02:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510150203.3257ccac.akpm@osdl.org>
In-Reply-To: <20040510223755.A7773@infradead.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > +hugetlb_shm_group-sysctl-patch.patch
> > 
> >  Add /proc/sys/vm/hugetlb_shm_group: this holds the group ID of users who may
> >  allocate hugetlb shm segments without CAP_IPC_LOCK.  For Oracle.
> > 
> > +mlock_group-sysctl.patch
> > 
> >  /proc/sys/vm/mlock_group: group ID of users who can do mlock() without
> >  CAP_IPC_LOCK.  Not sure that we need this.
> 
> These two just introduced a subtile behaviour change during stable series,
> possibly (not likely) leading to DoS opportunities from applications running
> as gid 0.

mlock_group is likely to go away.

Is an unprivileged user likely to have gid 0?   Easy enough to fix, anyway.

--- 25/fs/hugetlbfs/inode.c~hugetlb_shm_group-sysctl-gid-0-fix	Mon May 10 14:57:31 2004
+++ 25-akpm/fs/hugetlbfs/inode.c	Mon May 10 14:58:59 2004
@@ -722,8 +722,11 @@ static unsigned long hugetlbfs_counter(v
 
 static int can_do_hugetlb_shm(void)
 {
-	return likely(capable(CAP_IPC_LOCK) ||
-			in_group_p(sysctl_hugetlb_shm_group));
+	if (capable(CAP_IPC_LOCK))
+		return 1;
+	if (sysctl_hugetlb_shm_group == 0)
+		return 0;
+	return in_group_p(sysctl_hugetlb_shm_group);
 }
 
 struct file *hugetlb_zero_setup(size_t size)

>  Really, with capabilities first and now selinux we have moved
> away from treating uid 0 special, so introducing special casing of a gid
> now is more than just braindead.

Capabilities are broken and don't work.  Nobody has a clue how to provide
the required services with SELinux and nobody has any code and we need the
feature *now* before vendors go shipping even more ghastly stuff.

