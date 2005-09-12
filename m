Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVILTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVILTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVILTN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:13:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:35858 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932106AbVILTN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:13:28 -0400
Date: Mon, 12 Sep 2005 21:15:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050912191525.GA13435@mars.ravnborg.org>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk> <20050911220328.GE2177@mars.ravnborg.org> <20050911231601.GL25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911231601.GL25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al. 
 
> See what I mean?  _IF_ we just wanted subarch foo.h, your scheme would
> work.  If we wanted subarch-dependent header that would be pulled by
> foo.h - ditto (sysdep/blah.h from foo.h).  But we can't do that when
> we want #include <asm/foo.h> (from arch-independent code) pull some
> UML stuff *and* asm/foo.h of subarch.
> 
> That's the problem.  Everything else is reasonably easy to deal with.
> That one is not.  And yes, I know about #include_next.  I'd rather
> stick to C, though, TYVM...
> 
I got the picture. And you are right that there is no way to sort this
out with a clever directory structure and a few -I options.
The only two solutions I see you already pointed out:

o Use symlinks
  - With all their horror they do the job.
  - The need special care with make O=
  - We fail to detect when the point somewhere else, so make mrproper
    is needed.
  - They confuse people
    
o include_next
  - gcc extension
  - Give us correct dependencies
  - Signal that something fishy is going on

o Use some magic define trick like:
  - #include "ARCHDIR##foo.h"
  - I cannot recall correct syntax but something like this is doable

Of the three possibilities the include_next is the better chocie. Why?
Because we leave it to the build system to figure out what .h file to
include, and thus letting the build system having full knowledge we make
sure to recompile whatever is needed when we change subarch.
Without the asm symlink in the kernel it would just work in many cases
when you changed architecture.

So to repaet. symlinks are evil when used to in sources.

	Sam

