Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCMJAF>; Tue, 13 Mar 2001 04:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCMI74>; Tue, 13 Mar 2001 03:59:56 -0500
Received: from sulphur.cix.co.uk ([212.35.225.149]:11190 "EHLO
	sulphur.cix.co.uk") by vger.kernel.org with ESMTP
	id <S129443AbRCMI7s>; Tue, 13 Mar 2001 03:59:48 -0500
X-Envelope-From: patrick@tykepenguin.cix.co.uk
Date: Tue, 13 Mar 2001 08:35:41 +0000
From: Patrick Caulfield <caulfield@sistina.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: 2.4.2 sparc64 patch for LVM
Message-ID: <20010313083541.A510@tykepenguin.com>
Mail-Followup-To: davem@redhat.com, linux-kernel@vger.kernel.org,
	linux-lvm@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the ioctl32.c file so that LVM 0.9 will work on UltraSPARC
machines.

As LVM 0.9 has been in the kernel since 2.4.0 please consider for inclusion in
the standard Linux kernel.

There are further changes needed for LVM to work on UltraSPARC machines, these
are in the 0.9.1beta6 release available from www.sistina.com and will hopefully
be integrated into the main kernel tree shortly.

A patch for 2.2.18 kernels is included in the LVM 0.9.1beta6 release tarball.

Thanks,
Patrick


--- v2.4.2-testboxes/arch/sparc64/kernel/ioctl32.c.orig	Mon Mar 12 10:47:08 2001
+++ v2.4.2-testboxes/arch/sparc64/kernel/ioctl32.c	Mon Mar 12 10:47:19 2001
@@ -1,4 +1,4 @@
-/* $Id: ioctl32.c,v 1.107 2001/02/13 01:16:44 davem Exp $
+/* $Id: ioctl32.c,v 1.104 2001/01/03 09:28:19 anton Exp $
  * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
  *
  * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
@@ -2068,6 +2068,7 @@
 	u32 proc;
 	u32 pv[ABS_MAX_PV + 1];
 	u32 lv[ABS_MAX_LV + 1];
+    	uint8_t vg_uuid[UUID_LEN+1];	/* volume group UUID */
 } vg32_t;
 
 typedef struct {
@@ -2093,6 +2094,7 @@
 	uint32_t pe_stale;
 	u32 pe;
 	u32 inode;
+	uint8_t pv_uuid[UUID_LEN+1];
 } pv32_t;
 
 typedef struct {
@@ -2103,9 +2105,16 @@
 typedef struct {
 	u32 lv_index;
 	u32 lv;
+	/* Transfer size because user space and kernel space differ */
+	uint16_t size;
 } lv_status_byindex_req32_t;
 
 typedef struct {
+	dev_t dev;
+	u32   lv;
+} lv_status_bydev_req32_t;
+
+typedef struct {
 	uint8_t lv_name[NAME_LEN];
 	kdev_t old_dev;
 	kdev_t new_dev;
@@ -2204,11 +2213,12 @@
 		if (l->lv_block_exception) {
 			lbe32 = (lv_block_exception32_t *)A(ptr2);
 			memset(lbe, 0, size);
-			for (i = 0; i < l->lv_remap_end; i++, lbe++, lbe32++) {
-				err |= get_user(lbe->rsector_org, &lbe32->rsector_org);
-				err |= __get_user(lbe->rdev_org, &lbe32->rdev_org);
-				err |= __get_user(lbe->rsector_new, &lbe32->rsector_new);
-				err |= __get_user(lbe->rdev_new, &lbe32->rdev_new);
+                       for (i = 0; i < l->lv_remap_end; i++, lbe++, lbe32++) {
+                               err |= get_user(lbe->rsector_org, &lbe32->rsector_org);
+                               err |= __get_user(lbe->rdev_org, &lbe32->rdev_org);
+                               err |= __get_user(lbe->rsector_new, &lbe32->rsector_new);
+                               err |= __get_user(lbe->rdev_new, &lbe32->rdev_new);
+
 			}
 		}
 	}
@@ -2239,8 +2249,9 @@
 	err |= __copy_to_user(&ul->lv_remap_ptr, &l->lv_remap_ptr,
 				((long)&ul->dummy[0]) - ((long)&ul->lv_remap_ptr));
 	size = l->lv_allocated_le * sizeof(pe_t);
-	err |= __copy_to_user((void *)A(ptr1), l->lv_current_pe, size);
-	return -EFAULT;
+	if (ptr1)
+		err |= __copy_to_user((void *)A(ptr1), l->lv_current_pe, size);
+	return err ? -EFAULT : 0;
 }
 
 static int do_lvm_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -2250,7 +2261,8 @@
 		lv_req_t lv_req;
 		le_remap_req_t le_remap;
 		lv_status_byindex_req_t lv_byindex;
-		pv_status_req32_t pv_status;
+	        lv_status_bydev_req_t lv_bydev;
+		pv_status_req_t pv_status;
 	} u;
 	pv_t p;
 	int err;
