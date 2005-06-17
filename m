Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVFQNb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVFQNb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVFQNb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:31:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:9057 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261968AbVFQNbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:31:42 -0400
Date: Fri, 17 Jun 2005 14:32:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
In-Reply-To: <20050616185754.3646511e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506171419570.10248@goblin.wat.veritas.com>
References: <42B1DBF1.4020904@nortel.com> <20050616135708.4876c379.akpm@osdl.org>
 <42B20317.6000204@nortel.com> <20050616162933.25dee57b.akpm@osdl.org>
 <42B22CD3.9080600@nortel.com> <20050616185754.3646511e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Jun 2005 13:31:41.0771 (UTC) FILETIME=[E5A341B0:01C57340]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Andrew Morton wrote:
> Chris Friesen <cfriesen@nortel.com> wrote:
> > Andrew Morton wrote:
> > > Chris Friesen <cfriesen@nortel.com> wrote:
> > >>Currently tmpfs reuses the simple_dir_operations from libfs.c.
> > >>
> > >>Would it make sense to add the empty fsync() function there, and have 
> > >>all other users pick it up as well?  Is this likely to break stuff?
> > >  
> > > Isn't simple_sync_file() suitable?

Yes.

> > Alternately, if it makes sense for all the users of 
> > simple_dir_operations we could modify it directly and all of the other 
> > users of simple_dir_operations would get the change for free.  I don't 
> > know enough about the other filesystems to know if this makes sense or not.

That makes the best sense, yes.

> hm, what a lot of filesystems.
> ..... 
> I can't think of any reason why any of these would want fsync(dir_fd) to
> return -EINVAL.

No need to check the list: any filesystem using simple_dir_operations
is using dcache_readdir, which implies there's no storage to be synced.
And we all agree that success is a more helpful retval than -EINVAL
when there's nothing for fsync to do.  Here's a patch if you haven't
done it already....

tmpfs, and all other users of simple_dir_operations, should return 0
to say directory fsync was successful, instead of the worrying -EINVAL.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.12-rc6-git8/fs/libfs.c	2005-03-02 07:38:44.000000000 +0000
+++ linux/fs/libfs.c	2005-06-17 14:16:29.000000000 +0100
@@ -183,6 +183,7 @@ struct file_operations simple_dir_operat
 	.llseek		= dcache_dir_lseek,
 	.read		= generic_read_dir,
 	.readdir	= dcache_readdir,
+	.fsync		= simple_sync_file,
 };
 
 struct inode_operations simple_dir_inode_operations = {
