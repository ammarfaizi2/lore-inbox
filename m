Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbSLaBFS>; Mon, 30 Dec 2002 20:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSLaBFS>; Mon, 30 Dec 2002 20:05:18 -0500
Received: from magic.adaptec.com ([208.236.45.80]:11519 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S267107AbSLaBFR>; Mon, 30 Dec 2002 20:05:17 -0500
Date: Mon, 30 Dec 2002 18:12:49 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Sam Ravnborg <sam@ravnborg.org>, gibbs@adaptec.com,
       Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [aic7xxx] Spurious recompile with defconfig
Message-ID: <145050000.1041297169@aslan.btc.adaptec.com>
In-Reply-To: <698528112.1041102051@aslan.scsiguy.com>
References: <20021228085631.GA1835@mars.ravnborg.org>
 <698528112.1041102051@aslan.scsiguy.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> When compiling aic7xxx in 2.5.53 with defconfig the kernel always
>> recompiles because dependency for reg_print.c is not
>> per default in the aic7xxx Makefile.
>> Simple correction is to make PRETTY_PRINT dependend on BUILD_FIRMWARE.
> 
> There must be some other problem in the Makefile.  You can turn on
> reg pretty printing without having to build the firmware as there is
> a "shipped" version of that file.  I'll see if I can figure out why the
> re-build is occurring.

The real problem here is that make choses the wrong path for getting
to reg_print.o and, since "intermediate files" were used, those files
are removed once the target is made (See "Chained Rules" in the gmake
info file).  From the "make -d" output, for some reason make decides
that:

	.o <- .s <- .c <- .c_shipped

is better than

	.o <- .c <- .c_shipped

I can't see, from a cursory investigation of the 2.5.X Makefiles
why this happens, but it is certainly anoying.  The info pages
indicate that the removal can be avoided by listing these files
as prerequisites to .SECONDARY, but I could only get that to work
by leaving the prerequisites empty (all files are marked secondary).
Of course this is just a workaround for incorrect behavior.
Perhaps someone with more knowledge of the 2.5.X build system could
look into this?  That way we can restore the original (and correct)
behvior of the driver's Kconfig files.

--
Justin

