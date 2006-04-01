Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWDACcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWDACcG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 21:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWDACcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 21:32:06 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:50649 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751471AbWDACcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 21:32:04 -0500
Date: Fri, 31 Mar 2006 18:35:38 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Message-ID: <20060401023538.GB3157@gaz.sfgoth.com>
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <200603311800.19364.ak@suse.de> <yq0odzmtwni.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0odzmtwni.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 31 Mar 2006 18:35:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> I assume you mean select().
> 
> Updated patch attached.

This fixes a few problems introduced by this patch.

  * Fixes two warnings caused by mixing "char *" and "long *" pointers

  * If SELECT_STACK_ALLOC is not a multiple of sizeof(long) then stack_fds[]
    would be less than SELECT_STACK_ALLOC bytes and could overflow later in
    the function.  Fixed by simply rearranging the test later to work on
    sizeof(stack_fds)

    Currently SELECT_STACK_ALLOC is 256 so this doesn't happen, but it's
    nasty to have things like this hidden in the code.  What if later
    someone decides to change SELECT_STACK_ALLOC to 300?

  * I also changed "size" to be unsigned since that makes more sense and
    is less prone to overflow bugs.  I'm also a little scared by the
    "kmalloc(6 * size)" since that type of call is a classic multiply-overflow
    security hole (hence libc's calloc() API).  However "size" is constrained
    by fdt->max_fdset so I think it isn't exploitable.  The kernel doesn't
    have an overflow-safe API for kmalloc'ing arrays, does it?

Patch is vs current git HEAD.  Only compile/boot tested.

Signed-off-by: Mitchell Blank Jr <mitch@sfgoth.com>

diff --git a/fs/select.c b/fs/select.c
index 071660f..bd9c7db 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -311,7 +311,8 @@ static int core_sys_select(int n, fd_set
 {
 	fd_set_bits fds;
 	char *bits;
-	int ret, size, max_fdset;
+	int ret, max_fdset;
+	unsigned int size;
 	struct fdtable *fdt;
 	/* Allocate small arguments on the stack to save memory and be faster */
 	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
@@ -335,8 +336,8 @@ static int core_sys_select(int n, fd_set
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	if (6*size < SELECT_STACK_ALLOC)
-		bits = stack_fds;
+	if (size < sizeof(stack_fds) / 6)
+		bits = (char *) stack_fds;
 	else
 		bits = kmalloc(6 * size, GFP_KERNEL);
 	if (!bits)
@@ -373,7 +374,7 @@ static int core_sys_select(int n, fd_set
 		ret = -EFAULT;
 
 out:
-	if (bits != stack_fds)
+	if (bits != (char *) stack_fds)
 		kfree(bits);
 out_nofds:
 	return ret;
