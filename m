Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSFCSjf>; Mon, 3 Jun 2002 14:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317451AbSFCSjf>; Mon, 3 Jun 2002 14:39:35 -0400
Received: from quark.didntduck.org ([216.43.55.190]:51474 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S317450AbSFCSjd>; Mon, 3 Jun 2002 14:39:33 -0400
Message-ID: <3CFBB7DB.831BE453@didntduck.org>
Date: Mon, 03 Jun 2002 14:39:23 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
CC: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Atomic operations
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A10@ntserver2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Giguashvili wrote:
> 
> Hello,
> 
> I wonder if someone can help me to change the behaviour of the atomic
> functions available in <asm/atomic.h> include file. The operations I need to
> implement are described below:
> 
> atomic_t test_and_set (int i, atomic_t* v)
> {
>    atomic_t old = *v;
>    v->counter = i;
>    return old;
> }

What you have coded is really an exchange, not a test.  Here is the asm
equivalent of what you coded:

int atomic_xchg(int i, atomic_t *v)
{
	int ret;
	__asm__("xchgl %1,%0"
		: "=m" (v->counter), "=r" (ret)
		: "0" (v->counter), "1" (i));
	return ret;
}

> 
> atomic_t test_then_add (int i, atomic_t* v)
> {
>    atomic_t old = *v;
>    v->counter += i;
>    return old;
> }

int atomic_xadd(int i, atomic_t *v)
{
	int ret;
	__asm__(LOCK "xaddl %1,%0"
		: "=m" (v->counter), "=r" (ret)
		: "0" (v->counter), "1" (i));
	return ret;
}

This one only works on 486+, but there are practically no real 386 SMP
systems.

--

				Brian Gerst
