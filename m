Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267586AbUHEHZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267586AbUHEHZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUHEHZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:25:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:4787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267586AbUHEHZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:25:12 -0400
Date: Thu, 5 Aug 2004 00:25:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
In-Reply-To: <200408042216.12215.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408042216.12215.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Aug 2004, Gene Heskett wrote:
> 
> I *thought* I had PREEMPT turned off, but when I did a make xconfig, 
> it was turned on.  So its now off, and a new 2.6.8-rc3 is building.
> It was frame pointers I had turned on for the last build, still on for 
> this one underway now.

Your latest bug report definitely had preempt on, you could see the 
preempt code in the oops output when disassembled. 

Also, could you please enable CONFIG_DEBUG_BUGVERBOSE by hand if you use
the -mm tree, since you definitely hit a BUG() in there somewhere, but in
the -mm tree, the BUG()  message is totally unreadable unless you enable
BUGVERBOSE (and it's not in the config file).

(Andrew - I think you should drop that patch, or at least enable 
BUGVERBOSE on x86 - it looks like it's disabled and with no way to enable 
it in the current -mm tree..)

I _suspect_ you hit the new "list_del-debug.patch" in Andrew's tree, 
because in my tree there are no BUG_ON's in prune_cache() at all. 

If so, I think the last oops you had was

	BUG_ON(entry->next->prev != entry);

in list_del(), but the fact is, the _interesting_ part in prune_dcache() 
ends up being the "list_del_init()" at the top, which is _not_ 
instrumented by the list_del-debug patch.

So what I'd actually _like_ you to do is:
 - test 2.6.8-rc3, but with the "list_del-debug-patch" applied (appended).
   That way the BUG message will actually be readable.
 - add the same two BUG_ON() to "list_del_init()" too, for better 
   coverage. Most of the dcache uses the "init" version.
 - keep PREEMPT on, since it is quite possible (likely) that this is a 
   preempt problem.

I'd love to see if you can hit the BUG() that way.

		Linus

----

>From Manfred Spraul

A list_del debugging check.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/list.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/linux/list.h~list_del-debug include/linux/list.h
--- 25/include/linux/list.h~list_del-debug	Mon Jun 14 16:44:07 2004
+++ 25-akpm/include/linux/list.h	Mon Jun 14 16:51:27 2004
@@ -6,6 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/prefetch.h>
 #include <asm/system.h>
+#include <asm/bug.h>
 
 /*
  * These are non-NULL pointers that will result in page faults
@@ -160,6 +161,8 @@ static inline void __list_del(struct lis
  */
 static inline void list_del(struct list_head *entry)
 {
+	BUG_ON(entry->prev->next != entry);
+	BUG_ON(entry->next->prev != entry);
 	__list_del(entry->prev, entry->next);
 	entry->next = LIST_POISON1;
 	entry->prev = LIST_POISON2;
_
