Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWJRSVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWJRSVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWJRSVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:21:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:65111 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422758AbWJRSVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:21:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GA7DpSdrKf3v7OFza/xDXIa9P8mY2MBS9MDRhAPp4vnTHzY7tDp7wliHXGFT3PuoMe0XqqGBzT1S6dMfB8x2DyawNNZfeSVgax6a+BFZ9U/iCyrODpf11rMwv8p2ntwRQpudlI8YB2BKgKS0ROwLOOy3Zmx+OjIpqMXBHoE9kmc=
Date: Wed, 18 Oct 2006 22:21:16 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] OOM killer meets userspace headers
Message-ID: <20061018182116.GB5345@martell.zuzino.mipt.ru>
References: <20061018145305.GA5345@martell.zuzino.mipt.ru> <20061018150948.GA7371@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018150948.GA7371@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 04:09:48PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 18, 2006 at 06:53:05PM +0400, Alexey Dobriyan wrote:
> > Despite mm.h is not being exported header, it does contain one thing
> > which is part of userspace ABI -- value disabling OOM killer. So,
> > a) export mm.h to userspace
> > b) got OOM_DISABLE disable define out of __KERNEL__ prison.
> > c) turn bound values suitable for /proc/$PID/oom_adj into defines and export
> >    them too.
> > d) put some headers into __KERNEL__ prison. It'd bizarre to include mm.h and
> >    get capability stuff.
>
> NACK, mm.h is far too big for that.  Just create a tiny oom.h for those
> values.

It _will_ be tiny after "make headers_install". OTOH, oom.h indeed looks
like logical place.


[PATCH v2] OOM killer meets userspace headers

Despite mm.h is not being exported header, it does contain one thing
which is part of userspace ABI -- value disabling OOM killer for given
process. So,
a) create and export include/linux/oom.h
b) move OOM_DISABLE define there.
c) turn bounding values of /proc/$PID/oom_adj into defines and export
   them too.

Note: mass __KERNEL__ removal will be done later.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c       |    4 +++-
 include/linux/Kbuild |    1 +
 include/linux/mm.h   |    3 ---
 include/linux/oom.h  |   10 ++++++++++
 mm/oom_kill.c        |    1 +
 5 files changed, 15 insertions(+), 4 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -72,6 +72,7 @@ #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
 #include <linux/nsproxy.h>
+#include <linux/oom.h>
 #include "internal.h"
 
 /* NOTE:
@@ -689,7 +690,8 @@ static ssize_t oom_adjust_write(struct f
 	if (copy_from_user(buffer, buf, count))
 		return -EFAULT;
 	oom_adjust = simple_strtol(buffer, &end, 0);
-	if ((oom_adjust < -16 || oom_adjust > 15) && oom_adjust != OOM_DISABLE)
+	if ((oom_adjust < OOM_ADJUST_MIN || oom_adjust > OOM_ADJUST_MAX) &&
+	     oom_adjust != OOM_DISABLE)
 		return -EINVAL;
 	if (*end == '\n')
 		end++;
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -120,6 +120,7 @@ header-y += netrom.h
 header-y += nfs2.h
 header-y += nfs4_mount.h
 header-y += nfs_mount.h
+header-y += oom.h
 header-y += param.h
 header-y += pci_ids.h
 header-y += pci_regs.h
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1115,9 +1115,6 @@ int in_gate_area_no_task(unsigned long a
 #define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
-#define OOM_DISABLE -17
-
 int drop_caches_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 unsigned long shrink_slab(unsigned long scanned, gfp_t gfp_mask,
--- /dev/null
+++ b/include/linux/oom.h
@@ -0,0 +1,10 @@
+#ifndef __INCLUDE_LINUX_OOM_H
+#define __INCLUDE_LINUX_OOM_H
+
+/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
+#define OOM_DISABLE (-17)
+/* inclusive */
+#define OOM_ADJUST_MIN (-16)
+#define OOM_ADJUST_MAX 15
+
+#endif
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -15,6 +15,7 @@
  *  kernel subsystems and hints as to where to find out what things do.
  */
 
+#include <linux/oom.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>

