Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUDIKdS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUDIKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 06:33:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:8203 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261179AbUDIKdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 06:33:14 -0400
Date: Fri, 9 Apr 2004 20:32:44 +1000
To: Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ALPHA] Fix unaligned stxncpy again
Message-ID: <20040409103244.GA1904@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The current stxncpy on alpha is still broken when it comes to single
word, unaligned, src misalignment > dest misalignment copies.

I've attached a program which demonstrates this problem.

It looks like the code in glibc is correct and does not suffer from
the last problem that Richard fixed where the destination got
partially cleared.

So here is the patch to revert the unaligned case to use the same code
as glibc.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--jI8keyz6grp/JLjh
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="b.c"

#include <string.h>
#include <stdio.h>
#include <strings.h>
#include <pwd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	char buf[64];
	union {
		unsigned long foo;
		char salt[16];
	} u;
	int off;

	memcpy(u.salt, "abcde\0../\0jjj", 16);

	off = argc > 1 ? atoi(argv[1]) : 34;
	printf("%d\n", off);

	memset(buf, 1, 64);
	__stxncpy(buf + off, u.salt + 6, 3);
	buf[off + 3] = 0;
	printf("%s\n", buf + off - 8);

	return 0;
}

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: arch/alpha/lib/stxncpy.S
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/arch/alpha/lib/stxncpy.S,v
retrieving revision 1.4
diff -u -r1.4 stxncpy.S
--- a/arch/alpha/lib/stxncpy.S	3 Sep 2003 10:26:49 -0000	1.4
+++ b/arch/alpha/lib/stxncpy.S	9 Apr 2004 10:23:30 -0000
@@ -313,9 +313,9 @@
 	lda	t2, -1		# e0    : for creating masks later
 	beq	t12, $u_head	# .. e1 :
 
-	extql	t2, a1, t2	# e0    :
+	mskqh	t2, t5, t2	# e0	: begin src validity mask
 	cmpbge	zero, t1, t8	# .. e1 : is there a zero?
-	andnot	t2, t6, t12	# e0    : dest mask for a single word copy
+	extql	t2, a1, t2	# e0    :
 	or	t8, t10, t5	# .. e1 : test for end-of-count too
 	cmpbge	zero, t2, t3	# e0    :
 	cmoveq	a2, t5, t8	# .. e1 :
@@ -330,14 +330,14 @@
 	ldq_u	t0, 0(a0)	# e0    :
 	negq	t8, t6		# .. e1 : build bitmask of bytes <= zero
 	mskqh	t1, t4, t1	# e0    :
-	and	t6, t8, t2	# .. e1 :
-	subq	t2, 1, t6	# e0    :
-	or	t6, t2, t8	# e1    :
+	and	t6, t8, t12	# .. e1 :
+	subq	t12, 1, t6	# e0    :
+	or	t6, t12, t8	# e1    :
 
-	zapnot	t12, t8, t12	# e0    : prepare source word; mirror changes
+	zapnot	t2, t8, t2	# e0    : prepare source word; mirror changes
 	zapnot	t1, t8, t1	# .. e1 : to source validity mask
 
-	andnot	t0, t12, t0	# e0    : zero place for source to reside
+	andnot	t0, t2, t0	# e0    : zero place for source to reside
 	or	t0, t1, t0	# e1    : and put it there
 	stq_u	t0, 0(a0)	# e0    :
 	ret	(t9)		# .. e1 :

--jI8keyz6grp/JLjh--
