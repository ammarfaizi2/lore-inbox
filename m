Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSK1TxI>; Thu, 28 Nov 2002 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSK1TxI>; Thu, 28 Nov 2002 14:53:08 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:57094
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S266721AbSK1TxH>; Thu, 28 Nov 2002 14:53:07 -0500
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021128171324.G2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	 <shsptsrd761.fsf@charged.uio.no>
	 <1038387522.31021.188.camel@ixodes.goop.org>
	 <20021127150053.A2948@redhat.com>
	 <15845.10815.450247.316196@charged.uio.no>
	 <20021127205554.J2948@redhat.com> <20021128164439.E2362@redhat.com>
	 <20021128171324.G2362@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038513627.1464.44.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 28 Nov 2002 12:00:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-28 at 09:13, Stephen C. Tweedie wrote:
> In fact, it's not clear what we _can_ return as f_pos after the last
> dirent.
> 
> We're only using 31-bit hashes right now.  Trond, how will other NFS
> clients react if we return an NFS cookie 32-bits wide?  We could
> easily use something like 0x80000000 as an f_pos to represent EOF in
> the Linux side of things, but will that cookie work if passed over the
> wire on NFSv2?
> 
> The alternative is to hack in a special case so that (for example) we
> consider a major htree hash of 0x7fffffff to map to an f_pos of
> 0x7ffffffe and just consider that a possible collision, so that
> 0x7fffffff is a unique EOF for the htree tree walker.

Even if you fix this, there's another problem. 

It seems that htree basically can't work with NFS in its current state -
it only works at all on small directories, which aren't hashed and
therefore use the non-htree cookie scheme.  This can be fixed creating a
distinct EOF cookie.

However, in the transformation from a non-hashed to hashed directory the
cookie scheme completely changes, and in effect invalidates all cookies
currently known by clients.  The obvious problem is that sometimes
adding a single entry to a directory will kill all concurrent readdirs.

I know that changing a directory while scanning it has at least some
undefined effects (allowed to miss entries, but not allowed to
duplicate, if I remember correctly), but if you add a single entry to a
directory, is it allowed to completely break any pending readdir
operation?

One solution I can think of is to always use name hashes as directory
cookies, even for non-hashed directories.  This means that scans of a
small directory will require linear searching to find the entry
corresponding to a particular cookie, but since the directory is small
by definition it shouldn't be a bad performance hit.

	J

