Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVKWOBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVKWOBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVKWOBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:01:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55203 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750804AbVKWOBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:01:10 -0500
Date: Wed, 23 Nov 2005 19:34:26 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Fastboot] Re: [PATCH 9/10] kdump: read previous kernel's memory
Message-ID: <20051123140426.GA30814@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com> <20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com> <20051117132944.GM3981@in.ibm.com> <20051117142023.43764d8b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117142023.43764d8b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 02:20:23PM -0800, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > +                               size_t csize, unsigned long offset, int userbuf)
> > +{
> > +	void  *vaddr;
> > +
> > +	if (!csize)
> > +		return 0;
> > +
> > +	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
> > +
> > +	if (userbuf) {
> > +		if (copy_to_user(buf, (vaddr + offset), csize)) {
> > +			kunmap_atomic(vaddr, KM_PTE0);
> > +			return -EFAULT;
> 
> The copy_*_user() inside kmap_atomic() is problematic.
> 
> On some configs (eg, x86, highmem) the process is running atomically, hence
> the copy_*_user() will *refuse* to fault in the user's page if it's not
> present.  Because pagefaulting involves doing things which sleep.
> 
> So
> 
> a) This code will generate might_sleep() warnings at runtime and
> 
> b) It'll return -EFAULT for user pages which haven't been faulted in yet.
> 
> 
> We do all sorts of gruesome tricks in mm/filemap.c to get around all this. 
> I don't think your code is as performance-sensitive, so a suitable fix
> might be to double-copy the data.  Make sure that the same physical page is
> used as a bounce page for each copy (ie: get the caller to pass it in) and
> that page will be cache-hot and the performance should be acceptable.
> 
> If it really is performance-sensitive then you'll need to play filemap.c
> games.  It'd be better to use a sleeping kmap instead, if poss.  That's
> kmap().
> 
> Please send an incremental patch when it's sorted.  

Hi Andrew

Sending along the incremental patch as suggested.

In this patch, a global buffer page is introduced, where the page
from the previous kernel's memory is copied, before copying it
out to a user buffer. This will take care of the issue of
copy_to_user() page faulting in an atomic context.

This patch has been generated against 2.6.15-rc2-mm1.
Kindly review.

Thanks
Rachita



 o This patch allocates a page to copy the previous kernel's memory
   before we copy it onto a user buffer using copy_to_user(), thereby
   taking care of the scenario of a possible page fault in an atomic
   context.



Signed-off-by: Rachita Kothiyal <rachita@in.ibm.com>
---

 arch/i386/kernel/crash_dump.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff -puN arch/i386/kernel/crash_dump.c~double_copy_read_oldmem arch/i386/kernel/crash_dump.c
--- linux-2.6.15-rc2-mm1/arch/i386/kernel/crash_dump.c~double_copy_read_oldmem	2005-11-23 17:50:07.258543864 +0530
+++ linux-2.6.15-rc2-mm1-rachita/arch/i386/kernel/crash_dump.c	2005-11-23 17:50:36.779056064 +0530
@@ -11,6 +11,8 @@
 
 #include <asm/uaccess.h>
 
+static void *kdump_buf_page;
+
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -23,6 +25,10 @@
  *
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ *
+ * Calling copy_to_user() in atomic context is not desirable. Hence first
+ * copying the data to a pre-allocated kernel page and then copying to user
+ * space in non-atomic context.
  */
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
                                size_t csize, unsigned long offset, int userbuf)
@@ -34,14 +40,35 @@ ssize_t copy_oldmem_page(unsigned long p
 
 	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
 
-	if (userbuf) {
-		if (copy_to_user(buf, (vaddr + offset), csize)) {
-			kunmap_atomic(vaddr, KM_PTE0);
+	if (!userbuf) {
+		memcpy(buf, (vaddr + offset), csize);
+		kunmap_atomic(vaddr, KM_PTE0);
+	} else {
+		if (!kdump_buf_page) {
+			printk(KERN_WARNING "Kdump: Kdump buffer page not"
+				" allocated\n");
 			return -EFAULT;
 		}
-	} else
-	memcpy(buf, (vaddr + offset), csize);
+		copy_page(kdump_buf_page, vaddr);
+		kunmap_atomic(vaddr, KM_PTE0);
+		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
+			return -EFAULT;
+	}
 
-	kunmap_atomic(vaddr, KM_PTE0);
 	return csize;
 }
+
+static int __init kdump_buf_page_init(void)
+{
+	int ret = 0;
+
+	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kdump_buf_page) {
+		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
+			 " page\n");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+arch_initcall(kdump_buf_page_init);
_
