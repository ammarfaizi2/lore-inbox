Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTIYQ4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTIYQyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:54:41 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39383 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261607AbTIYQuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:50:39 -0400
Subject: [PATCH 6/8] Extend KD?BENT to handle > 256 keycodes.
In-Reply-To: <10645086121089@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 25 Sep 2003 18:50:12 +0200
Message-Id: <1064508612197@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, dtor_core@ameritech.net, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1346, 2003-09-25 18:28:12+02:00, hirofumi@mail.parknet.co.jp
  input: Create new KD?BENT ioctls with a bigger key range (int), so that
         it's posible to recompile kbdutils on 2.6 and load keymaps for
         keys beyond 128. kbdutils compiled on 2.4 will keep working on
         2.6, unfortunately not vice versa, without changing kbdutils.


 arch/mips/kernel/ioctl32.c   |    2 +
 drivers/char/vt_ioctl.c      |   51 +++++++++++++++++++++++++++++--------------
 include/linux/compat_ioctl.h |    2 +
 include/linux/kd.h           |   14 +++++++++--
 4 files changed, 50 insertions(+), 19 deletions(-)

===================================================================

diff -Nru a/arch/mips/kernel/ioctl32.c b/arch/mips/kernel/ioctl32.c
--- a/arch/mips/kernel/ioctl32.c	Thu Sep 25 18:37:13 2003
+++ b/arch/mips/kernel/ioctl32.c	Thu Sep 25 18:37:13 2003
@@ -884,6 +884,8 @@
 COMPATIBLE_IOCTL(KDGKBMODE)
 COMPATIBLE_IOCTL(KDSKBMETA)
 COMPATIBLE_IOCTL(KDGKBMETA)
+COMPATIBLE_IOCTL(KDGKBENT_OLD)
+COMPATIBLE_IOCTL(KDSKBENT_OLD)
 COMPATIBLE_IOCTL(KDGKBENT)
 COMPATIBLE_IOCTL(KDSKBENT)
 COMPATIBLE_IOCTL(KDGKBSENT)
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Thu Sep 25 18:37:13 2003
+++ b/drivers/char/vt_ioctl.c	Thu Sep 25 18:37:13 2003
@@ -75,24 +75,41 @@
 #define s (tmp.kb_table)
 #define v (tmp.kb_value)
 static inline int
-do_kdsk_ioctl(int cmd, struct kbentry *user_kbe, int perm, struct kbd_struct *kbd)
+do_kdsk_ioctl(int cmd, void *user_kbe, int perm, struct kbd_struct *kbd)
 {
-	struct kbentry tmp;
+	struct kbentry tmp, *kbe = user_kbe;;
+	struct kbentry_old old, *old_kbe = user_kbe;
 	ushort *key_map, val, ov;
 
-	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
-		return -EFAULT;
-
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
+		if (cmd == KDGKBENT_OLD)
+			return put_user(val, &old_kbe->kb_value);
+		return put_user(val, &kbe->kb_value);
+
+	case KDSKBENT_OLD:
 	case KDSKBENT:
 		if (!perm)
 			return -EPERM;
@@ -100,20 +117,20 @@
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
@@ -566,9 +583,11 @@
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
diff -Nru a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
--- a/include/linux/compat_ioctl.h	Thu Sep 25 18:37:13 2003
+++ b/include/linux/compat_ioctl.h	Thu Sep 25 18:37:13 2003
@@ -161,6 +161,8 @@
 COMPATIBLE_IOCTL(KDGKBMODE)
 COMPATIBLE_IOCTL(KDSKBMETA)
 COMPATIBLE_IOCTL(KDGKBMETA)
+COMPATIBLE_IOCTL(KDGKBENT_OLD)
+COMPATIBLE_IOCTL(KDSKBENT_OLD)
 COMPATIBLE_IOCTL(KDGKBENT)
 COMPATIBLE_IOCTL(KDSKBENT)
 COMPATIBLE_IOCTL(KDGKBSENT)
diff -Nru a/include/linux/kd.h b/include/linux/kd.h
--- a/include/linux/kd.h	Thu Sep 25 18:37:13 2003
+++ b/include/linux/kd.h	Thu Sep 25 18:37:13 2003
@@ -94,18 +94,26 @@
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

