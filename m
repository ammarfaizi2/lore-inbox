Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSFCWqk>; Mon, 3 Jun 2002 18:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSFCWqj>; Mon, 3 Jun 2002 18:46:39 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:41998 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S315708AbSFCWqi>;
	Mon, 3 Jun 2002 18:46:38 -0400
Date: Mon, 3 Jun 2002 18:45:44 -0400
Message-Id: <200206032245.g53Mji123739@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org,
        Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Subject: Re: SMB filesystem
In-Reply-To: <Pine.LNX.4.44.0206022319290.27283-100000@cola.enlightnet.local>
User-Agent: tin/1.5.11-20020130 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002 23:34:59 +0200 (CEST), Urban Widmark <urban@teststation.com> wrote:

> Currently autofs has a problem where it won't show the mountpoints of
> non-mounted directories, but I think you would run into that problem too.
> (short version of the problem: how do you prevent 'ls -l' from mounting
> all filesystems in a directory?)

You add the concept of a "light" lookup, and you make path_walk() call this
"light" lookup (be that a separate fs method, or a flag passed down to real
lookup()) iff the path component being looked up is the last component in 
the path. A "light" lookup sets a flag in the inode signalling that the inode
is incomplete, so cached_lookup() can check this flag and call a "full"
lookup() (or perhaps a "full" revalidate()) if necessary.

The actual details need to be thought out a bit more, this is only a general
outline. In particular, we need a bullet-proof way to determine when to
"upgrade" the inode from "light" to "full".

You then also need to add a "getdents" kind of message to the autofs 
protocol, and a "light lookup" message (which confirms the existence of the
entry, and maybe returns the type of the entry: symlink or directory).

Once all this is done, I'll add support for it in am-utils in a jiffy...

Ion (am-utils co-maintainer)

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
