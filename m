Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSIECPl>; Wed, 4 Sep 2002 22:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSIECPl>; Wed, 4 Sep 2002 22:15:41 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:31246 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S316608AbSIECPk>;
	Wed, 4 Sep 2002 22:15:40 -0400
Date: Thu, 05 Sep 2002 11:13:26 +0900 (JST)
Message-Id: <20020905.111326.68164898.taka@valinux.co.jp>
To: hpa@zytor.com
Cc: paubert@iram.es, linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D768C0F.7040006@zytor.com>
References: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es>
	<3D768C0F.7040006@zytor.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> > While it would work, this sequence is overkill. Unless I'm mistaken, the
> > only property of bswap which is used in this case is that it swaps even
> > and odd bytes, which can be done by a simple "roll $8,%eax" (or rorl).
> > 
> > I believe that bswap is one byte shorter than roll. In any case, using a
> > rotate might be the right thing to do on other architectures.
> > 
> 
> And again, I think you'll find the rotate faster on at least some x86 cores.

Yeah, I replaced "bswap %eax" with "roll $8,%eax" which would be more
familier to us.

> Better fix is to verify len >=2 before half-word alignment
> test at the beginning of csum_partial.  I am not enough of
> an x86 coder to hack this up reliably. :-)

Don't care about the order of checking len and half-word alignment
as both of them have to be checked after all.

Thank you,
Hirokazu Takahashi.


--- linux/arch/i386/lib/checksum.S.BUG	Sun Sep  1 17:00:59 2030
+++ linux/arch/i386/lib/checksum.S	Thu Sep  5 10:33:31 2030
@@ -126,8 +126,8 @@ csum_partial:
 	movl 16(%esp),%ecx	# Function arg: int len
 	movl 12(%esp),%esi	# Function arg:	const unsigned char *buf
 
-	testl $2, %esi         
-	jnz 30f                 
+	testl $3, %esi         
+	jnz 25f                 
 10:
 	movl %ecx, %edx
 	movl %ecx, %ebx
@@ -145,6 +145,20 @@ csum_partial:
 	lea 2(%esi), %esi
 	adcl $0, %eax
 	jmp 10b
+25:
+	testl $1, %esi         
+	jz 30f                 
+	# buf is odd
+	dec %ecx
+	jl 90f
+	roll $8, %eax
+	movzbl (%esi), %ebx
+	shll $8, %ebx
+	addl %ebx, %eax
+	adcl $0, %eax
+	inc %esi
+	testl $2, %esi
+	jz 10b
 
 30:	subl $2, %ecx          
 	ja 20b                 
@@ -211,6 +225,10 @@ csum_partial:
 	addl %ebx,%eax
 	adcl $0,%eax
 80: 
+	testl $1, 12(%esp)
+	jz 90f
+	roll $8, %eax
+90: 
 	popl %ebx
 	popl %esi
 	ret

