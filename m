Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUG0Sg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUG0Sg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266551AbUG0Sg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:36:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38160 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266545AbUG0SgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:36:00 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, aebr@win.tue.nl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040726154327.107409fc.akpm@osdl.org>
	<20040727134654.GB17362@ucw.cz> <878yd5be4z.fsf@devron.myhome.or.jp>
	<20040727175439.GA1358@ucw.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 28 Jul 2004 03:35:08 +0900
In-Reply-To: <20040727175439.GA1358@ucw.cz>
Message-ID: <87wu0p9u3n.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Wed, Jul 28, 2004 at 01:37:00AM +0900, OGAWA Hirofumi wrote:
> 
> > Vojtech Pavlik <vojtech@suse.cz> writes:
> > 
> > > > This all seems a bit inconclusive.  Do we proceed with the original patch
> > > > or not?  If not, how do we fix the overflow which Hirofumi has identified?
> > > 
> > > I think we should check the value in the ioctl, regardless of what's
> > > NR_KEYS defined to.
> > 
> > However, it breaks the current binary instead. (at least
> > console-tools, kbdutils).
>  
> We can do both, then, if that helps.

I'm confused. Sorry.

What is meaning of both? The following patch?  If so, "if (i >= NR_KEYS)"
part is never true, because "i" is unsigned char.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -puN include/linux/keyboard.h~nr_keys-off-by-one include/linux/keyboard.h
--- linux-2.6.8-rc2/include/linux/keyboard.h~nr_keys-off-by-one	2004-07-26 00:26:59.000000000 +0900
+++ linux-2.6.8-rc2-hirofumi/include/linux/keyboard.h	2004-07-26 00:26:59.000000000 +0900
@@ -16,7 +16,7 @@
 
 #define NR_SHIFT	9
 
-#define NR_KEYS		255
+#define NR_KEYS		256
 #define MAX_NR_KEYMAPS	256
 /* This means 128Kb if all keymaps are allocated. Only the superuser
 	may increase the number of keymaps beyond MAX_NR_OF_USER_KEYMAPS. */
diff -puN drivers/char/vt_ioctl.c~nr_keys-off-by-one drivers/char/vt_ioctl.c
--- linux-2.6.8-rc2/drivers/char/vt_ioctl.c~nr_keys-off-by-one	2004-07-28 03:18:43.000000000 +0900
+++ linux-2.6.8-rc2-hirofumi/drivers/char/vt_ioctl.c	2004-07-28 03:22:24.000000000 +0900
@@ -82,6 +82,8 @@ do_kdsk_ioctl(int cmd, struct kbentry __
 
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
+	if (i >= NR_KEYS)
+		return -EINVAL;
 
 	switch (cmd) {
 	case KDGKBENT:
_
