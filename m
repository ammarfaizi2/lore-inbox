Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266403AbUBLMsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 07:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266405AbUBLMsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 07:48:51 -0500
Received: from witte.sonytel.be ([80.88.33.193]:11467 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266403AbUBLMso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 07:48:44 -0500
Date: Thu, 12 Feb 2004 13:48:23 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Urban.Widmark@enlight.net,
       JohnNewbigin <jn@it.swin.edu.au>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: smb_ops_unix warning (was: Re: Linux 2.4.25-rc2)
In-Reply-To: <Pine.LNX.4.58L.0402111728060.28576@logos.cnet>
Message-ID: <Pine.GSO.4.58.0402121324180.7297@waterleaf.sonytel.be>
References: <Pine.LNX.4.58L.0402111728060.28576@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004, Marcelo Tosatti wrote:
> Here goes -rc2, with small number of fixes and corrections.

This patch adds a missing include (fortunately it was included in some other
include, but its' not clean for files that check CONFIG_* flags) and kills a
compiler warning (introduced in -rc1, IIRC) if CONFIG_SMB_UNIX is not set.

Alternatively, perhaps the code can be reshuffled a bit to avoid too many
ifdefs?

--- linux-2.4.25-rc2/fs/smbfs/proc.c	2004-01-30 09:17:07.000000000 +0100
+++ linux-m68k-2.4.25-rc2/fs/smbfs/proc.c	2004-02-12 13:46:14.000000000 +0100
@@ -7,6 +7,7 @@
  *  Please add a note about your changes to smbfs in the ChangeLog file.
  */

+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -49,7 +50,9 @@
 static struct smb_ops smb_ops_os2;
 static struct smb_ops smb_ops_win95;
 static struct smb_ops smb_ops_winNT;
+#ifdef CONFIG_SMB_UNIX
 static struct smb_ops smb_ops_unix;
+#endif

 static void
 smb_init_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
@@ -2636,6 +2639,7 @@
 	return result;
 }

+#ifdef CONFIG_SMB_UNIX
 /*
  * Note: called with the server locked.
  */
@@ -2680,6 +2684,7 @@
 out:
 	return result;
 }
+#endif /* CONFIG_SMB_UNIX */

 static int
 smb_proc_getattr_null(struct smb_sb_info *server, struct dentry *dir,
@@ -3332,6 +3337,7 @@
 	.truncate       = smb_proc_trunc64,
 };

+#ifdef CONFIG_SMB_UNIX
 /* Samba w/ unix extensions. Others? */
 static struct smb_ops smb_ops_unix =
 {
@@ -3341,6 +3347,7 @@
 	.getattr        = smb_proc_getattr_unix,
 	.truncate       = smb_proc_trunc64,
 };
+#endif /* CONFIG_SMB_UNIX */

 /* Place holder until real ops are in place */
 static struct smb_ops smb_ops_null =

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
