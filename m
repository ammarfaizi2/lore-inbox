Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262278AbSI1RV2>; Sat, 28 Sep 2002 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262280AbSI1RV2>; Sat, 28 Sep 2002 13:21:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2053 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262278AbSI1RV0>; Sat, 28 Sep 2002 13:21:26 -0400
Date: Sat, 28 Sep 2002 18:26:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, Daniel Jacobowitz <dan@debian.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Message-ID: <20020928182643.A13064@flint.arm.linux.org.uk>
References: <20020927140543.GA5613@nevyn.them.org> <20020927214721.GK21969@waste.org> <20020928091530.B32639@flint.arm.linux.org.uk> <20020928105911.GU27082@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020928105911.GU27082@louise.pinerecords.com>; from szepe@pinerecords.com on Sat, Sep 28, 2002 at 12:59:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 12:59:11PM +0200, Tomas Szepe wrote:
> > It certainly looks like it.  gcc 3.0.3 appears to ignore
> > "-iwithprefix include", where as gcc 2.95.x, 2.96, 3.1 and 3.2 all
> > work as expected.
> 
> No.  Try building/installing gcc-3.2 with '--prefix=/usr/gcc-3.2'
> and '--prefix=/usr'.  The former won't work with '-iwithprefix include',
> the latter will.  GCC build bug?

Maybe.

I've just checked the GCC 3.2 info files, and it appears that the
definition of -iwithprefix has changed.

gcc 2.9[156] comes with this description:

`-iwithprefix DIR'
     Add a directory to the second include path.  The directory's name
     is made by concatenating PREFIX and DIR, where PREFIX was
     specified previously with `-iprefix'.  If you have not specified a
     prefix yet, the directory containing the installed passes of the
     compiler is used as the default.

whereas gcc 3.2 comes with:

`-iwithprefix DIR'
`-iwithprefixbefore DIR'
     Append DIR to the prefix specified previously with `-iprefix', and
     add the resulting directory to the include search path.
     `-iwithprefixbefore' puts it in the same place `-I' would;
     `-iwithprefix' puts it where `-idirafter' would.

     Use of these options is discouraged.

This seems to leave us with no official guaranteed way to get at the
compiler specific includes, which is Bad News(tm).  We obviously can't
use "-I/usr/lib/gcc-lib/`gcc -dumpmachine`/`gcc -dumpversion`/" and
we've already had problems with the 2.4 "gcc -print-search-dirs"
version.

This leaves us with one option:

  gcc -print-file-name=include

This works, but its also not official:

`-print-file-name=LIBRARY'
     Print the full absolute name of the library file LIBRARY that
     would be used when linking--and don't do anything else.  With this
     option, GCC does not compile or link anything; it just prints the
     file name.

Maybe we need to go back to the gcc folk and get -iwithprefix
reinstated...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
	  "I know toolchain people.  They _love_ to change things."
