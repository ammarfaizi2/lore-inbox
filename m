Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRKKK7G>; Sun, 11 Nov 2001 05:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278396AbRKKK64>; Sun, 11 Nov 2001 05:58:56 -0500
Received: from www.wen-online.de ([212.223.88.39]:30739 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S278381AbRKKK6l>;
	Sun, 11 Nov 2001 05:58:41 -0500
Date: Sun, 11 Nov 2001 11:58:30 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] final cur of tr based current for -ac8
In-Reply-To: <20011110173331.F17437@redhat.com>
Message-ID: <Pine.LNX.4.33.0111111119270.305-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001, Benjamin LaHaise wrote:

> +static unsigned get_TR(void)
> +{
> +	unsigned tr;
> +	/* The PAIN!  The HORROR!
> +	 * Technically this is wrong, wrong, wrong, but
> +	 * gas doesn't know about strl.  *sigh*  Please
> +	 * flog them with a wet noodle repeatedly.  -ben
> +	 */
> +	__asm__ __volatile__("str %w0" : "=r" (tr));
> +	return tr;
> +}

The below seems to make flogging noises, but is likely too soggy.

	-Mike

diff -urN binutils-2.11.2/include/opcode/i386.h binutils-2.11.2.twiddle/include/opcode/i386.h
--- binutils-2.11.2/include/opcode/i386.h	Sat May 12 12:09:19 2001
+++ binutils-2.11.2.noodle/include/opcode/i386.h	Sun Nov 11 09:46:13 2001
@@ -555,7 +555,8 @@
 {"sidt",   1, 0x0f01, 1, Cpu286, wlq_Suf|Modrm,		{ WordMem, 0, 0} },
 {"sldt",   1, 0x0f00, 0, Cpu286, wlq_Suf|Modrm,		{ WordReg|WordMem, 0, 0} },
 {"smsw",   1, 0x0f01, 4, Cpu286, wlq_Suf|Modrm,		{ WordReg|WordMem, 0, 0} },
-{"str",	   1, 0x0f00, 1, Cpu286, w_Suf|Modrm|IgnoreSize,{ Reg16|ShortMem, 0, 0} },
+{"str",    1, 0x0f00, 1, Cpu286, w_Suf|Modrm|IgnoreSize,{ Reg16|ShortMem, 0, 0} },
+{"str",	  1, 0x0f00, 1, Cpu386, wlq_Suf|Modrm,    { WordReg|WordMem, 0, 0} },

 {"verr",   1, 0x0f00, 4, Cpu286, w_Suf|Modrm|IgnoreSize,{ Reg16|ShortMem, 0, 0} },
 {"verw",   1, 0x0f00, 5, Cpu286, w_Suf|Modrm|IgnoreSize,{ Reg16|ShortMem, 0, 0} },
diff -urN binutils-2.11.2/opcodes/i386-dis.c binutils-2.11.2.twiddle/opcodes/i386-dis.c
--- binutils-2.11.2/opcodes/i386-dis.c	Mon Jun 11 12:05:17 2001
+++ binutils-2.11.2.noodle/opcodes/i386-dis.c	Sun Nov 11 08:56:45 2001
@@ -2466,7 +2466,7 @@
   /* GRP6 */
   {
     { "sldt",	Ew, XX, XX },
-    { "str",	Ew, XX, XX },
+    { "strQ",	Ev, XX, XX },
     { "lldt",	Ew, XX, XX },
     { "ltr",	Ew, XX, XX },
     { "verr",	Ew, XX, XX },

-----------------------------------------------------------------------
static unsigned get_TR(int tryit)
{
       unsigned tr;
       if (tryit)
       	__asm__ __volatile__("strl %0" : "=r" (tr));
       else
       	__asm__ __volatile__("str %w0" : "=r" (tr));
       return tr;
}

08048400 <get_TR>:
 8048400:	55                   	push   %ebp
 8048401:	89 e5                	mov    %esp,%ebp
 8048403:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 8048407:	74 07                	je     8048410 <get_TR+0x10>
 8048409:	0f 00 c8             	str    %eax
 804840c:	eb 06                	jmp    8048414 <get_TR+0x14>
 804840e:	89 f6                	mov    %esi,%esi
 8048410:	66 0f 00 c8          	str    %ax
 8048414:	89 ec                	mov    %ebp,%esp
 8048416:	5d                   	pop    %ebp
 8048417:	c3                   	ret

