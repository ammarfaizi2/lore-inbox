Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131761AbQK2RXc>; Wed, 29 Nov 2000 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131789AbQK2RXX>; Wed, 29 Nov 2000 12:23:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:8430 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131761AbQK2RXQ>;
        Wed, 29 Nov 2000 12:23:16 -0500
Date: Wed, 29 Nov 2000 11:52:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Hugh Dickins <hugh@veritas.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291636440.1306-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011291142590.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> That is precisely the point I was making in my previous email. But both
> that email and yours asnwer only one question:
> 
> a) should access(2) behave identical to open(2) (with switched uid)? The
> answer is Yes.
> 
> but the main question still remains unanswered:
> 
> b) what should be the return of access(W_OK) (or, the same, open() for 
> write with switched uid) for devices on a readonly-mounted filesystems?
> 
> Should the majority win? I.e. should we say OK, as we do now?

We should, but we don't. 2.4 does the right thing. 2.2 got the following
change back in 2.2.6:
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