@@ -2273,6 +2285,11 @@
 			kfree(v);
 			return -EFAULT;
 		}
+		if (copy_from_user(v->vg_uuid, ((vg32_t *)arg)->vg_uuid, UUID_LEN+1)) {
+			kfree(v);
+			return -EFAULT;
+		}
+		    
 		karg = v;
 		memset(v->pv, 0, sizeof(v->pv) + sizeof(v->lv));
 		if (v->pv_max > ABS_MAX_PV || v->lv_max > ABS_MAX_LV)
@@ -2286,11 +2303,18 @@
 					err = -ENOMEM;
 					break;
 				}
-				err = copy_from_user(v->pv[i], (void *)A(ptr), sizeof(pv32_t) - 8);
+				err = copy_from_user(v->pv[i], (void *)A(ptr), sizeof(pv32_t) - 8 - UUID_LEN+1);
 				if (err) {
 					err = -EFAULT;
 					break;
 				}
+				err = copy_from_user(v->pv[i]->pv_uuid, ((pv32_t *)A(ptr))->pv_uuid, UUID_LEN+1);
+				if (err) {
+				        err = -EFAULT;
+					break;
+				}
+
+				
 				v->pv[i]->pe = NULL; v->pv[i]->inode = NULL;
 			}
 		}
@@ -2309,8 +2333,9 @@
 	case LV_EXTEND:
 	case LV_REDUCE:
 	case LV_REMOVE:
+	case LV_RENAME:
 	case LV_STATUS_BYNAME:
-		err = copy_from_user(&u.pv_status, arg, sizeof(u.pv_status.pv_name));
+	        err = copy_from_user(&u.pv_status, arg, sizeof(u.pv_status.pv_name));
 		if (err) return -EFAULT;
 		if (cmd != LV_REMOVE) {
 			err = __get_user(ptr, &((lv_req32_t *)arg)->lv);
@@ -2319,24 +2344,29 @@
 		} else
 			u.lv_req.lv = NULL;
 		break;
+
+
 	case LV_STATUS_BYINDEX:
 		err = get_user(u.lv_byindex.lv_index, &((lv_status_byindex_req32_t *)arg)->lv_index);
 		err |= __get_user(ptr, &((lv_status_byindex_req32_t *)arg)->lv);
 		if (err) return err;
 		u.lv_byindex.lv = get_lv_t(ptr, &err);
 		break;
+	case LV_STATUS_BYDEV:
+	        err = get_user(u.lv_bydev.dev, &((lv_status_bydev_req32_t *)arg)->dev);
+		u.lv_bydev.lv = get_lv_t(ptr, &err);
+		if (err) return err;
+		u.lv_bydev.lv = &p;
+		p.pe = NULL; p.inode = NULL;		
+		break;		
 	case VG_EXTEND:
-		err = copy_from_user(&p, (void *)arg, sizeof(pv32_t) - 8);
+		err = copy_from_user(&p, (void *)arg, sizeof(pv32_t) - 8 - UUID_LEN+1);
+		if (err) return -EFAULT;
+		err = copy_from_user(p.pv_uuid, ((pv32_t *)arg)->pv_uuid, UUID_LEN+1);
 		if (err) return -EFAULT;
 		p.pe = NULL; p.inode = NULL;
 		karg = &p;
 		break;
-	case LE_REMAP:
-		err = copy_from_user(&u.le_remap, (void *)arg, sizeof(le_remap_req32_t));
-		if (err) return -EFAULT;
-		u.le_remap.new_pe = ((le_remap_req32_t *)&u.le_remap)->new_pe;
-		u.le_remap.old_pe = ((le_remap_req32_t *)&u.le_remap)->old_pe;
-		break;
 	case PV_CHANGE:
 	case PV_STATUS:
 		err = copy_from_user(&u.pv_status, arg, sizeof(u.lv_req.lv_name));
