Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTJIPlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTJIPlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:41:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:42198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262262AbTJIPlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:41:18 -0400
Date: Thu, 9 Oct 2003 08:40:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: Andi Kleen <ak@colin2.muc.de>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <bos@serpentine.com>
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
In-Reply-To: <20031009153317.GA3096@averell>
Message-ID: <Pine.LNX.4.44.0310090837490.10041-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003, Andi Kleen wrote:
> 
> Ok, here's a new version.

Still won't work.

You need to call mlock_fixup() to split the vma properly (it might not 
cover the whole vma, and we _do_ want to keep track of the VM_LOCKED flag 
correctly.

I _think_ the proper fix is something trivial like this, but it's 
obviously untested. Please verify

		Linus

----
--- 1.6/mm/mlock.c	Sun Sep 21 14:50:36 2003
+++ edited/mm/mlock.c	Thu Oct  9 08:39:25 2003
@@ -43,7 +43,8 @@
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
 		pages = -pages;
-		ret = make_pages_present(start, end);
+		if (newflags & VM_READ)
+			ret = make_pages_present(start, end);
 	}
 
 	vma->vm_mm->locked_vm -= pages;

