Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTJIPdg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTJIPdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:33:36 -0400
Received: from zero.aec.at ([193.170.194.10]:35858 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262195AbTJIPde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:33:34 -0400
Date: Thu, 9 Oct 2003 17:33:17 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009153317.GA3096@averell>
References: <20031009151212.GA54555@colin2.muc.de> <Pine.LNX.4.44.0310090816360.1694-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310090816360.1694-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 08:17:48AM -0700, Linus Torvalds wrote:
> 
> On 9 Oct 2003, Andi Kleen wrote:
> > 
> > Ok. But what is with mappings that have MAY_READ not set ?
> > [not 100% this cannot happen]
> 
> Well, PROT_NONE will not have MAY_READ set, and no, they won't get locked 
> into memory.
> 
> But neither did they get locked in before either, so it's not like it's a 
> new issue. Now we'd just ignore them nicely rather than abort the 
> lockall(). Hmm?

Ok, here's a new version.

-------------------------------------------------------------------------

Fix mlockall when there are unreadable mappings in the address space
(happens frequently on x86-64 where ld.so creates an unreadable mapping
for libc). Ignores mappings that don't have MAY_READ set in the high level 
mlockall function.

As an improvement it continues mlockall now for all mappings even when an 
error occurs. The error is still reported, but only the first one.

This should do the right thing for applications that do mlockall(MCL_CURRENT)
but don't want to worry about some weird mappings e.g. from DRI in their
address space.


diff -u linux-test7-work/mm/mlock.c-o linux-test7-work/mm/mlock.c
--- linux-test7-work/mm/mlock.c-o	2003-09-28 10:53:25.000000000 +0200
+++ linux-test7-work/mm/mlock.c	2003-12-04 16:33:58.000000000 +0100
@@ -135,7 +135,7 @@
 
 static int do_mlockall(int flags)
 {
-	int error;
+	int error, nerr;
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
@@ -154,9 +154,15 @@
 		newflags = vma->vm_flags | VM_LOCKED;
 		if (!(flags & MCL_CURRENT))
 			newflags &= ~VM_LOCKED;
-		error = mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
-		if (error)
-			break;
+
+		if (!(newflags & VM_READ))
+			continue;
+
+	        nerr = mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
+		/* When an error occurs continue with the next mapping, 
+		   but report only the first one */
+		if (nerr && !error)
+			error = nerr;
 	}
 	return error;
 }
