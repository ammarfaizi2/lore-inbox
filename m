Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270319AbTGWNXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270321AbTGWNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:23:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:13838 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270319AbTGWNX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:23:26 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Japanese keyboards broken in 2.6
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>
	<20030722172903.A12240@pclin040.win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 23 Jul 2003 22:38:01 +0900
In-Reply-To: <20030722172903.A12240@pclin040.win.tue.nl>
Message-ID: <87k7a9z7ly.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> On Tue, Jul 22, 2003 at 10:56:33PM +0900, Norman Diamond wrote:
> 
> > On a Japanese PS/2 keyboard
> 
> I did not read your long message but stopped after the above words.
> Sorry if this is not an answer (ask again).
> 
> For 2.6.0t1 it helps to add the line
> 
>   keycode 183 = backslash bar
> 
> to your keymap.

I remembered this problem. At 2.4.x kbd tools use "#define NR_KEYS 128".
So, we can't set >= 128.

Currently NR_KEYS is 0x200 (KEY_MAX+1). We can't only recompile
because ->kb_index (struct kbentry) type using "unsigned char".

What do you think the following patch? (it may be needed to cleanup or
rewrite)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

 drivers/char/vt_ioctl.c |   49 +++++++++++++++++++++++++++++++++---------------
 include/linux/kd.h      |   14 ++++++++++---
 2 files changed, 45 insertions(+), 18 deletions(-)

diff -puN drivers/char/vt_ioctl.c~kbentry-fix drivers/char/vt_ioctl.c
--- linux-2.6.0-test1/drivers/char/vt_ioctl.c~kbentry-fix	2003-07-20 00:51:05.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/drivers/char/vt_ioctl.c	2003-07-20 00:51:05.000000000 +0900
@@ -75,26 +75,43 @@ asmlinkage long sys_ioperm(unsigned long
 #define s (tmp.kb_table)
 #define v (tmp.kb_value)
 static inline int
-do_kdsk_ioctl(int cmd, struct kbentry *user_kbe, int perm, struct kbd_struct *kbd)
+do_kdsk_ioctl(int cmd, void *user_kbe, int perm, struct kbd_struct *kbd)
 {
-	struct kbentry tmp;
+	struct kbentry tmp, *kbe = user_kbe;
+	struct kbentry_old old, *old_kbe = user_kbe;
 	ushort *key_map, val, ov;
 
-	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
-		return -EFAULT;
+	if (cmd == KDGKBENT_OLD || cmd == KDSKBENT_OLD) {
+		/* backward compatibility */
+		if (copy_from_user(&old, old_kbe, sizeof(struct kbentry_old)))
+			return -EFAULT;
+
+		tmp.kb_index = old.kb_index;
+		tmp.kb_table = old.kb_table;
+		tmp.kb_value = old.kb_value;
+	} else {
+		if (copy_from_user(&tmp, kbe, sizeof(struct kbentry)))
+			return -EFAULT;
+	}
+
 	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
 		return -EINVAL;	
 
 	switch (cmd) {
+	case KDGKBENT_OLD:
 	case KDGKBENT:
 		key_map = key_maps[s];
 		if (key_map) {
-		    val = U(key_map[i]);
-		    if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
-			val = K_HOLE;
+			val = U(key_map[i]);
+			if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
+				val = K_HOLE;
 		} else
-		    val = (i ? K_HOLE : K_NOSUCHMAP);
-		return put_user(val, &user_kbe->kb_value);
+			val = (i ? K_HOLE : K_NOSUCHMAP);
+
+		if (cmd ==  KDGKBENT_OLD)
+			return put_user(val, &old_kbe->kb_value);
+		return put_user(val, &kbe->kb_value);
+	case KDSKBENT_OLD:
 	case KDSKBENT:
 		if (!perm)
 			return -EPERM;
@@ -102,20 +119,20 @@ do_kdsk_ioctl(int cmd, struct kbentry *u
 			/* disallocate map */
 			key_map = key_maps[s];
 			if (s && key_map) {
-			    key_maps[s] = 0;
-			    if (key_map[0] == U(K_ALLOCATED)) {
+				key_maps[s] = 0;
+				if (key_map[0] == U(K_ALLOCATED)) {
 					kfree(key_map);
 					keymap_count--;
-			    }
+				}
 			}
 			break;
 		}
 
 		if (KTYP(v) < NR_TYPES) {
-		    if (KVAL(v) > max_vals[KTYP(v)])
+			if (KVAL(v) > max_vals[KTYP(v)])
 				return -EINVAL;
 		} else
-		    if (kbd->kbdmode != VC_UNICODE)
+			if (kbd->kbdmode != VC_UNICODE)
 				return -EINVAL;
 
 		/* ++Geert: non-PC keyboards may generate keycode zero */
@@ -572,9 +589,11 @@ int vt_ioctl(struct tty_struct *tty, str
 			perm=0;
 		return do_kbkeycode_ioctl(cmd, (struct kbkeycode *)arg, perm);
 
+	case KDGKBENT_OLD:
+	case KDSKBENT_OLD:
 	case KDGKBENT:
 	case KDSKBENT:
-		return do_kdsk_ioctl(cmd, (struct kbentry *)arg, perm, kbd);
+		return do_kdsk_ioctl(cmd, (void *)arg, perm, kbd);
 
 	case KDGKBSENT:
 	case KDSKBSENT:
diff -puN include/linux/kd.h~kbentry-fix include/linux/kd.h
--- linux-2.6.0-test1/include/linux/kd.h~kbentry-fix	2003-07-20 00:51:05.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/include/linux/kd.h	2003-07-20 00:51:05.000000000 +0900
@@ -94,18 +94,26 @@ struct unimapinit {
 #define	KDGKBLED	0x4B64	/* get led flags (not lights) */
 #define	KDSKBLED	0x4B65	/* set led flags (not lights) */
 
-struct kbentry {
+struct kbentry_old {
 	unsigned char kb_table;
 	unsigned char kb_index;
 	unsigned short kb_value;
 };
+#define KDGKBENT_OLD	0x4B46	/* gets one entry in translation table (old) */
+#define KDSKBENT_OLD	0x4B47	/* sets one entry in translation table (old) */
+
+struct kbentry {
+	unsigned int kb_table;
+	unsigned int kb_index;
+	unsigned short kb_value;
+};
 #define		K_NORMTAB	0x00
 #define		K_SHIFTTAB	0x01
 #define		K_ALTTAB	0x02
 #define		K_ALTSHIFTTAB	0x03
 
-#define KDGKBENT	0x4B46	/* gets one entry in translation table */
-#define KDSKBENT	0x4B47	/* sets one entry in translation table */
+#define KDGKBENT	0x4B73	/* gets one entry in translation table */
+#define KDSKBENT	0x4B74	/* sets one entry in translation table */
 
 struct kbsentry {
 	unsigned char kb_func;

_
