Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTKRVJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTKRVJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 16:09:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:51879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263787AbTKRVJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 16:09:25 -0500
Date: Tue, 18 Nov 2003 13:09:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: leif <leif@gci.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error in Sparc64 rwlock.S
Message-Id: <20031118130956.1edd4a24.akpm@osdl.org>
In-Reply-To: <00de01c3ae17$1ac8bd70$31828ad0@internet.gci.net>
References: <200212112043.gBBKhLE28272@devserv.devel.redhat.com>
	<00de01c3ae17$1ac8bd70$31828ad0@internet.gci.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

leif <leif@gci.net> wrote:
>
> I'm going through the 2.6.0-test9 and some -mm3 patches, and have run
> into
> an issue with arch/sparc64/lib/rwlock.S
> 
> When compiling, the assembler complains of multiple definitions of
> __write_trylock.

OK, the lockmeter patch adds a write_trylock() implementation to sparc64,
but now Linus's tree has one anyway.

Does this fix it?

diff -puN arch/sparc64/lib/rwlock.S~lockmeter-sparc64-fix arch/sparc64/lib/rwlock.S
--- 25/arch/sparc64/lib/rwlock.S~lockmeter-sparc64-fix	Tue Nov 18 13:07:40 2003
+++ 25-akpm/arch/sparc64/lib/rwlock.S	Tue Nov 18 13:08:26 2003
@@ -98,20 +98,5 @@ __read_trylock: /* %o0 = lock_ptr */
 	retl
 	 mov		1, %o0
 
-	.globl		__write_trylock
-__write_trylock: /* %o0 = lock_ptr */
-	sethi		%hi(0x80000000), %g2
-1:	lduw		[%o0], %g5
-4:	brnz,pn		%g5, 100f
-	 or		%g5, %g2, %g7
-	cas		[%o0], %g5, %g7
-	cmp		%g5, %g7
-	bne,pn		%icc, 1b
-	 membar		#StoreLoad | #StoreStore
-	retl
-	 mov		1, %o0
-100:	retl
-	 mov		0, %o0
-
 rwlock_impl_end:
 

_

