Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUHXR2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUHXR2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUHXR2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:28:11 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:52634 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S268138AbUHXR2H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:28:07 -0400
Subject: Re: nfsroot compile broken in 2.6.9-rc1?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ray Lehtiniemi <rayl@mail.com>, Linus Torvalds <torvalds@osdl.org>,
       Charles Lever <Charles.Lever@netapp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040824165002.GA4314@mail.com>
References: <20040824165002.GA4314@mail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093368479.5745.72.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 13:27:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 24/08/2004 klokka 12:50, skreiv Ray Lehtiniemi:
> just pulled the latest changes, and it seems nfsroot no longer
> compiles:
> 
>      CC      fs/nfs/nfsroot.o
>    fs/nfs/nfsroot.c: In function `root_nfs_get_handle':
>    fs/nfs/nfsroot.c:499: error: cannot convert to a pointer type
>    fs/nfs/nfsroot.c:499: error: cannot convert to a pointer type
>    make[2]: *** [fs/nfs/nfsroot.o] Error 1

Chuck, that conversion to nfs_fh_copy() is bogus since we're not copying
into an nfs_fh anyway. Let's just revert it.

Cheers,
  Trond

--- linux-2.6.9-up/fs/nfs/nfsroot.c.orig	2004-08-24 11:18:27.000000000 -0400
+++ linux-2.6.9-up/fs/nfs/nfsroot.c	2004-08-24 13:18:32.000000000 -0400
@@ -495,8 +495,10 @@ static int __init root_nfs_get_handle(vo
 	if (status < 0)
 		printk(KERN_ERR "Root-NFS: Server returned error %d "
 				"while mounting %s\n", status, nfs_path);
-	else
-		nfs_copy_fh(nfs_data.root, fh);
+	else {
+		nfs_data.root.size = fh.size;
+		memcpy(nfs_data.root.data, fh.data, fh.size);
+	}
 
 	return status;
 }

