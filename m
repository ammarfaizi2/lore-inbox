Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRKMPVz>; Tue, 13 Nov 2001 10:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRKMPVs>; Tue, 13 Nov 2001 10:21:48 -0500
Received: from ns.suse.de ([213.95.15.193]:23315 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280015AbRKMPVc>;
	Tue, 13 Nov 2001 10:21:32 -0500
Date: Tue, 13 Nov 2001 16:21:02 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113162102.A2305@suse.de>
In-Reply-To: <torvalds@transmeta.com> <200111131410.fADEA9L8023291@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200111131410.fADEA9L8023291@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Tue, Nov 13, 2001 at 11:10:09AM -0300
Organization: SuSE GmbH, Nuernberg, Germany
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, Horst von Brand wrote:

> On CVS as of today for sparc64 I get:
> 
> sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-proto
> types -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -
> m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -f
> call-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o ioctl32.o ioctl32.
> c
> ioctl32.c: In function `do_lvm_ioctl':
> ioctl32.c:2636: warning: assignment makes pointer from integer without a cast
> ioctl32.c:2670: structure has no member named `inode'
> ioctl32.c:2711: warning: assignment from incompatible pointer type
> ioctl32.c:2712: structure has no member named `inode'
> ioctl32.c:2719: structure has no member named `inode'
> ioctl32.c:2732: structure has no member named `inode'
> ioctl32.c:2611: warning: `v' might be used uninitialized in this function
> make[1]: *** [ioctl32.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4/arch/sparc64/kernel'
> make: *** [_dir_arch/sparc64/kernel] Error 2

Please try the both attached patches. I'm using them with 
2.4.15pre1aa1 (which has the same lvm version as now 2.2.15pre4).

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE GmbH            Deutschherrenstr. 15-19       D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="61_sparc64.lvm.diff"

--- linux/arch/sparc64/kernel/ioctl32.c
+++ linux/arch/sparc64/kernel/ioctl32.c	2001/05/22 10:08:13
@@ -2166,14 +2166,6 @@
 } lv_status_bydev_req32_t;
 
 typedef struct {
-	uint8_t lv_name[NAME_LEN];
-	kdev_t old_dev;
-	kdev_t new_dev;
-	u32 old_pe;
-	u32 new_pe;
-} le_remap_req32_t;
-
-typedef struct {
 	char pv_name[NAME_LEN];
 	u32 pv;
 } pv_status_req32_t;
@@ -2211,14 +2203,6 @@
 	char dummy[200];
 } lv32_t;
 
-typedef struct {
-	u32 hash[2];
-	u32 rsector_org;
-	kdev_t rdev_org;
-	u32 rsector_new;
-	kdev_t rdev_new;
-} lv_block_exception32_t;
-
 static void put_lv_t(lv_t *l)
 {
 	if (l->lv_current_pe) vfree(l->lv_current_pe);
@@ -2231,8 +2215,6 @@
 	int err, i;
 	u32 ptr1, ptr2;
 	size_t size;
-	lv_block_exception32_t *lbe32;
-	lv_block_exception_t *lbe;
 	lv32_t *ul = (lv32_t *)A(p);
 	lv_t *l = (lv_t *)kmalloc(sizeof(lv_t), GFP_KERNEL);
 	if (!l) {
@@ -2260,18 +2242,9 @@
 	}
 	if (!err && ptr2) {
 		size = l->lv_remap_end * sizeof(lv_block_exception_t);
-		l->lv_block_exception = lbe = vmalloc(size);
-		if (l->lv_block_exception) {
-			lbe32 = (lv_block_exception32_t *)A(ptr2);
-			memset(lbe, 0, size);
-                       for (i = 0; i < l->lv_remap_end; i++, lbe++, lbe32++) {
-                               err |= get_user(lbe->rsector_org, &lbe32->rsector_org);
-                               err |= __get_user(lbe->rdev_org, &lbe32->rdev_org);
-                               err |= __get_user(lbe->rsector_new, &lbe32->rsector_new);
-                               err |= __get_user(lbe->rdev_new, &lbe32->rdev_new);
-
-			}
-		}
+		l->lv_block_exception = vmalloc(size);
+		if (l->lv_block_exception)
+                        err = copy_from_user(l->lv_block_exception, (void *)A(ptr2), size);
 	}
 	if (err || (ptr1 && !l->lv_current_pe) || (ptr2 && !l->lv_block_exception)) {
 		if (!err)

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="61_sparc64.lvm-1.0.1-rc2.diff"

--- linux/arch/sparc64/kernel/ioctl32.c
+++ linux/arch/sparc64/kernel/ioctl32.c	2001/09/05 11:44:46
@@ -2188,7 +2188,7 @@
 	uint32_t pe_allocated;
 	uint32_t pe_stale;
 	u32 pe;
-	u32 inode;
+	u32 bd;
 	uint8_t pv_uuid[UUID_LEN+1];
 } pv32_t;
 
@@ -2345,6 +2345,7 @@
 		if (!v) return -ENOMEM;
 		karg = v;
 		break;
+	case VG_CREATE_OLD:
 	case VG_CREATE:
 		v = kmalloc(sizeof(vg_t), GFP_KERNEL);
 		if (!v) return -ENOMEM;
@@ -2383,7 +2384,7 @@
 				}
 
 				
-				v->pv[i]->pe = NULL; v->pv[i]->inode = NULL;
+				v->pv[i]->pe = NULL; v->pv[i]->bd = NULL;
 			}
 		}
 		if (!err) {
@@ -2425,14 +2426,14 @@
 		u.lv_bydev.lv = get_lv_t(ptr, &err);
 		if (err) return err;
 		u.lv_bydev.lv = &p;
-		p.pe = NULL; p.inode = NULL;		
+		p.pe = NULL; p.bd = NULL;		
 		break;		
 	case VG_EXTEND:
 		err = copy_from_user(&p, (void *)arg, sizeof(pv32_t) - 8 - UUID_LEN+1);
 		if (err) return -EFAULT;
 		err = copy_from_user(p.pv_uuid, ((pv32_t *)arg)->pv_uuid, UUID_LEN+1);
 		if (err) return -EFAULT;
-		p.pe = NULL; p.inode = NULL;
+		p.pe = NULL; p.bd = NULL;
 		karg = &p;
 		break;
 	case PV_CHANGE:
@@ -2445,7 +2446,7 @@
 		if (cmd == PV_CHANGE) {
 			err = copy_from_user(&p, (void *)A(ptr), sizeof(pv32_t) - 8 - UUID_LEN+1);
 			if (err) return -EFAULT;
-			p.pe = NULL; p.inode = NULL;
+			p.pe = NULL; p.bd = NULL;
 		}
 		break;
 	}
@@ -2464,6 +2465,7 @@
 		}
 		kfree(v);
 		break;
+	case VG_CREATE_OLD:
 	case VG_CREATE:
 		for (i = 0; i < v->pv_max; i++)
 			if (v->pv[i]) kfree(v->pv[i]);
@@ -4363,6 +4365,7 @@
 HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 HANDLE_IOCTL(VG_STATUS, do_lvm_ioctl)
+HANDLE_IOCTL(VG_CREATE_OLD, do_lvm_ioctl)
 HANDLE_IOCTL(VG_CREATE, do_lvm_ioctl)
 HANDLE_IOCTL(VG_EXTEND, do_lvm_ioctl)
 HANDLE_IOCTL(LV_CREATE, do_lvm_ioctl)

--wRRV7LY7NUeQGEoC--
