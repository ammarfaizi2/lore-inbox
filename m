Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTKNInN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 03:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKNInN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 03:43:13 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:63493 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262131AbTKNInM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 03:43:12 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: torvalds@osdl.org (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
Organization: Core
In-Reply-To: <Pine.LNX.4.44.0311131450220.1861-100000@home.osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AKZXh-0001TY-00@gondolin.me.apana.org.au>
Date: Fri, 14 Nov 2003 19:43:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Thu, 13 Nov 2003, Jochen Voss wrote:
>> 
>> I think the best thing would be, to incorporate the patch to
>> prevent the crashes with "local APIC support on
>> uniprocessors" enabled and ignore the rest of the problem.
> 
> Yup, I'm going to commit a minimal patch that just changes the panic calls 
> into printk's.

That patch produces a message with no terminating newline on the
machine in question.  This is because one of the four bytes that
you're printing out is NUL.  The following patch avoids that problem.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
--- kernel-source-2.5/arch/i386/kernel/mpparse.c.orig	2003-11-14 19:40:49.000000000 +1100
+++ kernel-source-2.5/arch/i386/kernel/mpparse.c	2003-11-13 20:48:50.000000000 +1100
@@ -361,15 +361,12 @@
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
-		printk("SMP mptable: bad signature [%c%c%c%c]!\n",
-			mpc->mpc_signature[0],
-			mpc->mpc_signature[1],
-			mpc->mpc_signature[2],
-			mpc->mpc_signature[3]);
+		printk(KERN_ERR "SMP mptable: bad signature [0x%x]!\n",
+			*(u32 *)mpc->mpc_signature);
 		return 0;
 	}
 	if (mpf_checksum((unsigned char *)mpc,mpc->mpc_length)) {
-		printk("SMP mptable: checksum error!\n");
+		printk(KERN_ERR "SMP mptable: checksum error!\n");
 		return 0;
 	}
 	if (mpc->mpc_spec!=0x01 && mpc->mpc_spec!=0x04) {
