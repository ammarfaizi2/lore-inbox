Return-Path: <linux-kernel-owner+w=401wt.eu-S1751295AbXAPVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXAPVUv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAPVUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:20:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59177 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXAPVUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:20:50 -0500
Date: Tue, 16 Jan 2007 13:20:07 -0800
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Attribute removal patch causes lockdep warning
Message-ID: <20070116212007.GA8737@kroah.com>
References: <Pine.LNX.4.44L0.0701161139450.2276-100000@iolanthe.rowland.org> <200701162215.57758.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701162215.57758.oneukum@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 10:15:57PM +0100, Oliver Neukum wrote:
> Am Dienstag, 16. Januar 2007 21:33 schrieb Alan Stern:
> > Are you aware that your patch for safe attribute file removal provokes a 
> > lockdep warning at bootup?
> 
> Yes, I am aware of that. However, the top down lock order is always
> followed. A patch to make the lock checker realize that has been posted
> and included upstream.


Alan, here's the patch:


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 8c533cb..3b5574b 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -214,7 +214,7 @@ static inline void orphan_all_buffers(st
 	struct sysfs_buffer_collection *set = node->i_private;
 	struct sysfs_buffer *buf;
 
-	mutex_lock(&node->i_mutex);
+	mutex_lock_nested(&node->i_mutex, I_MUTEX_CHILD);
 	if (node->i_private) {
 		list_for_each_entry(buf, &set->associates, associates) {
 			down(&buf->sem);
@@ -271,7 +271,7 @@ int sysfs_hash_and_remove(struct dentry
 		return -ENOENT;
 
 	parent_sd = dir->d_fsdata;
-	mutex_lock(&dir->d_inode->i_mutex);
+	mutex_lock_nested(&dir->d_inode->i_mutex, I_MUTEX_PARENT);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element)
 			continue;
 
