Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266041AbUA1TQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUA1TQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:16:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266041AbUA1TPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:15:51 -0500
Date: Wed, 28 Jan 2004 11:15:29 -0800
From: "David S. Miller" <davem@redhat.com>
To: Timothy Miller <miller@techsource.com>
Cc: hpa@zytor.com, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: long long on 32-bit machines
Message-Id: <20040128111529.4debeb40.davem@redhat.com>
In-Reply-To: <401809B2.70907@techsource.com>
References: <4017F991.2090604@zytor.com>
	<401809B2.70907@techsource.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 14:12:50 -0500
Timothy Miller <miller@techsource.com> wrote:

> I don't know how it is for GCC, but when using the Sun compiler, "long 
> long" for 32-bit is low-high, while "long long" (or just long) for 
> 64-bit is high-low.  This has been an annoyance to me.  :)

For 64-bit it goes into a single 64-bit register.
And for 32-bit the sequence is high 32-bits low 32-bits.
At least on Sparc.

extern void foo(long long a);
void bar(void)
{
    foo(1);
}
/* gcc -m32 -S -o bar.s bar.c */
bar:
	!#PROLOGUE# 0
	save	%sp, -104, %sp
	!#PROLOGUE# 1
	mov	0, %o0
	mov	1, %o1
	call	foo, 0
	 nop
	nop
	ret
	restore
/* gcc -m64 -S -o bar.s bar.c */
bar:
	!#PROLOGUE# 0
	save	%sp, -192, %sp
	!#PROLOGUE# 1
	mov	1, %o0
	call	foo, 0
	 nop
	nop
	return	%i7+8
