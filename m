Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLSFrf>; Tue, 19 Dec 2000 00:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQLSFrZ>; Tue, 19 Dec 2000 00:47:25 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:2820 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129391AbQLSFrT>; Tue, 19 Dec 2000 00:47:19 -0500
Date: Mon, 18 Dec 2000 23:16:47 -0600
To: richard offer <offer@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001218231647.A980@cadcamlab.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net> <20001215155741.B4830@ping.be> <01cf01c066ab$036fc030$890216ac@ottawa.loran.com> <91gr99$bs81o$1@fido.engr.sgi.com> <10012180904.ZM26544@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10012180904.ZM26544@sgi.com>; from offer@sgi.com on Mon, Dec 18, 2000 at 09:04:58AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[richard offer]
> Or userland libraries/applications that need to bypass libc and make
> direct kernel calls because libc hasn't yet implemented those new
> kernel calls.

Nah, it's still error-prone because it's too hard to guarantee that the
user compiling your program has up-to-date kernel headers in a location
you can find.  Too many things can go wrong.

So just '#include <asm/unistd.h>' -- the libc version -- then have your
own header for those few things you consider "too new to be in libc":

  /* my_unistd.h */
  /* [not sure if all the __{arch}__ defines are right] */
  #include <asm/unistd.h>	/* from libc, not from kernel */
  #ifndef __NR_pivot_root
  # ifdef __alpha__
  #  define __NR_pivot_root 374
  # endif
  # if defined(__i386__) || defined(__s390__) || defined(__superh__)
  #  define __NR_pivot_root 217
  # endif
  # ifdef __mips__
  #  define __NR_pivot_root (__NR_Linux + 216)
  # endif
  # ifdef __hppa__
  #  define __NR_pivot_root (__NR_Linux + 67)
  # endif
  # ifdef __sparc__
  #  define __NR_pivot_root 146
  # endif
  #endif
  #ifndef __NR_pivot_root
  # error Your architecture is not known to support pivot_root(2)
  #endif
  _syscall2(int,pivot_root,char *,new,char *,old)

Yes it's clumsy but it's guaranteed to be where you expect it.  (And
it's not nearly as clumsy if you don't feel the need to support all
architectures.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
