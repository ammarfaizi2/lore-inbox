Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVILRyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVILRyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVILRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:54:45 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:55689 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751111AbVILRyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:54:44 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Mon, 12 Sep 2005 19:54:33 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3 [OOPS] vfs, page_owner, full reproductively, badness in vsnprintf
Message-ID: <20050912175433.GA8574@localhost.localdomain>
References: <20050912024350.60e89eb1.akpm@osdl.org> <6bffcb0e050912044856628995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e050912044856628995@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 01:48:54PM +0200 Michal Piotrowski wrote:

> Hi,
> 
> [1.] One line summary of the problem:
> System oops when I do F3 (file view) in mc on /proc/page_owner
> 
> [2.] Full description of the problem/report:
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> vfs, page_owner, full reproductively
> 
> [4.] Kernel version (from /proc/version):
> Linux version 2.6.13-mm3 (root@ng02.pl) (gcc version 3.3.5 (Debian
> 1:3.3.5-13)) #4 SMP PREEMPT Mon Sep 12 12:14:24 CEST 2005
> 

Gah, I'm such a fantastic programmer.

I don't know what mc is up to but the error checking in read_page_owner
is flawed wrt snprintf which could cause the 'size' argument to snprintf
to become negative and if so overwrite beyond 'buf'.

Again, I fail to see how mc causes this to happen, but this fixes it
by proper error checking.

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: mm/fs/proc/proc_misc.c
===================================================================
--- mm.orig/fs/proc/proc_misc.c	2005-09-12 16:52:22.000000000 +0200
+++ mm/fs/proc/proc_misc.c	2005-09-12 17:20:13.000000000 +0200
@@ -567,6 +567,7 @@
 	char namebuf[128];
 	unsigned long offset = 0, symsize;
 	int i;
+	ssize_t num_written = 0;
 
 	pfn = min_low_pfn + *ppos;
 	page = pfn_to_page(pfn);
@@ -588,22 +589,40 @@
 	if (!kbuf)
 		return -ENOMEM;
 
-	ret = snprintf(kbuf, 1024, "Page allocated via order %d, mask 0x%x\n",
+	ret = snprintf(kbuf, count, "Page allocated via order %d, mask 0x%x\n",
 			page->order, page->gfp_mask);
+	if (ret >= count) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	num_written = ret;
 
 	for (i = 0; i < 8; i++) {
 		if (!page->trace[i])
 			break;
 		symname = kallsyms_lookup(page->trace[i], &symsize, &offset, &modname, namebuf);
-		ret += snprintf(kbuf + ret, count - ret, "[0x%lx] %s+%lu\n",
+		ret = snprintf(kbuf + num_written, count - num_written, "[0x%lx] %s+%lu\n",
 			page->trace[i], namebuf, offset);
+		if (ret >= count - num_written) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		num_written += ret;
 	}
 
-	ret += snprintf(kbuf + ret, count -ret, "\n");
+	ret = snprintf(kbuf + num_written, count - num_written, "\n");
+	if (ret >= count - num_written) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	num_written += ret;
+	ret = num_written;
 
 	if (copy_to_user(buf, kbuf, ret))
 		ret = -EFAULT;
-
+out:
 	kfree(kbuf);
 	return ret;
 }
