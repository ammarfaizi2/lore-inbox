Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUG2UuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUG2UuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUG2Utr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:49:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19431 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265269AbUG2UnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:43:03 -0400
Date: Thu, 29 Jul 2004 22:42:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, aia21@cantab.net,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [patch] Re: 2.6.8-rc2-mm1: NTFS compile error with gcc 2.95
Message-ID: <20040729204250.GD2349@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040729144149.GC2349@fs.tum.de> <20040729155411.GF26643@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729155411.GF26643@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 05:54:11PM +0200, Jan-Benedict Glaw wrote:
> > 
> > This causes the following compile error when using gcc 2.95:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > fs/built-in.o(.text+0x14425f): In function `ntfs_find_vcn':
> > : undefined reference to `__cmpdi2'
> > fs/built-in.o(.text+0x144272): In function `ntfs_find_vcn':
> > : undefined reference to `__cmpdi2'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > <--  snip  -->
> 
> GCC wanted to make a compare on a 8byte integer (so probably long long),
> but decided there isn't an appropriate insn on that hardware platform.
> So instead of emitting assembler, it generated a function call that
> would have resulted in a call to libgcc. However, the Linux kernel asks
> to *not* link that lib (eg. think about a gcc compiled for i686 (so is
> libgcc) while compiling for i386).
>...

We had the same problem somewhere else recently.

This problem occurs only with gcc 2.95 and case statements.

> MfG, JBG


What about the following patch to fix NTFS compilation with gcc 2.95?


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-mm1-full/fs/ntfs/attrib.c.old	2004-07-29 22:34:21.000000000 +0200
+++ linux-2.6.8-rc2-mm1-full/fs/ntfs/attrib.c	2004-07-29 22:36:15.000000000 +0200
@@ -1113,15 +1113,11 @@
 			}
 			rl++;
 		}
-		switch (rl->lcn) {
-		case (LCN)LCN_RL_NOT_MAPPED:
-			break;
-		case (LCN)LCN_ENOENT:
-			err = -ENOENT;
-			break;
-		default:
-			err = -EIO;
-			break;
+		if (rl->lcn != (LCN)LCN_RL_NOT_MAPPED) {
+			if (rl->lcn == (LCN)LCN_ENOENT)
+				err = -ENOENT;
+			else
+				err = -EIO;
 		}
 	}
 	if (!need_write)


