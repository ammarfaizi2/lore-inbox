Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFTVFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFTVFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFTU6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:58:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261729AbVFTUhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:37:18 -0400
Date: Mon, 20 Jun 2005 13:38:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: jgarzik@pobox.com, telendiz@eircom.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in /fs/open.c
Message-Id: <20050620133800.0dac1d97.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506201154300.2245@graphe.net>
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
	<42B70E62.5070704@pobox.com>
	<Pine.LNX.4.62.0506201154300.2245@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> On Mon, 20 Jun 2005, Jeff Garzik wrote:
> 
> > If you don't like goto, don't read kernel code!
> 
> But his patch also cleans up a code quit a bit.

Yes, it is cleaner that way.

The old trick to make the error-handling code out-of-line shouldn't be
needed nowadays - IS_ERR uses unlikely(), which is supposed to handle that
stuff.

We can go a bit further and remove local variable `error'.

Code size is the same before and after, and the assembly very similar.

diff -puN fs/open.c~sys_open-cleanup fs/open.c
--- 25/fs/open.c~sys_open-cleanup	Mon Jun 20 13:31:54 2005
+++ 25-akpm/fs/open.c	Mon Jun 20 13:33:37 2005
@@ -934,7 +934,7 @@ EXPORT_SYMBOL(fd_install);
 asmlinkage long sys_open(const char __user * filename, int flags, int mode)
 {
 	char * tmp;
-	int fd, error;
+	int fd;
 
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
@@ -945,20 +945,16 @@ asmlinkage long sys_open(const char __us
 		fd = get_unused_fd();
 		if (fd >= 0) {
 			struct file *f = filp_open(tmp, flags, mode);
-			error = PTR_ERR(f);
-			if (IS_ERR(f))
-				goto out_error;
-			fd_install(fd, f);
+			if (IS_ERR(f)) {
+				put_unused_fd(fd);
+				fd = PTR_ERR(f);
+			} else {
+				fd_install(fd, f);
+			}
 		}
-out:
 		putname(tmp);
 	}
 	return fd;
-
-out_error:
-	put_unused_fd(fd);
-	fd = error;
-	goto out;
 }
 EXPORT_SYMBOL_GPL(sys_open);
 
_

