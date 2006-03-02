Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWCBSEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWCBSEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWCBSEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:04:13 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:1168 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751647AbWCBSEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:04:13 -0500
Date: Thu, 2 Mar 2006 13:04:52 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add O_NONBLOCK support to FUSE
Message-ID: <20060302180452.GA9188@ccure.user-mode-linux.org>
References: <20060301022944.GB9624@ccure.user-mode-linux.org> <E1FENzJ-0008S7-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FENzJ-0008S7-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found the BUG, patch below.  Feel free to merge it with the async
patch even though it is signed off on its own.

				Jeff

I didn't realize that kobject_put(&fc->kobj) freed fc.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: host-2.6.15-fuse/fs/fuse/dev.c
===================================================================
--- host-2.6.15-fuse.orig/fs/fuse/dev.c	2006-03-01 14:08:40.000000000 -0500
+++ host-2.6.15-fuse/fs/fuse/dev.c	2006-03-01 14:09:04.000000000 -0500
@@ -919,9 +919,9 @@ static int fuse_dev_release(struct inode
 	}
 	spin_unlock(&fuse_lock);
 	if (fc) {
-		kobject_put(&fc->kobj);
 		fasync_helper(-1, file, 0, &fc->fasync);
 		fc->fasync = NULL;
+		kobject_put(&fc->kobj);
 	}
 
 	return 0;
