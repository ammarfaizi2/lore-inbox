Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280201AbRKNGc3>; Wed, 14 Nov 2001 01:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280192AbRKNGcM>; Wed, 14 Nov 2001 01:32:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59520 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280171AbRKNGbx>;
	Wed, 14 Nov 2001 01:31:53 -0500
Date: Tue, 13 Nov 2001 22:31:40 -0800 (PST)
Message-Id: <20011113.223140.45519573.davem@redhat.com>
To: kukuk@suse.de
Cc: vonbrand@inf.utfsm.cl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011114072852.A16556@suse.de>
In-Reply-To: <20011113162102.A2305@suse.de>
	<20011113.205729.71087461.davem@redhat.com>
	<20011114072852.A16556@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thorsten Kukuk <kukuk@suse.de>
   Date: Wed, 14 Nov 2001 07:28:52 +0100
   
   If the first one should be wrong, why not apply the second one ?
   Or I'm missing something ?
   To the first patch: Without it you will always get a kernel oops
   in this part of ioctl32.c

Please try this patch instead.  I just cleaned up all of this code.

--- ../vanilla/linux/arch/sparc64/kernel/ioctl32.c	Mon Nov 12 15:13:04 2001
+++ arch/sparc64/kernel/ioctl32.c	Tue Nov 13 22:14:45 2001
@@ -2403,6 +2421,7 @@
 	u32 pv[ABS_MAX_PV + 1];
 	u32 lv[ABS_MAX_LV + 1];
     	uint8_t vg_uuid[UUID_LEN+1];	/* volume group UUID */
+	uint8_t dummy1[200];
 } vg32_t;
 
 typedef struct {
@@ -2444,7 +2463,7 @@
 } lv_status_byindex_req32_t;
 
 typedef struct {
-	dev_t dev;
+	__kernel_dev_t32 dev;
 	u32   lv;
 } lv_status_bydev_req32_t;
 
@@ -2517,7 +2536,8 @@
 	lv_block_exception32_t *lbe32;
 	lv_block_exception_t *lbe;
 	lv32_t *ul = (lv32_t *)A(p);
