Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUDITfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUDITfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:35:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:17163 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261673AbUDITfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:35:12 -0400
Date: Fri, 9 Apr 2004 23:35:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ALPHA] Fix unaligned stxncpy again
Message-ID: <20040409233511.B727@den.park.msu.ru>
References: <20040409103244.GA1904@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040409103244.GA1904@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Fri, Apr 09, 2004 at 08:32:44PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 08:32:44PM +1000, Herbert Xu wrote:
> The current stxncpy on alpha is still broken when it comes to single
> word, unaligned, src misalignment > dest misalignment copies.
> 
> I've attached a program which demonstrates this problem.

Ugh, indeed. It fails when there is a zero byte before the data.
Thanks.

> So here is the patch to revert the unaligned case to use the same code
> as glibc.

Here is simpler equivalent of that and ev6 fix.

Ivan.

--- linux.orig/arch/alpha/lib/ev6-stxncpy.S	Sun Apr  4 07:37:42 2004
+++ linux/arch/alpha/lib/ev6-stxncpy.S	Fri Apr  9 22:13:40 2004
@@ -365,7 +365,7 @@ $unaligned:
 	andnot	t2, t6, t12	# E : dest mask for a single word copy
 	or	t8, t10, t5	# E : test for end-of-count too
 
-	cmpbge	zero, t2, t3	# E :
+	cmpbge	zero, t12, t3	# E :
 	cmoveq	a2, t5, t8	# E : Latency=2, extra map slot
 	nop			# E : keep with cmoveq
 	andnot	t8, t3, t8	# E : (stall)
--- linux.orig/arch/alpha/lib/stxncpy.S	Sun Apr  4 07:38:22 2004
+++ linux/arch/alpha/lib/stxncpy.S	Fri Apr  9 22:14:24 2004
@@ -317,7 +317,7 @@ $unaligned:
 	cmpbge	zero, t1, t8	# .. e1 : is there a zero?
 	andnot	t2, t6, t12	# e0    : dest mask for a single word copy
 	or	t8, t10, t5	# .. e1 : test for end-of-count too
-	cmpbge	zero, t2, t3	# e0    :
+	cmpbge	zero, t12, t3	# e0    :
 	cmoveq	a2, t5, t8	# .. e1 :
 	andnot	t8, t3, t8	# e0    :
 	beq	t8, $u_head	# .. e1 (zdb)
