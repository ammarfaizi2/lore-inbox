Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUG1Uml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUG1Uml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUG1Uml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:42:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45499 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263713AbUG1Ume (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:42:34 -0400
Date: Wed, 28 Jul 2004 13:42:02 -0700
From: Paul Jackson <pj@sgi.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040728134202.5938b275.pj@sgi.com>
In-Reply-To: <87fz7c9j0y.fsf@devron.myhome.or.jp>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi writes:
> Any comments or suggestions?

How about coding more of this in C instead of in C preprocessor:

--- 2.6.7-mm7/drivers/char/vt_ioctl.c	2004-07-10 17:21:07.000000000 -0700
+++ 2.6.7-mm7.new/drivers/char/vt_ioctl.c	2004-07-28 13:32:47.000000000 -0700
@@ -71,18 +71,26 @@ unsigned char keyboard_type = KB_101;
 #define GPLAST 0x3df
 #define GPNUM (GPLAST - GPFIRST + 1)
 
-#define i (tmp.kb_index)
-#define s (tmp.kb_table)
-#define v (tmp.kb_value)
 static inline int
 do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm, struct kbd_struct *kbd)
 {
 	struct kbentry tmp;
 	ushort *key_map, val, ov;
+	unsigned char s, i;
+	unsigned short v;
 
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
 
+	s = tmp.kb_table;
+	i = tmp.kb_index;
+	v = tmp.kb_value;
+
+	if (s >= ARRAY_SIZE(key_maps))
+		return -EINVAL;
+	if (i >= ARRAY_SIZE(key_map))
+		return -EINVAL;
+
 	switch (cmd) {
 	case KDGKBENT:
 		key_map = key_maps[s];
@@ -155,9 +163,6 @@ do_kdsk_ioctl(int cmd, struct kbentry __
 	}
 	return 0;
 }
-#undef i
-#undef s
-#undef v
 
 static inline int 
 do_kbkeycode_ioctl(int cmd, struct kbkeycode __user *user_kbkc, int perm)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
