Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319565AbSIHEWt>; Sun, 8 Sep 2002 00:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319566AbSIHEWt>; Sun, 8 Sep 2002 00:22:49 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:47120 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319565AbSIHEWs>;
	Sun, 8 Sep 2002 00:22:48 -0400
Date: Sun, 08 Sep 2002 13:20:18 +0900 (JST)
Message-Id: <20020908.132018.52159009.taka@valinux.co.jp>
To: paubert@iram.es
Cc: lk@tantalophile.demon.co.uk, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.33.0209051334280.13338-100000@gra-lx1.iram.es>
References: <20020905121717.A15540@kushida.apsleyroad.org>
	<Pine.LNX.4.33.0209051334280.13338-100000@gra-lx1.iram.es>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I updated the csum_partial() for x86.
csum_partial() for standard x86 can also handle odd buffer better.

> > > Now that is grossly inefficient ;-) since you can save one instruction by
> > > moving roll after adcl (hand edited partial patch hunk, won't apply):

I applied it.
But it will be trivial for its performance on most packets.

> > I've been doing some PPro assembly lately, and I'm reminded that
> > sometimes inserting instructions can reduce the timing by up to 8 cycles
> > or so.
> 
> The one instruction that you can still be moved around easily is the
> pointer increment. But I would never try to improve code paths that I
> consider non critical.

I wish recent x86 processor can reorder instructions in it.


--- linux/arch/i386/lib/checksum.S.BUG	Sun Sep  1 17:00:59 2030
+++ linux/arch/i386/lib/checksum.S	Fri Sep  6 16:19:27 2030
@@ -55,8 +55,21 @@ csum_partial:	
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
 	movl 16(%esp),%ecx	# Function arg: int len
 	movl 12(%esp),%esi	# Function arg: unsigned char *buff
-	testl $2, %esi		# Check alignment.
+	testl $3, %esi		# Check alignment.
 	jz 2f			# Jump if alignment is ok.
+	testl $1, %esi		# Check alignment.
+	jz 10f			# Jump if alignment is boundary of 2bytes.
+
+	# buf is odd
+	dec %ecx
+	jl 8f
+	movzbl (%esi), %ebx
+	adcl %ebx, %eax
+	roll $8, %eax
+	inc %esi
+	testl $2, %esi
+	jz 2f
+10:
 	subl $2, %ecx		# Alignment uses up two bytes.
 	jae 1f			# Jump if we had at least two bytes.
 	addl $2, %ecx		# ecx was < 2.  Deal with it.
@@ -111,6 +124,10 @@ csum_partial:	
 6:	addl %ecx,%eax
 	adcl $0, %eax 
 7:	
+	testl $1, 12(%esp)
+	jz 8f
+	roll $8, %eax
+8:
 	popl %ebx
 	popl %esi
 	ret
@@ -126,8 +143,8 @@ csum_partial:
 	movl 16(%esp),%ecx	# Function arg: int len
 	movl 12(%esp),%esi	# Function arg:	const unsigned char *buf
 
-	testl $2, %esi         
-	jnz 30f                 
+	testl $3, %esi         
+	jnz 25f                 
 10:
 	movl %ecx, %edx
 	movl %ecx, %ebx
@@ -145,6 +162,19 @@ csum_partial:
 	lea 2(%esi), %esi
 	adcl $0, %eax
 	jmp 10b
+25:
+	testl $1, %esi         
+	jz 30f                 
+	# buf is odd
+	dec %ecx
+	jl 90f
+	movzbl (%esi), %ebx
+	addl %ebx, %eax
+	adcl $0, %eax
+	roll $8, %eax
+	inc %esi
+	testl $2, %esi
+	jz 10b
 
 30:	subl $2, %ecx          
 	ja 20b                 
@@ -211,6 +241,10 @@ csum_partial:
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
