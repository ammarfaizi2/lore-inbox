Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbVINTYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVINTYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbVINTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:24:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38569 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932670AbVINTYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:24:22 -0400
Date: Thu, 15 Sep 2005 00:48:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Brown paper bag in fs/file.c?
Message-ID: <20050914191842.GA6315@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050914.113133.78024310.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914.113133.78024310.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:31:33AM -0700, David S. Miller wrote:
> 
> The bug is that free_fd_array() takes a "num" argument, but when
> calling it from __free_fdtable() we're instead passing in the size in
> bytes (ie. "num * sizeof(struct file *)").

Yes it is a bug. I think I messed it up while merging newer
changes with an older version where I was using size in bytes
to optimize.

> 
> How come this doesn't crash things for people?  Perhaps I'm missing
> something.  fs/vmalloc.c should bark very loudly if we call it with a
> non-vmalloc area address, since that is what would happen if we pass a
> kmalloc() SLAB object address to vfree().
> 
> I think I know what might be happening.  If the miscalculation means
> that we kfree() the embedded fdarray, that would actually work just
> fine, and free up the fdtable.  I guess if the SLAB redzone stuff were
> enabled for these caches, it would trigger when something like this
> happens.

__free_fdtable() is used only when the fdarray/fdset are vmalloced
(use of the workqueue) or there is a race between two expand_files().
That might be why we haven't seen this cause any explicit problem
so far.

This would be an appropriate patch - (untested). I will update
as soon as testing is done.

Thanks
Dipankar



Fixes the fdtable freeing in the case of vmalloced fdset/arrays.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
--


 fs/file.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -puN fs/file.c~files-fix-fdtable-free fs/file.c
--- linux-2.6.14-rc1-fd/fs/file.c~files-fix-fdtable-free	2005-09-15 00:36:03.000000000 +0530
+++ linux-2.6.14-rc1-fd-dipankar/fs/file.c	2005-09-15 00:39:46.000000000 +0530
@@ -69,13 +69,9 @@ void free_fd_array(struct file **array, 
 
 static void __free_fdtable(struct fdtable *fdt)
 {
-	int fdset_size, fdarray_size;
-
-	fdset_size = fdt->max_fdset / 8;
-	fdarray_size = fdt->max_fds * sizeof(struct file *);
-	free_fdset(fdt->open_fds, fdset_size);
-	free_fdset(fdt->close_on_exec, fdset_size);
-	free_fd_array(fdt->fd, fdarray_size);
+	free_fdset(fdt->open_fds, fdt->max_fdset);
+	free_fdset(fdt->close_on_exec, fdt->max_fdset);
+	free_fd_array(fdt->fd, fdt->max_fds);
 	kfree(fdt);
 }
 

_
