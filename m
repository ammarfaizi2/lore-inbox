Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbREWBP6>; Tue, 22 May 2001 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262935AbREWBPs>; Tue, 22 May 2001 21:15:48 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:35494 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262934AbREWBPl>; Tue, 22 May 2001 21:15:41 -0400
Message-Id: <5.0.2.1.2.20010522180640.00ae5a30@pxwang.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 22 May 2001 18:15:30 -0700
To: alan@lxorguk.ukuu.org.uk
From: Philip Wang <PXWang@stanford.edu>
Subject: [PATCH] drivers/media/video/zr36120.c (repost)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I wanted to repost this zr36120 patch, both because so far it has gone 
unnoticed, and because there was a problem with the text formatting which 
is now fixed.

There is a bug in zr36120.c of not freeing memory on error paths.  This one 
is particularly dangerous, because kmalloc allocates a memory block the 
size of an entire video clip!  I simply free the local pointer, vcp, before 
returning -EFAULT.

Philip

--- drivers/media/video/zr36120.c.orig      Tue May 22 18:08:22 2001
+++ drivers/media/video/zr36120.c   Tue May 22 18:08:49 2001
@@ -1195,8 +1195,10 @@
                 if (vcp==NULL)
                         return -ENOMEM;
                 if (vw.clipcount && copy_from_user(vcp,vw.clips,sizeof(s$
-                       return -EFAULT;
-
+                 {
+                   vfree(vcp);
+                   return -EFAULT;
+                 }
                 on = ztv->running;
                 if (on)
                         zoran_cap(ztv, 0);

