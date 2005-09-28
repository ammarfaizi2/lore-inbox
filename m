Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVI1KEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVI1KEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVI1KEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:04:20 -0400
Received: from mail.renesas.com ([202.234.163.13]:49338 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1750860AbVI1KET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:04:19 -0400
Date: Wed, 28 Sep 2005 19:04:14 +0900 (JST)
Message-Id: <20050928.190414.189705294.takata.hirokazu@renesas.com>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050928001840.GW7992@ftp.linux.org.uk>
References: <20050927.152325.424252181.takata.hirokazu@renesas.com>
	<Pine.LNX.4.58.0509270758040.3308@g5.osdl.org>
	<20050928001840.GW7992@ftp.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 28 Sep 2005 01:18:40 +0100
> On Tue, Sep 27, 2005 at 08:00:03AM -0700, Linus Torvalds wrote:
> > 
> > On Tue, 27 Sep 2005, Hirokazu Takata wrote:
> > > 
> > > Now, the endianness is to be determined by a (cross)compiler:
> > > - For the big-endian, a compiler (m32r-linux-gcc or m32r-linux-gnu-gcc)
> > >   provides a predefined macro __BIG_ENDIAN__.
> > > - For little-endian, a compiler (m32rle-linux-gcc or m32rle-linux-gnu-gcc)
> > >   provides a predefined macro __LITTLE_ENDIAN__.
> > 
> > Hmm.. You need to tell sparse _some_ way which one you use, since sparse 
> > won't do it.

In the top Makefile, CHECKFLAGS is defined as follows:
CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ $(CF)

Can I use CF for user specific CHECKFLAGS ?
What do you think about we specify it manyally for a biendian target?

ex. m32r
  sparse check for biendian target
  $ make ARCH=m32r CF=-D__BIG_ENDIAN__=1 C=1   ... for big-endian
  $ make ARCH=m32r CF=-D__LITTLE__=1 C=1       ... for little-endian

  arch/m32r/Makefile:
  CHECKFLAGS += -D__m32r__

> > Picking one at random is fine, of course. It doesn't even have to match 
> > the one you'll compile with, although that means that sparse will 
> > obviously be testing a different configuration than the one you'd actually 
> > compile.
> > 
> > So I think having -D__BIG_ENDIAN__ in the sparse flags is better than not
> > having anything at all (since otherwise it won't be able to check
> > anything). And having something that matches the compiler would be better
> > still.

I understand what you said.
I think having -D__BIG_ENDIAN__ is one of the realistic solutions,
because it seems that there is no good solution about this problem
as other people said in this ML-thread.


> Really interesting question is why do we need two toolchains at all.
> Note that little-endian m32r gcc at least appears to understand
> -mbe/-mbig-endian and binutils handles both endianness just fine.

IMHO, I think it is for convinience of building userland programs.
For example, in case of building programs (like Debian/GNU Linux
packages), it is useful that we can simply use a compiler without
not only modifying any source/Makefile but also specifing any 
target-specific options of the compiler.

> Does that really work and is there any reason why big-endian one
> could not handle -mle the same way with minimal changes?  IOW, do
> they have to differ in anything except the default target endianness?

I have no idea...

> Note that dependencies on "host endianness == target endianness" are
> practically guaranteed to cause bugs in cross-compiler, so any of
> those would very likely to be a bug in need of fixing anyway...

I think so, too.
I hope we can do check both of target endianness intentionally.

-- Takata
