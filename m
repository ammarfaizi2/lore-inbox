Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268925AbTGTXxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbTGTXxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:53:24 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:41684 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S268925AbTGTXxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:53:23 -0400
Date: Mon, 21 Jul 2003 10:08:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
Message-Id: <20030721100819.11584560.sfr@canb.auug.org.au>
In-Reply-To: <20030719183254.GE25703@krispykreme>
References: <20030714084000.J15481@devserv.devel.redhat.com>
	<20030715025252.17ec8d6f.sfr@canb.auug.org.au>
	<20030719183254.GE25703@krispykreme>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Sun, 20 Jul 2003 04:32:54 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> Hi Stephen,
> 
> > I am not sure if the s390 fix is correct (since s390x has been merged) or
> > if x86_64 needs this (as I cannot remember the alignment needs of the
> > x86_64 compiler - though I suspect it is needed).
> 
> I didnt follow this thread very carefully :) Is ppc64 broken?

It is broken subtly (but noone would probably notice :-)).  It is OK
on the structure size, but copy_siginfo will copy sizeof(int) bytes less
than necessary sometimes (particularly in the case of a SIGCHILD).

You need the following patch (against 2.6.0-test1-bk2 but should apply
to just about anything).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.0-test1-bk2/include/asm-ppc64/siginfo.h 2.6.0-test1-bk2-sfr.1/include/asm-ppc64/siginfo.h
--- 2.6.0-test1-bk2/include/asm-ppc64/siginfo.h	2002-11-05 17:00:34.000000000 +1100
+++ 2.6.0-test1-bk2-sfr.1/include/asm-ppc64/siginfo.h	2003-07-21 09:59:04.000000000 +1000
@@ -8,8 +8,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define SI_PAD_SIZE    ((SI_MAX_SIZE/sizeof(int)) - 4)
-#define SI_PAD_SIZE32  ((SI_MAX_SIZE/sizeof(int)) - 3)
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#define SI_PAD_SIZE32		((SI_MAX_SIZE/sizeof(int)) - 3)
 
 #include <asm-generic/siginfo.h>
 
