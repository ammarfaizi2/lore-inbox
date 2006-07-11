Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWGKXie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWGKXie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGKXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:38:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932251AbWGKXid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:38:33 -0400
Date: Tue, 11 Jul 2006 16:42:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: nickpiggin@yahoo.com.au, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, efault@gmx.de
Subject: Re: [patch] i386: handle_BUG(): don't print garbage if debug info
 unavailable
Message-Id: <20060711164208.323dada1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607110959160.5623@g5.osdl.org>
References: <200607101034_MC3-1-C497-51F7@compuserve.com>
	<20060711012755.59965932.akpm@osdl.org>
	<44B382DD.5070202@yahoo.com.au>
	<Pine.LNX.4.64.0607110959160.5623@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> That said, I think it's wrong to use "__get_user()", which can hang on the 
> MM semaphore if something is bogus. We should probably mark us as being 
> "in_atomic()" to make sure that the page fault handler, if it is entered, 
> will not try to get the semaphore or page anything in.

This?


--- a/include/linux/uaccess.h~add-probe_kernel_address
+++ a/include/linux/uaccess.h
@@ -19,4 +19,26 @@ static inline unsigned long __copy_from_
 
 #endif		/* ARCH_HAS_NOCACHE_UACCESS */
 
+/**
+ * probe_kernel_address(): safely attempt to read from a location
+ * @addr: address to read from - its type is type typeof(retval)*
+ * @retval: read into this variable
+ *
+ * Safely read from address @addr into variable @revtal.  If a kernel fault
+ * happens, handle that and return -EFAULT.
+ * We ensure that the __get_user() is executed in atomic context so that
+ * do_page_fault() doesn't attempt to take mmap_sem.  This makes
+ * probe_kernel_address() suitable for use within regions where the caller
+ * already holds mmap_sem, or other locks which nest inside mmap_sem.
+ */
+#define probe_kernel_address(addr, retval)		\
+	({						\
+		long ret;				\
+							\
+		inc_preempt_count();			\
+		ret = __get_user(retval, addr);		\
+		dec_preempt_count();			\
+		ret;					\
+	})
+
 #endif		/* __LINUX_UACCESS_H__ */
_

