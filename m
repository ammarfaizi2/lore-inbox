Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267623AbUG3H2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267623AbUG3H2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 03:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUG3H2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 03:28:25 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:35819 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267644AbUG3H2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 03:28:20 -0400
Date: Fri, 30 Jul 2004 00:27:06 -0700
From: Paul Jackson <pj@sgi.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: akpm@osdl.org, aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040730002706.2330974d.pj@sgi.com>
In-Reply-To: <87pt6e2sm3.fsf@devron.myhome.or.jp>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
	<87llh3ihcn.fsf@ibmpc.myhome.or.jp>
	<20040728231548.4edebd5b.pj@sgi.com>
	<87oelzjhcx.fsf@ibmpc.myhome.or.jp>
	<20040729024931.4b4e78e6.pj@sgi.com>
	<20040729162423.7452e8f5.akpm@osdl.org>
	<20040729165152.492faced.pj@sgi.com>
	<87pt6e2sm3.fsf@devron.myhome.or.jp>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew writes:
> Hate to be a bore, but I'm still waiting for a definitive patch ;)

OGAWA Hirofumi writes:
> Could you please post your lastest patch? It seems that my patch does
> not satisfy peoples.

Hmmm ...

As is often the case, Andrew knows more than he lets on.


OGAWA,

I cannot post a latest patch.  I do not know enough to do so.

I attempted some code readability comments, but probably I should not
have, since I don't have the knowledge of this code that I should have
in order to test it, nor to know by reading it what works.

You replied, a couple of messages ago, with entirely sensible comments
to my posting.  Since then, I have been doing my best to remove myself
from this thread.

Unless you have something else you wish to propose, please tell Andrew
to go with your patch, which (just to avoid confusion) I copy again
below.

Your patch satisfies me just fine now.

Please let Andrew know if he should take it.

My apologies for making a confusion of this.

Thank-you for your good work and your patience.


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
-

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
