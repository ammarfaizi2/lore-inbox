Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVC2PG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVC2PG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVC2PG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:06:26 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:1661 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262306AbVC2PGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:06:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mMhGixw0sLLX+gi2TrJOcSvZHIir726gBLziHzcmaPD/o4d60krn2/82wK0fHrMfVhAYtgV+FFBTx2v8TQ0tQIbtcO+k1VXLLNHqtg+XZR//a3Uaqs0aOxnm46vbn5o2Do7f2DuBw57W+2nq6hwsCO+6EUZUXjzEUnMo0IRJKyc=
Message-ID: <84fc9c00050329070625293d40@mail.gmail.com>
Date: Tue, 29 Mar 2005 16:06:17 +0100
From: Richard Guenther <richard.guenther@gmail.com>
Reply-To: Richard Guenther <richard.guenther@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
In-Reply-To: <200503291737.06356.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503291737.06356.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 17:37:06 +0300, Denis Vlasenko <vda@ilport.com.ua> wrote:
> Try testcase below the sig.
> 
> This causes nearly one thousand calls to memcpy in my kernel
> (not an allyesconfig one):

> static inline void * __memcpy(void * to, const void * from, size_t n)
> {
> int d0, d1, d2;
> __asm__ __volatile__(
>         "rep ; movsl\n\t"
>         "testb $2,%b4\n\t"
>         "je 1f\n\t"
>         "movsw\n"
>         "1:\ttestb $1,%b4\n\t"
>         "je 2f\n\t"
>         "movsb\n"
>         "2:"
>         : "=&c" (d0), "=&D" (d1), "=&S" (d2)
>         :"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
>         : "memory");
> return (to);
> }

The question is, what reason does -Winline give for this inlining
decision?  And then
of course, how is the size estimate counted for the above.  What kind
of tree node do
we get for the ASM expression?

Richard.
