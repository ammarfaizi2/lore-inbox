Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131747AbQK2Rsg>; Wed, 29 Nov 2000 12:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131870AbQK2Rs0>; Wed, 29 Nov 2000 12:48:26 -0500
Received: from hera.cwi.nl ([192.16.191.1]:17290 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131747AbQK2RsY>;
        Wed, 29 Nov 2000 12:48:24 -0500
Date: Wed, 29 Nov 2000 18:17:38 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011291717.SAA136039.aeb@aak.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, tigran@veritas.com, viro@math.psu.edu
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
Cc: aeb@veritas.com, hugh@veritas.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Wed Nov 29 17:52:57 2000

    > Should the majority win? I.e. should we say OK, as we do now?

    We should, but we don't. 2.4 does the right thing.
    2.2 got the following change back in 2.2.6:

            res = PTR_ERR(dentry);
            if (!IS_ERR(dentry)) {
                    res = permission(dentry->d_inode, mode);
    +               /* SuS v2 requires we report a read only fs too */
    +               if(!res && (mode & S_IWOTH) && IS_RDONLY(dentry->d_inode))
    +                       res = -EROFS;
                    dput(dentry);
            }
    ... and that's what really ticks me off - permission() does the right
    tests in case of read-only fs (ignoring the r/o vs. r/w for devices and
    FIFOs), but sys_access() explicitly overrides that.

    IMO we should revert that in 2.2. HP/UX is probably hopeless - if they
    will ever start caring about bogus behaviour access() will not be anywhere
    near the top of their list ;-/

Yes. Alan, it seems we all agree that 

--- open.c~     Tue Jan  4 19:12:23 2000
+++ open.c      Wed Nov 29 18:14:14 2000
@@ -305,9 +305,6 @@
        res = PTR_ERR(dentry);
        if (!IS_ERR(dentry)) {
                res = permission(dentry->d_inode, mode);
-               /* SuS v2 requires we report a read only fs too */
-               if(!res && (mode & S_IWOTH) && IS_RDONLY(dentry->d_inode))
-                       res = -EROFS;
                dput(dentry);
        }

is a good idea.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
