Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSHGJVz>; Wed, 7 Aug 2002 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSHGJVz>; Wed, 7 Aug 2002 05:21:55 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:55566 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S317261AbSHGJVy>;
	Wed, 7 Aug 2002 05:21:54 -0400
To: linux-kernel@vger.kernel.org
Cc: gam3@acm.org
Subject: Re: Problems with NFS exports
References: <87eldchtr2.fsf@deneb.enyo.de>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, gam3@acm.org
Date: Wed, 07 Aug 2002 11:25:33 +0200
In-Reply-To: <87eldchtr2.fsf@deneb.enyo.de> (Florian Weimer's message of
 "Tue, 06 Aug 2002 18:00:06 +0200")
Message-ID: <87k7n3t3zm.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

> I'm seeing weired errors with nfsctl():
>
> This works:
>
> nfsservctl(NFSCTL_EXPORT, "deneb.enyo.de", "/mnt/storage/2/backup/deneb/tmp", makedev(3, 66), ino 167772288, uid 65534, gid 65534) = 0
>
> But a subsequent call fails:
>
> nfsservctl(NFSCTL_EXPORT, "deneb.enyo.de", "/mnt/storage/2/backup/deneb", makedev(3, 66), ino 150995072, uid 65534, gid 65534) = -1 EINVAL (Invalid argument)
>
> I don't understand what makes the difference (the inode values are
> correct).  This is kernel 2.4.18 with XFS support, and the directory
> resides on an XFS file system.
>
> Any ideas?

(Full quote because of additional recipeint.)

It appears that a directory tree can only be exported once.  Is this
intentional?  If yes, the following patch should be applied (to
linux/fs/nfsd/export.c), so that the return value is more meaningful:

--- export.c	2002/08/07 09:22:11	1.1
+++ export.c	2002/08/07 09:22:28
@@ -219,6 +219,7 @@
 		goto finish;
 	}
 
+	err = -EBUSY;
 	if ((parent = exp_child(clp, dev, nd.dentry)) != NULL) {
 		dprintk("exp_export: export not valid (Rule 3).\n");
 		goto finish;


After this change, the userspace tools can issue are more meaningful
error message for this case.
