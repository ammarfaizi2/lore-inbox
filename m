Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbQLUQMM>; Thu, 21 Dec 2000 11:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQLUQMD>; Thu, 21 Dec 2000 11:12:03 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:46855 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S130195AbQLUQLv>; Thu, 21 Dec 2000 11:11:51 -0500
Date: Thu, 21 Dec 2000 18:40:46 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alexander Zarochentcev <zam@namesys.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: memmove() in 2.4.0-test12, alpha platform
Message-ID: <20001221184046.A6717@jurassic.park.msu.ru>
In-Reply-To: <20001220220342.B20612@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001220220342.B20612@crimson.namesys.com>; from zam@namesys.com on Wed, Dec 20, 2000 at 10:03:42PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 10:03:42PM +0300, Alexander Zarochentcev wrote:
> New (since test12) optimized memmove function seems to be broken
> on alpha platform. 

Indeed it is.

> If dest and src arguments are misaligned, new memmove does wrong things.

Actually it broke when dest < src. Incrementing pointers should be used in
this case.

This patch seems to work (tested in userspace).

Ivan.

--- linux/arch/alpha/lib/memmove.S.orig	Tue Dec 12 00:46:26 2000
+++ linux/arch/alpha/lib/memmove.S	Thu Dec 21 18:32:59 2000
@@ -26,12 +26,16 @@ memmove:
 	bne $1,memcpy
 
 	and $2,7,$2			/* Test for src/dest co-alignment.  */
-	bne $2,$misaligned
+	and $16,7,$1
+	cmpule $16,$17,$3
+	bne $3,$memmove_up		/* dest < src */
 
 	and $4,7,$1
-	beq $1,$skip_aligned_byte_loop_head
+	bne $2,$misaligned_dn
+	unop
+	beq $1,$skip_aligned_byte_loop_head_dn
 
-$aligned_byte_loop_head:
+$aligned_byte_loop_head_dn:
 	lda $4,-1($4)
 	lda $5,-1($5)
 	unop
@@ -48,13 +52,13 @@ $aligned_byte_loop_head:
 	and $4,7,$6
 
 	stq_u $1,0($4)
-	bne $6,$aligned_byte_loop_head
+	bne $6,$aligned_byte_loop_head_dn
 
-$skip_aligned_byte_loop_head:
+$skip_aligned_byte_loop_head_dn:
 	lda $18,-8($18)
-	blt $18,$skip_aligned_word_loop
+	blt $18,$skip_aligned_word_loop_dn
 
-$aligned_word_loop:
+$aligned_word_loop_dn:
 	ldq $1,-8($5)
 	nop
 	lda $5,-8($5)
@@ -63,22 +67,22 @@ $aligned_word_loop:
 	stq $1,-8($4)
 	nop
 	lda $4,-8($4)
-	bge $18,$aligned_word_loop
+	bge $18,$aligned_word_loop_dn
 
-$skip_aligned_word_loop:
+$skip_aligned_word_loop_dn:
 	lda $18,8($18)
-	bgt $18,$byte_loop_tail
+	bgt $18,$byte_loop_tail_dn
 	unop
 	ret $31,($26),1
 
 	.align 4
-$misaligned:
+$misaligned_dn:
 	nop
 	fnop
 	unop
 	beq $18,$egress
 
-$byte_loop_tail:
+$byte_loop_tail_dn:
 	ldq_u $3,-1($5)
 	ldq_u $2,-1($4)
 	lda $5,-1($5)
@@ -91,8 +95,77 @@ $byte_loop_tail:
 
 	bis $1,$2,$1
 	stq_u $1,0($4)
+	bgt $18,$byte_loop_tail_dn
+	br $egress
+
+$memmove_up:
+	mov $16,$4
+	mov $17,$5
+	bne $2,$misaligned_up
+	beq $1,$skip_aligned_byte_loop_head_up
+
+$aligned_byte_loop_head_up:
+	unop
+	ble $18,$egress
+	ldq_u $3,0($5)
+	ldq_u $2,0($4)
+
+	lda $18,-1($18)
+	extbl $3,$5,$1
+	insbl $1,$4,$1
+	mskbl $2,$4,$2
+
+	bis $1,$2,$1
+	lda $5,1($5)
+	stq_u $1,0($4)
+	lda $4,1($4)
+
+	and $4,7,$6
+	bne $6,$aligned_byte_loop_head_up
+
+$skip_aligned_byte_loop_head_up:
+	lda $18,-8($18)
+	blt $18,$skip_aligned_word_loop_up
+
+$aligned_word_loop_up:
+	ldq $1,0($5)
+	nop
+	lda $5,8($5)
+	lda $18,-8($18)
+
+	stq $1,0($4)
+	nop
+	lda $4,8($4)
+	bge $18,$aligned_word_loop_up
+
+$skip_aligned_word_loop_up:
+	lda $18,8($18)
+	bgt $18,$byte_loop_tail_up
+	unop
+	ret $31,($26),1
+
+	.align 4
+$misaligned_up:
+	nop
+	fnop
+	unop
+	beq $18,$egress
+
+$byte_loop_tail_up:
+	ldq_u $3,0($5)
+	ldq_u $2,0($4)
+	lda $18,-1($18)
+	extbl $3,$5,$1
+
+	insbl $1,$4,$1
+	mskbl $2,$4,$2
+	bis $1,$2,$1
+	stq_u $1,0($4)
+
+	lda $5,1($5)
+	lda $4,1($4)
 	nop
-	bgt $18,$byte_loop_tail
+	bgt $18,$byte_loop_tail_up
 
 $egress:
 	ret $31,($26),1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
