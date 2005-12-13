Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVLMIbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVLMIbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLMIbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:31:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:55171 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932553AbVLMIY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:56 -0500
Date: Tue, 13 Dec 2005 00:22:29 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, marcelo.tosatti@cyclades.com, mikpe@csd.uu.se
Subject: [patch 06/26] setkeys needs root
Message-ID: <20051213082229.GG5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="setkeys-needs-root.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Drake <dsd@gentoo.org>

This patch combines commit 0b360adbdb54d5b98b78d57ba0916bc4b8871968 (make
setkeys root-only) and commit e3f17f0f6e98f58edb13cb38810d93e6d4808e68 (only
disallow setting by users)

   Because people can play games reprogramming keys and leaving traps for the
   next user of the console.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/char/vt_ioctl.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.14.3.orig/drivers/char/vt_ioctl.c
+++ linux-2.6.14.3/drivers/char/vt_ioctl.c
@@ -80,6 +80,9 @@ do_kdsk_ioctl(int cmd, struct kbentry __
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
 
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
 	switch (cmd) {
 	case KDGKBENT:
 		key_map = key_maps[s];
@@ -192,6 +195,9 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
 	int i, j, k;
 	int ret;
 
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
 	kbs = kmalloc(sizeof(*kbs), GFP_KERNEL);
 	if (!kbs) {
 		ret = -ENOMEM;

--
