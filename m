Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSFCSII>; Mon, 3 Jun 2002 14:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317445AbSFCSIH>; Mon, 3 Jun 2002 14:08:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16256 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317444AbSFCSIF>; Mon, 3 Jun 2002 14:08:05 -0400
Date: Mon, 3 Jun 2002 14:08:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Atomic operations
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A10@ntserver2>
Message-ID: <Pine.LNX.3.95.1020603132526.893A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Gregory Giguashvili wrote:

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

atomic_t test_and_set(int i, atomic_t *v)
{
    int ret;

    __asm__ __volatile__(LOCK "movl (%1), %ecx\n"
                         LOCK "orl   %0,  (%1)\n" 
	: ecx (ret) 
	: "r" (i), "m" (v)
	: "ecx", "memory" );

    return (ret & i);
}

I did not check this to even see if it compiles. It serves only
as an example of a problem with your requirements. You may be
able to use BTS for your problem, but that may not satisfy your
requirements.

In the above example, I lock the bus and move the contents of
your memory location into a register. Then, I lock the bus again
and OR in the bits you require. Later, I see if that bit was set
in the return value. Unfortunately, a lot can change during the
two lock instructions.

To use the BTS instruction, you do something like this:

atomic_t test_and_set(int i, atomic_t *v)
{
    int ret;
    __asm__ __volatile__("xorl %ecx, %ecx\n"
                         LOCK "btsl %0, (%1)\n"
                         "adcl %ecx, ecx\n"
	: ecx (ret) 
	: "r" (i), "m" (v)
	: "ecx", "memory" );

    return(i && ret);  /* Note Logical AND */
// or
    return ret; 
}
 
BTS will test a bit then set it. The result of the initial
test will be in the CY flag. I zero a register first, do the stuff,
then add the contents of the CY flag into the previously-zeroed
register. This I how I return the result. Again, this may not
be what you want although you may be able to modify the logic of
your code to accept such.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

