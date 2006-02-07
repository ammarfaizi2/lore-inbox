Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWBGA14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWBGA14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBGA1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:27:55 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:24202 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932423AbWBGA1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:27:54 -0500
Date: Tue, 7 Feb 2006 11:27:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
Message-Id: <20060207112713.7cd0a61c.sfr@canb.auug.org.au>
In-Reply-To: <20060206.160140.59716704.davem@davemloft.net>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au>
	<20060206.160140.59716704.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2006 16:01:40 -0800 (PST) "David S. Miller" <davem@davemloft.net> wrote:
>
> I do the sign extension with tiny stubs in arch/sparc64/kernel/sys32.S
> so that the arg frobbing does not consume a stack frame, which is what
> happens if you do this in C code.

In which case you need to to stubs for all the *at syscalls.

> We need to revisit this at some point and make a way for all
> compat platforms to do this with a portable table of some kind
> that expands a bunch of macros defined by the platform.

*If* we do get is_compat_task(), what would be you reaction to something
like this:

diff --git a/fs/namei.c b/fs/namei.c
index faf61c3..83d6cd1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1877,6 +1877,8 @@ asmlinkage long sys_mkdirat(int dfd, con
 	int error = 0;
 	char * tmp;
 
+	if (is_compat_task())
+		dfd = compat_sign_extend(dfd);
 	tmp = getname(pathname);
 	error = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f9ca534..e6c9db6 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -162,4 +162,10 @@ int get_compat_sigevent(struct sigevent 
 		const struct compat_sigevent __user *u_event);
 
 #endif /* CONFIG_COMPAT */
+
+static inline int compat_sign_extend(long i)
+{
+	return i;
+}
+
 #endif /* _LINUX_COMPAT_H */

On powerpc64, this is sufficient to get the 32 to 64 bit sign extension
we need done in place.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
