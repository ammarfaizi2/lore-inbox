Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUESM53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUESM53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbUESM53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:57:29 -0400
Received: from colin2.muc.de ([193.149.48.15]:57873 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264160AbUESM51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:57:27 -0400
Date: 19 May 2004 14:57:26 +0200
Date: Wed, 19 May 2004 14:57:26 +0200
From: Andi Kleen <ak@muc.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Jan Kasprzak <kas@informatics.muni.cz>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519125726.GB68902@colin2.muc.de>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz> <20040519105805.GK30909@devserv.devel.redhat.com> <20040519124427.GA68902@colin2.muc.de> <20040519125036.GM30909@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519125036.GM30909@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The userland prototypes are:
> extern ssize_t sendfile (int __out_fd, int __in_fd, off_t *__offset,
>                          size_t __count) __THROW;
> extern ssize_t sendfile64 (int __out_fd, int __in_fd, __off64_t *__offset,
>                            size_t __count) __THROW;
> Thus you really cannot transfer more than 4G-1 bytes in one call on 32-bit
> arches.

True.

> Actually, already any counts >= 2GB-1 might be problematic, but we are
> there on the same boat as with e.g. read(2).  For read, POSIX says:
> "If the value of nbyte is greater than {SSIZE_MAX}, the result is
> implementation-defined."
> so portable programs really shouldn't try to transfer more than that
> in one go but the kernel certainly should try to handle sizes up to
> SIZE_MAX-4096 or something like that.

Hmm, ssize_t is signed. If there are any if (ret < 0) checks in the
kernel it will fail too. So the real limit would be 0x7fffffff

Perhaps that should be enforced like this?


diff -u linux/fs/read_write.c-o linux/fs/read_write.c
--- linux/fs/read_write.c-o	2004-05-18 10:55:54.000000000 +0200
+++ linux/fs/read_write.c	2004-05-19 14:57:06.000000000 +0200
@@ -700,6 +700,9 @@
 	off_t off;
 	ssize_t ret;
 
+	if (sizeof(size_t) == 4 && (int)count < 0)
+		return -EOVERFLOW;
+
 	if (offset) {
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
@@ -718,6 +721,9 @@
 	loff_t pos;
 	ssize_t ret;
 
+	if (sizeof(size_t) == 4 && (int)count < 0)
+		return -EOVERFLOW;
+		
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;

-Andi
