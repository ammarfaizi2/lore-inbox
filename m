Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUAAMD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUAAMDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:03:54 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:13326 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S261262AbUAAMDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:03:42 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
Content-Type: multipart/mixed; boundary="=-FAXpkk2cpTOUsp3AUpPf"
Message-Id: <1072958618.1603.236.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 13:03:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FAXpkk2cpTOUsp3AUpPf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2003-12-31 at 19:21, Jon Smirl wrote:
> The headers for nopageXX calls just changed.
> 
> struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int
> unused);
> changed to:
> struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int
> *type);
> 
> The DRM drivers need to be adjusted. This probably impacts the BSD builds.

No, this is Linux specific.

How does this patch look?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

--=-FAXpkk2cpTOUsp3AUpPf
Content-Disposition: inline; filename=drm-nopage.diff
Content-Type: text/x-patch; name=drm-nopage.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: drmP.h
===================================================================
RCS file: /cvs/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h,v
retrieving revision 1.85
diff -p -u -r1.85 drmP.h
--- drmP.h	5 Nov 2003 08:13:52 -0000	1.85
+++ drmP.h	1 Jan 2004 12:02:05 -0000
@@ -806,18 +819,10 @@ extern int	     DRM(flush)(struct file *
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
+extern struct page   *DRM(vm_nopage)( DRM_NOPAGE_ARGS );
+extern struct page   *DRM(vm_shm_nopage)( DRM_NOPAGE_ARGS );
+extern struct page   *DRM(vm_dma_nopage)( DRM_NOPAGE_ARGS );
+extern struct page   *DRM(vm_sg_nopage)( DRM_NOPAGE_ARGS );
 extern void	     DRM(vm_open)(struct vm_area_struct *vma);
 extern void	     DRM(vm_close)(struct vm_area_struct *vma);
 extern void	     DRM(vm_shm_close)(struct vm_area_struct *vma);
Index: drm_os_linux.h
===================================================================
RCS file: /cvs/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_os_linux.h,v
retrieving revision 1.19
diff -p -u -r1.19 drm_os_linux.h
--- drm_os_linux.h	4 Nov 2003 00:46:05 -0000	1.19
+++ drm_os_linux.h	1 Jan 2004 12:02:05 -0000
@@ -52,6 +52,13 @@ typedef void irqreturn_t;
 #define DRM_AGP_KERN		struct agp_kern_info
 #endif
 
+/** Page fault handler arguments */
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+#define DRM_NOPAGE_ARGS		struct vm_area_struct *vma, unsigned long address, int *type
+#else
+#define DRM_NOPAGE_ARGS		struct vm_area_struct *vma, unsigned long address, int unused
+#endif
+
 /** Task queue handler arguments */
 #define DRM_TASKQUEUE_ARGS	void *arg
 
Index: drm_vm.h
===================================================================
RCS file: /cvs/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_vm.h,v
retrieving revision 1.26
diff -p -u -r1.26 drm_vm.h
--- drm_vm.h	12 Sep 2003 20:00:59 -0000	1.26
+++ drm_vm.h	1 Jan 2004 12:02:05 -0000
@@ -69,15 +69,14 @@ struct vm_operations_struct   DRM(vm_sg_
  *
  * \param vma virtual memory area.
  * \param address access address.
- * \param write_access sharing.
+ * \param type pointer to variable holding the type of fault
+ *        (unused before kernel 2.6.1).
  * \return pointer to the page structure.
  * 
  * Find the right map and if it's AGP memory find the real physical page to
  * map, get the page, increment the use count and return it.
  */
-struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
-			    unsigned long address,
-			    int write_access)
+struct page *DRM(vm_nopage)( DRM_NOPAGE_ARGS )
 {
 #if __REALLY_HAVE_AGP
 	drm_file_t *priv  = vma->vm_file->private_data;
@@ -134,6 +133,10 @@ struct page *DRM(vm_nopage)(struct vm_ar
 			  baddr, __va(agpmem->memory->memory[offset]), offset,
 			  atomic_read(&page->count));
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+		if (type)
+			*type = VM_FAULT_MINOR;
+#endif
 		return page;
         }
 vm_nopage_error:
@@ -147,15 +150,14 @@ vm_nopage_error:
  *
  * \param vma virtual memory area.
  * \param address access address.
- * \param write_access sharing.
+ * \param type pointer to variable holding the type of fault
+ *        (unused before kernel 2.6.1).
  * \return pointer to the page structure.
  * 
  * Get the the mapping, find the real physical page to map, get the page, and
  * return it.
  */
-struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
-				unsigned long address,
-				int write_access)
+struct page *DRM(vm_shm_nopage)( DRM_NOPAGE_ARGS )
 {
 	drm_map_t	 *map	 = (drm_map_t *)vma->vm_private_data;
 	unsigned long	 offset;
@@ -171,6 +173,10 @@ struct page *DRM(vm_shm_nopage)(struct v
 	if (!page)
 		return NOPAGE_OOM;
 	get_page(page);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
 	return page;
@@ -262,14 +268,13 @@ void DRM(vm_shm_close)(struct vm_area_st
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
-struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
-				unsigned long address,
-				int write_access)
+struct page *DRM(vm_dma_nopage)( DRM_NOPAGE_ARGS )
 {
 	drm_file_t	 *priv	 = vma->vm_file->private_data;
 	drm_device_t	 *dev	 = priv->dev;
@@ -288,6 +293,10 @@ struct page *DRM(vm_dma_nopage)(struct v
 			     (offset & (~PAGE_MASK))));
 
 	get_page(page);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
 
 	DRM_DEBUG("dma_nopage 0x%lx (page %lu)\n", address, page_nr);
 	return page;
@@ -298,14 +307,13 @@ struct page *DRM(vm_dma_nopage)(struct v
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
-struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
-			       unsigned long address,
-			       int write_access)
+struct page *DRM(vm_sg_nopage)( DRM_NOPAGE_ARGS )
 {
 	drm_map_t        *map    = (drm_map_t *)vma->vm_private_data;
 	drm_file_t *priv = vma->vm_file->private_data;
@@ -326,6 +334,10 @@ struct page *DRM(vm_sg_nopage)(struct vm
 	page_offset = (offset >> PAGE_SHIFT) + (map_offset >> PAGE_SHIFT);
 	page = entry->pagelist[page_offset];
 	get_page(page);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
 
 	return page;
 }

--=-FAXpkk2cpTOUsp3AUpPf--

