Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSFCR2I>; Mon, 3 Jun 2002 13:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSFCR2H>; Mon, 3 Jun 2002 13:28:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22283 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317432AbSFCR2F>; Mon, 3 Jun 2002 13:28:05 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Atomic operations
Date: 3 Jun 2002 10:27:55 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <adg8ur$13g$1@cesium.transmeta.com>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A10@ntserver2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <EE83E551E08D1D43AD52D50B9F5110927E7A10@ntserver2>
By author:    Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
In newsgroup: linux.dev.kernel
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
> 

This is not a test and set operation.

On i386:

atomic_t atomic_exchange (atomic_t i, atomic_t *v)
{
   asm volatile("xchgl %0,%1" : "+m" (*v), "+r" (i));
   return i;
}

> atomic_t test_then_add (int i, atomic_t* v)
> {
>    atomic_t old = *v;
>    v->counter += i;
>    return old;
> }

There is no way to do this (without waiting and trying again type
code) that I know of on i386.  However, you can test for zeroness of
the result, or for <= 0, or a few other options.

int test_and_add (atomic_t i, atomic_t *v)
{
  char was_nonzero;	/* MUST BE CHAR!!! */

  asm volatile("lock; addl %2,%0; setz %1"
    : "+m" (*v), "=rm" (was_nonzero)
    : "g" (i));

  return was_nonzero;
}

  

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
