Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263161AbTCLMSI>; Wed, 12 Mar 2003 07:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbTCLMSI>; Wed, 12 Mar 2003 07:18:08 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:23818 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263161AbTCLMSH>; Wed, 12 Mar 2003 07:18:07 -0500
Message-Id: <200303121207.h2CC7Ku29506@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Date: Wed, 12 Mar 2003 14:04:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: george@mvista.com, felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
References: <20030311144448.4d9ee416.akpm@digeo.com> <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com> <20030311150913.20ddb760.akpm@digeo.com>
In-Reply-To: <20030311150913.20ddb760.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 March 2003 01:09, Andrew Morton wrote:
> > However, gcc is unable to do-the-right-thing and generate 32x32->64
> > multiplies, or 32x64->64 multiplies, even though those are both a
> > _lot_ faster than the full 64x64->64 case.
>
> 2.95.3 and 3.2.1 seem to do it right?
>
>
>
> long a;
> long b;
> long long c;
>
> void foo(void)
> {
> 	c = a * b;

(long * long) is a long
(long long = long) has to sign extend right side and do assignment

> }
>
>
>
> 	.file	"t.c"
> 	.version	"01.01"
> gcc2_compiled.:
> .text
> 	.align 4
> .globl foo
> 	.type	 foo,@function
> foo:
> 	pushl %ebp
> 	movl %esp,%ebp
> 	movl a,%eax
> 	imull b,%eax
> 	movl %eax,c

store low word...

> 	cltd

sign extend eax into edx...

> 	movl %edx,c+4

store sign-extended high word

In other words, you lost high 32 bits of 32x32 mul here
due to error in C code.

Proper example would be  c = ((long long)a) * b;
--
vda
