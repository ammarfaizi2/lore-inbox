Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVA3MMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVA3MMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 07:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVA3MMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 07:12:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7947 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261690AbVA3MMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 07:12:46 -0500
Date: Sun, 30 Jan 2005 13:12:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050130121241.GH3185@stusta.de>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org> <20050130105738.GA28387@infradead.org> <20050130120009.GG3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130120009.GG3185@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 01:00:09PM +0100, Adrian Bunk wrote:
>...
> His problem is:
> - CONFIG_NFSD=m
> - CONFIG_EXPORTFS=m
> - CONFIG_XFS=y
> - CONFIG_XFS_EXPORT=y
> 
> The builtin fs/xfs/linux-2.6/xfs_export.c can't call the function 
> find_exported_dentry in the modular fs/exportfs/expfs.c .

Below is a patch that should fix these problems.

It isn't very elebgant, and I've Cc'd Roman Zippel who might be able to 
tell how to express these things without two helper variables.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-test/fs/Kconfig.old	2005-01-30 12:46:07.000000000 +0100
+++ linux-2.6.11-rc2-mm2-test/fs/Kconfig	2005-01-30 12:51:00.000000000 +0100
@@ -1476,6 +1476,7 @@
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFSD_ACL
+	select WANT_EXPORTFS
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
@@ -1560,9 +1561,12 @@
 	depends on NFSD_V3 || NFS_V3
 	default y
 
+config WANT_EXPORTFS
+	tristate
+	select EXPORTFS
+
 config EXPORTFS
 	tristate
-	default NFSD
 
 config SUNRPC
 	tristate
--- linux-2.6.11-rc2-mm2-test/fs/xfs/Kconfig.old	2005-01-30 12:46:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-test/fs/xfs/Kconfig	2005-01-30 13:04:11.000000000 +0100
@@ -20,9 +20,15 @@
 	  system of your root partition is compiled as a module, you'll need
 	  to use an initial ramdisk (initrd) to boot.
 
+config XFS_WANT_EXPORT
+	tristate
+	default XFS_FS
+	depends on WANT_EXPORTFS!=n
+	select XFS_EXPORT
+	select EXPORTFS
+
 config XFS_EXPORT
 	bool
-	default y if XFS_FS && EXPORTFS
 
 config XFS_RT
 	bool "Realtime support (EXPERIMENTAL)"

