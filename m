Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTLGNjN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTLGNjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:39:13 -0500
Received: from smtp.mailix.net ([216.148.213.132]:25410 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S264477AbTLGNjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:39:11 -0500
Date: Sun, 7 Dec 2003 14:39:06 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] FIx 'noexec' behavior
Message-ID: <20031207133906.GA1140@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-12-07 12:17:37, wli wrote:
> You took a fault in do_mmap_pgoff().
...
> +		if (file->f_vfsmnt && (prot & PROT_EXEC)) {
> +			if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)
> +				return -EPERM;
> +		}

I had to put a check for 'file' (as Ulrich suggested).
Otherwise it deadlocks again.
Is it possible for ->f_vfsmnt to be NULL at all? Should it be tested?

diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c Sun Dec  7 14:37:33 2003
+++ b/mm/mmap.c Sun Dec  7 14:37:33 2003
@@ -478,7 +478,7 @@
        if (file && (!file->f_op || !file->f_op->mmap))
                return -ENODEV;
 
-       if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+       if ((prot & PROT_EXEC) && file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
                return -EPERM;
 
        if (!len)