@@ -2345,7 +2375,7 @@
 		if (err) return err;
 		u.pv_status.pv = &p;
 		if (cmd == PV_CHANGE) {
-			err = copy_from_user(&p, (void *)A(ptr), sizeof(pv32_t) - 8);
+			err = copy_from_user(&p, (void *)A(ptr), sizeof(pv32_t) - 8 - UUID_LEN+1);
 			if (err) return -EFAULT;
 			p.pe = NULL; p.inode = NULL;
 		}
@@ -2361,6 +2391,9 @@
 			    clear_user(&((vg32_t *)arg)->proc, sizeof(vg32_t) - (long)&((vg32_t *)0)->proc))
 				err = -EFAULT;
 		}
+		if (copy_to_user(((vg32_t *)arg)->vg_uuid, v->vg_uuid, UUID_LEN+1)) {
+		        err = -EFAULT;
+		}
 		kfree(v);
 		break;
 	case VG_CREATE:
@@ -2383,12 +2416,21 @@
 			if (!err) err = copy_lv_t(ptr, u.lv_byindex.lv);
 			put_lv_t(u.lv_byindex.lv);
 		}
+		break;
 	case PV_STATUS:
 		if (!err) {
-			err = copy_to_user((void *)A(ptr), &p, sizeof(pv32_t) - 8);
-			if (err) return -EFAULT;		
+			err = copy_to_user((void *)A(ptr), &p, sizeof(pv32_t) - 8 - UUID_LEN+1);
+			if (err) return -EFAULT;
+			err = copy_to_user(((pv_t *)A(ptr))->pv_uuid, p.pv_uuid, UUID_LEN + 1);
+			if (err) return -EFAULT;
 		}
 		break;
+	case LV_STATUS_BYDEV:
+	        if (!err) {
+			if (!err) err = copy_lv_t(ptr, u.lv_bydev.lv);
+			put_lv_t(u.lv_byindex.lv);
+	        }
+	        break;
 	}
 	return err;
 }
@@ -3565,6 +3607,7 @@
 COMPATIBLE_IOCTL(VG_STATUS_GET_COUNT)
 COMPATIBLE_IOCTL(VG_STATUS_GET_NAMELIST)
 COMPATIBLE_IOCTL(VG_REMOVE)
+COMPATIBLE_IOCTL(VG_RENAME)
 COMPATIBLE_IOCTL(VG_REDUCE)
 COMPATIBLE_IOCTL(PE_LOCK_UNLOCK)
 COMPATIBLE_IOCTL(PV_FLUSH)
@@ -3576,6 +3619,9 @@
 COMPATIBLE_IOCTL(LV_SET_ACCESS)
 COMPATIBLE_IOCTL(LV_SET_STATUS)
 COMPATIBLE_IOCTL(LV_SET_ALLOCATION)
+COMPATIBLE_IOCTL(LE_REMAP)
+COMPATIBLE_IOCTL(LV_BMAP)
+COMPATIBLE_IOCTL(LV_SNAPSHOT_USE_RATE)
 #endif /* LVM */
 #if defined(CONFIG_DRM) || defined(CONFIG_DRM_MODULE)
 COMPATIBLE_IOCTL(DRM_IOCTL_GET_MAGIC)
@@ -3749,9 +3795,9 @@
 HANDLE_IOCTL(LV_REMOVE, do_lvm_ioctl)
 HANDLE_IOCTL(LV_EXTEND, do_lvm_ioctl)
 HANDLE_IOCTL(LV_REDUCE, do_lvm_ioctl)
+HANDLE_IOCTL(LV_RENAME, do_lvm_ioctl)
 HANDLE_IOCTL(LV_STATUS_BYNAME, do_lvm_ioctl)
 HANDLE_IOCTL(LV_STATUS_BYINDEX, do_lvm_ioctl)
-HANDLE_IOCTL(LE_REMAP, do_lvm_ioctl)
 HANDLE_IOCTL(PV_CHANGE, do_lvm_ioctl)
 HANDLE_IOCTL(PV_STATUS, do_lvm_ioctl)
 #endif /* LVM */
