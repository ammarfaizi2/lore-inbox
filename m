Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSEHImQ>; Wed, 8 May 2002 04:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSEHImP>; Wed, 8 May 2002 04:42:15 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:42115 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312411AbSEHImO>;
	Wed, 8 May 2002 04:42:14 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15576.58488.179061.846058@argo.ozlabs.ibm.com>
Date: Wed, 8 May 2002 18:40:24 +1000 (EST)
To: jsimmons@transvirtual.com
Cc: linux-kernel@vger.kernel.org
Subject: cmap problems with aty128fb.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having difficulties with aty128fb.c in 2.5.14.  The
version in Linus' tree crashes on boot for me with a null pointer
dereference in memcpy, called from fb_copy_cmap from gen_set_cmap,
from fbcon_show_logo via the fbops->fb_set_cmap pointer.

At the lowest level the null pointer dereference is caused by a
signed/unsigned bug in fb_copy_cmap.  We are ending up with size > 0
even when to->start and to->len were both zero.  The patch below fixes
that.

At the next level up, the problem seems to be that info->cmap is never
getting initialized.  How and where is it supposed to be initialized?

Paul.

diff -urN linux-2.5/drivers/video/fbcmap.c pmac-2.5/drivers/video/fbcmap.c
--- linux-2.5/drivers/video/fbcmap.c	Mon Apr 29 16:25:24 2002
+++ pmac-2.5/drivers/video/fbcmap.c	Wed May  8 16:29:04 2002
@@ -150,9 +150,9 @@
     else
 	tooff = from->start-to->start;
     size = to->len-tooff;
-    if (size > from->len-fromoff)
+    if (size > (int)(from->len-fromoff))
 	size = from->len-fromoff;
-    if (size < 0)
+    if (size <= 0)
 	return;
     size *= sizeof(u16);
     
