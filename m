Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423120AbWJRW5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423120AbWJRW5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423137AbWJRW5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:57:30 -0400
Received: from twin.jikos.cz ([213.151.79.26]:4303 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1423120AbWJRW53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:57:29 -0400
Date: Thu, 19 Oct 2006 00:57:21 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
In-Reply-To: <20061018154636.2317059a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610190055440.29022@twin.jikos.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org> <453675A6.9080001@googlemail.com>
 <Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz> <20061018152947.bb404481.akpm@osdl.org>
 <Pine.LNX.4.64.0610190031260.29022@twin.jikos.cz> <20061018154636.2317059a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Andrew Morton wrote:

> I simply dropped the debugging patch.  Which is pretty sad, because it 
> _is_ a really nasty and subtle-to-show bug.  So I'd be OK with adding 
> sufficient patches to -mm to make the false positives go away so we can 
> re-add the check.

What about this one? 

[PATCH] Fix spurious warning in i_size_write()

i_size_write() can be legitimately called without inode->i_mutex locked. 
This is OK in cases when the inode has not been yet linked into the parent 
dentry, so no race condition on i_size can occur.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- 

 fs/inode.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bb88835..11d8794 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1386,7 +1386,9 @@ void __init inode_init(unsigned long mem
 
 void i_size_write(struct inode *inode, loff_t i_size)
 {
-	WARN_ON_ONCE(!mutex_is_locked(&inode->i_mutex));
+	/* calling us without i_mutex is OK when not connected to dentry yet */
+	if (list_empty(&inode->i_dentry))
+		WARN_ON_ONCE(!mutex_is_locked(&inode->i_mutex));
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	write_seqcount_begin(&inode->i_size_seqcount);
 	inode->i_size = i_size;
diff --git a/fs/namei.c b/fs/namei.c

-- 
Jiri Kosina
