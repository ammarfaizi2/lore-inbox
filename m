Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290433AbSBSVvm>; Tue, 19 Feb 2002 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290496AbSBSVvd>; Tue, 19 Feb 2002 16:51:33 -0500
Received: from ns0.petreley.net ([64.170.109.178]:56449 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S290433AbSBSVvP>;
	Tue, 19 Feb 2002 16:51:15 -0500
Message-ID: <3C72C8CC.3050506@petreley.com>
Date: Tue, 19 Feb 2002 13:51:08 -0800
From: Nicholas Petreley <nicholas@petreley.com>
Reply-To: nicholas@petreley.com
Organization: Petreley.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NVidia driver with 2.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tried the NVidia driver with the latest 2.5 kernels but I had 
no problem modifying nv.c and making the driver work with earlier diffs. 
The trick is to just fudge the code in os-interface.c to make it 
compile, and then configure XF86Config-4 not to use the NVidia agp 
driver (use the kernel agpgart instead). That way the fudged 
os-interface.c code doesn't even get called, as far as I know. It worked 
for me (at least, as I said, as of a few diffs ago).

Don't even try to use the bogus os-interface.c changes by activating 
NV's agp or it will bomb, and I take no responsibility for the damage. 
 In fact, I take no responsibility for the damage no matter what you do 
with this info. ;-)

Having said all that, I use 2.4.18-rc2-ac1, which only requires a few 
modifications (IIRC, just the minor() stuff).  But here are some diffs 
against NVidia drivers 2314 for those who are suicidal or just curious.


--- nv.c.original    Wed Jan 16 09:47:27 2002
+++ nv.c.vma    Mon Jan 28 17:05:26 2002
@@ -1146,11 +1146,11 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+    if (NV_DEVICE_IS_CONTROL_DEVICE(minor(inode->i_rdev)))
         return nv_kern_ctl_open(inode, file);
 
     /* what device are we talking about? */
-    devnum = NV_DEVICE_NUMBER(inode->i_rdev);
+    devnum = NV_DEVICE_NUMBER(minor(inode->i_rdev));
     if (devnum >= NV_MAX_DEVICES)
     {
         rc = -ENODEV;
@@ -1257,7 +1257,7 @@
 
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+    if (NV_DEVICE_IS_CONTROL_DEVICE(minor(inode->i_rdev)))
         return nv_kern_ctl_close(inode, file);
 
     NV_DMSG(nv, "close");
@@ -1383,7 +1383,7 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
-        if (remap_page_range(vma->vm_start,
+        if (remap_page_range(vma, vma->vm_start,
                              (u32) (nv->reg_physical_address) + 
LINUX_VMA_OFFS(vma) - NV_MMAP_REG_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
@@ -1400,7 +1400,7 @@
 #if defined(IA64)
         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
-        if (remap_page_range(vma->vm_start,
+        if (remap_page_range(vma, vma->vm_start,
                              (u32) (nv->fb_physical_address) + 
LINUX_VMA_OFFS(vma) - NV_MMAP_FB_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
@@ -1435,7 +1435,7 @@
         while (pages--)
         {
             page = (unsigned long) at->page_table[i++];
-            if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                   return -EAGAIN;
             start += PAGE_SIZE;
             pos += PAGE_SIZE;

=================================================

--- os-interface.c.original    Mon Feb  4 22:42:44 2002
+++ os-interface.c.vma    Thu Jan 31 23:35:59 2002
@@ -1446,7 +1446,7 @@
     uaddr = *priv;
 
     /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,
+    err = remap_page_range(uaddr, (size_t) uaddr, (size_t) paddr, 
size_bytes,
                             PAGE_SHARED);
 
     if (err != 0)
@@ -1474,7 +1474,7 @@
     uaddr = *priv;
 
     /* finally, let's do it! */
-    err = remap_page_range( (size_t) uaddr, (size_t) start, size_bytes,
+    err = remap_page_range(uaddr, (size_t) uaddr, (size_t) start, 
size_bytes,
                             PAGE_SHARED);
 
     if (err != 0)
@@ -2027,7 +2027,7 @@
 
     agp_addr = agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
 
-    err = remap_page_range(vma->vm_start, (size_t) agp_addr,
+    err = remap_page_range(vma, vma->vm_start, (size_t) agp_addr,
                            agp_data->num_pages << PAGE_SHIFT,
 #if defined(IA64)
                            vma->vm_page_prot);




-Nicholas Petreley


