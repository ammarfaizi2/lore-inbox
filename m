Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSK1RCW>; Thu, 28 Nov 2002 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSK1RCW>; Thu, 28 Nov 2002 12:02:22 -0500
Received: from pc-62-31-66-70-ed.blueyonder.co.uk ([62.31.66.70]:46467 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S265863AbSK1RCV>; Thu, 28 Nov 2002 12:02:21 -0500
Date: Thu, 28 Nov 2002 17:09:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021128170924.F2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no> <1038387522.31021.188.camel@ixodes.goop.org> <20021127150053.A2948@redhat.com> <15845.10815.450247.316196@charged.uio.no> <20021127205554.J2948@redhat.com> <shslm3e4or2.fsf@charged.uio.no> <20021128164143.D2362@redhat.com> <15846.19228.868861.629722@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15846.19228.868861.629722@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Nov 28, 2002 at 05:58:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 28, 2002 at 05:58:04PM +0100, Trond Myklebust wrote:
> >>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:
 
>      > If you want it to be preserved in cache, it needs to be in the
>      > inode, not in the file.
> 
> You misunderstand the problem. It isn't that the page cache has an
> incorrect representation of the stream: the page cache is indeed
> stopping filling as soon as it hits the EOF marker.

I know that.

> The problem is that we are stuffing the server-supplied cookies into
> file->f_pos and using them to reconstruct where we are in the readdir
> stream.
> As there is no reserved 'EOF cookie' defined by the protocol that we
> might use, we must either rely on the server giving us a unique cookie
> also for the EOF case, or else mark the fact that filp->f_pos points
> to EOF in some other way.

Right.  But marking the fact can be done in the inode.  We do that for
regular files, after all --- we have an i_size field which marks the
value of f_pos which represents EOF.  And _that_ is what I'm
suggesting for the NFS case --- record in the inode the cookie which
represents EOF, so that in future reads from cache, we still know when
we've got to the end of the stream.

This gets complicated by the possible presence of hash collisions,
though.

Ted, I think there's a problem with the logic for that case.  We can
really only deal sensibly with hash collisions if we do everything in
our power to prevent returning f_pos back to the user in the middle of
a collision, but there's nothing in the ext3 code to do that right now
afaict.  (And even if there were, NFS would just keep calling us to
get more dirents, so fixing it just in ext3 doesn't stop a hash
collision from spanning an NFS reply.)

--Stephen
