Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUK2AfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUK2AfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 19:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUK2AfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 19:35:04 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:36286 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261609AbUK2Ae5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 19:34:57 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 29 Nov 2004 00:34:55 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 28 Nov 2004 19:34:55 -0500
Subject: Re: broken gcc 3.x update ("3.4.3""fixed")
X-Originating-Ip: 172.192.222.243
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20041129003455.B46644BDAA@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon further investigation, the literal
string concatenation bug I described may
have been an unnoticed unescaped newline
in a literal string after all (which gcc-3.3.4
and newer report as an error). I have not
been able to reproduce it with the compilers
where I originally noticed it. (I changed
the original code shortly after that to
not use string concatenation, but numerous
attempts to put it back the way it was have
failed to reproduce the error.)

However, I have yet to see any code that gcc-3.4.3
refuses to compile that gcc-3.3.4 does not also
find fault with, so if using 3.3.4 or newer,
one may as well upgrade and get the bug fixes
and compiler performance improvements. (3.3.2
is less whiny, but it doubtless has bugs
that are fixed in the newer versions.)

The gcc-3.4.3 kernel bloating only seems to
be true at -O2 and above, at least on x86.
With -Os, gcc-3.4.3 compiles a smaller bzImage
than gcc-2.95.3.

There is another potential code generation issue
on i686 architectures with gcc-3.3.4 (it is not
obvious that this would affect the kernel, but
this seems to me the sort of thing to avoid on
principle if you don't have to use that compiler).

Compiling gcc itself, I supply optimization flags
in CFLAGS and CXXFLAGS to configure, then supply
-march= to make (any trailing blanks in this post
are email client artifacts):

  (in a build directory)
  CC="gcc" CXX="g++" CFLAGS="-O2" CXXFLAGS="-O2" \
  ../gcc-[version]/configure [configure options]

  make CFLAGS+="-march=pentium3" CXXFLAGS+="-march=pentium3" \
    LIBCXXFLAGS+="-march=pentium3 -fno-implicit-templates" \
    bootstrap

gcc-3.3.4 does not finish the compile with this make command,
reporting an error from collect2 while building the C++ support.
gcc-3.4.3 completes this build without problems. (Same binutils,
libc-2.2.5, same configure options, same make command.)

This alternative works for the gcc-3.3.4 source tree:

  make CFLAGS+="-march=pentium3" CXXFLAGS+="-march=pentium3" \
    LIBCXXFLAGS+="-march=i686 -fno-implicit-templates" bootstrap

(-fno-implicit-templates is not an issue. The gcc-3.3.4
build only fails with -march=pentium3 instead of -march=i686
in LIBCXXFLAGS).

Draw your own conclusions.

Additional data point: using the bc tests in
the bc-1.06 source tree, gcc-3.4.3 produces
slightly faster divides on a pIII (-O2 -march=i686 or
-march=pentium3) than gcc-2.95.3, but 2.95.3
generates consistently faster multiplies by
a larger margin. (Altered bc's "timetest"
script to do one run and throw away the
results on each test for each bc version,
then do 3 in a row of the same test with
the same bc and take an average.)

Change in estimated cost of a shift altering
the code generator's choices, ie p4 pollution
in all submodels in the i686 code generator?
2.95.3 getting away with something by chance
that 3.4.3 considers unsafe? (Mathematical output
values in the bc tests were the same.)

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

