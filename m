Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUAPI6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUAPI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:58:21 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:57259 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265328AbUAPI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:58:20 -0500
Subject: Re: Linux 2.4.25-pre5
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, davem@redhat.com,
       linux-kernel@vger.kernel.org, sim@netnation.com,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20040116004516.5fea2995.akpm@osdl.org>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
	 <20040115145519.79beddc3.davem@redhat.com>
	 <Pine.LNX.4.58L.0401152110020.17528@logos.cnet>
	 <1074239098.31120.27.camel@imladris.demon.co.uk>
	 <20040116004516.5fea2995.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074243491.31120.49.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 16 Jan 2004 08:58:11 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-16 at 00:45 -0800, Andrew Morton wrote:
> Really, the init_waitqueue_head() should be done prior to putting the inode
> back into slab.

I had that version first but preferred doing it with all the other inode
initialisation in alloc_inode() rather than in destroy_inode(). If you
do it this way, you reinit even when you're about to discard the slab
pages. I don't care much though. 

===== inode.c 1.48 vs edited =====
--- 1.48/fs/inode.c	Wed Jan 14 20:51:18 2004
+++ edited/inode.c	Fri Jan 16 08:56:14 2004
@@ -127,6 +127,10 @@
 {
 	if (inode_has_buffers(inode))
 		BUG();
+	/* Reinitialise the waitqueue head because __wait_on_freeing_inode()
+	   may have left stale entries on it which it can't remove (since
+	   it knows we're freeing the inode right now */
+	init_waitqueue_head(&inode->i_wait);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
 	else

-- 
dwmw2


