Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWDADgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWDADgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 22:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWDADgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 22:36:19 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:10971 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751487AbWDADgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 22:36:19 -0500
Date: Fri, 31 Mar 2006 19:39:57 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Message-ID: <20060401033957.GC3157@gaz.sfgoth.com>
References: <yq0sloytyj5.fsf@jaguar.mkp.net> <200603311800.19364.ak@suse.de> <yq0odzmtwni.fsf@jaguar.mkp.net> <20060401023538.GB3157@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401023538.GB3157@gaz.sfgoth.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 31 Mar 2006 19:39:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a slightly updated version of my patch: it changes the

		if (size < sizeof(stack_fds) / 6)
to:
		if (size <= sizeof(stack_fds) / 6)

Otherwise this is exactly the same as the version I just posted.  The old
code had this problem too but before it only mattered if SELECT_STACK_ALLOC
was a multiple of six.

Signed-off-by: Mitchell Blank Jr <mitch@sfgoth.com>

diff --git a/fs/select.c b/fs/select.c
index 071660f..c46d40c 100644
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
+	if (size <= sizeof(stack_fds) / 6)
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
