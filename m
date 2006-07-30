Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWG3QhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWG3QhB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWG3QhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:37:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:34598 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932358AbWG3Qg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:36:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uhs8S5cxRMOX/GWzfBk6jxKBeS27awZ3ChBunkCO3q8yl+B1PT+bFR17Yaevu729krAdZ1fNQi86J1QdaGba/AXqFJ68WpYqUtPHO19zCKsES7mWeD+RKYY9+3xUsPRi5EFaJbZIEPZ6oWrg5j5aN5c23c4iCvaYQeRWnthOjBY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] making the kernel -Wshadow clean - warnings related to 'up'
Date: Sun, 30 Jul 2006 18:38:03 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301838.03869.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few -Wshadow warnings related to variables of the name 'up' clashing 
with the global function name up() by renaming the variables.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/vt_ioctl.c |   60 +++++++++++++++++++-------------------
 fs/select.c             |    6 +--
 kernel/user.c           |   36 +++++++++++-----------
 3 files changed, 51 insertions(+), 51 deletions(-)

--- linux-2.6.18-rc2-orig/drivers/char/vt_ioctl.c	2006-07-18 18:46:23.000000000 +0200
+++ linux-2.6.18-rc2/drivers/char/vt_ioctl.c	2006-07-18 21:21:39.000000000 +0200
@@ -187,7 +187,7 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
 	struct kbsentry *kbs;
 	char *p;
 	u_char *q;
-	u_char __user *up;
+	u_char __user *u;
 	int sz;
 	int delta;
 	char *first_free, *fj, *fnw;
@@ -215,15 +215,15 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
 	case KDGKBSENT:
 		sz = sizeof(kbs->kb_string) - 1; /* sz should have been
 						  a struct member */
-		up = user_kdgkb->kb_string;
+		u = user_kdgkb->kb_string;
 		p = func_table[i];
 		if(p)
 			for ( ; *p && sz; p++, sz--)
