Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287733AbSAAEEf>; Mon, 31 Dec 2001 23:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287729AbSAAEEY>; Mon, 31 Dec 2001 23:04:24 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:27911 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S287735AbSAAEEQ>; Mon, 31 Dec 2001 23:04:16 -0500
Date: Mon, 31 Dec 2001 20:03:59 -0800
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011231200359.A22497@bluemug.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227174723.V25698@work.bitmover.com> <19047.1009504678@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19047.1009504678@ocs3.intra.ocs.com.au>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 12:57:58PM +1100, Keith Owens wrote:
> 
> Unlike the broken make dep, kbuild 2.5 extracts accurate dependencies
> by using the -MD option of cpp and post processing the cpp list.  The
> post processing code is slow because the current design requires every
> compile to read a complete list of all the files, giving O(n^2)
> effects.  Mark 2 of the core code will use a shared database with
> concurrent update so post processing is limited to looking up just the
> required files, instead of reading the complete list every time.

Why not use '$(GCC) -c -Wp,-MD,foo.d foo.c' to generate the dependencies
as a side effect of the regular compile step?  This enables you to skip
the initial dependency preprocessing step entirely, and could lead to a
speedup over even the current fastdep system.  You still have to massage
the dependencies but you can do it based on the side-effect dependency
output of the _previous_ build, to whatever degree that output exists.

This strategy allows for lazy dependency generation in those cases in
which the dependencies need not be known--for example, if floppy.o
doesn't exist, you know it needs to be built no matter which header
files floppy.c may include.  This breaks down in some cases (as when a
.c file depends on a generated .h file) but those breakdown cases can
be explicitly identified, and a full dependency tree be generated for
them in an eager, rather than a lazy, fashion.

It seems like it's worth it if it leads to a near 100% speedup over the
current kbuild 2.5.  The "build whole clean tree" case is a common one
even among kernel developers, e.g. for compile-testing patches before
resending them.

miket
