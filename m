Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSJGDNy>; Sun, 6 Oct 2002 23:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262820AbSJGDNy>; Sun, 6 Oct 2002 23:13:54 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:35759 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S262536AbSJGDNn>; Sun, 6 Oct 2002 23:13:43 -0400
Date: Sun, 6 Oct 2002 22:18:55 -0500
From: Bob McElrath <bob+linux-kernel@vger.kernel.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org
Subject: Re: nvidia 2.5.40+ patch? (& work queues)
Message-ID: <20021007031855.GA5991@draal.physics.wisc.edu>
References: <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <3DA0958A.9050809@drugphish.ch> <20021006203142.GD10884@draal.physics.wisc.edu> <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <3DA0958A.9050809@drugphish.ch> <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <20021006212215.GA17790@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20021006212215.GA17790@tapu.f00f.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Chris Wedgwood [cw@f00f.org] wrote:
> My changes are pretty small and don't oops.  Like I said though,
> something just isn't quite right though :)

Yes indeed, your patch works fine, but as you observed, it hangs
sometimes.  My guess is the work queue work isn't getting done on time.

If you give the [nvisr/0] process a negative priority, the stalls go
away.  I just played through a level of Chromium BSU and it performed
flawlessly (with the nvisr process at -20 priority).  With the latest bk
tree there are also no oopses.

I'm not sure how to solve this in a general way.  But the nvisr work
isn't getting done quickly enough.  I think under the task queue system
the bottom-half interrupt work got scheduled as immediate (i.e. it's
guaranteed to be the next work run).  But under work queues it enters
the scheduler like any other process, so several timeslices can pass
before it gets done.

Really, the nvisr process should be SCHED_FIFO.  (i think)  Or whatever
it takes to ensure that when it is given work, it gets scheduled
immediately.

Correct me if I'm wrong...I know diddly squat about task/work queues/bh
isr's...

I'm re-sending your patch against the nvidia driver with this post and
copying it to lkml, since it works great and others might want to see
what the code does.

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nv-2.5.40.patch"
Content-Transfer-Encoding: quoted-printable

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/cvs/nvkern/Makefile,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- Makefile	5 Oct 2002 08:18:46 -0000	1.1.1.1
+++ Makefile	5 Oct 2002 09:03:54 -0000	1.2
@@ -57,9 +57,9 @@
=20
 # allow specification of alternate include file tree on command line and e=
xtra defines
 ifdef SYSINCLUDE
-INCLUDES +=3D -I$(SYSINCLUDE)
+INCLUDES +=3D -I$(SYSINCLUDE) -I$(KERNINC)/../arch/i386/mach-generic
 else
-INCLUDES +=3D -I$(KERNINC)
+INCLUDES +=3D -I$(KERNINC) -I$(KERNINC)/../arch/i386/mach-generic
 endif
=20
 DEFINES+=3D$(EXTRA_DEFINES)
Index: nv-linux.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/cvs/nvkern/nv-linux.h,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- nv-linux.h	5 Oct 2002 08:18:46 -0000	1.1.1.1
+++ nv-linux.h	5 Oct 2002 09:03:55 -0000	1.2
@@ -36,11 +36,6 @@
 #  error This driver does not support 2.3.x development kernels!
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
-#  define KERNEL_2_5
-#else
-#  error This driver does not support 2.6.x or newer kernels!
 #endif
=20
 #if defined (CONFIG_SMP) && !defined (__SMP__)
@@ -51,7 +46,7 @@
 #include <linux/errno.h>            /* error codes                      */
 #include <linux/stddef.h>           /* NULL, offsetof                   */
 #include <linux/wait.h>             /* wait queues                      */
-#include <linux/tqueue.h>           /* struct tq_struct                 */
+#include <linux/workqueue.h>
=20
 #include <linux/slab.h>             /* kmalloc, kfree, etc              */
 #include <linux/vmalloc.h>          /* vmalloc, vfree, etc              */
@@ -194,7 +189,7 @@
     nv_alloc_t *alloc_queue;
=20
     // bottom half interrupt handler info; per device
-    struct tq_struct *bh;
+    struct work_struct *work;
=20
     U032 vblank_notifier;
     U032 waiting_for_vblank;
Index: nv.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/cvs/nvkern/nv.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- nv.c	5 Oct 2002 08:18:46 -0000	1.1.1.1
+++ nv.c	5 Oct 2002 09:03:55 -0000	1.2
@@ -17,6 +17,15 @@
 #include "nv_compiler.h"
=20
 /*
+ * Queue for delayed I/O completion.
+ *
+ * CW:XXX the way the driver is presently structures, we want on of
+ * these per device (card) which rather than something global.
+ *
+ */
+struct workqueue_struct *isr_workqueue;
+
+/*
  * our global state; one per device
  */
