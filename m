Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUAAO2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 09:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUAAO2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 09:28:18 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:271 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S261660AbUAAO2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 09:28:03 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040101122851.GA13671@devserv.devel.redhat.com>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
	 <1072958618.1603.236.camel@thor.asgaard.local>
	 <1072959055.5717.1.camel@laptop.fenrus.com>
	 <1072959820.1600.252.camel@thor.asgaard.local>
	 <20040101122851.GA13671@devserv.devel.redhat.com>
Content-Type: multipart/mixed; boundary="=-O9M85//BouIYvswKOCQx"
Message-Id: <1072967278.1603.270.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 15:27:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O9M85//BouIYvswKOCQx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 2004-01-01 at 13:28, Arjan van de Ven wrote:
> On Thu, Jan 01, 2004 at 01:23:40PM +0100, Michel Dänzer wrote:
> > > 
> > > I find using #defines for function arguments ugly beyond belief and
> > > makes it really hard to look through code. I 10x rather have an ifdef in
> > > the function prototype (which then for the mainstream kernel drm can be
> > > removed for non-matching versions) than such obfuscation.
> > 
> > That doesn't strike me as particularly beautiful either... 
> 
> well the advantage is that the ifdefs can just go away in kernel trees of
> specific versions... (eg unifdef it)

Does this look better? Maybe a macro (or a typedef?) for the type of the
last argument would still be a good idea? Or is there yet a better way?


> > is it really easier for merges, considering that the ugly way is kinda
> > needed for functions which take different arguments on BSD anyway?
> 
> I disagree there. The "BSD takes different arguments" thing *should* be
> fixed imo by making the common core of the function an inline function, and have
> one or two (depends if the common core happens to have its arguments in common
> with one of the oses) OS specific wrappers with the right prototype. This
> way the difference in error return sign can also be solved in the wrapper
> instead of with a nasty macro...
> 
> The compiler generates the same code, but it's a lot easier to read/review.

Interesting, sounds like food for thought for Eric Anholt. :)


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

--=-O9M85//BouIYvswKOCQx
Content-Disposition: inline; filename=drm-nopage.diff
Content-Type: text/x-patch; name=drm-nopage.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: drmP.h
===================================================================
RCS file: /cvs/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h,v
retrieving revision 1.85
diff -p -u -r1.85 drmP.h
--- drmP.h	5 Nov 2003 08:13:52 -0000	1.85
+++ drmP.h	1 Jan 2004 14:16:30 -0000
@@ -806,18 +819,34 @@ extern int	     DRM(flush)(struct file *
 extern int	     DRM(fasync)(int fd, struct file *filp, int on);
 
 				/* Mapping support (drm_vm.h) */
-extern struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
-				   unsigned long address,
-				   int write_access);
-extern struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
-				       unsigned long address,
-				       int write_access);
-extern struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
-				       unsigned long address,
-				       int write_access);
-extern struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
-				      unsigned long address,
-				      int write_access);
+extern struct page   *DRM(vm_nopage)(struct vm_area_struct *vma,
+				     unsigned long address,
+				     int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+				     *
+#endif
+				     type);
+extern struct page   *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
+					 unsigned long address,
+					 int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+					 *
+#endif
+					 type);
+extern struct page   *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
+					 unsigned long address,
+					 int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+					 *
+#endif
+					 type);
+extern struct page   *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
+					unsigned long address,
+					int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+					*
+#endif
+					type);
 extern void	     DRM(vm_open)(struct vm_area_struct *vma);
 extern void	     DRM(vm_close)(struct vm_area_struct *vma);
 extern void	     DRM(vm_shm_close)(struct vm_area_struct *vma);
