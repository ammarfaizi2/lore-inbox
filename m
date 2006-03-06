Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWCFD2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWCFD2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 22:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWCFD2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 22:28:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751439AbWCFD2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 22:28:05 -0500
Date: Sun, 5 Mar 2006 19:27:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <20060305154858.0fb0006a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603051840280.13139@g5.osdl.org>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
 <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org> <20060304213447.GA4445@kroah.com>
 <20060304135138.613021bd.akpm@osdl.org> <20060304221810.GA20011@kroah.com>
 <20060305154858.0fb0006a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,
 I'm worried about the fact that kmalloc() doesn't get redlining.

The lifetime rules for the pipe_info thing and the bprm seems totally 
obvious, and we'd get slab errors if somebody was doing something strange 
there anyway.

So I'd be more inclined to blame a buffer overflow on a kmalloc, and the 
obvious target is the "add_uevent_var()" thing, since all/many of the 
corruptions seem to come from uevent environment variable strings.

Because kmalloc() doesn't do redlining, we'd never see an overflow as an 
error, and it would just overwrite the next block. Now, they are in 
different slab blocks (the uevent strign allocation is a 2048-byte 
allocation), but maybe it flows over into the next page entirely..

Now, it all uses "vnsprintf()" which _should_ be safe, but that in turn 
uses pointer comparisons, so maybe gcc screws that up. Who knows. Gcc has 
been known to use signed comparisons on pointers and other brokenness. And 
we could just have screwed something up (not updating "len" when we update 
the buffer start etc etc)

Anyway, this trivial patch will check for buffer length consistency and 
overflow by just putting a magic value at the end of the buffer, and 
checking it. Maybe.

I don't see anything wrong there, and booting with this patch doesn't 
trigger anything for me, but it's simple enough to be worth checking out.

			Linus
---
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 086a0c6..366214a 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -51,6 +51,9 @@ static char *action_to_string(enum kobje
 	}
 }
 
+#define UEV_MAGIC (0xc0edbabeu)
+#define uev_magic(buffer, len) ((unsigned int *) ((len) + (void *)(buffer)))[-1]
+
 /**
  * kobject_uevent - notify userspace by ending an uevent
  *
@@ -107,6 +110,8 @@ void kobject_uevent(struct kobject *kobj
 	if (!buffer)
 		goto exit;
 
+	uev_magic(buffer, BUFFER_SIZE) = UEV_MAGIC;
+
 	/* complete object path */
 	devpath = kobject_get_path(kobj, GFP_KERNEL);
 	if (!devpath)
@@ -223,6 +228,10 @@ int add_uevent_var(char **envp, int num_
 {
 	va_list args;
 
+	BUG_ON(buffer_size < 4);
+	BUG_ON(buffer_size > 2048);
+	BUG_ON(uev_magic(buffer, buffer_size) != UEV_MAGIC);
+
 	/*
 	 * We check against num_envp - 1 to make sure there is at
 	 * least one slot left after we return, since kobject_uevent()

