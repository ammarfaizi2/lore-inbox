Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVKGKXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVKGKXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVKGKXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:23:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:6354 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964812AbVKGKXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:23:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/25] fs: move ext2 ioctl32 handlers into file systems
Date: Mon, 7 Nov 2005 11:24:47 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       ext3-users@redhat.com, linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       nathans@sgi.com, reiserfs-dev@namesys.com, zippel@linux-m68k.org,
       sfrench@samba.org, samba-technical@lists.samba.org
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162714.555612000@b551138y.boeblingen.de.ibm.com> <20051106043942.GA31343@lst.de>
In-Reply-To: <20051106043942.GA31343@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511071124.49467.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 06 November 2005 05:39, Christoph Hellwig wrote:
> NACK, this is completely idiotic.  Duplicating handlers is the very
> last thing we want.  I actually have patches to move handling some
> of those ioctls into generic code, but that's a different story.

Ok, I'll drop this patch then, except for the ext3 parts that fix
an actual problem of missing conversion handlers.

What is your opinion on the xfs bit. The current code is somewhat
broken, since XFS_IOC_{GET,SET}{VERSION,XFLAGS} are not really
compatible. Should those three lines simply be removed?

	Arnd <><

--- linux-cg.orig/fs/xfs/linux-2.6/xfs_ioctl32.c        2005-11-05 02:44:55.000000000 +0100
+++ linux-cg/fs/xfs/linux-2.6/xfs_ioctl32.c     2005-11-05 02:45:35.000000000 +0100
@@ -34,6 +34,11 @@
 #define  _NATIVE_IOC(cmd, type) \
          _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(type))
 
+/* broken ext2 ioctl numbers */
+#define XFS_IOC_GETVERSION32 _IOR('v', 1, int)
+#define XFS_IOC_GETXFLAGS32 _IOR('f', 1, int)
+#define XFS_IOC_SETXFLAGS32 _IOW('f', 2, int)
+
 #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
 #define BROKEN_X86_ALIGNMENT
 /* on ia32 l_start is on a 32-bit boundary */
@@ -115,12 +120,16 @@
        vnode_t         *vp = LINVFS_GET_VP(inode);
 
        switch (cmd) {
+       /* these take an int as their argument, not a long */
+       case XFS_IOC_GETVERSION32:
+       case XFS_IOC_GETXFLAGS32:
+       case XFS_IOC_SETXFLAGS32:
+               cmd = _NATIVE_IOC(cmd, long);
+               break;
+
        case XFS_IOC_DIOINFO:
        case XFS_IOC_FSGEOMETRY_V1:
        case XFS_IOC_FSGEOMETRY:
-       case XFS_IOC_GETVERSION:
-       case XFS_IOC_GETXFLAGS:
-       case XFS_IOC_SETXFLAGS:
        case XFS_IOC_FSGETXATTR:
        case XFS_IOC_FSSETXATTR:
        case XFS_IOC_FSGETXATTRA:
