Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbSKSWTh>; Tue, 19 Nov 2002 17:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbSKSWTh>; Tue, 19 Nov 2002 17:19:37 -0500
Received: from pop.gmx.net ([213.165.64.20]:41462 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267354AbSKSWTf>;
	Tue, 19 Nov 2002 17:19:35 -0500
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: Matthew Grant <grantma@anathoth.gen.nz>, debian-security@lists.debian.org,
       linux-kernel@vger.kernel.org, bugtraq@lists.securityfocus.com,
       lwn@lwn.net, alan@redhat.com, Herbert Xu <herbert@debian.org>
Subject: Re: [PATCH] ALERT!! - 2.2.x i386 Linux kernel has DoS same as 2.4.x!!!!
Date: Tue, 19 Nov 2002 23:21:15 +0100
User-Agent: KMail/1.4.3
References: <1037744004.10197.5.camel@luther>
In-Reply-To: <1037744004.10197.5.camel@luther>
MIME-Version: 1.0
Message-Id: <200211192320.09956.m.c.p@gmx.net>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_FRGU0UCVJW22VGVQTO7R"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_FRGU0UCVJW22VGVQTO7R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 19 November 2002 23:13, Matthew Grant wrote:

Hi Matt,

> Here is the patch to fix 2.2:
consider using this instead.

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
--------------Boundary-00=_FRGU0UCVJW22VGVQTO7R
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.2.22-fix-local-DoS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.2.22-fix-local-DoS.patch"

diff -urN linux.orig/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux.orig/arch/i386/kernel/entry.S	Tue May 21 01:32:34 2002
+++ linux/arch/i386/kernel/entry.S	Thu Nov 14 21:39:36 2002
@@ -63,7 +63,9 @@
 OLDSS		= 0x38
 
 CF_MASK		= 0x00000001
+TF_MASK		= 0x00000100
 IF_MASK		= 0x00000200
+DF_MASK		= 0x00000400
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
@@ -139,6 +141,9 @@
 	movl CS(%esp),%edx	# this is eip..
 	movl EFLAGS(%esp),%ecx	# and this is cs..
 	movl %eax,EFLAGS(%esp)	#
+	andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+	pushl %eax
+	popfl
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
@@ -256,6 +261,9 @@
 	pushl $ SYMBOL_NAME(do_divide_error)
 	ALIGN
 error_code:
+	pushfl
+	andl $~(NT_MASK|TF_MASK|DF_MASK), (%esp)
+	popfl
 	pushl %ds
 	pushl %eax
 	xorl %eax,%eax
@@ -266,7 +274,6 @@
 	decl %eax			# eax = -1
 	pushl %ecx
 	pushl %ebx
-	cld
 	movl %es,%cx
 	movl ORIG_EAX(%esp), %esi	# get the error code
 	movl ES(%esp), %edi		# get the function address
diff -urN linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux.orig/arch/i386/kernel/traps.c	Thu Nov 14 21:19:40 2002
+++ linux/arch/i386/kernel/traps.c	Thu Nov 14 21:40:01 2002
@@ -601,7 +601,7 @@
 	return;
 
 clear_TF:
-	regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~(TF_MASK|NT_MASK);
 	return;
 }
 

--------------Boundary-00=_FRGU0UCVJW22VGVQTO7R--

