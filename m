Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263971AbRFFRwT>; Wed, 6 Jun 2001 13:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbRFFRwK>; Wed, 6 Jun 2001 13:52:10 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47058 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264019AbRFFRv6>; Wed, 6 Jun 2001 13:51:58 -0400
Date: Wed, 6 Jun 2001 19:26:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Tom Vier <tmv5@home.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <3B1E42EA.B0AE7F6E@mandrakesoft.com>
Message-ID: <Pine.GSO.3.96.1010606185833.2113C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Jeff Garzik wrote:

> There are two things you can do here, one is easy:  use linker tricks to
> make sure that an application built on alpha -- with 64-bit pointers --
> uses no more than the lower 32 bits of each pointer for addressing. 
> This should fix a ton of applications which cast pointer values to ints
> and similar garbage.

 Note we are only writing of executing an OSF/1 netscape binary.  The
binary is built with the -taso option on OSF/1 and is linked fine with
respect to 31-bit pointers.  It fails when mmap()ping shared libraries
after applying my patch that went to -ac series recently.  Since OSF/1
shared libraries are PIC, there should be no problem to mmap() them into
the low 2GB provided mmap() know we want it.  And mmap() has already all
needed bits in place -- it's the ECOFF support on Alpha/Linux that does
not set the personality as it should. 

> The other option, hacking gcc to output "32-bit alpha" binary code, is a
> tougher job.
> 
> I had mentioned this to Richard Henderson a while back, when I was
> wondering how easy it is to implement -taso under Linux, and IIRC he
> seemed to think that linker tricks were much easier.

 It might be unavoidable to prevent shared libraries from being mmap()ped
outside the 31-bit address space unless we hint the dynamic linker
somehow.  Implementing the -taso option is trivial -- all it actually does
on OSF/1 is mapping program's segments into low 2GB of memory (we may do
it by selecting a different linker script) and setting the "31-bit address
space flag" in the program's header so that the dynamic linker mmap()s
shared libraries appropriately as well.  We do have all the bits in place
already as well.

 Note that personally I'm strongly against the -taso approach -- it's a
hack to be meant as an excuse for fixing broken programs.  But fixing
programs is not that difficult (though it might be boring and
time-consuming).  I've already did a conversion of a moderately sized DOS
program to *nix.  The program was twisted by far and near pointers and
casts to ints and longs (depending on the pointer type) scattered over the
source.  It took me about two weeks worth of full-time work (assuming
eight hours per day; the actual time elapsed was longer, but I was only
doing it in my free time) to make the program working on i386/Linux,
another week to port it to Alpha/Linux (i.e. make it 64-bit clean) and yet
another day to make it work on SPARC/Solaris (i.e. make it
endianness-clean).  The program was checked to be running fine on
MIPS/Ultrix and Alpha/OSF/1 afterwards as well.  Therefore I see no point
in keeping programs broken.  If a vendor is not willing to fix a
non-open-sourced broken program, then maybe the program is just not worth
attention.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

