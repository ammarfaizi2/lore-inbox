Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTKTC3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTKTC3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:29:45 -0500
Received: from c-24-6-236-77.client.comcast.net ([24.6.236.77]:2267 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261188AbTKTC3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:29:43 -0500
Date: Wed, 19 Nov 2003 18:22:46 -0500
From: Christopher Li <lkml@chrisli.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031119232246.GA20840@64m.dyndns.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031119223425.GA20549@64m.dyndns.org> <20031120014718.GA22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120014718.GA22764@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,  I post a totally untested patch follows, but the testing of
which kernel has this feature is not completed yet.

Is there a way to reliably detect which kernel has this change?

Look at all the ifdef I need to make to keep the module working
with other kernels.  :-(

Best Regards,

Chris


--- /tmp/p5diffhtml.tmp1.27140	2003-11-19 18:28:07.000000000 -0800
+++ /modules/shared/linux/compat_version.h	2003-11-19 18:25:12.000000000 -0800
@@ -96,5 +96,10 @@
 #   define KERNEL_2_5_5
 #endif
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
+/*  New status return pointer in vmop->nopage() */
+/*  FIXME: We need to test against 2.6.0-test9-mm4 */
+#   define KERNEL_2_6_0_TEST9_MM4
+#endif
 
 #endif /* __COMPAT_VERSION_H__ */
--- /tmp/p5diffhtml.tmp1.27140	2003-11-19 18:28:07.000000000 -0800
+++ /modules/vmmon/linux/driver.c	2003-11-19 18:26:28.000000000 -0800
@@ -548,6 +548,11 @@
  *-----------------------------------------------------------------------------
  */
 
+#ifdef KERNEL_2_6_0_TEST9_MM4
+static struct page *LinuxDriverNoPage(struct vm_area_struct *vma, //IN
+				      unsigned long address, 	  //IN
+				      int *type)		  //OUT
+#else
 #ifdef KERNEL_2_4_0
 static struct page *LinuxDriverNoPage(struct vm_area_struct *vma, //IN
 				      unsigned long address, 	  //IN
@@ -557,6 +562,7 @@
 				       unsigned long address,	  //IN
 				       int write_access)	  //IN
 #endif
+#endif
 {
 	VMLinux *vmLinux = (VMLinux *) vma->vm_file->private_data;
 	unsigned long pg;
@@ -566,6 +572,11 @@
 		return 0;
 	}
 	get_page(virt_to_page(vmLinux->pages4Gb[pg]));
+#ifdef KERNEL_2_6_0_TEST9_MM4
+	if (type) {
+		*type = VM_FAULT_MINOR;
+	}
+#endif
 #ifdef KERNEL_2_4_0
 	return virt_to_page(vmLinux->pages4Gb[pg]);
 #else
On Wed, Nov 19, 2003 at 05:47:18PM -0800, William Lee Irwin III wrote:
> On Wed, Nov 19, 2003 at 05:34:25PM -0500, Christopher Li wrote:
> > Can send me a few more lines of the log file before and after that message? I can take
> > a look at what is going on there. Most likely vmmon driver get confused.
> 
> You should have a vm_ops->nopage() method that didn't get updated.
> The formerly-unused argument got turned into a status return pointer,
> so you need to do something like:
> 
> struct page *vmmon_nopage(struct vm_area_struct *vma, unsigned long addr, int *type)
> {
> 	...
> 	if (type)
> 		*type = VM_FAULT_MINOR;
> 	return page;
> }
> 
> It should also give off a big fat warning about initialization from
> incompatible pointer types when compiled.
> 
> 
> -- wli
