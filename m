Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWDNCfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWDNCfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWDNCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:34:59 -0400
Received: from mga03.intel.com ([143.182.124.21]:10574 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965046AbWDNCe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:34:58 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23049856:sNHT18343612"
Subject: Re: [PATCH 6/8] IA64 various hugepage size - introduce prctl
	options to set/get hugepage size
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Tony <tony.luck@intel.com>,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144975746.5817.94.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
	 <1144974667.5817.51.camel@linux-znh>  <1144974881.5817.59.camel@linux-znh>
	 <1144975292.5817.74.camel@linux-znh>  <1144975523.5817.84.camel@linux-znh>
	 <1144975746.5817.94.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144975953.5817.102.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:52:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 2 prctl option to set/get hugepage size.


Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

diff -Nraup a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	2006-04-13 08:41:37.000000000 +0800
+++ b/arch/ia64/mm/hugetlbpage.c	2006-04-13 08:34:57.000000000 +0800
@@ -194,3 +194,25 @@ int is_valid_hpage_size(unsigned long lo
         return 1;
 }
 
+int set_hugepagesize(struct task_struct *task,unsigned long size)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+	unsigned int shift;
+	if (!is_valid_hpage_size(size))
+		return -EINVAL;
+	shift = __ffs(size);
+	if (shift == mm->hugepage_shift)
+		return 0;
+	down_write(&mm->mmap_sem);
+	for (vma = mm->mmap; vma ; vma = vma->vm_next) {
+		if (vma->vm_flags & VM_HUGETLB) {
+			up_write(&mm->mmap_sem);
+			return -EPERM;
+		}
+	}
+	mm->hugepage_shift = shift;
+	activate_mm(mm, mm);
+	up_write(&mm->mmap_sem);
+	return 0;
+}
diff -Nraup a/include/asm-ia64/page.h b/include/asm-ia64/page.h
--- a/include/asm-ia64/page.h	2006-04-13 08:41:37.000000000 +0800
+++ b/include/asm-ia64/page.h	2006-04-13 08:30:21.000000000 +0800
@@ -166,6 +166,8 @@ typedef union ia64_va {
 	 (REGION_NUMBER(addr) == RGN_HPAGE ||	\
 	  REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE)
 extern unsigned int init_hpage_shift;
+struct task_struct;
+extern int set_hugepagesize(struct task_struct *,unsigned long);
 #endif
 
 static __inline__ int
diff -Nraup a/include/asm-ia64/processor.h b/include/asm-ia64/processor.h
--- a/include/asm-ia64/processor.h	2006-04-13 08:41:37.000000000 +0800
+++ b/include/asm-ia64/processor.h	2006-04-13 08:30:13.000000000 +0800
@@ -211,6 +211,14 @@ typedef struct {
 		 (int __user *) (addr));							\
 })
 
+#ifdef CONFIG_HUGETLB_PAGE
+#define	GET_HUGEPAGESIZE(task,addr) \
+({	put_user((1UL<<(task)->mm->hugepage_shift), \
+		(unsigned long __user *)(addr)); \
+})
+#define SET_HUGEPAGESIZE(task,size) set_hugepagesize(task,size)
+#endif
+
 #ifdef CONFIG_IA32_SUPPORT
 struct desc_struct {
 	unsigned int a, b;
diff -Nraup a/include/linux/prctl.h b/include/linux/prctl.h
--- a/include/linux/prctl.h	2006-03-20 13:53:29.000000000 +0800
+++ b/include/linux/prctl.h	2006-04-13 08:43:37.000000000 +0800
@@ -52,4 +52,8 @@
 #define PR_SET_NAME    15		/* Set process name */
 #define PR_GET_NAME    16		/* Get process name */
 
+/* Get/set task huge page size (if meaningful) */
+#define PR_SET_HUGEPAGE_SIZE	17
+#define PR_GET_HUGEPAGE_SIZE	18
+
 #endif /* _LINUX_PRCTL_H */
diff -Nraup a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	2006-04-13 08:41:37.000000000 +0800
+++ b/kernel/sys.c	2006-04-13 08:47:41.000000000 +0800
@@ -57,6 +57,12 @@
 #ifndef GET_FPEXC_CTL
 # define GET_FPEXC_CTL(a,b)	(-EINVAL)
 #endif
+#ifndef GET_HUGEPAGESIZE
+# define GET_HUGEPAGESIZE(a,b)  (-EINVAL)
+#endif
+#ifndef SET_HUGEPAGESIZE
+# define SET_HUGEPAGESIZE(a,b)  (-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2057,6 +2063,12 @@ asmlinkage long sys_prctl(int option, un
 				return -EFAULT;
 			return 0;
 		}
+		case PR_SET_HUGEPAGE_SIZE:
+			error = SET_HUGEPAGESIZE(current, arg2);
+			break;
+		case PR_GET_HUGEPAGE_SIZE:
+			error = GET_HUGEPAGESIZE(current, arg2);
+			break;
 		default:
 			error = -EINVAL;
 			break;

