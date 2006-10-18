Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWJROxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWJROxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJROxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:53:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:24973 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161095AbWJROxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:53:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=WRhDIzgSbAs8/gju6qnCGCTY94P9ZhJ6sv7y7NfiKDNstcEkJK2+wlAaHO7fhPszBCD6STgABH1Fxmjw/GiV5jIpK3vJb//FIQxvQ8p/JiyiD8NmcD1xwlknUv23LEFPLnxaYMS4wMN60r3bragBT86u1M82zIg73wbrOSrqGq0=
Date: Wed, 18 Oct 2006 18:53:05 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] OOM killer meets userspace headers
Message-ID: <20061018145305.GA5345@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Despite mm.h is not being exported header, it does contain one thing
which is part of userspace ABI -- value disabling OOM killer. So,
a) export mm.h to userspace
b) got OOM_DISABLE disable define out of __KERNEL__ prison.
c) turn bound values suitable for /proc/$PID/oom_adj into defines and export
   them too.
d) put some headers into __KERNEL__ prison. It'd bizarre to include mm.h and
   get capability stuff.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c       |    3 ++-
 include/linux/Kbuild |    2 ++
 include/linux/mm.h   |   13 +++++++------
 3 files changed, 11 insertions(+), 7 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -689,7 +689,8 @@ static ssize_t oom_adjust_write(struct f
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
@@ -110,6 +110,7 @@ header-y += major.h
 header-y += matroxfb.h
 header-y += meye.h
 header-y += minix_fs.h
+header-y += mm.h
 header-y += mmtimer.h
 header-y += mqueue.h
 header-y += mtio.h
@@ -257,6 +258,7 @@ unifdef-y += loop.h
 unifdef-y += lp.h
 unifdef-y += mempolicy.h
 unifdef-y += mii.h
+unifdef-y += mm.h
 unifdef-y += mman.h
 unifdef-y += mroute.h
 unifdef-y += msdos_fs.h
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1,12 +1,16 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
+#define OOM_DISABLE (-17)
+/* inclusive */
+#define OOM_ADJUST_MIN (-16)
+#define OOM_ADJUST_MAX 15
+
+#ifdef __KERNEL__
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/capability.h>
-
-#ifdef __KERNEL__
-
 #include <linux/gfp.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -1115,9 +1119,6 @@ int in_gate_area_no_task(unsigned long a
 #define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
-#define OOM_DISABLE -17
-
 int drop_caches_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 unsigned long shrink_slab(unsigned long scanned, gfp_t gfp_mask,