-	lv_t *l = (lv_t *)kmalloc(sizeof(lv_t), GFP_KERNEL);
+	lv_t *l = (lv_t *) kmalloc(sizeof(lv_t), GFP_KERNEL);
+
 	if (!l) {
 		*errp = -ENOMEM;
 		return NULL;
@@ -2547,12 +2567,11 @@
 		if (l->lv_block_exception) {
 			lbe32 = (lv_block_exception32_t *)A(ptr2);
 			memset(lbe, 0, size);
-                       for (i = 0; i < l->lv_remap_end; i++, lbe++, lbe32++) {
-                               err |= get_user(lbe->rsector_org, &lbe32->rsector_org);
-                               err |= __get_user(lbe->rdev_org, &lbe32->rdev_org);
-                               err |= __get_user(lbe->rsector_new, &lbe32->rsector_new);
-                               err |= __get_user(lbe->rdev_new, &lbe32->rdev_new);
-
+			for (i = 0; i < l->lv_remap_end; i++, lbe++, lbe32++) {
+				err |= get_user(lbe->rsector_org, &lbe32->rsector_org);
+				err |= __get_user(lbe->rdev_org, &lbe32->rdev_org);
+				err |= __get_user(lbe->rsector_new, &lbe32->rsector_new);
+				err |= __get_user(lbe->rdev_new, &lbe32->rdev_new);
 			}
 		}
 	}
@@ -2590,7 +2609,7 @@
 
 static int do_lvm_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	vg_t *v;
+	vg_t *v = NULL;
 	union {
 		lv_req_t lv_req;
 		le_remap_req_t le_remap;
@@ -2608,17 +2627,22 @@
 	switch (cmd) {
 	case VG_STATUS:
 		v = kmalloc(sizeof(vg_t), GFP_KERNEL);
-		if (!v) return -ENOMEM;
+		if (!v)
+			return -ENOMEM;
 		karg = v;
 		break;
+
+	case VG_CREATE_OLD:
 	case VG_CREATE:
 		v = kmalloc(sizeof(vg_t), GFP_KERNEL);
-		if (!v) return -ENOMEM;
-		if (copy_from_user(v, (void *)arg, (long)&((vg32_t *)0)->proc) ||
-		    __get_user(v->proc, &((vg32_t *)arg)->proc)) {
+		if (!v)
+			return -ENOMEM;
+		if (copy_from_user(v, (void *)arg, (long)&((vg32_t *)0)->proc)) {
 			kfree(v);
 			return -EFAULT;
 		}
+		/* 'proc' field is unused, just NULL it out. */
+		v->proc = NULL;
 		if (copy_from_user(v->vg_uuid, ((vg32_t *)arg)->vg_uuid, UUID_LEN+1)) {
 			kfree(v);
 			return -EFAULT;
@@ -2630,39 +2654,46 @@
 			return -EPERM;
 		for (i = 0; i < v->pv_max; i++) {
 			err = __get_user(ptr, &((vg32_t *)arg)->pv[i]);
-			if (err) break;
+			if (err)
+				break;
 			if (ptr) {
 				v->pv[i] = kmalloc(sizeof(pv_t), GFP_KERNEL);
 				if (!v->pv[i]) {
 					err = -ENOMEM;
 					break;
 				}
-				err = copy_from_user(v->pv[i], (void *)A(ptr), sizeof(pv32_t) - 8 - UUID_LEN+1);
+				err = copy_from_user(v->pv[i], (void *)A(ptr),
+						     sizeof(pv32_t) - 8 - UUID_LEN+1);
 				if (err) {
 					err = -EFAULT;
 					break;
 				}
-				err = copy_from_user(v->pv[i]->pv_uuid, ((pv32_t *)A(ptr))->pv_uuid, UUID_LEN+1);
+				err = copy_from_user(v->pv[i]->pv_uuid,
+						     ((pv32_t *)A(ptr))->pv_uuid,
+						     UUID_LEN+1);
 				if (err) {
 				        err = -EFAULT;
 					break;
 				}
 
-				
-				v->pv[i]->pe = NULL; v->pv[i]->inode = NULL;
+				v->pv[i]->pe = NULL;
+				v->pv[i]->bd = NULL;
 			}
 		}
 		if (!err) {
 			for (i = 0; i < v->lv_max; i++) {
 				err = __get_user(ptr, &((vg32_t *)arg)->lv[i]);
-				if (err) break;
+				if (err)
+					break;
 				if (ptr) {
 					v->lv[i] = get_lv_t(ptr, &err);
-					if (err) break;
+					if (err)
+						break;
 				}
 			}
 		}
 		break;
+
 	case LV_CREATE:
 	case LV_EXTEND:
 	case LV_REDUCE:
@@ -2670,54 +2701,70 @@
 	case LV_RENAME:
 	case LV_STATUS_BYNAME:
 	        err = copy_from_user(&u.pv_status, arg, sizeof(u.pv_status.pv_name));
-		if (err) return -EFAULT;
+		if (err)
+			return -EFAULT;
 		if (cmd != LV_REMOVE) {
 			err = __get_user(ptr, &((lv_req32_t *)arg)->lv);
-			if (err) return err;
+			if (err)
+				return err;
 			u.lv_req.lv = get_lv_t(ptr, &err);
 		} else
 			u.lv_req.lv = NULL;
 		break;
 
-
 	case LV_STATUS_BYINDEX:
-		err = get_user(u.lv_byindex.lv_index, &((lv_status_byindex_req32_t *)arg)->lv_index);
+		err = get_user(u.lv_byindex.lv_index,
+			       &((lv_status_byindex_req32_t *)arg)->lv_index);
 		err |= __get_user(ptr, &((lv_status_byindex_req32_t *)arg)->lv);
-		if (err) return err;
+		if (err)
+			return err;
 		u.lv_byindex.lv = get_lv_t(ptr, &err);
 		break;
+
 	case LV_STATUS_BYDEV:
 	        err = get_user(u.lv_bydev.dev, &((lv_status_bydev_req32_t *)arg)->dev);
+		err |= __get_user(ptr, &((lv_status_bydev_req32_t *)arg)->lv);
+		if (err)
+			return err;
 		u.lv_bydev.lv = get_lv_t(ptr, &err);
-		if (err) return err;
-		u.lv_bydev.lv = &p;
-		p.pe = NULL; p.inode = NULL;		
-		break;		
+		break;
+
 	case VG_EXTEND:
 		err = copy_from_user(&p, (void *)arg, sizeof(pv32_t) - 8 - UUID_LEN+1);
-		if (err) return -EFAULT;
+		if (err)
+			return -EFAULT;
 		err = copy_from_user(p.pv_uuid, ((pv32_t *)arg)->pv_uuid, UUID_LEN+1);
-		if (err) return -EFAULT;
-		p.pe = NULL; p.inode = NULL;
+		if (err)
+			return -EFAULT;
+		p.pe = NULL;
+		p.bd = NULL;
 		karg = &p;
 		break;
+
 	case PV_CHANGE:
 	case PV_STATUS:
 		err = copy_from_user(&u.pv_status, arg, sizeof(u.lv_req.lv_name));
-		if (err) return -EFAULT;
+		if (err)
+			return -EFAULT;
 		err = __get_user(ptr, &((pv_status_req32_t *)arg)->pv);
-		if (err) return err;
+		if (err)
+			return err;
 		u.pv_status.pv = &p;
 		if (cmd == PV_CHANGE) {
-			err = copy_from_user(&p, (void *)A(ptr), sizeof(pv32_t) - 8 - UUID_LEN+1);
-			if (err) return -EFAULT;
-			p.pe = NULL; p.inode = NULL;
+			err = copy_from_user(&p, (void *)A(ptr),
+					     sizeof(pv32_t) - 8 - UUID_LEN+1);
+			if (err)
+				return -EFAULT;
+			p.pe = NULL;
+			p.bd = NULL;
 		}
 		break;
-	}
+	};
+
         old_fs = get_fs(); set_fs (KERNEL_DS);
         err = sys_ioctl (fd, cmd, (unsigned long)karg);
         set_fs (old_fs);
+
 	switch (cmd) {
 	case VG_STATUS:
 		if (!err) {
@@ -2730,42 +2777,60 @@
 		}
 		kfree(v);
 		break;
+
+	case VG_CREATE_OLD:
 	case VG_CREATE:
-		for (i = 0; i < v->pv_max; i++)
-			if (v->pv[i]) kfree(v->pv[i]);
-		for (i = 0; i < v->lv_max; i++)
-			if (v->lv[i]) put_lv_t(v->lv[i]);
+		for (i = 0; i < v->pv_max; i++) {
+			if (v->pv[i])
+				kfree(v->pv[i]);
+		}
+		for (i = 0; i < v->lv_max; i++) {
+			if (v->lv[i])
+				put_lv_t(v->lv[i]);
+		}
 		kfree(v);
 		break;
+
 	case LV_STATUS_BYNAME:
-		if (!err && u.lv_req.lv) err = copy_lv_t(ptr, u.lv_req.lv);
+		if (!err && u.lv_req.lv)
+			err = copy_lv_t(ptr, u.lv_req.lv);
 		/* Fall through */
+
         case LV_CREATE:
 	case LV_EXTEND:
 	case LV_REDUCE:
-		if (u.lv_req.lv) put_lv_t(u.lv_req.lv);
+		if (u.lv_req.lv)
+			put_lv_t(u.lv_req.lv);
 		break;
+
 	case LV_STATUS_BYINDEX:
 		if (u.lv_byindex.lv) {
-			if (!err) err = copy_lv_t(ptr, u.lv_byindex.lv);
+			if (!err)
+				err = copy_lv_t(ptr, u.lv_byindex.lv);
 			put_lv_t(u.lv_byindex.lv);
 		}
 		break;
+
+	case LV_STATUS_BYDEV:
+	        if (u.lv_bydev.lv) {
+			if (!err)
+				err = copy_lv_t(ptr, u.lv_bydev.lv);
+			put_lv_t(u.lv_byindex.lv);
+	        }
+	        break;
+
 	case PV_STATUS:
 		if (!err) {
 			err = copy_to_user((void *)A(ptr), &p, sizeof(pv32_t) - 8 - UUID_LEN+1);
-			if (err) return -EFAULT;
+			if (err)
+				return -EFAULT;
 			err = copy_to_user(((pv_t *)A(ptr))->pv_uuid, p.pv_uuid, UUID_LEN + 1);
-			if (err) return -EFAULT;
+			if (err)
+				return -EFAULT;
 		}
 		break;
-	case LV_STATUS_BYDEV:
-	        if (!err) {
-			if (!err) err = copy_lv_t(ptr, u.lv_bydev.lv);
-			put_lv_t(u.lv_byindex.lv);
-	        }
-	        break;
-	}
+	};
+
 	return err;
 }
 #endif
@@ -4646,6 +4713,7 @@
 HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 HANDLE_IOCTL(VG_STATUS, do_lvm_ioctl)
+HANDLE_IOCTL(VG_CREATE_OLD, do_lvm_ioctl)
 HANDLE_IOCTL(VG_CREATE, do_lvm_ioctl)
 HANDLE_IOCTL(VG_EXTEND, do_lvm_ioctl)
 HANDLE_IOCTL(LV_CREATE, do_lvm_ioctl)
@@ -4655,6 +4723,7 @@
 HANDLE_IOCTL(LV_RENAME, do_lvm_ioctl)
 HANDLE_IOCTL(LV_STATUS_BYNAME, do_lvm_ioctl)
 HANDLE_IOCTL(LV_STATUS_BYINDEX, do_lvm_ioctl)
+HANDLE_IOCTL(LV_STATUS_BYDEV, do_lvm_ioctl)
 HANDLE_IOCTL(PV_CHANGE, do_lvm_ioctl)
 HANDLE_IOCTL(PV_STATUS, do_lvm_ioctl)
 #endif /* LVM */
