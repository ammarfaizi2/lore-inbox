Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTHVJ0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 05:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTHVJ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 05:26:47 -0400
Received: from ns.suse.de ([195.135.220.2]:723 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263077AbTHVJ0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 05:26:45 -0400
Date: Fri, 22 Aug 2003 11:26:42 +0200
From: Andi Kleen <ak@suse.de>
To: Steve Lord <lord@sgi.com>
Cc: ak@muc.de, clubneon@hereintown.net, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Hang when mounting XFS root in 2.6.0 tests on x86-64
Message-Id: <20030822112642.46d3f538.ak@suse.de>
In-Reply-To: <1061513734.1622.55.camel@laptop.americas.sgi.com>
References: <n4o5.8ga.21@gated-at.bofh.it>
	<m3r83en2th.fsf@averell.firstfloor.org>
	<1061513734.1622.55.camel@laptop.americas.sgi.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2003 19:55:32 -0500
Steve Lord <lord@sgi.com> wrote:

> On Thu, 2003-08-21 at 16:00, Andi Kleen wrote:
> > Chris Meadors <clubneon@hereintown.net> writes:
> > 
> > Better report it to linux-xfs@oss.sgi.com (cc'ed) too.
> > 
> > > I'm trying to get a 2.6.0-test kernel to boot on my Opteron system.  It
> > > has SuSE's 2.4.19-SMP kernel on it now, and it boots with that, mounts
> > > the XFS root just fine.  But I build a vanilla 2.6.0-test3 with no
> > > module support, everything included that I would need.  The last line
> > > that it prints during boot is the NET4.0
> > >
> > > Repeated presses of Alt+SysRq+P seems to show RIP looping in xfs_xlatesb
> > > and xfs_lowbit64.
> 
> Seems to suggest a platform specific problem with this code, Andi,
> didn't you write the function behind xfs_lowbit64?

First at least the comment on top of xfs_lowbit64() is not correct.
ffs() only handles an 32bit argument, not 64bit. Hope that isn't a problem.

Hmm, one difference is that the x86-64 ffs will return 32 on zero, while
i386 returns -1.

Does this patch fix it?

--- linux-2.6.0test3-amd64/include/asm-x86_64/bitops.h-o	2003-07-11 13:34:21.000000000 +0200
+++ linux-2.6.0test3-amd64/include/asm-x86_64/bitops.h	2003-08-22 11:17:53.000000000 +0200
@@ -466,7 +466,7 @@
 
 	__asm__("bsfl %1,%0\n\t"
 		"cmovzl %2,%0" 
-		: "=r" (r) : "g" (x), "r" (32));
+		: "=r" (r) : "g" (x), "r" (-1));
 	return r+1;
 }
 

If that doesn't help I would also try it with -O1 and possibly a different compiler
(e.g. gcc 3.2 if you're using 3.3 or the other way round) to rule out a compiler problem
 
-Andi


