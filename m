Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277666AbRJRKBO>; Thu, 18 Oct 2001 06:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277667AbRJRKAz>; Thu, 18 Oct 2001 06:00:55 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:37391 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S277666AbRJRKAk>; Thu, 18 Oct 2001 06:00:40 -0400
Message-ID: <3BCEA924.14415870@loewe-komp.de>
Date: Thu, 18 Oct 2001 12:04:20 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: nfsfh.c:nfsd_findparent lookup("..") failure fix in 2.4.4 - xfs related?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following diff was made in 2.4.4.
 
diff -u --recursive --new-file v2.4.4/linux/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
--- v2.4.4/linux/fs/nfsd/nfsfh.c        Fri Feb  9 11:29:44 2001
+++ linux/fs/nfsd/nfsfh.c       Sat May 19 17:47:55 2001
@@ -244,6 +245,11 @@
         */
        pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
        d_drop(tdentry); /* we never want ".." hashed */
+       if (!pdentry && tdentry->d_inode == NULL) {
+               /* File system cannot find ".." ... sad but possible */
+               dput(tdentry);
+               pdentry = ERR_PTR(-EINVAL);
+       }


Umh. How is it possible to have a valid dentry which has no parent?
Even "/.." is linked to "/."

Is this xfs related? At least it was triggered on 2.4.3-xfs with
exported xfs filesystems.
