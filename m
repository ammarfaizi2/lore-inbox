Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbULVGnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbULVGnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 01:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbULVGnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 01:43:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:42625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261768AbULVGnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 01:43:37 -0500
Date: Tue, 21 Dec 2004 22:43:04 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041222064304.GA31995@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <20041222005726.GA13317@kroah.com> <1103679534.5055.2.camel@npiggin-nld.site> <20041222050424.GB31076@kroah.com> <41C9074E.8050406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C9074E.8050406@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 12:34:06AM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >On Wed, Dec 22, 2004 at 12:38:54PM +1100, Nick Piggin wrote:
> >>Is there any reason why these debug filesystems are going under the
> >>root directory? Why not /sys/debug or /sys/kernel/debug or something?
> >
> >
> >See the previous thread as to where to mount debugfs.  In short, I don't
> >really care :)
> 
> 
> Well, somebody should pick a single location, and try to use that 
> consistently.  Sure the sysadmin can change it, but a "preferred 
> default" is always nice.

Bah, fine, make me make a policy decision, damm I tried hard to resist :)

Anyway, here's a patch I just applied that creates the /sys/kernel/debug
directory (you need a small patch that exports the proper subsys for
this to work, if anyone wants that too, I'll send it.)  Now, if you
want, you can mount debugfs at this location.

Now either this is going to make people happy, or make them mad I didn't
pick their proposed location.  Either way, I'm going on vacation in 2
days, so I will not be around to hear the screams...

thanks,

greg k-h

-------
debugfs: add /sys/kernel/debug mount point for people to mount debugfs on.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/fs/debugfs/inode.c b/fs/debugfs/inode.c
--- a/fs/debugfs/inode.c	2004-12-21 22:40:00 -08:00
+++ b/fs/debugfs/inode.c	2004-12-21 22:40:00 -08:00
@@ -298,15 +298,28 @@
 }
 EXPORT_SYMBOL_GPL(debugfs_remove);
 
+static decl_subsys(debug, NULL, NULL);
+
 static int __init debugfs_init(void)
 {
-	return register_filesystem(&debug_fs_type);
+	int retval;
+
+	kset_set_kset_s(&debug_subsys, kernel_subsys);
+	retval = subsystem_register(&debug_subsys);
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&debug_fs_type);
+	if (retval)
+		subsystem_unregister(&debug_subsys);
+	return retval;
 }
 
 static void __exit debugfs_exit(void)
 {
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 	unregister_filesystem(&debug_fs_type);
+	subsystem_unregister(&debug_subsys);
 }
 
 core_initcall(debugfs_init);
