Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVAYBOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVAYBOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVAYA4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:56:32 -0500
Received: from palrel10.hp.com ([156.153.255.245]:2501 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261719AbVAYAv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:51:59 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.38947.35646.558780@napali.hpl.hp.com>
Date: Mon, 24 Jan 2005 16:51:47 -0800
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-ia64@vger.kernel.org, davidm@hpl.hp.com, tony.luck@intel.com,
       bgerst@didntduck.org, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: patch to enable Nvidia v5336 on v2.6.11 kernel (was Re: inter_module_get and __symbol_get)
In-Reply-To: <31612.1106607781@ocs3.ocs.com.au>
References: <16885.32149.788747.550216@napali.hpl.hp.com>
	<31612.1106607781@ocs3.ocs.com.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 25 Jan 2005 10:03:01 +1100, Keith Owens <kaos@ocs.com.au> said:

  Keith> I have always hated the dynamic resolution model used by
  Keith> DRM/AGP and (originally) MTD.

Well, the attached patch does the trick for me for Nvidia driver v5336
on ia64.  It compiles with a minimum amount of fuss with gcc v3.4
(just a handful of warnings about deprecated pm_{un,}register() and
inter_module_put()).

I have only tried it against 2.6.11-rc2 (really: Linus' bk tree as of
today) but I hope I didn't screw up backwards compatibility for older
kernels too badly.

Note: I removed the super-user sanity check---I hate that one since it
prevents me from building the module on an NFS-mounted file-system.
If you don't care for that bit, just omit the patch to conftest.sh.

	--david

diff -urN -x nv_compiler.h -x '*.mod.c' -x '*.ko' -x '*.d' -x '*.o' -x '*~' -x build -x Makefile -x '.*' NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/Makefile.kbuild NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/Makefile.kbuild
--- NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/Makefile.kbuild	2004-01-16 12:46:59.000000000 -0800
+++ NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/Makefile.kbuild	2005-01-24 15:49:37.000000000 -0800
@@ -73,7 +73,7 @@
 #
 
 EXTRA_CFLAGS += -I$(src)
-EXTRA_CFLAGS += -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts -Wparentheses -Wpointer-arith  -Wno-multichar  -Werror -O -MD $(DEFINES) $(INCLUDES) -Wno-cast-qual -Wno-error
+EXTRA_CFLAGS += -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts -Wparentheses -Wno-multichar  -Werror -O2 -MD $(DEFINES) $(INCLUDES) -Wno-cast-qual -Wno-error
 
 #
 # We rely on these two definitions below; if they aren't set, we set them to
@@ -199,7 +199,7 @@
 #
 
 module: gcc-sanity-check
-	@make CC=$(CC) $(KBUILD_PARAMS) modules; \
+	@make CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(KBUILD_PARAMS) modules; \
 	if ! [ -f $(MODULE_OBJECT) ]; then \
 	  echo "$(MODULE_OBJECT) failed to build!"; \
 	  exit 1; \
diff -urN -x nv_compiler.h -x '*.mod.c' -x '*.ko' -x '*.d' -x '*.o' -x '*~' -x build -x Makefile -x '.*' NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/conftest.sh NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/conftest.sh
--- NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/conftest.sh	2004-01-16 12:46:59.000000000 -0800
+++ NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/conftest.sh	2005-01-24 15:49:33.000000000 -0800
@@ -129,7 +129,7 @@
             echo -en "\033[1;31m";
             echo -e  "*** Failed super-user sanity check. Bailing out! ***";
             echo -en "\033[0m";
-            exit 1
+            exit 0
         else
             exit 0
         fi
diff -urN -x nv_compiler.h -x '*.mod.c' -x '*.ko' -x '*.d' -x '*.o' -x '*~' -x build -x Makefile -x '.*' NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/nv-linux.h NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/nv-linux.h
--- NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/nv-linux.h	2004-01-16 12:46:59.000000000 -0800
+++ NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/nv-linux.h	2005-01-24 16:09:14.000000000 -0800
@@ -24,7 +24,7 @@
 #  define KERNEL_2_4
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
 #  error This driver does not support 2.5 kernels!
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 7, 0) && defined(NVCPU_X86)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 7, 0)
 #  define KERNEL_2_6
 #else
 #  error This driver does not support development kernels!
