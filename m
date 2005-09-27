Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVI0UBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVI0UBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVI0UBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:01:41 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33132 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750940AbVI0UBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:01:41 -0400
Date: Tue, 27 Sep 2005 22:02:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Hirokazu Takata <takata@linux-m32r.org>, torvalds@odsl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050927200230.GA8403@mars.ravnborg.org>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com> <20050927071025.GS7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927071025.GS7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Sam, any help in that area?  Ideally we want to have something equivalent
> to
> PREDEFINED_WE_MIGHT_WANT = __m32r__ __LITTLE_ENDIAN__ __BIG_ENDIAN__
> and CHECKFLAGS done from that - basically, the subset of cross-gcc
> predefined symbols reproduced for sparse.  Ideally with -m64 added
> if we have sizeof(long) == 8 on target, to take care of all that
> crap in one go.
> 
> Suggestions?
The most simple solution would be to provide a small script that
create the defines as we need and run it for each invocation of sparse.
The script should use same trick as scripts/gcc-version.sh does.

So we could have:
#!/bin/sh
compiler="$*"

BIG=$(echo __BIG_ENDIAN__ | $compiler -E -xc - | tail -n 1)
LITTLE=$(echo __LITTLE_ENDIAN__ | $compiler -E -xc - | tail -n 1)

Then BIG would be set to "1" if this is big endian, and "__BIG_ENDIAN__"
if little endian.
A little bit of shell script and we have the defines we want for m32r.
Then we could add calling this script as part of sparse invocation.

The better solution would be to find the relevant flags before we
start building the kernel. This is not so easy if we want access to
final CFLAGS. But for the architecture the important ones are
defined in arch/Makefile so placing this late in the file and
use $(CC) $(CFLAGS) should be OK in almost all cases.

Too late for me to cook up a patch right now - but simple.
Oh, and I agree. We do NOT want all the gcc defined flags.

We should restrict to a subset in the kernel - so it's good
if sparse warns/errors out on usage of the non-trivial defines.
	Sam
