Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131901AbRAFQQR>; Sat, 6 Jan 2001 11:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRAFQQI>; Sat, 6 Jan 2001 11:16:08 -0500
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:35335 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131901AbRAFQQC>; Sat, 6 Jan 2001 11:16:02 -0500
From: "Jared Sulem" <jsulem@sulem.freeserve.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: [non-kernel patch] Re: bug of Nvidia (0.9.5) Drivers in 2.4 Kernel Enviroment
Date: Sat, 6 Jan 2001 16:19:19 -0000
Message-ID: <NEBBKEIJMLEIHACEGKDMAEAECAAA.jsulem@sulem.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(replies - cc: jsulem@sulem.freeserve.co.uk)

Driver should work after applying the following patch.  I'm not a kernel
hacker so I don't know how good a solution this is (especially suspicious
of the work around in os-interface.c) but X works on my machine and it has
not crashed (yet) - have not tried any OpenGL though.

Apply this to the extracted tar.gz version of the driver and compile that.
Don't just try and rebuild the binary rpm from the spec file as it will
extract
the tar.gz again and all changes will be lost (there should be a tar.gz
hanging
around once the src.rpm has been installed).

diff -u NVIDIA_kernel-0.9-5/nv.c NVIDIA_kernel-0.9-5-kern2.4/nv.c
--- NVIDIA_kernel-0.9-5/nv.c	Sat Aug 26 01:48:38 2000
+++ NVIDIA_kernel-0.9-5-kern2.4/nv.c	Sat Jan  6 14:53:02 2001
@@ -84,6 +84,9 @@

 #include <nv_ref.h>

+#define mem_map_inc_count(p) atomic_inc(&(p->count))
+#define mem_map_dec_count(p) atomic_dec(&(p->count))
+
 #define LINUX_VMA_DEV(vma)  ((vma)->vm_file->f_dentry->d_inode->i_rdev)

 #ifdef KERNEL_2_3
@@ -850,7 +853,7 @@
 struct vm_operations_struct nv_vm_ops = {
     open:     nv_vma_open,
     close:    nv_vma_release,
-    unmap:    nv_vma_unmap,
+    nv_vma_unmap,
 };
 #endif

diff -u NVIDIA_kernel-0.9-5/os-interface.c
NVIDIA_kernel-0.9-5-kern2.4/os-interface.c
--- NVIDIA_kernel-0.9-5/os-interface.c	Fri Sep  1 03:19:17 2000
+++ NVIDIA_kernel-0.9-5-kern2.4/os-interface.c	Sat Jan  6 14:59:36 2001
@@ -81,6 +81,9 @@

 #include <os-interface.h>

+static inline unsigned long get_module_symbol(char *unused1, char *unused2)
{ return 0; };
+static inline void put_module_symbol(unsigned long unused) { };
+
 // registry controls

 #define NV_MODULE_NAME       "NVdriver"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
