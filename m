Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbTCKCk3>; Mon, 10 Mar 2003 21:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbTCKCk3>; Mon, 10 Mar 2003 21:40:29 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:40627 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP
	id <S262802AbTCKCkZ>; Mon, 10 Mar 2003 21:40:25 -0500
Message-ID: <3E6D4E8C.46002A13@verizon.net>
Date: Mon, 10 Mar 2003 18:48:44 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.64 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: [PATCH] vt_ioctl() stack size reduction (v2)
Content-Type: multipart/mixed;
 boundary="------------0D2F297F1BB89F7147301F97"
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [4.64.238.61] at Mon, 10 Mar 2003 20:51:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0D2F297F1BB89F7147301F97
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch (to 2.5.64) reduces stack size usage in
  drivers/char/vt_ioctl.c::vt_ioctl()
from 0x334 bytes to 0xec bytes (P4, UP, gcc 2.96).

James, are you the maintainer of this module?

Comments, anyone?

Thanks to Ingo Oeser for one suggestion -- applied.

~Randy
--------------0D2F297F1BB89F7147301F97
Content-Type: text/plain; charset=us-ascii;
 name="vt_ioctl_stack3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt_ioctl_stack3.patch"

patch_name:	vt_ioctl_stack3.patch
patch_version:	2003-03-10.18:12:21
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduces stack usage in drivers/char/vt_ioctl.c::vt_ioctl()
		from 0x334 bytes to 0xec bytes (P4, UP, gcc 2.96)
product_versions: linux-2564
changelog:	share one console_font_op structure throughout the ioctl();
		kmalloc() the kbsentry struct (513 bytes);
requires:	Linux 2.5.64
maintainer:	jsimmons@users.sf.net, jsimmons@infradead.org
diffstat:	=
 drivers/char/vt_ioctl.c |  104 ++++++++++++++++++++++++++++--------------------
 1 files changed, 62 insertions(+), 42 deletions(-)


diff -Naur ./drivers/char/vt_ioctl.c%VTSTK ./drivers/char/vt_ioctl.c
--- ./drivers/char/vt_ioctl.c%VTSTK	Tue Mar  4 19:29:31 2003
+++ ./drivers/char/vt_ioctl.c	Mon Mar 10 18:08:32 2003
@@ -191,38 +191,56 @@
 static inline int
 do_kdgkb_ioctl(int cmd, struct kbsentry *user_kdgkb, int perm)
 {
-	struct kbsentry tmp;
+	struct kbsentry *kbs;
 	char *p;
 	u_char *q;
 	int sz;
 	int delta;
 	char *first_free, *fj, *fnw;
 	int i, j, k;
+	int ret;
+
+	kbs = kmalloc(sizeof(*kbs), GFP_KERNEL);
+	if (!kbs) {
+		ret = -ENOMEM;
+		goto reterr;
+	}
 
 	/* we mostly copy too much here (512bytes), but who cares ;) */
-	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
-		return -EFAULT;
-	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
-	if (tmp.kb_func >= MAX_NR_FUNC)
-		return -EINVAL;
-	i = tmp.kb_func;
+	if (copy_from_user(kbs, user_kdgkb, sizeof(struct kbsentry))) {
+		ret = -EFAULT;
+		goto reterr;
+	}
+	kbs->kb_string[sizeof(kbs->kb_string)-1] = '\0';
+	if (kbs->kb_func >= MAX_NR_FUNC) {
+		ret = -EINVAL;
+		goto reterr;
+	}
+	i = kbs->kb_func;
 
 	switch (cmd) {
 	case KDGKBSENT:
-		sz = sizeof(tmp.kb_string) - 1; /* sz should have been
+		sz = sizeof(kbs->kb_string) - 1; /* sz should have been
 						  a struct member */
 		q = user_kdgkb->kb_string;
 		p = func_table[i];
 		if(p)
 			for ( ; *p && sz; p++, sz--)
-				if (put_user(*p, q++))
-					return -EFAULT;
-		if (put_user('\0', q))
-			return -EFAULT;
+				if (put_user(*p, q++)) {
+					ret = -EFAULT;
+					goto reterr;
+				}
+		if (put_user('\0', q)) {
+			ret = -EFAULT;
+			goto reterr;
+		}
+		kfree(kbs);
 		return ((p && *p) ? -EOVERFLOW : 0);
 	case KDSKBSENT:
-		if (!perm)
-			return -EPERM;
+		if (!perm) {
+			ret = -EPERM;
+			goto reterr;
+		}
 
 		q = func_table[i];
 		first_free = funcbufptr + (funcbufsize - funcbufleft);
@@ -233,7 +251,7 @@
 		else
 			fj = first_free;
 
-		delta = (q ? -strlen(q) : 1) + strlen(tmp.kb_string);
+		delta = (q ? -strlen(q) : 1) + strlen(kbs->kb_string);
 		if (delta <= funcbufleft) { 	/* it fits in current buf */
 		    if (j < MAX_NR_FUNC) {
 			memmove(fj + delta, fj, first_free - fj);
@@ -249,8 +267,10 @@
 		    while (sz < funcbufsize - funcbufleft + delta)
 		      sz <<= 1;
 		    fnw = (char *) kmalloc(sz, GFP_KERNEL);
-		    if(!fnw)
-		      return -ENOMEM;
+		    if(!fnw) {
+		      ret = -ENOMEM;
+		      goto reterr;
+		    }
 
 		    if (!q)
 		      func_table[i] = fj;
@@ -272,17 +292,20 @@
 		    funcbufleft = funcbufleft - delta + sz - funcbufsize;
 		    funcbufsize = sz;
 		}
-		strcpy(func_table[i], tmp.kb_string);
+		strcpy(func_table[i], kbs->kb_string);
 		break;
 	}
-	return 0;
+	ret = 0;
+
+reterr:
+	kfree(kbs);
+	return ret;
 }
 
 static inline int 
-do_fontx_ioctl(int cmd, struct consolefontdesc *user_cfd, int perm)
+do_fontx_ioctl(int cmd, struct consolefontdesc *user_cfd, int perm, struct console_font_op *op)
 {
 	struct consolefontdesc cfdarg;
-	struct console_font_op op;
 	int i;
 
 	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc))) 
