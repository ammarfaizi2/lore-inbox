Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263989AbRFJHKF>; Sun, 10 Jun 2001 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264503AbRFJHJp>; Sun, 10 Jun 2001 03:09:45 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54733 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S263989AbRFJHJd>; Sun, 10 Jun 2001 03:09:33 -0400
Date: Sun, 10 Jun 2001 16:09:14 +0900
Message-ID: <66e4zu91.wl@bardioc.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS bug? Trying to free free buffer
In-Reply-To: <20010608164254.A936@Hews1193nrc>
In-Reply-To: <20010608164254.A936@Hews1193nrc>
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 () SLIM/1.14.7
 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE XEmacs/21.2
 (beta46) (Urania) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Fri, 8 Jun 2001 16:42:54 +0300,
Alexey Vyskubov wrote:
> 
> Hello.
> 
> Kernel 2.4.5.
> 
> $ sudo mount -o iocharset=garbage /dev/cdrom /cdrom
> 
> VFS: brelse: Trying to free free buffer

  I think this is the ISOFS's bug. If invalid iocharset is specified
as a mount option, isofs_read_super() tries to free the buffer_head twice.

  This patch may help.



diff -r -u -N linux.org/fs/isofs/inode.c linux/fs/isofs/inode.c
--- linux.org/fs/isofs/inode.c	Sun Jun 10 14:23:02 2001
+++ linux/fs/isofs/inode.c	Sun Jun 10 15:10:38 2001
@@ -744,7 +744,7 @@
 		if (! s->u.isofs_sb.s_nls_iocharset) {
 			/* Fail only if explicit charset specified */
 			if (opt.iocharset)
-				goto out_freebh;
+				goto out_unlock;
 			s->u.isofs_sb.s_nls_iocharset = load_nls_default();
 		}
 	}