-				if (put_user(*p, up++)) {
+				if (put_user(*p, u++)) {
 					ret = -EFAULT;
 					goto reterr;
 				}
-		if (put_user('\0', up)) {
+		if (put_user('\0', u)) {
 			ret = -EFAULT;
 			goto reterr;
 		}
@@ -370,7 +370,7 @@ int vt_ioctl(struct tty_struct *tty, str
 	struct kbd_struct * kbd;
 	unsigned int console;
 	unsigned char ucval;
-	void __user *up = (void __user *)arg;
+	void __user *u = (void __user *)arg;
 	int i, perm;
 	
 	console = vc->vc_num;
@@ -454,12 +454,12 @@ int vt_ioctl(struct tty_struct *tty, str
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
-		if (copy_from_user(&kbrep, up, sizeof(struct kbd_repeat)))
+		if (copy_from_user(&kbrep, u, sizeof(struct kbd_repeat)))
 			return -EFAULT;
 		err = kbd_rate(&kbrep);
 		if (err)
 			return err;
-		if (copy_to_user(up, &kbrep, sizeof(struct kbd_repeat)))
+		if (copy_to_user(u, &kbrep, sizeof(struct kbd_repeat)))
 			return -EFAULT;
 		return 0;
 	}
@@ -569,19 +569,19 @@ int vt_ioctl(struct tty_struct *tty, str
 	case KDSETKEYCODE:
 		if(!capable(CAP_SYS_TTY_CONFIG))
 			perm=0;
-		return do_kbkeycode_ioctl(cmd, up, perm);
+		return do_kbkeycode_ioctl(cmd, u, perm);
 
 	case KDGKBENT:
 	case KDSKBENT:
-		return do_kdsk_ioctl(cmd, up, perm, kbd);
+		return do_kdsk_ioctl(cmd, u, perm, kbd);
 
 	case KDGKBSENT:
 	case KDSKBSENT:
-		return do_kdgkb_ioctl(cmd, up, perm);
+		return do_kdgkb_ioctl(cmd, u, perm);
 
 	case KDGKBDIACR:
 	{
-		struct kbdiacrs __user *a = up;
+		struct kbdiacrs __user *a = u;
 
 		if (put_user(accent_table_size, &a->kb_cnt))
 			return -EFAULT;
@@ -592,7 +592,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case KDSKBDIACR:
 	{
-		struct kbdiacrs __user *a = up;
+		struct kbdiacrs __user *a = u;
 		unsigned int ct;
 
 		if (!perm)
@@ -661,7 +661,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 		if (!perm)
 			return -EPERM;
-		if (copy_from_user(&tmp, up, sizeof(struct vt_mode)))
+		if (copy_from_user(&tmp, u, sizeof(struct vt_mode)))
 			return -EFAULT;
 		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
 			return -EINVAL;
@@ -685,7 +685,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		memcpy(&tmp, &vc->vt_mode, sizeof(struct vt_mode));
 		release_console_sem();
 
-		rc = copy_to_user(up, &tmp, sizeof(struct vt_mode));
+		rc = copy_to_user(u, &tmp, sizeof(struct vt_mode));
 		return rc ? -EFAULT : 0;
 	}
 
@@ -696,7 +696,7 @@ int vt_ioctl(struct tty_struct *tty, str
 	 */
 	case VT_GETSTATE:
 	{
-		struct vt_stat __user *vtstat = up;
+		struct vt_stat __user *vtstat = u;
 		unsigned short state, mask;
 
 		if (put_user(fg_console + 1, &vtstat->v_active))
@@ -840,7 +840,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case VT_RESIZE:
 	{
-		struct vt_sizes __user *vtsizes = up;
+		struct vt_sizes __user *vtsizes = u;
 		ushort ll,cc;
 		if (!perm)
 			return -EPERM;
@@ -857,7 +857,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case VT_RESIZEX:
 	{
-		struct vt_consize __user *vtconsize = up;
+		struct vt_consize __user *vtconsize = u;
 		ushort ll,cc,vlin,clin,vcol,ccol;
 		if (!perm)
 			return -EPERM;
@@ -911,7 +911,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		op.width = 8;
 		op.height = 0;
 		op.charcount = 256;
-		op.data = up;
+		op.data = u;
 		return con_font_op(vc_cons[fg_console].d, &op);
 	}
 
@@ -921,21 +921,21 @@ int vt_ioctl(struct tty_struct *tty, str
 		op.width = 8;
 		op.height = 32;
 		op.charcount = 256;
-		op.data = up;
+		op.data = u;
 		return con_font_op(vc_cons[fg_console].d, &op);
 	}
 
 	case PIO_CMAP:
                 if (!perm)
 			return -EPERM;
-                return con_set_cmap(up);
+                return con_set_cmap(u);
 
 	case GIO_CMAP:
-                return con_get_cmap(up);
+                return con_get_cmap(u);
 
 	case PIO_FONTX:
 	case GIO_FONTX:
-		return do_fontx_ioctl(cmd, up, perm, &op);
+		return do_fontx_ioctl(cmd, u, perm, &op);
 
 	case PIO_FONTRESET:
 	{
@@ -960,13 +960,13 @@ int vt_ioctl(struct tty_struct *tty, str
 	}
 
 	case KDFONTOP: {
-		if (copy_from_user(&op, up, sizeof(op)))
+		if (copy_from_user(&op, u, sizeof(op)))
 			return -EFAULT;
 		if (!perm && op.op != KD_FONT_OP_GET)
 			return -EPERM;
 		i = con_font_op(vc, &op);
 		if (i) return i;
-		if (copy_to_user(up, &op, sizeof(op)))
+		if (copy_to_user(u, &op, sizeof(op)))
 			return -EFAULT;
 		return 0;
 	}
@@ -974,24 +974,24 @@ int vt_ioctl(struct tty_struct *tty, str
 	case PIO_SCRNMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_trans_old(up);
+		return con_set_trans_old(u);
 
 	case GIO_SCRNMAP:
-		return con_get_trans_old(up);
+		return con_get_trans_old(u);
 
 	case PIO_UNISCRNMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_trans_new(up);
+		return con_set_trans_new(u);
 
 	case GIO_UNISCRNMAP:
-		return con_get_trans_new(up);
+		return con_get_trans_new(u);
 
 	case PIO_UNIMAPCLR:
 	      { struct unimapinit ui;
 		if (!perm)
 			return -EPERM;
-		i = copy_from_user(&ui, up, sizeof(struct unimapinit));
+		i = copy_from_user(&ui, u, sizeof(struct unimapinit));
 		if (i) return -EFAULT;
 		con_clear_unimap(vc, &ui);
 		return 0;
@@ -999,7 +999,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, up, perm, vc);
+		return do_unimap_ioctl(cmd, u, perm, vc);
 
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
--- linux-2.6.18-rc2-orig/fs/select.c	2006-07-18 18:46:59.000000000 +0200
+++ linux-2.6.18-rc2/fs/select.c	2006-07-18 21:23:01.000000000 +0200
@@ -524,17 +524,17 @@ asmlinkage long sys_pselect6(int n, fd_s
 	fd_set __user *exp, struct timespec __user *tsp, void __user *sig)
 {
 	size_t sigsetsize = 0;
-	sigset_t __user *up = NULL;
+	sigset_t __user *u = NULL;
 
 	if (sig) {
 		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t __user * __user *)sig)
+		    || __get_user(u, (sigset_t __user * __user *)sig)
 		    || __get_user(sigsetsize,
 				(size_t __user *)(sig+sizeof(void *))))
 			return -EFAULT;
 	}
 
-	return sys_pselect7(n, inp, outp, exp, tsp, up, sigsetsize);
+	return sys_pselect7(n, inp, outp, exp, tsp, u, sigsetsize);
 }
 #endif /* TIF_RESTORE_SIGMASK */
 
--- linux-2.6.18-rc2-orig/kernel/user.c	2006-07-18 18:47:16.000000000 +0200
+++ linux-2.6.18-rc2/kernel/user.c	2006-07-19 00:05:58.000000000 +0200
@@ -56,14 +56,14 @@ struct user_struct root_user = {
 /*
  * These routines must be called with the uidhash spinlock held!
  */
-static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
+static inline void uid_hash_insert(struct user_struct *u, struct list_head *hashent)
 {
-	list_add(&up->uidhash_list, hashent);
+	list_add(&u->uidhash_list, hashent);
 }
 
-static inline void uid_hash_remove(struct user_struct *up)
+static inline void uid_hash_remove(struct user_struct *u)
 {
-	list_del(&up->uidhash_list);
+	list_del(&u->uidhash_list);
 }
 
 static inline struct user_struct *uid_hash_find(uid_t uid, struct list_head *hashent)
@@ -101,20 +101,20 @@ struct user_struct *find_user(uid_t uid)
 	return ret;
 }
 
-void free_uid(struct user_struct *up)
+void free_uid(struct user_struct *u)
 {
 	unsigned long flags;
 
-	if (!up)
+	if (!u)
 		return;
 
 	local_irq_save(flags);
-	if (atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
-		uid_hash_remove(up);
+	if (atomic_dec_and_lock(&u->__count, &uidhash_lock)) {
+		uid_hash_remove(u);
 		spin_unlock_irqrestore(&uidhash_lock, flags);
-		key_put(up->uid_keyring);
-		key_put(up->session_keyring);
-		kmem_cache_free(uid_cachep, up);
+		key_put(u->uid_keyring);
+		key_put(u->session_keyring);
+		kmem_cache_free(uid_cachep, u);
 	} else {
 		local_irq_restore(flags);
 	}
@@ -123,13 +123,13 @@ void free_uid(struct user_struct *up)
 struct user_struct * alloc_uid(uid_t uid)
 {
 	struct list_head *hashent = uidhashentry(uid);
-	struct user_struct *up;
+	struct user_struct *u;
 
 	spin_lock_irq(&uidhash_lock);
-	up = uid_hash_find(uid, hashent);
+	u = uid_hash_find(uid, hashent);
 	spin_unlock_irq(&uidhash_lock);
 
-	if (!up) {
+	if (!u) {
 		struct user_struct *new;
 
 		new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
@@ -158,19 +158,19 @@ struct user_struct * alloc_uid(uid_t uid
 		 * on adding the same user already..
 		 */
 		spin_lock_irq(&uidhash_lock);
-		up = uid_hash_find(uid, hashent);
-		if (up) {
+		u = uid_hash_find(uid, hashent);
+		if (u) {
 			key_put(new->uid_keyring);
 			key_put(new->session_keyring);
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
-			up = new;
+			u = new;
 		}
 		spin_unlock_irq(&uidhash_lock);
 
 	}
-	return up;
+	return u;
 }
 
 void switch_uid(struct user_struct *new_user)