=20
@@ -36,7 +45,7 @@
 // keep track of opened clients and their process id so they
 //   can be free'd up on abnormal close
 nv_client_t       nv_clients[NV_MAX_CLIENTS];
-struct tq_struct  nv_bottom_halves[NV_MAX_CLIENTS];
+struct work_struct  nv_work[NV_MAX_CLIENTS];
=20
=20
 #ifdef CONFIG_DEVFS_FS
@@ -838,6 +847,13 @@
     int rc;
     int num_devices;
=20
+    /* create a workqueue */
+    isr_workqueue =3D create_workqueue("nvisr");
+    if (!isr_workqueue) {
+	printk("Unable to create workqueue for NV\n");
+	return -EIO;
+    }
+
     memset(nv_linux_devices, 0, sizeof(nv_linux_devices));
     num_devices =3D nvos_probe_devices();
=20
@@ -885,10 +901,8 @@
     // init all the bottom half structures
     for (nvl =3D nv_linux_devices; nvl < nv_linux_devices + NV_MAX_DEVICES=
; nvl++)
     {
-        nvl->bh =3D &nv_bottom_halves[nvl - nv_linux_devices];
-        nvl->bh->routine =3D rm_isr_bh;
-        nvl->bh->data =3D (void *) 0;
-        nvl->bh->sync =3D 0;
+	nvl->work =3D &nv_work[nvl - nv_linux_devices];
+	INIT_WORK(nvl->work, rm_isr_bh, NULL);
     }
=20
     // init the control device
@@ -984,6 +998,8 @@
     } while(0);
     devfs_unregister(nv_ctl_handle);
 #endif
+
+    destroy_workqueue(isr_workqueue);
 }
