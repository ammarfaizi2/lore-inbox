Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRLSRtl>; Wed, 19 Dec 2001 12:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRLSRta>; Wed, 19 Dec 2001 12:49:30 -0500
Received: from ca-ol-tours-10-196.abo.wanadoo.fr ([80.8.7.196]:30608 "EHLO
	walhalla.agaha") by vger.kernel.org with ESMTP id <S278522AbRLSRtQ>;
	Wed, 19 Dec 2001 12:49:16 -0500
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011217174020.GA24772@0xd6.org>
From: Benoit Poulot-Cazajous <poulot@ifrance.com>
Organization: Sun Microsystems
Date: 19 Dec 2001 18:46:13 +0100
In-Reply-To: <20011217174020.GA24772@0xd6.org>
Message-ID: <lnitb3drx6.fsf_-_@walhalla.agaha>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. R. Brown" <mrbrown@0xd6.org> writes:

> * nbecker@fred.net <nbecker@fred.net> on Mon, Dec 17, 2001:
> 
> > I noticed that linux/arch/i386/Makefile says:
> > 
> > ifdef CONFIG_MK7
> > CFLAGS += -march=i686 -malign-functions=4 
> > endif
> > 
> > 
> > Why not -march=athlon?  Is this just for compatibility with old gcc?
> 
> The recommend kernel compiler is gcc 2.95.x, which doesn't support
> "-march=athlon".

But gcc-2.95,x _supports_ "-march=k6", and we should use that instead of
"-march-i686".

Obvious patch for 2.4.16 :

--- linux-2.4.16/arch/i386/Makefile	Thu Apr 12 21:20:31 2001
+++ linux-2.4.16-bpc/arch/i386/Makefile	Sun Dec 16 15:44:06 2001
@@ -63,7 +63,7 @@
 endif
 
 ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; elif $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6 -malign-functions=4"; else echo "-march=i686 -malign-functions=4"; fi)
 endif
 
 ifdef CONFIG_MCRUSOE

I have tested this change, using 3 steps of the ChorusOS compilation
as benchmarks (The test first bootstrap gcc, then compiles various
cross-compilers in parallel and then uses them to build ChorusOS for
various architectures). On my XP1800+, it gives :

before the patch :
1017.92user 261.80system 24:39.89elapsed 86%CPU
706.33user 160.79system 16:23.61elapsed 88%CPU
1787.38user 418.76system 43:35.97elapsed 84%CPU

after the patch :
1018.42user 253.85system 24:44.68elapsed 85%CPU
704.89user 151.76system 16:16.14elapsed 87%CPU
1786.96user 410.76system 43:05.32elapsed 85%CPU

The improvement in system time is nice.

  -- Benoit