Index: drm_vm.h
===================================================================
RCS file: /cvs/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_vm.h,v
retrieving revision 1.26
diff -p -u -r1.26 drm_vm.h
--- drm_vm.h	12 Sep 2003 20:00:59 -0000	1.26
+++ drm_vm.h	1 Jan 2004 14:16:30 -0000
@@ -69,7 +69,8 @@ struct vm_operations_struct   DRM(vm_sg_
  *
  * \param vma virtual memory area.
  * \param address access address.
- * \param write_access sharing.
+ * \param type pointer to variable holding the type of fault
+ *        (unused before kernel 2.6.1).
  * \return pointer to the page structure.
  * 
  * Find the right map and if it's AGP memory find the real physical page to
@@ -77,7 +78,11 @@ struct vm_operations_struct   DRM(vm_sg_
  */
 struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
 			    unsigned long address,
-			    int write_access)
+			    int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+			    *
+#endif
+			    type)
 {
 #if __REALLY_HAVE_AGP
 	drm_file_t *priv  = vma->vm_file->private_data;
@@ -134,6 +139,10 @@ struct page *DRM(vm_nopage)(struct vm_ar
 			  baddr, __va(agpmem->memory->memory[offset]), offset,
 			  atomic_read(&page->count));
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+		if (type)
+			*type = VM_FAULT_MINOR;
+#endif
 		return page;
         }
 vm_nopage_error:
@@ -147,7 +156,8 @@ vm_nopage_error:
  *
  * \param vma virtual memory area.
  * \param address access address.
- * \param write_access sharing.
+ * \param type pointer to variable holding the type of fault
+ *        (unused before kernel 2.6.1).
  * \return pointer to the page structure.
  * 
  * Get the the mapping, find the real physical page to map, get the page, and
@@ -155,7 +165,11 @@ vm_nopage_error:
  */
 struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
 				unsigned long address,
-				int write_access)
+				int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+				*
+#endif
+				type)
 {
 	drm_map_t	 *map	 = (drm_map_t *)vma->vm_private_data;
 	unsigned long	 offset;
@@ -171,6 +185,10 @@ struct page *DRM(vm_shm_nopage)(struct v
 	if (!page)
 		return NOPAGE_OOM;
 	get_page(page);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
 	return page;
@@ -262,14 +280,19 @@ void DRM(vm_shm_close)(struct vm_area_st
  *
  * \param vma virtual memory area.
  * \param address access address.
- * \param write_access sharing.
+ * \param type pointer to variable holding the type of fault
+ *        (unused before kernel 2.6.1).
  * \return pointer to the page structure.
  * 
  * Determine the page number from the page offset and get it from drm_device_dma::pagelist.
  */
 struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
 				unsigned long address,
-				int write_access)
+				int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+				*
+#endif
+				type)
 {
 	drm_file_t	 *priv	 = vma->vm_file->private_data;
 	drm_device_t	 *dev	 = priv->dev;
@@ -288,6 +311,10 @@ struct page *DRM(vm_dma_nopage)(struct v
 			     (offset & (~PAGE_MASK))));
 
 	get_page(page);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
 
 	DRM_DEBUG("dma_nopage 0x%lx (page %lu)\n", address, page_nr);
 	return page;
@@ -298,14 +325,19 @@ struct page *DRM(vm_dma_nopage)(struct v
  *
  * \param vma virtual memory area.
  * \param address access address.
- * \param write_access sharing.
+ * \param type pointer to variable holding the type of fault
+ *        (unused before kernel 2.6.1).
  * \return pointer to the page structure.
  * 
  * Determine the map offset from the page offset and get it from drm_sg_mem::pagelist.
  */
 struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
 			       unsigned long address,
-			       int write_access)
+			       int
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+			       *
+#endif
+			       type)
 {
 	drm_map_t        *map    = (drm_map_t *)vma->vm_private_data;
 	drm_file_t *priv = vma->vm_file->private_data;
@@ -326,6 +358,10 @@ struct page *DRM(vm_sg_nopage)(struct vm
 	page_offset = (offset >> PAGE_SHIFT) + (map_offset >> PAGE_SHIFT);
 	page = entry->pagelist[page_offset];
 	get_page(page);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
 
 	return page;
 }

--=-O9M85//BouIYvswKOCQx--

