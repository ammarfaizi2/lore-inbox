Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUBLRSn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUBLRSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:18:43 -0500
Received: from fungus.teststation.com ([212.32.186.211]:62986 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S266539AbUBLRQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:16:55 -0500
Date: Thu, 12 Feb 2004 18:16:56 +0100 (CET)
From: Urban Widmark <Urban.Widmark@enlight.net>
X-X-Sender: puw@cola.local
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       JohnNewbigin <jn@it.swin.edu.au>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: smb_ops_unix warning (was: Re: Linux 2.4.25-rc2)
In-Reply-To: <Pine.GSO.4.58.0402121324180.7297@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0402121758290.14391-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Geert Uytterhoeven wrote:

> On Wed, 11 Feb 2004, Marcelo Tosatti wrote:
> > Here goes -rc2, with small number of fixes and corrections.
> 
> This patch adds a missing include (fortunately it was included in some other
> include, but its' not clean for files that check CONFIG_* flags) and kills a
> compiler warning (introduced in -rc1, IIRC) if CONFIG_SMB_UNIX is not set.

Ah, thanks.


> Alternatively, perhaps the code can be reshuffled a bit to avoid too many
> ifdefs?

Code below builds cleanly for me either way, but I have not tested it yet.
Will do that later.

The config could also be removed, but I like that 2.4 users can keep the
previous 2.4 behaviour if they want to.

/Urban


diff -ur linux-2.4.25-rc2-orig/fs/smbfs/proc.c linux-2.4.25-rc2-smbfs/fs/smbfs/proc.c
--- linux-2.4.25-rc2-orig/fs/smbfs/proc.c	2004-02-12 17:52:37.000000000 +0100
+++ linux-2.4.25-rc2-smbfs/fs/smbfs/proc.c	2004-02-12 17:54:41.000000000 +0100
@@ -7,6 +7,7 @@
  *  Please add a note about your changes to smbfs in the ChangeLog file.
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -915,7 +916,9 @@
 		SB_of(server)->s_maxbytes = ~0ULL >> 1;
 		VERBOSE("LFS enabled\n");
 	}
-#ifdef CONFIG_SMB_UNIX
+#ifndef CONFIG_SMB_UNIX
+	server->opt.capabilities &= ~SMB_CAP_UNIX;
+#endif
 	if (server->opt.capabilities & SMB_CAP_UNIX) {
 		struct inode *inode;
 		VERBOSE("Using UNIX CIFS extensions\n");
@@ -924,9 +927,6 @@
 		if (inode)
 			inode->i_op = &smb_dir_inode_operations_unix;
 	}
-#else
-	server->opt.capabilities &= ~SMB_CAP_UNIX;
-#endif
 
 	VERBOSE("protocol=%d, max_xmit=%d, pid=%d capabilities=0x%x\n",
 		server->opt.protocol, server->opt.max_xmit, server->conn_pid,

