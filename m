Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWGPTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWGPTsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWGPTsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:48:18 -0400
Received: from [83.101.158.253] ([83.101.158.253]:37129 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750834AbWGPTsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:48:18 -0400
From: Al Boldi <a1426z@gawab.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Sun, 16 Jul 2006 22:49:25 +0300
User-Agent: KMail/1.5
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
References: <200607160000_MC3-1-C51D-6B44@compuserve.com>
In-Reply-To: <200607160000_MC3-1-C51D-6B44@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607162249.25641.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Sat, 15 Jul 2006 17:09:45 +0300, Al Boldi wrote:
> > Randomization on.  Executable runs with 8x blips/hits.
> > Randomization off.  Executable runs without blips/hits.
> > With randomization off, a mere rename causes an 8x-slowdown to occur. 
> > Run this renamed executable through sh -c ./tstExec, and the slowdown
> > disappears.  Really weired :)
>
> Does this help at all?  I don't have a space heater^W^WPentium IV
> to test on.

P4 is not a space heater, it's a stove.

> --- 2.6.18-rc1-nb.orig/arch/i386/kernel/process.c
> +++ 2.6.18-rc1-nb/arch/i386/kernel/process.c
> @@ -890,5 +890,5 @@ unsigned long arch_align_stack(unsigned
>  {
>  	if (randomize_va_space)
>  		sp -= get_random_int() % 8192;
> -	return sp & ~0xf;
> +	return sp & ~0x7f;
>  }

Thanks! That did the trick!

The weirdness is completely gone, as are the continuous slowdowns, but I 
still get these:

on mdk9.1/gcc3.2.2/2.6.17.4
# gcc -O3 tstExec.c
# echo 0 > /proc/sys/kernel/randomize_va_space
# while :; do ./a.out;done

   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5    7    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    6 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec
   5    5    5    5    5    5    5    5    6    5 msec

on mdk9.1/gcc3.2.2/2.6.17.4
# gcc -O3 tstExec.c
# echo 1 > /proc/sys/kernel/randomize_va_space
# while :; do ./a.out;done

   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    6    5    5   13    5   13    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5   11    5   13    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    6    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5    6    5   13    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5    6    5   13    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5    6    5   13    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5   13    5    6    5 msec
   5    5    5    5    5    5   13    5    7    5 msec
   5    5    5    5    5    5   13    5   13    5 msec
   5    5    5    5    5    5    6    5    6    5 msec
   5    5    5    5    5    5    6    5    6    5 msec

on rhel4/gcc4.0.1/2.6.17.4
# gcc -O3 tstExec.c
# echo 0 > /proc/sys/kernel/randomize_va_space
# while :; do ./a.out;done

   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   6    6    6    6    6    6    6    6    6    6 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    6    5    5    5    5    5    5    5    5 msec

on rhel4/gcc4.0.1/2.6.17.4
# gcc -O3 tstExec.c
# echo 1 > /proc/sys/kernel/randomize_va_space
# while :; do ./a.out;done

  13   13   13   13   13   13   13   13   13   13 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   12    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
  13   13   13   13   13   13   13   13   13   13 msec
  13   13   13   13   13   13   13   13   13   14 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   14 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec
   5    5    5    5    5    5    5    5    5    5 msec
  13   13   13   13   13   13   13   13   13   13 msec

Thanks again!

--
Al