@@ -293,13 +293,13 @@
 #if defined(NVCPU_IA64)
 #define NV_VMALLOC(ptr, size) \
     { \
-        (void *) (ptr) = vmalloc_dma(size); \
+        (ptr) = __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL); \
         VM_ALLOC_RECORD(ptr, size, "vm_alloc"); \
     }
 #else
 #define NV_VMALLOC(ptr, size) \
     { \
-        (void *) (ptr) = vmalloc_32(size); \
+        (ptr) = vmalloc_32(size); \
         VM_ALLOC_RECORD(ptr, size, "vm_alloc"); \
     }
 #endif
@@ -333,13 +333,13 @@
  */
 #define NV_KMALLOC(ptr, size) \
     { \
-        (void *) (ptr) = kmalloc(size, GFP_KERNEL); \
+        (ptr) = kmalloc(size, GFP_KERNEL); \
         KM_ALLOC_RECORD(ptr, size, "km_alloc"); \
     }
 
 #define NV_KMALLOC_ATOMIC(ptr, size) \
     { \
-        (void *) (ptr) = kmalloc(size, GFP_ATOMIC); \
+        (ptr) = kmalloc(size, GFP_ATOMIC); \
         KM_ALLOC_RECORD(ptr, size, "km_alloc_atomic"); \
     }  
 
@@ -352,7 +352,7 @@
 
 #define NV_GET_FREE_PAGES(ptr, order) \
     { \
-        (void *) (ptr) = __get_free_pages(NV_GFP_HW, order); \
+        (ptr) = __get_free_pages(NV_GFP_HW, order); \
     }
         
 #define NV_FREE_PAGES(ptr, order) \
@@ -454,14 +454,22 @@
  * relevant releases to date use it. This version was backported to 2.4 
  * without means to identify the change, hence this hack.
  */
-#if defined(REMAP_PAGE_RANGE_5)
-#define NV_REMAP_PAGE_RANGE(a, b...)    remap_page_range(vma, a, ## b)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
+#define NV_REMAP_PFN_RANGE(a,b,c,d)	remap_pfn_range(vma, a, b, c, d)
+#elif defined(REMAP_PAGE_RANGE_5)
+#define NV_REMAP_PFN_RANGE(a, b...)    remap_page_range(vma, a << PAGE_SHIFT, ## b)
 #elif defined(REMAP_PAGE_RANGE_4)
-#define NV_REMAP_PAGE_RANGE(a, b...)    remap_page_range(a, ## b)
+#define NV_REMAP_PFN_RANGE(a, b...)    remap_page_range(a << PAGE_SHIFT, ## b)
 #else
 #error "Couldn't determine number of arguments expected by remap_page_range!"
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 11)
+typedef pgd_t pud_t;
+# define pud_offset(pg_dir, address)	(pg_dir);
+# define pud_none(pud)			0
+#endif
+
 #if defined(pte_offset_atomic)
 #define NV_PTE_OFFSET(addres, pg_mid_dir, pte) \
     { \
@@ -540,17 +548,6 @@
 #define page_to_pfn(page)  ((page) - mem_map)
 #endif
 
-/* On IA64 physical memory is partitioned into a cached and an
- * uncached view controlled by bit 63.  Set this bit when remapping
- * page ranges.  
- */
-#if defined(NVCPU_IA64)
-#define phys_to_uncached(addr) ((addr) | ((unsigned long) 1<<63))
-#else
-/* Some other scheme must be used on this platform */
-#define phys_to_uncached(addr) (addr)
-#endif
-
 /*
  * An allocated bit of memory using NV_MEMORY_ALLOCATION_OFFSET
  *   looks like this in the driver
diff -urN -x nv_compiler.h -x '*.mod.c' -x '*.ko' -x '*.d' -x '*.o' -x '*~' -x build -x Makefile -x '.*' NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/nv.c NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/nv.c
--- NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/nv.c	2004-01-16 12:46:59.000000000 -0800
+++ NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/nv.c	2005-01-24 16:43:33.000000000 -0800
@@ -212,12 +212,15 @@
     count = 0;
     dev = (struct pci_dev *) 0;
 
-    dev = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8, dev);
+    dev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, dev);
     while (dev)
     {
         if ((dev->vendor != 0x10de) || (dev->device < 0x20))
             goto next;
 
+	if (pci_enable_device(dev))
+		goto next;
+
         /* initialize bus-dependent config state */
         nvl = &nv_linux_devices[count];
         nv  = NV_STATE_PTR(nvl);
@@ -303,7 +306,7 @@
         }
 
     next:
