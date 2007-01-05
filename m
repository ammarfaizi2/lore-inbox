Return-Path: <linux-kernel-owner+w=401wt.eu-S1161145AbXAEQox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbXAEQox (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbXAEQox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:44:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:11450 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161145AbXAEQow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:44:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=IwXDLfTMOhdJD1kjC1OC55GddledAE5LiTrzKCX6wcuINL315OHqDb1cwogudYzoZAyqKcr5facvTkAHwYGQvfB0vNqbReKD2t09k7HTKWuTRmvx30XkylNR+gZEInx06kWWCYvrdmXYrWOJV53u/PiU78jiGU+94UCrfF6OLqk=
Date: Fri, 5 Jan 2007 16:42:52 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, maneesh@in.ibm.com, oliver@neukum.name
Subject: Re: [-mm patch] lockdep: possible deadlock in sysfs
Message-ID: <20070105164252.GG17863@slug>
References: <20070104220200.ae4e9a46.akpm@osdl.org> <20070105121643.GE17863@slug> <200701051613.25882.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701051613.25882.oliver@neukum.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 04:13:25PM +0100, Oliver Neukum wrote:
> Am Freitag, 5. Januar 2007 13:16 schrieb Frederik Deweerdt:
> > On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
> > > 
> > > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> > > 
> are you sure there's a code path that takes these locks in the reverse order?
> I've looked through the code twice and not found any. It doesn't make much
> sense to first lock the file and afterwards the directory.
You're right, an annotation should be enough, what do you think?

Regards,
Frederik


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
 
> Regarding your patch, it should work, but I don't see the need for it.
> 
> 	Regards
> 		Oliver
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
