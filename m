Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVFLTus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVFLTus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFLT1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:27:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262665AbVFLSKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 14:10:09 -0400
Date: Sun, 12 Jun 2005 14:10:06 -0400
From: Neil Horman <nhorman@redhat.com>
To: Neil Horman <nhorman@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050612181006.GC2229@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com> <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk> <20050611193500.GC1097@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611193500.GC1097@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about this?  Its the same feature, with an added check in fcntl_dirnotify to
ensure that only processes with CAP_SYS_ADMIN set can tell processes preforming
the monitored actions to stop.

Signed-off-by: Neil Horman <nhorman@redhat.com>


 fs/dnotify.c          |    4 ++++
 fs/fcntl.c            |    1 +
 include/linux/fcntl.h |    1 +
 3 files changed, 6 insertions(+)


--- linux-2.6/include/linux/fcntl.h.orig	2005-06-10 16:04:48.000000000 -0400
+++ linux-2.6/include/linux/fcntl.h	2005-06-10 16:02:16.000000000 -0400
@@ -21,6 +21,7 @@
 #define DN_DELETE	0x00000008	/* File removed */
 #define DN_RENAME	0x00000010	/* File renamed */
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
+#define DN_STOPSND	0x40000000	/* Send a SIGSTOP to the sender */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
 #ifdef __KERNEL__
--- linux-2.6/fs/dnotify.c.orig	2005-05-04 21:47:58.000000000 -0400
+++ linux-2.6/fs/dnotify.c	2005-06-11 21:27:37.000000000 -0400
@@ -74,6 +74,8 @@ int fcntl_dirnotify(int fd, struct file 
 	}
 	if (!dir_notify_enable)
 		return -EINVAL;
+	if(!capable(CAP_SYS_ADMIN) && (arg & DN_STOPSND))
+		return -EPERM;
 	inode = filp->f_dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return -ENOTDIR;
@@ -138,6 +140,8 @@ void __inode_dir_notify(struct inode *in
 			changed = 1;
 			kmem_cache_free(dn_cache, dn);
 		}
+		if (dn->dn_mask & DN_STOPSND)
+			send_sig(SIGSTOP,current,1);
 	}
 	if (changed)
 		redo_inode_mask(inode);
--- linux-2.6/fs/fcntl.c.orig	2005-05-04 21:47:58.000000000 -0400
+++ linux-2.6/fs/fcntl.c	2005-06-10 16:05:17.000000000 -0400
@@ -438,6 +438,7 @@ static void send_sigio_to_task(struct ta
 			else
 				si.si_band = band_table[reason - POLL_IN];
 			si.si_fd    = fd;
+			si.si_pid   = current->pid;
 			if (!send_group_sig_info(fown->signum, &si, p))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