-        dev = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8, dev);
+        dev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, dev);
     }
 
     nv_printf(NV_DBG_INFO, "NVRM: found %d device%s\n", count, count ? "" : "s");
@@ -620,7 +623,7 @@
     u8     cap_ptr;
     int    func, slot;
 
-    dev = pci_find_class(class << 8, NULL);
+    dev = pci_get_class(class << 8, NULL);
     do {
         for (func = 0; func < 8; func++) {
             slot = PCI_SLOT(dev->devfn);
@@ -631,7 +634,7 @@
             if (cap_ptr)
                 return fn;
         }
-        dev = pci_find_class(class << 8, dev);
+        dev = pci_get_class(class << 8, dev);
     } while (dev);
 
     return NULL;
@@ -1070,7 +1073,7 @@
  * addresses by the CPU.  This nopage handler will fault on CPU
  * accesses to AGP memory and map the address to the correct page.
  */
-struct page *nv_kern_vma_nopage(struct vm_area_struct *vma, unsigned long address, int write_access)
+struct page *nv_kern_vma_nopage(struct vm_area_struct *vma, unsigned long address, int *write_accessp)
 {
 #if defined(NVCPU_IA64) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 9))
     nv_alloc_t *at, *tmp;
@@ -1201,6 +1204,7 @@
 {
     nv_state_t *nv = (nv_state_t *) 0;
     nv_linux_state_t *nvl = (nv_linux_state_t *) 0;
+    nv_file_private_t *nv_private;
     int devnum;
     int rc = 0, status;
 
@@ -1229,7 +1233,8 @@
     nv_printf(NV_DBG_INFO, "nv_kern_open on device %d\n", devnum);
     nv_down(nvl->ldata_lock);
 
-    NVL_FROM_FILEP(file) = nvl;
+    nv_private = file->private_data;
+    nv_private->nvptr = nvl;
 
     /*
      * map the memory and allocate isr on first open
@@ -1405,8 +1410,8 @@
             pages = nv->regs->size / PAGE_SIZE;
 
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-        if (NV_REMAP_PAGE_RANGE(vma->vm_start,
-                             phys_to_uncached(NV_VMA_OFFSET(vma)),
+        if (NV_REMAP_PFN_RANGE(vma->vm_start,
+                             NV_VMA_OFFSET(vma) >> PAGE_SHIFT,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
@@ -1424,8 +1429,8 @@
             pages = nv->fb->size / PAGE_SIZE;
 
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-        if (NV_REMAP_PAGE_RANGE(vma->vm_start,
-                             phys_to_uncached(NV_VMA_OFFSET(vma)),
+        if (NV_REMAP_PFN_RANGE(vma->vm_start,
+                             NV_VMA_OFFSET(vma) >> PAGE_SHIFT,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
@@ -1512,7 +1517,8 @@
         while (pages--)
         {
             page = (unsigned long) at->page_table[i++].phys_addr;
-            if (NV_REMAP_PAGE_RANGE(start, page, PAGE_SIZE, PAGE_SHARED))
+            if (NV_REMAP_PFN_RANGE(start, page >> PAGE_SHIFT, PAGE_SIZE,
+				   PAGE_SHARED))
                 return -EAGAIN;
             start += PAGE_SIZE;
             pos += PAGE_SIZE;
@@ -1863,6 +1869,7 @@
     struct file *file
 )
 {
+    nv_file_private_t *nv_private;
     nv_state_t *nv;
     nv_linux_state_t *nvl;
     int rc = 0;
@@ -1877,7 +1884,8 @@
     nv->device_number = NV_CONTROL_DEVICE_NUMBER;
 
     /* save the nv away in file->private_data */
-    NVL_FROM_FILEP(file) = nvl;
+    nv_private = file->private_data;
+    nv_private->nvptr = nvl;
 
     if (nv->usage_count == 0)
     {
@@ -2308,6 +2316,7 @@
 )
 {
     pgd_t *pg_dir;
+    pud_t *pud_dir;
     pmd_t *pg_mid_dir;
     pte_t pte;
     unsigned long retval;
@@ -2318,7 +2327,11 @@
     if (pgd_none(*pg_dir))
         goto failed;
 
-    pg_mid_dir = pmd_offset(pg_dir, address);
+    pud_dir = pud_offset(pg_dir, address);
+    if (pud_none(*pud_dir))
+	    goto failed;
+
+    pg_mid_dir = pmd_offset(pud_dir, address);
     if (pmd_none(*pg_mid_dir))
         goto failed;
 
diff -urN -x nv_compiler.h -x '*.mod.c' -x '*.ko' -x '*.d' -x '*.o' -x '*~' -x build -x Makefile -x '.*' NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/os-agp.c NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/os-agp.c
--- NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/os-agp.c	2004-01-16 12:46:59.000000000 -0800
+++ NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/os-agp.c	2005-01-24 16:18:34.000000000 -0800
@@ -47,7 +47,6 @@
 
 agp_kern_info         agpinfo;
 agp_gart              gart;
-const drm_agp_t       *drm_agp_p;
 
 #if defined(CONFIG_MTRR)
 #define MTRR_DEL(gart) if ((gart).mtrr > 0) mtrr_del((gart).mtrr, 0, 0);
@@ -75,12 +74,7 @@
 
     memset( (void *) &gart, 0, sizeof(agp_gart));
 
-    if (!(drm_agp_p = inter_module_get_request("drm_agp", "agpgart")))
-    {
-        nv_printf(NV_DBG_ERRORS,
-            "NVRM: AGPGART: unable to retrieve symbol table\n");
-        return 1;
-    }
+    request_module("%s", "agpgart");
 
     /* NOTE: from here down, return an error code of '-1'
      * that indicates that agpgart is loaded, but we failed to use it
@@ -88,7 +82,7 @@
      * the memory controller.
      */
 
-    if (drm_agp_p->acquire())
+    if (agp_backend_acquire())
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: backend in use\n");
         return -1;
@@ -113,10 +107,10 @@
      * chipsets via this function. If this Linux 2.4 kernels behaves the same
      * way, we have no way to know.
      */
-    drm_agp_p->copy_info(&agpinfo);
+    agp_copy_info(&agpinfo);
 #else
-    if (drm_agp_p->copy_info(&agpinfo)) {
-        drm_agp_p->release();
+    if (agp_copy_info(&agpinfo)) {
+        agp_backend_release();
         inter_module_put("drm_agp");
         return -1;
     }
@@ -134,7 +128,7 @@
          */
         nv_printf(NV_DBG_ERRORS, 
             "NVRM: AGPGART: unable to set MTRR write-combining\n");
-        drm_agp_p->release();
+        agp_backend_release();
         inter_module_put("drm_agp");
         return -1;
     }
@@ -151,7 +145,7 @@
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: unable to remap aperture\n");
         MTRR_DEL(gart);
-        drm_agp_p->release();
+        agp_backend_release();
         inter_module_put("drm_agp");
         return -1;
     }
@@ -163,7 +157,7 @@
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: unable to allocate bitmap\n");
         NV_IOUNMAP(gart.aperture, RM_PAGE_SIZE);
         MTRR_DEL(gart);
-        drm_agp_p->release();
+        agp_backend_release();
         inter_module_put("drm_agp");
         return -1;
     }
@@ -175,7 +169,7 @@
         os_free_mem(bitmap);
         NV_IOUNMAP(gart.aperture, RM_PAGE_SIZE);
         MTRR_DEL(gart);
-        drm_agp_p->release();
+        agp_backend_release();
         inter_module_put("drm_agp");
         return -1;
     }
