Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266164AbUFUItj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUFUItj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUFUItj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:49:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:32748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266164AbUFUIth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:49:37 -0400
Date: Mon, 21 Jun 2004 01:48:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
Message-Id: <20040621014837.6b52fa2e.akpm@osdl.org>
In-Reply-To: <40D64DF7.5040601@pobox.com>
References: <40D64DF7.5040601@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Something is definitely screwy with the latest -bk.

Would you believe that there is a totally separate bug in the latest -mm
which has exactly the same symptoms?

mark_offset_tsc() does

	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
		jiffies_64++;

which is doing abs(unsigned long).

Which works OK if abs() in a function, but I made it a macro.

This fixes it up.


diff -puN include/linux/kernel.h~abs-fix-fix include/linux/kernel.h
--- 25/include/linux/kernel.h~abs-fix-fix	2004-06-21 01:42:24.283873616 -0700
+++ 25-akpm/include/linux/kernel.h	2004-06-21 01:43:08.150204920 -0700
@@ -55,7 +55,12 @@ void __might_sleep(char *file, int line)
 #endif
 
 #define abs(x) ({				\
-		typeof(x) __x = (x);		\
+		int __x = (x);			\
+		(__x < 0) ? -__x : __x;		\
+	})
+
+#define labs(x) ({				\
+		long __x = (x);			\
 		(__x < 0) ? -__x : __x;		\
 	})
 
_