=20
=20
@@ -1068,11 +1084,11 @@
=20
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+    if (NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
         return nv_kern_ctl_open(inode, file);
=20
     /* what device are we talking about? */
-    devnum =3D NV_DEVICE_NUMBER(inode->i_rdev);
+    devnum =3D NV_DEVICE_NUMBER(kdev_val(inode->i_rdev));
     if (devnum >=3D NV_MAX_DEVICES)
     {
         rc =3D -ENODEV;
@@ -1178,9 +1194,9 @@
=20
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
-        return nv_kern_ctl_close(inode, file);
=20
+    if(NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
+        return nv_kern_ctl_close(inode, file);
     NV_DMSG(nv, "close");
=20
     rm_free_unused_clients(nv, current->pid, (void *) file);
@@ -1188,8 +1204,6 @@
     nv_lock_ldata(nv);
     if (--nv->usage_count =3D=3D 0)
     {
-        int counter =3D 0;
-
         /* turn off interrupts.
         ** be careful to make sure any pending bottom half gets run
         **  or disabled before calling rm_shutdown_adapter() since
@@ -1200,20 +1214,14 @@
         rm_disable_adapter(nv);
=20
         /* give it a moment to allow any bottom half to run */
-
-#define MAX_BH_TASKS 10
-        while ((nv->bh_count) && (counter < MAX_BH_TASKS))
-        {
-            current->state =3D TASK_INTERRUPTIBLE;
-            schedule_timeout(HZ/50);
-            counter++;
-        }
+	flush_workqueue(isr_workqueue);
+	/* destroy_workqueue(isr_workqueue); */ /* CW:XXX */
=20
         /* free the irq, which may block until any pending interrupts */
         /* are done being processed. */
         free_irq(nv->interrupt_line, (void *) nv);
=20
-        nvl->bh->data =3D (void *) 0;
+	INIT_WORK(nvl->work, NULL, NULL);
=20
         rm_shutdown_adapter(nv);
=20
@@ -1299,7 +1307,7 @@
 #if defined(NVCPU_IA64)
         vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
 #endif
-        if (remap_page_range(vma->vm_start,
+        if (remap_page_range(vma, vma->vm_start,
                              (u32)(nv->regs.address) + LINUX_VMA_OFFS(vma)=
 - NV_MMAP_REG_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
@@ -1316,7 +1324,7 @@
 #if defined(NVCPU_IA64)
         vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
 #endif
-        if (remap_page_range(vma->vm_start,
+        if (remap_page_range(vma, vma->vm_start,
                              (u32)(nv->fb.address) + LINUX_VMA_OFFS(vma) -=
 NV_MMAP_FB_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
@@ -1350,7 +1358,7 @@
         while (pages--)
         {
             page =3D (unsigned long) at->page_table[i++];
-            if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
               	return -EAGAIN;
             start +=3D PAGE_SIZE;
             pos +=3D PAGE_SIZE;
@@ -1626,9 +1634,8 @@
     {
         nv_lock_bh(nv);
         nv->bh_count++;
-        nvl->bh->data =3D nv->pdev;
-        queue_task(nvl->bh, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+        INIT_WORK(nvl->work, rm_isr_bh, nv->pdev);
+        queue_work(isr_workqueue, nvl->work);
         nv_unlock_bh(nv);
     }
 }
@@ -2179,7 +2186,7 @@
     pte_kunmap(pte__);
 #else
     pte__ =3D NULL;
-    pte =3D *pte_offset(pg_mid_dir, address);
+    pte =3D *pte_offset_map(pg_mid_dir, address);
 #endif
=20
     if (!pte_present(pte))=20
@@ -2681,7 +2688,6 @@
     spin_unlock_irqrestore(&nvl->at_lock, nvl->at_pflags);
 }
=20
-
 void nv_lock_bh(
     nv_state_t *nv
 )
@@ -2695,7 +2701,7 @@
=20
     if (locking_debuglevel && nvl->bh_locked)
     {
-        nv_printf("(%d) %d wait on bh\n", cpu, me);
+        nv_printf("(%d) %d wait on work\n", cpu, me);
         if (nvl->bh_locked =3D=3D -1)
             nv_printf("  ISR owns the lock!!\n");
         if (nvl->bh_locked =3D=3D -2)
@@ -2732,14 +2738,12 @@
=20
 #if defined(NV_DEBUG_LOCKS)
     if (locking_debuglevel >=3D DEBUG_ISR_LOCKING)
-        nv_printf("(%d): %d drop bh\n", cpu, nvl->bh_locked);
+        nv_printf("(%d): %d drop work\n", cpu, nvl->bh_locked);
     nvl->bh_locked =3D 0;
 #endif
=20
     spin_unlock_irqrestore(&nvl->bh_lock, nvl->bh_pflags);
 }
-
-
=20
 /*
 ** post the event
Index: nv.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/cvs/nvkern/nv.h,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- nv.h	5 Oct 2002 08:18:46 -0000	1.1.1.1
+++ nv.h	5 Oct 2002 09:03:55 -0000	1.2
@@ -195,6 +195,11 @@
     U032 agp_buffers;
     U032 agp_teardown;
=20
+    /*
+     * CW:XXX.  I'm not sure *how* the value below ever gets
+     * decremented, perhaps inside the magic binary logic in which case
+     * we need to keep it about
+     */
     /* keep track of any pending bottom-halves */
     int bh_count;
=20
Index: os-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/cvs/nvkern/os-interface.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- os-interface.c	5 Oct 2002 08:18:46 -0000	1.1.1.1
+++ os-interface.c	5 Oct 2002 09:03:55 -0000	1.2
@@ -27,7 +27,7 @@
=20
 BOOL os_is_administrator(PHWINFO pDev)
 {
-    return suser();
+    return (capable(CAP_SYS_ADMIN) !=3D 0);
 }
=20
 U032 os_get_page_size(VOID)
@@ -1141,7 +1141,7 @@
     uaddr =3D *priv;
=20
     /* finally, let's do it! */
-    err =3D remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,=
=20
+    err =3D remap_page_range( kaddr, (size_t) uaddr, (size_t) paddr, size_=
bytes,
                             PAGE_SHARED);
=20
     if (err !=3D 0)
@@ -1177,7 +1177,7 @@
     uaddr =3D *priv;
=20
     /* finally, let's do it! */
-    err =3D remap_page_range( (size_t) uaddr, (size_t) start, size_bytes,=
=20
+    err =3D remap_page_range( *priv, (size_t) uaddr, (size_t) start, size_=
bytes,=20
                             PAGE_SHARED);
=20
     if (err !=3D 0)
@@ -1560,8 +1560,10 @@
=20
     *pPriv_data =3D data;
    =20
+#if 0 /* CW:XXX silence */
     printk(KERN_INFO "NVRM: AGPGART: allocated %lu pages\n",
            (unsigned long) PageCount);
+#endif
     return RM_OK;
=20
 fail:
@@ -1593,7 +1595,7 @@
=20
     agp_addr =3D agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
=20
-    err =3D remap_page_range(vma->vm_start, (size_t) agp_addr,=20
+    err =3D remap_page_range(vma, vma->vm_start, (size_t) agp_addr,=20
                            agp_data->num_pages << PAGE_SHIFT,
 #if defined(NVCPU_IA64)
                            vma->vm_page_prot);
@@ -1686,7 +1688,9 @@
         (*(agp_ops.unbind_memory))(ptr);
         (*(agp_ops.free_memory))(ptr);
=20
+#if 0 /* CW:XXX silence */
         printk(KERN_INFO "NVRM: AGPGART: freed %ld pages\n", (unsigned lon=
g)pages);
+#endif
         PRINT_AGPGART_TABLE();
         return RM_OK;
     }

--h31gzZEtNLTqOjlF--

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2g/R8ACgkQjwioWRGe9K3ScwCg6qJhTbzmYk6Fz6m/c84CmtTY
qGoAoPMqFmYZvNxmum9B/xd5ad7f1RYm
=jxpk
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