@@ -186,7 +180,7 @@
     if (!(agp_rate & 0x00000004)) agpinfo.mode &= ~0x00000004;
     if (!(agp_rate & 0x00000002)) agpinfo.mode &= ~0x00000002;
     
-    drm_agp_p->enable(agpinfo.mode);
+    agp_enable(agpinfo.mode);
 
     *ap_phys_base   = (void*) agpinfo.aper_base;
     *ap_mapped_base = (void*) gart.aperture;
@@ -221,7 +215,7 @@
         NV_IOUNMAP(gart.aperture, RM_PAGE_SIZE);
     }
 
-    drm_agp_p->release();
+    agp_backend_release();
 
     inter_module_put("drm_agp");
 
@@ -270,7 +264,7 @@
         return RM_ERROR;
     }
 
-    ptr = drm_agp_p->allocate_memory(PageCount, AGP_NORMAL_MEMORY);
+    ptr = agp_allocate_memory(PageCount, AGP_NORMAL_MEMORY);
     if (ptr == NULL)
     {
         *pAddress = (void*) 0;
@@ -278,7 +272,7 @@
         return RM_ERR_NO_FREE_MEM;
     }
     
-    err = drm_agp_p->bind_memory(ptr, *Offset);
+    err = agp_bind_memory(ptr, *Offset);
     if (err)
     {
         // this happens a lot when the aperture itself fills up..
@@ -295,7 +289,7 @@
     if (status != RM_OK)
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: memory allocation failed\n");
-        drm_agp_p->unbind_memory(ptr);
+        agp_unbind_memory(ptr);
         goto fail;
     }
 
