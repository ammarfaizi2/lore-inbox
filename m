Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSICHox>; Tue, 3 Sep 2002 03:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318736AbSICHow>; Tue, 3 Sep 2002 03:44:52 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:28940 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S318731AbSICHou>;
	Tue, 3 Sep 2002 03:44:50 -0400
Date: Tue, 03 Sep 2002 16:42:43 +0900 (JST)
Message-Id: <20020903.164243.21934772.taka@valinux.co.jp>
To: kuznet@ms2.inr.ac.ru
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       davem@redhat.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200209021858.WAA00388@sex.inr.ac.ru>
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
	<200209021858.WAA00388@sex.inr.ac.ru>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

kuznet> > [1] Kudos to 
kuznet> 
kuznet> Hmm... wait awhile with celebrating, the implementation in tcp is still
kuznet> at level of a toy. Well, and it happens to crash, the patch is enclosed.

I guess it may also depend on bad implementations of csum_partial().
It's wrong that some architecture assume every data in a skbuff are
aligned on a 2byte boundary so that it would access a byte next to
the the last byte where no pages might be there.

And we should know sendfile systemcall also pass pages with any offsets
and any byte  while csum_partial() may be called from everywhere
in the kernel including device drivers.

It's time to fix csum_partial().


P.S.
    Using "bswap" is little bit tricky.

Regards,
Hirokazu Takahashi
VP Engineering Dept.
VA Linux Systems Japan



--- linux/arch/i386/lib/checksum.S.BUG	Sun Sep  1 17:00:59 2030
+++ linux/arch/i386/lib/checksum.S	Mon Sep  2 13:09:09 2030
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
+	bswap %eax
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
+	bswap %eax
+90: 
 	popl %ebx
 	popl %esi
 	ret
