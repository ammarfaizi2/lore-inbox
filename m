Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWGJLP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWGJLP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWGJLPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:15:01 -0400
Received: from fitch1.uni2.net ([130.227.52.101]:12239 "EHLO fitch1.uni2.net")
	by vger.kernel.org with ESMTP id S1751393AbWGJLO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:14:57 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 5/9] -Wshadow: variables named 'up' clash with up()
Date: Mon, 10 Jul 2006 13:13:04 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101313.04275.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Fix -Wshadow warnings related to variables of the name 'up' clashing with
the global function name up().
(this patch fixes only those occurences that show up for allnoconfig)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/vt_ioctl.c |   60 +++++++++++++++++++-------------------
 fs/select.c             |    6 +--
 kernel/user.c           |   42 +++++++++++++-------------
 3 files changed, 54 insertions(+), 54 deletions(-)

--- linux-2.6.18-rc1-orig/kernel/user.c	2006-07-06 19:39:58.000000000 +0200
+++ linux-2.6.18-rc1/kernel/user.c	2006-07-09 20:34:50.000000000 +0200
@@ -56,24 +56,24 @@ struct user_struct root_user = {
 /*
  * These routines must be called with the uidhash spinlock held!
  */
-static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
+static inline void uid_hash_insert(struct user_struct *_up, struct list_head *hashent)
 {
-	list_add(&up->uidhash_list, hashent);
+	list_add(&_up->uidhash_list, hashent);
 }
 
-static inline void uid_hash_remove(struct user_struct *up)
+static inline void uid_hash_remove(struct user_struct *_up)
 {
-	list_del(&up->uidhash_list);
+	list_del(&_up->uidhash_list);
 }
 
 static inline struct user_struct *uid_hash_find(uid_t uid, struct list_head *hashent)
 {
-	struct list_head *up;
+	struct list_head *_up;
 
-	list_for_each(up, hashent) {
+	list_for_each(_up, hashent) {
 		struct user_struct *user;
 
-		user = list_entry(up, struct user_struct, uidhash_list);
+		user = list_entry(_up, struct user_struct, uidhash_list);
 
 		if(user->uid == uid) {
 			atomic_inc(&user->__count);
@@ -101,20 +101,20 @@ struct user_struct *find_user(uid_t uid)
 	return ret;
 }
 
-void free_uid(struct user_struct *up)
+void free_uid(struct user_struct *_up)
 {
 	unsigned long flags;
 
-	if (!up)
+	if (!_up)
 		return;
 
 	local_irq_save(flags);
-	if (atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
-		uid_hash_remove(up);
+	if (atomic_dec_and_lock(&_up->__count, &uidhash_lock)) {
+		uid_hash_remove(_up);
 		spin_unlock_irqrestore(&uidhash_lock, flags);
-		key_put(up->uid_keyring);
-		key_put(up->session_keyring);
-		kmem_cache_free(uid_cachep, up);
+		key_put(_up->uid_keyring);
+		key_put(_up->session_keyring);
+		kmem_cache_free(uid_cachep, _up);
 	} else {
 		local_irq_restore(flags);
 	}
@@ -123,13 +123,13 @@ void free_uid(struct user_struct *up)
 struct user_struct * alloc_uid(uid_t uid)
 {
 	struct list_head *hashent = uidhashentry(uid);
-	struct user_struct *up;
+	struct user_struct *_up;
 
 	spin_lock_irq(&uidhash_lock);
-	up = uid_hash_find(uid, hashent);
+	_up = uid_hash_find(uid, hashent);
 	spin_unlock_irq(&uidhash_lock);
 
-	if (!up) {
+	if (!_up) {
 		struct user_struct *new;
 
 		new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
@@ -158,19 +158,19 @@ struct user_struct * alloc_uid(uid_t uid
 		 * on adding the same user already..
 		 */
 		spin_lock_irq(&uidhash_lock);
-		up = uid_hash_find(uid, hashent);
-		if (up) {
+		_up = uid_hash_find(uid, hashent);
+		if (_up) {
 			key_put(new->uid_keyring);
 			key_put(new->session_keyring);
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
-			up = new;
+			_up = new;
 		}
 		spin_unlock_irq(&uidhash_lock);
 
 	}
-	return up;
+	return _up;
 }
 
 void switch_uid(struct user_struct *new_user)
--- linux-2.6.18-rc1-orig/fs/select.c	2006-07-06 19:39:47.000000000 +0200
+++ linux-2.6.18-rc1/fs/select.c	2006-07-09 20:35:42.000000000 +0200
@@ -524,17 +524,17 @@ asmlinkage long sys_pselect6(int n, fd_s
 	fd_set __user *exp, struct timespec __user *tsp, void __user *sig)
 {
 	size_t sigsetsize = 0;
-	sigset_t __user *up = NULL;
+	sigset_t __user *_up = NULL;
 
 	if (sig) {
 		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t __user * __user *)sig)
+		    || __get_user(_up, (sigset_t __user * __user *)sig)
 		    || __get_user(sigsetsize,
 				(size_t __user *)(sig+sizeof(void *))))
 			return -EFAULT;
 	}
 
-	return sys_pselect7(n, inp, outp, exp, tsp, up, sigsetsize);
+	return sys_pselect7(n, inp, outp, exp, tsp, _up, sigsetsize);
 }
 #endif /* TIF_RESTORE_SIGMASK */
 
--- linux-2.6.18-rc1-orig/drivers/char/vt_ioctl.c	2006-07-06 19:39:35.000000000 +0200
+++ linux-2.6.18-rc1/drivers/char/vt_ioctl.c	2006-07-09 20:38:02.000000000 +0200
@@ -187,7 +187,7 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
 	struct kbsentry *kbs;
 	char *p;
 	u_char *q;
-	u_char __user *up;
+	u_char __user *_up;
 	int sz;
 	int delta;
 	char *first_free, *fj, *fnw;
@@ -215,15 +215,15 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
 	case KDGKBSENT:
 		sz = sizeof(kbs->kb_string) - 1; /* sz should have been
 						  a struct member */
-		up = user_kdgkb->kb_string;
+		_up = user_kdgkb->kb_string;
 		p = func_table[i];
 		if(p)
 			for ( ; *p && sz; p++, sz--)
-				if (put_user(*p, up++)) {
+				if (put_user(*p, _up++)) {
 					ret = -EFAULT;
 					goto reterr;
 				}
-		if (put_user('\0', up)) {
+		if (put_user('\0', _up)) {
 			ret = -EFAULT;
 			goto reterr;
 		}
@@ -370,7 +370,7 @@ int vt_ioctl(struct tty_struct *tty, str
 	struct kbd_struct * kbd;
 	unsigned int console;
 	unsigned char ucval;
-	void __user *up = (void __user *)arg;
+	void __user *_up = (void __user *)arg;
 	int i, perm;
 	
 	console = vc->vc_num;
@@ -454,12 +454,12 @@ int vt_ioctl(struct tty_struct *tty, str
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
-		if (copy_from_user(&kbrep, up, sizeof(struct kbd_repeat)))
+		if (copy_from_user(&kbrep, _up, sizeof(struct kbd_repeat)))
 			return -EFAULT;
 		err = kbd_rate(&kbrep);
 		if (err)
 			return err;
-		if (copy_to_user(up, &kbrep, sizeof(struct kbd_repeat)))
+		if (copy_to_user(_up, &kbrep, sizeof(struct kbd_repeat)))
 			return -EFAULT;
 		return 0;
 	}
@@ -569,19 +569,19 @@ int vt_ioctl(struct tty_struct *tty, str
 	case KDSETKEYCODE:
 		if(!capable(CAP_SYS_TTY_CONFIG))
 			perm=0;
-		return do_kbkeycode_ioctl(cmd, up, perm);
+		return do_kbkeycode_ioctl(cmd, _up, perm);
 
 	case KDGKBENT:
 	case KDSKBENT:
-		return do_kdsk_ioctl(cmd, up, perm, kbd);
+		return do_kdsk_ioctl(cmd, _up, perm, kbd);
 
 	case KDGKBSENT:
 	case KDSKBSENT:
-		return do_kdgkb_ioctl(cmd, up, perm);
+		return do_kdgkb_ioctl(cmd, _up, perm);
 
 	case KDGKBDIACR:
 	{
-		struct kbdiacrs __user *a = up;
+		struct kbdiacrs __user *a = _up;
 
 		if (put_user(accent_table_size, &a->kb_cnt))
 			return -EFAULT;
@@ -592,7 +592,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case KDSKBDIACR:
 	{
-		struct kbdiacrs __user *a = up;
+		struct kbdiacrs __user *a = _up;
 		unsigned int ct;
 
 		if (!perm)
@@ -661,7 +661,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 		if (!perm)
 			return -EPERM;
-		if (copy_from_user(&tmp, up, sizeof(struct vt_mode)))
+		if (copy_from_user(&tmp, _up, sizeof(struct vt_mode)))
 			return -EFAULT;
 		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
 			return -EINVAL;
@@ -685,7 +685,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		memcpy(&tmp, &vc->vt_mode, sizeof(struct vt_mode));
 		release_console_sem();
 
-		rc = copy_to_user(up, &tmp, sizeof(struct vt_mode));
+		rc = copy_to_user(_up, &tmp, sizeof(struct vt_mode));
 		return rc ? -EFAULT : 0;
 	}
 
@@ -696,7 +696,7 @@ int vt_ioctl(struct tty_struct *tty, str
 	 */
 	case VT_GETSTATE:
 	{
-		struct vt_stat __user *vtstat = up;
+		struct vt_stat __user *vtstat = _up;
 		unsigned short state, mask;
 
 		if (put_user(fg_console + 1, &vtstat->v_active))
@@ -840,7 +840,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case VT_RESIZE:
 	{
-		struct vt_sizes __user *vtsizes = up;
+		struct vt_sizes __user *vtsizes = _up;
 		ushort ll,cc;
 		if (!perm)
 			return -EPERM;
@@ -857,7 +857,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case VT_RESIZEX:
 	{
-		struct vt_consize __user *vtconsize = up;
+		struct vt_consize __user *vtconsize = _up;
 		ushort ll,cc,vlin,clin,vcol,ccol;
 		if (!perm)
 			return -EPERM;
@@ -911,7 +911,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		op.width = 8;
 		op.height = 0;
 		op.charcount = 256;
-		op.data = up;
+		op.data = _up;
 		return con_font_op(vc_cons[fg_console].d, &op);
 	}
 
@@ -921,21 +921,21 @@ int vt_ioctl(struct tty_struct *tty, str
 		op.width = 8;
 		op.height = 32;
 		op.charcount = 256;
-		op.data = up;
+		op.data = _up;
 		return con_font_op(vc_cons[fg_console].d, &op);
 	}
 
 	case PIO_CMAP:
                 if (!perm)
 			return -EPERM;
-                return con_set_cmap(up);
+                return con_set_cmap(_up);
 
 	case GIO_CMAP:
-                return con_get_cmap(up);
+                return con_get_cmap(_up);
 
 	case PIO_FONTX:
 	case GIO_FONTX:
-		return do_fontx_ioctl(cmd, up, perm, &op);
+		return do_fontx_ioctl(cmd, _up, perm, &op);
 
 	case PIO_FONTRESET:
 	{
@@ -960,13 +960,13 @@ int vt_ioctl(struct tty_struct *tty, str
 	}
 
 	case KDFONTOP: {
-		if (copy_from_user(&op, up, sizeof(op)))
+		if (copy_from_user(&op, _up, sizeof(op)))
 			return -EFAULT;
 		if (!perm && op.op != KD_FONT_OP_GET)
 			return -EPERM;
 		i = con_font_op(vc, &op);
 		if (i) return i;
-		if (copy_to_user(up, &op, sizeof(op)))
+		if (copy_to_user(_up, &op, sizeof(op)))
 			return -EFAULT;
 		return 0;
 	}
@@ -974,24 +974,24 @@ int vt_ioctl(struct tty_struct *tty, str
 	case PIO_SCRNMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_trans_old(up);
+		return con_set_trans_old(_up);
 
 	case GIO_SCRNMAP:
-		return con_get_trans_old(up);
+		return con_get_trans_old(_up);
 
 	case PIO_UNISCRNMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_trans_new(up);
+		return con_set_trans_new(_up);
 
 	case GIO_UNISCRNMAP:
-		return con_get_trans_new(up);
+		return con_get_trans_new(_up);
 
 	case PIO_UNIMAPCLR:
 	      { struct unimapinit ui;
 		if (!perm)
 			return -EPERM;
-		i = copy_from_user(&ui, up, sizeof(struct unimapinit));
+		i = copy_from_user(&ui, _up, sizeof(struct unimapinit));
 		if (i) return -EFAULT;
 		con_clear_unimap(vc, &ui);
 		return 0;
@@ -999,7 +999,7 @@ int vt_ioctl(struct tty_struct *tty, str
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, up, perm, vc);
+		return do_unimap_ioctl(cmd, _up, perm, vc);
 
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))