@@ -310,7 +304,7 @@
     return RM_OK;
 
 fail:
-    drm_agp_p->free_memory(ptr);
+    agp_free_memory(ptr);
     *pAddress = (void*) 0;
 
     return RM_ERROR;
@@ -350,7 +344,7 @@
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: unable to remap %lu pages\n",
             (unsigned long)agp_data->num_pages);
-        drm_agp_p->unbind_memory(agp_data->ptr);
+        agp_unbind_memory(agp_data->ptr);
         goto fail;
     }
     
@@ -449,8 +443,8 @@
     {
         size_t pages = ptr->page_count;
 
-        drm_agp_p->unbind_memory(ptr);
-        drm_agp_p->free_memory(ptr);
+        agp_unbind_memory(ptr);
+        agp_free_memory(ptr);
 
         nv_printf(NV_DBG_INFO, "NVRM: AGPGART: freed %ld pages\n",
             (unsigned long)pages);
diff -urN -x nv_compiler.h -x '*.mod.c' -x '*.ko' -x '*.d' -x '*.o' -x '*~' -x build -x Makefile -x '.*' NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/os-interface.c NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/os-interface.c
--- NVIDIA-Linux-ia64-1.0-5336-pkg1/usr/src/nv/os-interface.c	2004-01-16 12:46:59.000000000 -0800
+++ NVIDIA-Linux-ia64-1.0-5336-pkg1-davidm/usr/src/nv/os-interface.c	2005-01-24 16:18:10.000000000 -0800
@@ -913,8 +913,8 @@
 
     vma = (struct vm_area_struct *) *priv;
 
-    if (NV_REMAP_PAGE_RANGE(vma->vm_start,
-                start & PAGE_MASK, size_bytes, PAGE_SHARED))
+    if (NV_REMAP_PFN_RANGE(vma->vm_start,
+			   start >> PAGE_SHIFT, size_bytes, PAGE_SHARED))
         return NULL;
 
     return (void *)(NV_UINTPTR_T) vma->vm_start;
