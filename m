Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUIQUwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUIQUwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUIQUsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:48:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13747 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269001AbUIQUrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:47:22 -0400
Date: Sun, 12 Sep 2004 22:11:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Elladan <elladan@eskimo.com>
Cc: Timothy Miller <miller@techsource.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040912201111.GB4637@openzaurus.ucw.cz>
References: <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <4141FF13.8030009@techsource.com> <20040910221834.GC8698@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910221834.GC8698@eskimo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm talking about uservfs.sf.net, aka podfuk, which implements tarfs
(and more).

> Leaving aside the obvious complexities of making sure the user space
> daemon doesn't just do something crazy, you have a number of problems:
> 
> * Which user does the daemon run as?  If it runs as root, it needs to
>   enforce strict security requirements in terms of VFS operations coming
>   in, and also, it has all the problems of a SUID application running on
>   an arbitrary user file.  I don't know about you, but I don't trust
>   joebob's tarfsd to be suid when running on some script kiddie tarball.

It needs to run as root. If there's bug in tar, that script kiddie is going
to get your users anyway. Audit the code.

> * If the daemon runs as a user, then what happens if you try to run a

It does not.

> * Consider what happens if foo.tar/blah_blah is automatically bound to
>   enter a tarfsd view of foo.tar.  What happens if I point the web
>   server at foo.tar/blah?  The web server runs as httpd or something, so
>   presumably httpd ends up running some sort of tarfsd view on the
>   file.  But if the tarball was made by a malicious person, presumably
>   it can obtain httpd user access now by exploiting a bug in tarfsd.

If there's a bug in tar, I can do a lot of interesting things. Audit tar.

> * Even if you assume the view is read-only and the kernel coerces all
>   permissions and ownership and such, there's the possibility of tarfsd
>   presenting unexpected syscall results - weird error codes, short
>   reads, file data changing underneath mmap, etc. that user applications
>   don't expect and may be susceptible to.

FUD. Fix tarfsd if its problem.

> * Besides all these security issues, if this scheme is writable it has

There are no security issues. Yes, uservfs is security-sensitive code.

>   all the resource problems that loopback network filesystems suffer.
>   What if the kernel is short on memory and tries to flush dirty buffers
>   to reclaim it.  If those buffers are running against the user FS
>   daemon, then that daemon must wake up to clear dirty buffers.  If it
>   tries to allocate memory, deadlock in the kernel.

Coda solves this: all writable things are file-backed on file in /tmp =>
bad performance if you only need piece of very large file,
but no deadlocks.

> Probably the security problems can be solved to some degree by being
> very paranoid in the kernel (at an associated loss in utility), and the
> resource issues can be solved by restricting dirty buffers for loopback
> mounts (at an associated loss in performance), but it's hardly simple.

See sources. It is <1000 lines of code.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

