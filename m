Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUANIrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUANIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:47:09 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:17536 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S264963AbUANIrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:47:02 -0500
Date: Wed, 14 Jan 2004 09:46:54 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: [PATCH] Use -funit-at-a-time when possible
Message-ID: <20040114084654.GA1858@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The upcomming gcc 3.4 has a new compilation mode called unit-at-a-time.
What it does is to first load the whole file into memory and then generate
the output. This allows it to use a better inlining strategy, drop unused
static functions and use -mregparm automatically for static functions.

It does not seem to compile significantly slower.

This is also available in some of the 3.3 based "hammer branch"
compilers used in distributions (at least in SuSE and Mandrake)

Some tests show impressive .text shrinkage from unit-at-a-time.

e.g. here is the same kernel compiled with -fno-unit-at-a-time and
-funit-at-a-time with a gcc 3.4 snapshot. The gains are really
impressive:

   text    data     bss     dec     hex filename
4129346  708629  207240 5045215  4cfbdf vmlinux-nounitatatime
3999250  674853  207208 4881311  4a7b9f vmlinux-unitatatime

.text shrinks by over 130KB!. And .data shrinks too. 

At first look the numbers look nearly too good to be true, but they have been 
verified with several configurations and seem to be real. It looks like
we have a lot of stupid inlines or dead functions. I'm really not 
sure why it is that much better. But it's hard to argue with hard
numbers.

[A bloat-o-meter comparision between the two vmlinuxes can be found in 
http://www.firstfloor.org/~andi/unit-vs-no-unit.gz . It doesn't show
any obvious candidates unfortunately, just lots of small changes]

With the gcc 3.3-hammer from SuSE 9.0 the gains are a bit smaller, but
still noticeable (>100KB on .text)

Enabling -funit-at-a-time requires at least one kernel patch (the
"noinline" patch I sent earlier), on top of the no always inline patch required
to make it compile on gcc 3.4.

This patch enables -funit-at-a-time by default when it is available.

-Andi

--- linux-34/Makefile-o	2004-01-09 09:27:08.000000000 +0100
+++ linux-34/Makefile	2004-01-14 09:23:10.486613056 +0100
@@ -445,6 +446,10 @@
 CFLAGS		+= -g
 endif
 
+# Enable unit-at-a-time mode when possible. It shrinks the 
+# kernel considerably.
+CFLAGS += $(call check_gcc,-funit-at-a-time,)
+
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 