@@ -292,25 +315,25 @@
 	case PIO_FONTX:
 		if (!perm)
 			return -EPERM;
-		op.op = KD_FONT_OP_SET;
-		op.flags = KD_FONT_FLAG_OLD;
-		op.width = 8;
-		op.height = cfdarg.charheight;
-		op.charcount = cfdarg.charcount;
-		op.data = cfdarg.chardata;
-		return con_font_op(fg_console, &op);
+		op->op = KD_FONT_OP_SET;
+		op->flags = KD_FONT_FLAG_OLD;
+		op->width = 8;
+		op->height = cfdarg.charheight;
+		op->charcount = cfdarg.charcount;
+		op->data = cfdarg.chardata;
+		return con_font_op(fg_console, op);
 	case GIO_FONTX: {
-		op.op = KD_FONT_OP_GET;
-		op.flags = KD_FONT_FLAG_OLD;
-		op.width = 8;
-		op.height = cfdarg.charheight;
-		op.charcount = cfdarg.charcount;
-		op.data = cfdarg.chardata;
-		i = con_font_op(fg_console, &op);
+		op->op = KD_FONT_OP_GET;
+		op->flags = KD_FONT_FLAG_OLD;
+		op->width = 8;
+		op->height = cfdarg.charheight;
+		op->charcount = cfdarg.charcount;
+		op->data = cfdarg.chardata;
+		i = con_font_op(fg_console, op);
 		if (i)
 			return i;
-		cfdarg.charheight = op.height;
-		cfdarg.charcount = op.charcount;
+		cfdarg.charheight = op->height;
+		cfdarg.charcount = op->charcount;
 		if (copy_to_user(user_cfd, &cfdarg, sizeof(struct consolefontdesc)))
 			return -EFAULT;
 		return 0;
@@ -355,6 +378,7 @@
 	unsigned char ucval;
 	struct kbd_struct * kbd;
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
+	struct console_font_op op;	/* used in multiple places here */
 
 	console = vt->vc_num;
 
@@ -860,7 +884,6 @@
 	}
 
 	case PIO_FONT: {
-		struct console_font_op op;
 		if (!perm)
 			return -EPERM;
 		op.op = KD_FONT_OP_SET;
@@ -873,7 +896,6 @@
 	}
 
 	case GIO_FONT: {
-		struct console_font_op op;
 		op.op = KD_FONT_OP_GET;
 		op.flags = KD_FONT_FLAG_OLD;
 		op.width = 8;
@@ -893,7 +915,7 @@
 
 	case PIO_FONTX:
 	case GIO_FONTX:
-		return do_fontx_ioctl(cmd, (struct consolefontdesc *)arg, perm);
+		return do_fontx_ioctl(cmd, (struct consolefontdesc *)arg, perm, &op);
 
 	case PIO_FONTRESET:
 	{
@@ -906,7 +928,6 @@
 		return -ENOSYS;
 #else
 		{
-		struct console_font_op op;
 		op.op = KD_FONT_OP_SET_DEFAULT;
 		op.data = NULL;
 		i = con_font_op(fg_console, &op);
@@ -918,7 +939,6 @@
 	}
 
 	case KDFONTOP: {
-		struct console_font_op op;
 		if (copy_from_user(&op, (void *) arg, sizeof(op)))
 			return -EFAULT;
 		if (!perm && op.op != KD_FONT_OP_GET)

--------------0D2F297F1BB89F7147301F97--

