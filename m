Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbRAKIqn>; Thu, 11 Jan 2001 03:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRAKIqX>; Thu, 11 Jan 2001 03:46:23 -0500
Received: from gorilla.mchh.siemens.de ([194.138.158.18]:2527 "EHLO
	gorilla.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S130187AbRAKIqV>; Thu, 11 Jan 2001 03:46:21 -0500
Message-ID: <EFDD2C814ABCD211B6360008C70D713C013732AA@MCHH240E>
From: Widmann Thomas <Thomas.Widmann@icn.siemens.de>
To: linux-kernel@vger.kernel.org
Subject: Re: has anyone patched NVIDIA_kernel to work with 2.4.0?
Date: Thu, 11 Jan 2001 09:46:01 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

* David Meyer wrote:

> Between 2.4.0-test10 and 2.4.0 enough stuff changed that I can't get
> the OpenGL NVIDIA_kernel module compiled and linked properly.  Has
> anyone else taken a shot at this?

Try using this Patch. It compiles well on my 2.4.0 machine.

--- snipp ---

diff -ruN NVIDIA_kernel-0.9-5/nv.c nvdriver/nv.c
--- NVIDIA_kernel-0.9-5/nv.c	Sat Aug 26 02:48:38 2000
+++ nvdriver/nv.c	Tue Jan  2 13:43:13 2001
@@ -49,6 +49,13 @@
 #include <linux/modversions.h>
 #endif
 
+#ifndef mem_map_dec_count
+  #define mem_map_dec_count(p) atomic_dec(&((p)->count));
+#endif
+#ifndef mem_map_inc_count
+  #define mem_map_inc_count(p) atomic_inc(&((p)->count));
+#endif
+
 #include <nv.h>			        // needs to precede other headers (SMP)
 
 #include <linux/stddef.h>
@@ -778,17 +785,6 @@
 }
 
 
-void nv_vma_release(struct vm_area_struct *vma)
-{
-    nv_state_t *nv;
-
-    nv = &nv_devices[NV_DEVICE_NUMBER(LINUX_VMA_DEV(vma))];
-    NV_DMSG(nv, "vma_release [0x%lx-0x%lx]", vma->vm_start, vma->vm_end);
-
-    MOD_DEC_USE_COUNT;
-}
-
-
 // assumes we are destroying entire map
 void nv_vma_unmap(
     struct vm_area_struct *vma,
@@ -833,6 +829,21 @@
     }
 }
 
+
+void nv_vma_release(struct vm_area_struct *vma)
+{
+    nv_state_t *nv;
+
+    nv = &nv_devices[NV_DEVICE_NUMBER(LINUX_VMA_DEV(vma))];
+    NV_DMSG(nv, "vma_release [0x%lx-0x%lx]", vma->vm_start, vma->vm_end);
+
+    /*  2.4.0 PR fix/hack  */
+    nv_vma_unmap(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+
+    MOD_DEC_USE_COUNT;
+}
+
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 0)
 struct vm_operations_struct nv_vm_ops = {
     nv_vma_open,
@@ -850,7 +861,8 @@
 struct vm_operations_struct nv_vm_ops = {
     open:     nv_vma_open,
     close:    nv_vma_release,
-    unmap:    nv_vma_unmap,  
+/*  2.4.0 PR hack/fix       */
+/*  unmap:    nv_vma_unmap, */
 };
 #endif
 
diff -ruN NVIDIA_kernel-0.9-5/nv.h nvdriver/nv.h
--- NVIDIA_kernel-0.9-5/nv.h	Sat Aug 26 02:48:38 2000
+++ nvdriver/nv.h	Tue Jan  2 13:43:41 2001
@@ -128,7 +128,7 @@
   #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
     #define KERNEL_2_2
   #else
-    #warning This driver is not officially supported on post-2.2 kernels
+/*  #warning This driver is not officially supported on post-2.2 kernels */
     #define KERNEL_2_3
   #endif  // < 2.3
 #endif  // < 2.2
diff -ruN NVIDIA_kernel-0.9-5/os-interface.c nvdriver/os-interface.c
--- NVIDIA_kernel-0.9-5/os-interface.c	Fri Sep  1 04:19:17 2000
+++ nvdriver/os-interface.c	Tue Jan  2 13:41:14 2001
@@ -1331,6 +1331,11 @@
     char *parmp;
     char ch;
 
+    spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
+    struct module *mp = THIS_MODULE;
+    struct module_symbol *sym;
+    int i;
+
     if ((strlen(regParmStr) + NV_SYM_PREFIX_LENGTH) > NV_MAX_SYM_NAME)
         goto done;
 
@@ -1351,11 +1356,18 @@
 
     *symp = '\0';
 
-    symbol_value = get_module_symbol(NV_MODULE_NAME, symbol_name);
-    
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
-    put_module_symbol(symbol_value);
-#endif
+    spin_lock(&unload_lock);
+    if (MOD_CAN_QUERY(mp) && (mp->nsyms > 0)) {
+        for (i = mp->nsyms, sym = mp->syms;
+             i > 0; --i, ++sym) {
+
+            if (strcmp(sym->name, symbol_name) == 0) {
+                symbol_value = sym->value;
+                break;
+            }
+        }
+    }
+    spin_unlock(&unload_lock);
 
  done:
     return (void *) symbol_value;

--- snipp ---

Regards
Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
