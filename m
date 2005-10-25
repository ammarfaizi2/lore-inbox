Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVJYOPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVJYOPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVJYOPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:15:00 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34339
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932153AbVJYOPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:15:00 -0400
Date: Tue, 25 Oct 2005 16:14:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051025141452.GP5091@opteron.random>
References: <20051018082609.GC15717@x30.random> <20051018171335.3b308b3e.akpm@osdl.org> <20051019004018.GZ1027@watt.suse.com> <20051018181548.760dbf8c.akpm@osdl.org> <20051019015840.GC1027@watt.suse.com> <20051018192646.2ddcbf57.akpm@osdl.org> <20051025022102.GC5099@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051025022102.GC5099@watt.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 10:21:02PM -0400, Chris Mason wrote:
> The short version is that no additional patches should be needed for
> mainline.

This one may be needed too. Perhaps it's unnecessary for the MS_ACTIVE
case (I would assume in that case by design nobody can find the inode
while MS_ACTIVE is not set), but the unhashed case sounds more
interesting. At the moment I'm unsure who is using the unhashed
last-iput feature to get rid of the inode but the below looks needed at
the light of that feature.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

diff -r 2c7561cc445e fs/inode.c
--- a/fs/inode.c	Mon Oct 24 00:24:54 2005 +0011
+++ b/fs/inode.c	Tue Oct 25 16:06:25 2005 +0200
@@ -1088,6 +1088,7 @@
 	if (inode->i_data.nrpages)
 		truncate_inode_pages(&inode->i_data, 0);
 	clear_inode(inode);
+	wake_up_inode(inode);
 	destroy_inode(inode);
 }
 

