Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbRAKKXZ>; Thu, 11 Jan 2001 05:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbRAKKXP>; Thu, 11 Jan 2001 05:23:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130063AbRAKKXJ>;
	Thu, 11 Jan 2001 05:23:09 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 11 Jan 2001 07:34:01 +0000 (GMT)
Cc: mantel@suse.de (Hubert Mantel),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010111005924.L29093@athlon.random> from "Andrea Arcangeli" at Jan 11, 2001 12:59:24 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> However I'd _love_ to see the EIP where you get the fault, I currently don't
> see the line of code that is crashing your ARM and I know this code doesn't
> segfault on ARM.

Examine nlm_lookup_file() and the usage of fh->fh_dev and fh->fh_ino.
What happens is that in that dprintk fh_dev and fh_ino contain garbage
and as such, the nlm_lookup_file fails (since it doesn't refer to a valid
device and inode pair).  Therefore locking does not work.

Note: I've never said that it crashes.  I've only said that NFS locking
does not work.

> > And yes, APIs shouldn't break in a major kernel release.  Its a shame some
> > API broke in 2.2.18.
> 
> What broke in 2.2.18?

The API changed:

 struct nfs_mount_data {
        int             version;                /* 1 */
        int             fd;                     /* 1 */
-       struct nfs_fh   root;                   /* 1 */
+       struct nfs2_fh  old_root;               /* 1 */
        int             flags;                  /* 1 */
        int             rsize;                  /* 1 */
        int             wsize;                  /* 1 */
@@ -35,6 +42,7 @@
        char            hostname[256];          /* 1 */
        int             namlen;                 /* 2 */
        unsigned int    bsize;                  /* 3 */
+       struct nfs_fh   root;                   /* 4 */
 };

which then caused this breakage.  Therefore, I still propose my original
patch as a bug fix against something that appears to be brand new in
design.

Anyway, changing it back will break the API on ARM, so either way API
breakage WILL happen at some point.  The real question is which is better:

1. Yucky code in the NFS layers to copy a nfs_fh from userspace to kernel
   space, translating it into something sane.
2. Yucky code in the NFS layers to manually handle the nfs_fh to knfs_fh
   translation.
3. Accept the breakage of a *brand new* API in 2.2.18 and suffer zero
   yucky code.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
