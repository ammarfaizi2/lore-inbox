Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVJAHgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJAHgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJAHgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:36:41 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30398 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750770AbVJAHgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:36:39 -0400
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
	<433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
	<433D1E5D.20303@pobox.com> <7v64si4von.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0509301112100.3378@g5.osdl.org>
Date: Sat, 01 Oct 2005 00:36:37 -0700
Message-ID: <7voe69664a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Hey, even more impressive is "git pull --all", which will happily try to 
> create an octopus of every single ref available at the other end.

True.

However, I think --all is a mistake even if you use it without
merging in 'git fetch', so I am not planning to do refs/heads/
side, at least not yet.  Even if you prevent an Octopus, what
would you do then?  If you choose to merge one of them, which
one?  Not merging any that is not explicitly specified on the
command line, seems to me the most sensible and safe option.

The rule for 'pull' to decide which refs to merge is:

 (1) if command line has explicit refspecs (--tags and --heads
     do not count), they are all merged.

 (2) if command line has no explicit refspecs (--tags and
     --heads do not count), the default one found from either
     remotes or branches file is merged.

Notice that I am forbidding remotes file to say "by default I
always merge these three heads from there to make an Octopus" by
the above rule (branches file cannot even name more than one
head so this is not an issue).  Since everybody seems to agree
that Octopus is not something that is done mechanically and
routinely anyway [*1*], I think this is a sensible way to guard
against accidental Octopus.

We could consider fetching all heads, by minimally renaming
remote master to origin and getting everything else under the
same name, but I'd really want to keep the local namespace for
branches isolated from each other.  Many kernel.org public
repositories seem to have 'test' and 'release' branches and if
you are a maintainer of such a tree, and if you are interested
in another maintainer's tree, and if that other maintainer has
the 'test' and 'release' branches, --heads (or --tags)
overwriting your 'test' with his 'test' is obviously not what
you want.

Possibly, something like this could be arranged later:

	* git fetch --heads=$ns $remote "$@"

	In addition to the usual refspecs (the rest of the
	command line arguments), fetch all remote heads and
	store remote refs/heads/$a under local refs/heads/$ns/$a
	for all $a.  If $ns is empty, remote "master" is renamed
	"origin".

	* git fetch --heads $remote "$@"

        shorthand for empty $ns

[Footnote]

*1* I do make many Octopus merges, but they happen across my
local topic branches.  Topics merged change day-by-day, and even
the set of topics alive at the time changes everyday.  IOW, it
is not something I would want to do with the same sets of heads
every time by describing them in the remotes file.

