Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVL3RZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVL3RZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 12:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVL3RZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 12:25:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964884AbVL3RZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 12:25:42 -0500
Date: Fri, 30 Dec 2005 09:25:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Yi Yang <yang.y.yi@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
In-Reply-To: <43B4F287.6080307@gmail.com>
Message-ID: <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
References: <43B4F287.6080307@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Yi Yang wrote:
>
> If the user reads a sysctl entry which is of string type
> by sysctl syscall, this call probably corrupts the user data
> right after the old value buffer, the issue lies in sysctl_string
> seting 0 to oldval[len], len is the available buffer size
> specified by the user, obviously, this will write to the first
> byte of the user memory place immediate after the old value buffer,
> the correct way is that sysctl_string doesn't set 0, the user
> should do it by self in the program.

Hmm.. I think this patch is incomplete.

We _should_ zero-pad the data, at least if the result fits in the buffer.

So I think the correct fix is to just _copy_ the last zero if it fits in 
the buffer, rather than do the unconditional "add NUL at the end" thing. 
The simplest way to do that is to just make "l" be "strlen(str)+1", so 
that we count the ending NUL in the length (and then, if the buffer isn't 
big enough, we will truncate it).

In other words, I would instead suggest a patch like the appended.

But even that is questionable: one alternative is to always zero-pad (like 
we used to), but make sure that the buffer size is sufficient for it (ie 
instead of adding one to the length of the string, we'd subtract one from 
the buffer length and make sure that the '\0' fits..

Comments?

		Linus
---
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9990e10..ad0425a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2201,14 +2201,12 @@ int sysctl_string(ctl_table *table, int 
 		if (get_user(len, oldlenp))
 			return -EFAULT;
 		if (len) {
-			l = strlen(table->data);
+			l = strlen(table->data)+1;
 			if (len > l) len = l;
 			if (len >= table->maxlen)
 				len = table->maxlen;
 			if(copy_to_user(oldval, table->data, len))
 				return -EFAULT;
-			if(put_user(0, ((char __user *) oldval) + len))
-				return -EFAULT;
 			if(put_user(len, oldlenp))
 				return -EFAULT;
 		}
