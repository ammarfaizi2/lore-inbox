Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUG1Qsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUG1Qsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUG1Qs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:48:29 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:8979 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267301AbUG1Qr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:47:57 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 29 Jul 2004 01:46:37 +0900
In-Reply-To: <20040728115130.GA4008@pclin040.win.tue.nl>
Message-ID: <87fz7c9j0y.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> When an array has an arbitrary upper bound that can be changed
> via a #define, and for some values of the upper bound a test
> is superfluous, that does not mean that the test is superfluous.

OK. The patch is the following.

Any comments or suggestions?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] Fix NR_KEYS off-by-one error

KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.

	key_map[0] = U(K_ALLOCATED);
	for (j = 1; j < NR_KEYS; j++)
		key_map[j] = U(K_HOLE);

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/char/vt_ioctl.c  |    6 ++++++
 include/linux/keyboard.h |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff -puN include/linux/keyboard.h~nr_keys-off-by-one include/linux/keyboard.h
--- linux-2.6.8-rc2/include/linux/keyboard.h~nr_keys-off-by-one	2004-07-28 03:37:12.000000000 +0900
+++ linux-2.6.8-rc2-hirofumi/include/linux/keyboard.h	2004-07-28 03:37:12.000000000 +0900
@@ -16,7 +16,7 @@
 
 #define NR_SHIFT	9
 
-#define NR_KEYS		255
+#define NR_KEYS		256
 #define MAX_NR_KEYMAPS	256
 /* This means 128Kb if all keymaps are allocated. Only the superuser
 	may increase the number of keymaps beyond MAX_NR_OF_USER_KEYMAPS. */
diff -puN drivers/char/vt_ioctl.c~nr_keys-off-by-one drivers/char/vt_ioctl.c
--- linux-2.6.8-rc2/drivers/char/vt_ioctl.c~nr_keys-off-by-one	2004-07-29 01:31:12.000000000 +0900
+++ linux-2.6.8-rc2-hirofumi/drivers/char/vt_ioctl.c	2004-07-29 01:35:23.000000000 +0900
@@ -83,6 +83,12 @@ do_kdsk_ioctl(int cmd, struct kbentry __
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
 
+#if NR_KEYS != 256 || MAX_NR_KEYMAPS != 256
+#error "you should check this too"
+	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
+		return -EINVAL;
+#endif
+
 	switch (cmd) {
 	case KDGKBENT:
 		key_map = key_maps[s];
_
